.. _minio-decommissioning:

=========================
Decommission Server Pools
=========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

Buckit supports decommissioning and removing :ref:`server pools <minio-intro-server-pool>` from a deployment with two or more pools.
To decommission, there must be at least one remaining pool with sufficient available space to receive the objects from the decommissioned pools.

Buckit supports queueing :ref:`multiple pools <minio-decommission-multiple-pools>` in a single decommission command.
Each listed pool immediately enters a read-only status, but draining occurs one pool at a time.

Decommissioning is designed for removing an older server pool whose hardware is no longer sufficient or performant compared to the pools in the deployment. 
Buckit automatically migrates data from the decommissioned pools to the remaining pools in the deployment based on the ratio of free space available in each pool.

During the decommissioning process, Buckit routes read operations (e.g. ``GET``, ``LIST``, ``HEAD``) normally. 
Buckit routes write operations (e.g. ``PUT``, versioned ``DELETE``) to the remaining "active" pools in the deployment.
Versioned objects maintain their ordering throughout the migration process.

The procedures on this page decommission and remove one or more server pools from a :ref:`distributed <deploy-minio-distributed>` Buckit deployment with *at least* two server pools.

.. admonition:: Decommissioning is Permanent
   :class: important

   Once Buckit begins decommissioning a pool, it marks that pool as *permanently* inactive ("draining"). 
   Cancelling or otherwise interrupting the  decommissioning procedure does **not** restore the pool to an active state. 
   Use extra caution when decommissioning multiple pools.

   Decommissioning is a major administrative operation that requires care in planning and execution, and is not a trivial or 'daily' task. 



.. _minio-decommissioning-prereqs:

Prerequisites
-------------

Back Up Cluster Settings First
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :mc:`bm admin cluster bucket export` and :mc:`bm admin cluster iam export` commands to take a snapshot of the bucket metadata and IAM configurations respectively prior to starting decommissioning.
You can use these snapshots to restore bucket/IAM settings to recover from user or process errors as necessary.

Networking and Firewalls
~~~~~~~~~~~~~~~~~~~~~~~~

Each node should have full bidirectional network access to every other node in
the deployment. For containerized or orchestrated infrastructures, this may
require specific configuration of networking and routing components such as
ingress or load balancers. Certain operating systems may also require setting
firewall rules. For example, the following command explicitly opens the default
Buckit server API port ``9000`` on servers using ``firewalld``:

.. code-block:: shell
   :class: copyable

   firewall-cmd --permanent --zone=public --add-port=9000/tcp
   firewall-cmd --reload

If you set a static :ref:`Buckit Console <minio-console>` port (e.g. ``:9001``)
you must *also* grant access to that port to ensure connectivity from external
clients.

Buckit **strongly recomends** using a load balancer to manage connectivity to the
cluster. The Load Balancer should use a "Least Connections" algorithm for
routing requests to the Buckit deployment, since any Buckit node in the deployment
can receive, route, or process client requests. 

The following load balancers are known to work well with Buckit:

- `NGINX <https://www.nginx.com/products/nginx/load-balancing/>`__
- `HAProxy <https://cbonte.github.io/haproxy-dconv/2.3/intro.html#3.3.5>`__

Configuring firewalls or load balancers to support Buckit is out of scope for
this procedure.

Deployment Must Have Sufficient Storage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The decommissioning process migrates objects from the target pool to other pools in the deployment. 
The total available storage on the deployment *must* exceed the total storage of the decommissioned pool.

Use the `Erasure Code Calculator <../../_static/ec-calculator.html>`__ to determine the usable storage capacity.
Then reduce that by the size of the objects already on the deployment.

For example, consider a deployment with the following distribution of used and free storage:

.. list-table::
   :stub-columns: 1
   :widths: 30 30 30
   :width: 100%

   * - Pool 1
     - 100TB Used
     - 200TB Total

   * - Pool 2
     - 100TB Used
     - 200TB Total

   * - Pool 3
     - 100TB Used
     - 200TB Total

Decommissioning Pool 1 requires distributing the 100TB of used storage across the remaining pools. 
Pool 2 and Pool 3 each have 100TB of unused storage space and can safely absorb the data stored on Pool 1. 

However, if Pool 1 were full (e.g. 200TB of used space), decommissioning would
completely fill the remaining pools and potentially prevent any further write
operations.

Considerations
--------------

Replacing a Server Pool
~~~~~~~~~~~~~~~~~~~~~~~

For hardware upgrade cycles where you replace old pool hardware with a new pool, you should :ref:`add the new pool through expansion <expand-minio-distributed>` before starting the decommissioning of the old pool.
Adding the new pool first allows the decommission process to transfer objects in a balanced way across all available pools, both existing and new.

Complete any planned :ref:`hardware expansion <expand-minio-distributed>` prior to decommissioning older hardware pools.

Decommissioning requires that a cluster's topology remain stable throughout the pool draining process.
Do **not** attempt to perform expansion and decommission changes in a single step.

Decommissioning is Resumable
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit resumes decommissioning if interrupted by transient issues such as
deployment restarts or network failures.

For manually cancelled or failed decommissioning attempts, Buckit 
resumes only after you manually re-initiate the decommissioning operation.

The pool remains in the decommissioning state *regardless* of the interruption.
A pool can *never* return to active status after decommissioning begins.

Decommissioning is Non-Disruptive
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Removing a decommissioned server pool requires restarting *all* Buckit
nodes in the deployment at around the same time.

.. include:: /includes/common-installation.rst
   :start-after: start-nondisruptive-upgrade-desc
   :end-before: end-nondisruptive-upgrade-desc

Decommissioning Ignores Expired Objects and Trailing DeleteMarker
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Decommissioning ignores objects where the only remaining version is a ``DeleteMarker``.
This avoids creating empty metadata on the remaining server pool(s) for objects that are effectively fully deleted.

Decommissioning also ignores object versions which have expired based on the configured :ref:`lifecycle rules <minio-lifecycle-management-expiration>` for the parent bucket.
You can monitor ignored delete markers and expired objects during the decommission process with :mc-cmd:`bm admin trace --call decommission <bm admin trace --call>`.

Once the decommissioning process completes, you can safely shut down that pool.
Since the only remaining data was scheduled for deletion *or* was only a ``DeleteMarker``, you can safely clear or destroy those drives as per your internal procedures.

Behavior
--------

Final Listing Check
~~~~~~~~~~~~~~~~~~~

At the end of the decommission process, Buckit checks for a list of items on the pool.
If the list returns empty, Buckit marks the decommission as successfully completed.
If any objects return, Buckit returns an error that the decommission process failed.

If the decommission fails, review the failure details before retrying the decommission.

Decommissioning a Server with Tiering Enabled
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For deployments with tiering enabled and active, decommissioning moves the object references to a new active pool.
Applications can continue issuing GET requests against those objects where Buckit handles transparently retrieving them from the remote tier.

In older Buckit versions, tiering configurations prevent decommissioning. 

.. _minio-decommissioning-server-pool:

Decommission a Server Pool
--------------------------

1) Review the Buckit Deployment Topology
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The :mc:`bm admin decommission` command returns a list of all
pools in the Buckit deployment:

.. code-block:: shell
   :class: copyable

   bm admin decommission status mybuckit

The command returns output similar to the following:

.. code-block:: shell

   ┌─────┬────────────────────────────────────────────────────────────────┬──────────────────────────────────┬────────┐
   │ ID  │ Pools                                                          │ Capacity                         │ Status │
   │ 1st │ https://buckit-{01...04}.example.com:9000/mnt/disk{1...4}/buckit │  10 TiB (used) / 10  TiB (total) │ Active │
   │ 2nd │ https://buckit-{05...08}.example.com:9000/mnt/disk{1...4}/buckit │  60 TiB (used) / 100 TiB (total) │ Active │
   │ 3rd │ https://buckit-{09...12}.example.com:9000/mnt/disk{1...4}/buckit │  40 TiB (used) / 100 TiB (total) │ Active │
   └─────┴────────────────────────────────────────────────────────────────┴──────────────────────────────────┴────────┘

The example deployment above has three pools. Each pool has four servers
with four drives each.

Identify the target pool for decommissioning and review the current capacity.
The remaining pools in the deployment *must* have sufficient total
capacity to migrate all object stored in the decommissioned pool.

In the example above, the deployment has 210TiB total storage with 110TiB used.
The first pool (``buckit-{01...04}``) is the decommissioning target, as it was
provisioned when the Buckit deployment was created and is completely full. The
remaining newer pools can absorb all objects stored on the first pool without
significantly impacting total available storage.

2) Start the Decommissioning Process
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. admonition:: Decommissioning is Permanent
   :class: warning

   Once Buckit begins decommissioning a pool, it marks that pool as *permanently*
   inactive ("draining"). Cancelling or otherwise interrupting the 
   decommissioning procedure does **not** restore the pool to an active
   state. 

   Review and validate that you are decommissioning the correct pool
   *before* running the following command.

Use the :mc-cmd:`bm admin decommission start` command to begin decommissioning
the target pool. Specify the :ref:`alias <alias>` of the deployment and the
full description of the pool to decommission, including all hosts, disks, and file paths.

.. code-block:: shell
   :class: copyable

   bm admin decommission start mybuckit/ https://buckit-{01...04}.example.net:9000/mnt/disk{1...4}/buckit

The example command begins decommissioning the matching server pool on the
``mybuckit`` deployment.

During the decommissioning process, Buckit continues routing read operations
(``GET``, ``LIST``, ``HEAD``) to the pool for those objects not
yet migrated. Buckit routes all new write operations (``PUT``) to the
remaining pools in the deployment.

Load balancers, reverse proxy, or other network control components which
manage connections to the deployment do not need to modify their configurations
at this time.

3) Monitor the Decommissioning Process
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :mc-cmd:`bm admin decommission status` command to monitor the 
decommissioning process. 

.. code-block:: shell
   :class: copyable

   bm admin decommission status mybuckit

The command returns output similar to the following:

.. code-block:: shell

   ┌─────┬────────────────────────────────────────────────────────────────┬──────────────────────────────────┬──────────┐
   │ ID  │ Pools                                                          │ Capacity                         │ Status   │
   │ 1st │ https://buckit-{01...04}.example.com:9000/mnt/disk{1...4}/buckit │  10 TiB (used) / 10  TiB (total) │ Draining │
   │ 2nd │ https://buckit-{05...08}.example.com:9000/mnt/disk{1...4}/buckit │  60 TiB (used) / 100 TiB (total) │ Active   │
   │ 3rd │ https://buckit-{09...12}.example.com:9000/mnt/disk{1...4}/buckit │  40 TiB (used) / 100 TiB (total) │ Active   │
   └─────┴────────────────────────────────────────────────────────────────┴──────────────────────────────────┴──────────┘

You can retrieve more detailed information by specifying the description of
the server pool to the command:

.. code-block:: shell
   :class: copyable

   bm admin decommission status mybuckit https://buckit-{01...04}.example.com:9000/mnt/disk{1...4}/buckit

The command returns output similar to the following:

.. code-block:: shell

   Decommissioning rate at 100MiB/sec [1TiB/10TiB]
   Started: 30 minutes ago

:mc-cmd:`bm admin decommission status` marks the :guilabel:`Status` as
:guilabel:`Complete` once decommissioning is completed. You can move on to
the next step once decommissioning is completed.

If :guilabel:`Status` reads as failed, you can re-run the
:mc-cmd:`bm admin decommission start` command to resume the process. 
For persistent failures, use :mc:`bm admin logs` or review
the systemd logs (e.g. ``journalctl -u minio``) to identify more specific
errors.

4) Remove the Decommissioned Pool from the Deployment Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As each pool completes decommissioning, you can safely remove it from the
deployment configuration. Modify the startup command for each remaining Buckit
server in the deployment and remove the decommissioned pool.

The ``.deb`` or ``.rpm`` packages install a 
`systemd <https://www.freedesktop.org/wiki/Software/systemd/>`__ service file to 
``/usr/lib/systemd/system/buckit.service``. For binary installations, this
procedure assumes the file was created manually as per the 
:ref:`deploy-minio-distributed` procedure.

The ``buckit.service`` file uses an environment file located at 
``/etc/default/minio`` for sourcing configuration settings, including the
startup. Specifically, the ``MINIO_VOLUMES`` variable sets the startup
command:

.. code-block:: shell
   :class: copyable

   cat /etc/default/minio | grep "MINIO_VOLUMES"

The command returns output similar to the following:

.. code-block:: shell

   MINIO_VOLUMES="https://buckit-{1...4}.example.net:9000/mnt/disk{1...4}/buckit https://buckit-{5...8}.example.net:9000/mnt/disk{1...4}/buckit https://buckit-{9...12}.example.net:9000/mnt/disk{1...4}/buckit"

Edit the environment file and remove the decommissioned pool from the 
``MINIO_VOLUMES`` value.

5) Update Network Control Plane
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Update any load balancers, reverse proxies, or other network control planes
to remove the decommissioned server pool from the connection configuration for
the Buckit deployment.

Specific instructions for configuring network control plane components is
out of scope for this procedure.

6) Restart the Buckit Deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Issue the following commands on each node **simultaneously** in the deployment
to restart the Buckit service:

.. include:: /includes/linux/common-installation.rst
   :start-after: start-install-minio-restart-service-desc
   :end-before: end-install-minio-restart-service-desc

.. include:: /includes/common-installation.rst
   :start-after: start-nondisruptive-upgrade-desc
   :end-before: end-nondisruptive-upgrade-desc

Once the deployment is online, use :mc:`bm admin info` to confirm the
uptime of all remaining servers in the deployment.

.. _minio-decommission-multiple-pools:

Decommission Multiple Server Pools
----------------------------------

You can start the decommission process for multiple server pools when issuing a decommission command.

After entering the command:

- Buckit immediately stops write access to all pools to be decommissioned.
- Decommissioning happens one pool at a time.
- Each pool completes the decommission draining process before Buckit begins draining the next pool.

To decommission multiple server pools from one command, add the full description of each server pool to decommission as a comma-separated list.

All other considerations about decommissioning apply when performing the process on multiple servers.

- Decommissioning is permanent.
- Once you mark the pools as decommissioned, you **cannot** restore them.
- Confirm you select the intended pools.

1) Review the Buckit Deployment Topology
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The :mc:`bm admin decommission` command returns a list of all pools in the Buckit deployment:

.. code-block:: shell
   :class: copyable

   bm admin decommission status mybuckit

The command returns output similar to the following:

.. code-block:: shell

   ┌─────┬────────────────────────────────────────────────────────────────┬──────────────────────────────────┬────────┐
   │ ID  │ Pools                                                          │ Capacity                         │ Status │
   │ 1st │ https://buckit-{01...04}.example.com:9000/mnt/disk{1...4}/buckit │  10 TiB (used) / 10  TiB (total) │ Active │
   │ 2nd │ https://buckit-{05...08}.example.com:9000/mnt/disk{1...4}/buckit │  95 TiB (used) / 100 TiB (total) │ Active │
   │ 3rd │ https://buckit-{09...12}.example.com:9000/mnt/disk{1...4}/buckit │  40 TiB (used) / 500 TiB (total) │ Active │
   │ 4th │ https://buckit-{13...16}.example.com:9000/mnt/disk{1...4}/buckit │  0  TiB (used) / 500 TiB (total) │ Active │
   └─────┴────────────────────────────────────────────────────────────────┴──────────────────────────────────┴────────┘

The example deployment above has three pools. 
Each pool has four servers with four drives each.

Identify the target pool for decommissioning and review the current capacity.
The remaining pools in the deployment *must* have sufficient total capacity to migrate all object stored in the decommissioned pool.

In the example above, the deployment has 1110TiB total storage with 145TiB used.

- The first pool (``buckit-{01...04}``) is the first decommissioning target, as it was provisioned when the Buckit deployment was created and is completely full.
- The second pool (``buckit-{05...08}``) is the second decommissioning target, as it was also provisioned when the Buckit deployment was created and is nearly full.
- The fourth pool (``buckit-{13...16}``) is a newly added pool with new hardware from a completed server expansion.

The third and fourth pools can absorb all objects stored on the first pool without significantly impacting total available storage.

.. important:: 

   Complete any server expansion to add new storage resources _before_ beginning a decommission process.

2) Start the Decommissioning Process
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. admonition:: Decommissioning is Permanent
   :class: warning

   Once Buckit begins decommissioning the pools, it marks those pools as *permanently* inactive ("draining"). 
   Cancelling or otherwise interrupting the decommissioning procedure does **not** restore the pools to an active state. 

   Review and validate that you are decommissioning the correct pools *before* running the following command.

Use the :mc-cmd:`bm admin decommission start` command to begin decommissioning the target pool. 
Specify the :ref:`alias <alias>` of the deployment and a comma-separated list of the full description of each pool to decommission, including all hosts, disks, and file paths.

.. code-block:: shell
   :class: copyable

   bm admin decommission start mybuckit/ https://buckit-{01...04}.example.net:9000/mnt/disk{1...4}/buckit,https://buckit-{05...08}.example.net:9000/mnt/disk{1...4}/buckit

The example command begins decommissioning the two listed matching server pools on the ``mybuckit`` deployment.

During the decommissioning process, Buckit continues routing read operations (``GET``, ``LIST``, ``HEAD``) operations to the pools for those objects not yet migrated. 
Buckit routes all new write operations (``PUT``) to the remaining pools in the deployment not scheduled for decommissioning.

Draining of decommissioned pools happens one pool at a time, completing the decommission of each pool in sequence.
Draining does _not_ happen concurrently for all decommissioning pools.

Load balancers, reverse proxy, or other network control components which manage connections to the deployment do not need to modify their configurations at this time.

3) Monitor the Decommissioning Process
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :mc-cmd:`bm admin decommission status` command to monitor the decommissioning process. 

.. code-block:: shell
   :class: copyable

   bm admin decommission status mybuckit

The command returns output similar to the following:

.. code-block:: shell

   ┌─────┬────────────────────────────────────────────────────────────────┬──────────────────────────────────┬──────────┐
   │ ID  │ Pools                                                          │ Capacity                         │ Status   │
   │ 1st │ https://buckit-{01...04}.example.com:9000/mnt/disk{1...4}/buckit │  10 TiB (used) / 10  TiB (total) │ Draining │
   │ 2nd │ https://buckit-{05...08}.example.com:9000/mnt/disk{1...4}/buckit │  95 TiB (used) / 100 TiB (total) │ Pending  │
   │ 3rd │ https://buckit-{09...12}.example.com:9000/mnt/disk{1...4}/buckit │  40 TiB (used) / 500 TiB (total) │ Active   │
   │ 4th │ https://buckit-{13...16}.example.com:9000/mnt/disk{1...4}/buckit │  0  TiB (used) / 500 TiB (total) │ Active   │
   └─────┴────────────────────────────────────────────────────────────────┴──────────────────────────────────┴──────────┘

You can retrieve more detailed information by specifying the description of the server pool to the command:

.. code-block:: shell
   :class: copyable

   bm admin decommission status mybuckit https://buckit-{01...04}.example.com:9000/mnt/disk{1...4}/buckit

The command returns output similar to the following:

.. code-block:: shell

   Decommissioning rate at 100MiB/sec [1TiB/10TiB]
   Started: 30 minutes ago

:mc-cmd:`bm admin decommission status` marks the :guilabel:`Status` as :guilabel:`Complete` once decommissioning is completed. 
You can move on to the next step once Buckit completes decommissioning for all pools.

If :guilabel:`Status` reads as failed, you can re-run the :mc-cmd:`bm admin decommission start` command to resume the process. 
For persistent failures, use :mc:`bm admin logs` or review the systemd logs (e.g. ``journalctl -u minio``) to identify more specific errors.

4) Remove the Decommissioned Pools from the Deployment Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Once decommissioning completes, you can safely remove the pools from the deployment configuration. 
Modify the startup command for each remaining Buckit server in the deployment and remove the decommissioned pool.

The ``.deb`` or ``.rpm`` packages install a `systemd <https://www.freedesktop.org/wiki/Software/systemd/>`__ service file to ``/usr/lib/systemd/system/buckit.service``.

The ``buckit.service`` file uses an environment file located at ``/etc/default/minio`` for sourcing configuration settings, including the startup. 
Specifically, the ``MINIO_VOLUMES`` variable sets the startup command:

.. code-block:: shell
   :class: copyable

   cat /etc/default/minio | grep "MINIO_VOLUMES"

The command returns output similar to the following:

.. code-block:: shell

   MINIO_VOLUMES="https://buckit-{1...4}.example.net:9000/mnt/disk{1...4}/buckit https://buckit-{5...8}.example.net:9000/mnt/disk{1...4}/buckit https://buckit-{9...12}.example.net:9000/mnt/disk{1...4}/buckit"

Edit the environment file and remove the decommissioned pools from the ``MINIO_VOLUMES`` value.

5) Update Network Control Plane
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Update any load balancers, reverse proxies, or other network control planes to remove the decommissioned server pools from the connection configuration for the Buckit deployment.

Specific instructions for configuring network control plane components is out of scope for this procedure.

6) Restart the Buckit Deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Issue the following commands on each node **simultaneously** in the deployment to restart the Buckit service:

.. include:: /includes/linux/common-installation.rst
   :start-after: start-install-minio-restart-service-desc
   :end-before: end-install-minio-restart-service-desc

.. include:: /includes/common-installation.rst
   :start-after: start-nondisruptive-upgrade-desc
   :end-before: end-nondisruptive-upgrade-desc

Once the deployment is online, use :mc:`bm admin info` to confirm the uptime of all remaining servers in the deployment.
