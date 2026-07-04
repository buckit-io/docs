.. _expand-minio-distributed:

======================================
Expand a Distributed Buckit Deployment
======================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

Buckit supports expanding an existing distributed deployment by adding a new :ref:`Server Pool <minio-intro-server-pool>`. 
Each Pool expands the total available storage capacity of the cluster.

Expansion does not provide Business Continuity/Disaster Recovery (BC/DR)-grade protections.
While each pool is an independent set of servers with distinct :ref:`erasure sets <minio-ec-erasure-set>` for availability, the complete loss of one pool results in Buckit stopping I/O for all pools in the deployment.
Similarly, an erasure set which loses quorum in one pool represents data loss of objects stored in that set, regardless of the number of other erasure sets or pools.

The new server pool does **not** need to use the same type or size of hardware and software configuration as any existing server pool, though doing so may allow for simplified cluster management and more predictable performance across pools.
All drives in the new pool **should** be of the same type and size within the new pool.
Review Buckit's :ref:`hardware recommendations <minio-hardware-checklist>` for more complete guidance on selecting an appropriate configuration.

To provide BC-DR grade failover and recovery support for your single or multi-pool Buckit deployments, use :ref:`site replication <minio-site-replication-overview>`.

The procedure on this page expands an existing :ref:`distributed <deploy-minio-distributed>` Buckit deployment with an additional server pool. 

.. important::

   Buckit does not support expanding Single-Node Single-Drive topologies.

.. _expand-minio-distributed-prereqs:

Prerequisites
-------------

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

All Buckit servers in the deployment *must* use the same listen port.

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
The :ref:`integrations-nginx-proxy` reference provides a baseline configuration for using NGINX as a reverse proxy with basic load balancing configured.

Sequential Hostnames
~~~~~~~~~~~~~~~~~~~~

Buckit *requires* using expansion notation ``{x...y}`` to denote a sequential
series of Buckit hosts when creating a server pool. Buckit therefore *requires*
using sequentially-numbered hostnames to represent each
:mc:`buckit server <buckit server>` process in the pool. 

Create the necessary DNS hostname mappings *prior* to starting this procedure.
For example, the following hostnames would support a 4-node distributed
server pool:

- ``buckit5.example.com``
- ``buckit6.example.com``
- ``buckit7.example.com``
- ``buckit8.example.com``

You can specify the entire range of hostnames using the expansion notation
``buckit{5...8}.example.com``.

Configuring DNS to support Buckit is out of scope for this procedure.

Storage Requirements
~~~~~~~~~~~~~~~~~~~~

.. |deployment| replace:: server pool

.. include:: /includes/common-installation.rst
   :start-after: start-storage-requirements-desc
   :end-before: end-storage-requirements-desc

.. include:: /includes/common-admonitions.rst
   :start-after: start-exclusive-drive-access
   :end-before: end-exclusive-drive-access

Minimum Drives for Erasure Code Parity
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit requires each pool satisfy the deployment :ref:`erasure code
<minio-erasure-coding>` settings. Specifically the new pool topology must 
support a minimum of ``2 x EC:N`` drives per 
:ref:`erasure set <minio-ec-erasure-set>`, where ``EC:N`` is the 
:ref:`Standard <minio-ec-storage-class>` parity storage class of the
deployment. This requirement ensures the new server pool can satisfy the
expected :abbr:`SLA (Service Level Agreement)` of the deployment.

You can use the 
`Erasure Code Calculator
<../../_static/ec-calculator.html>`__ to check the
:guilabel:`Erasure Code Stripe Size (K+M)` of your new pool. If the highest
listed value is at least ``2 x EC:N``, the pool supports the deployment's
erasure parity settings.

Time Synchronization
~~~~~~~~~~~~~~~~~~~~

Multi-node systems must maintain synchronized time and date to maintain stable internode operations and interactions.
Make sure all nodes sync to the same time server regularly.
Operating systems vary for methods used to synchronize time and date, such as with ``ntp``, ``timedatectl``, or ``timesyncd``.

Check the documentation for your operating system for how to set up and maintain accurate and identical system clock times across nodes.

Back Up Cluster Settings First
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :mc:`bm admin cluster bucket export` and :mc:`bm admin cluster iam export` commands to take a snapshot of the bucket metadata and IAM configurations respectively prior to starting decommissioning.
You can use these snapshots to restore :ref:`bucket <minio-mc-admin-cluster-bucket-import>` and :ref:`IAM <minio-mc-admin-cluster-iam-import>` settings to recover from user or process errors as necessary.

Considerations
--------------

.. _minio-writing-files:

Writing Files
~~~~~~~~~~~~~

Buckit does not automatically rebalance objects across the new server pools. 
Instead, Buckit performs new write operations to the pool with the most free
storage weighted by the amount of free space on the pool divided by the free space across all available pools.

The formula to determine the probability of a write operation on a particular pool is

:math:`FreeSpaceOnPoolA / FreeSpaceOnAllPools`

Consider a situation where a group of three pools has a total of 10 TiB of free space distributed as:

- Pool A has 3 TiB of free space
- Pool B has 2 TiB of free space
- Pool C has 5 TiB of free space

Buckit calculates the probability of a write operation to each of the pools as:

- Pool A: 30% chance (:math:`3TiB / 10TiB`)
- Pool B: 20% chance (:math:`2TiB / 10TiB`)
- Pool C: 50% chance (:math:`5TiB / 10TiB`)

In addition to the free space calculation, if a write option (with parity) would bring a drive
usage above 99% or a known free inode count below 1000, Buckit does not write to the pool.

If desired, you can manually initiate a rebalance procedure with :mc:`bm admin rebalance`.
For more about how rebalancing works, see :ref:`managing objects across a deployment <minio-rebalance>`.

Likewise, Buckit does not write to pools in a decommissioning process.

Expansion is Non-Disruptive
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Adding a new server pool requires restarting *all* :mc:`buckit server <buckit server>` processes in the
deployment at around same time. 

.. include:: /includes/common-installation.rst
   :start-after: start-nondisruptive-upgrade-desc
   :end-before: end-nondisruptive-upgrade-desc

Capacity-Based Planning
~~~~~~~~~~~~~~~~~~~~~~~

Buckit recommends planning storage capacity sufficient to store **at least** 2 years of data before reaching 70% usage.
Performing :ref:`server pool expansion <expand-minio-distributed>` more frequently or on a "just-in-time" basis generally indicates an architecture or planning issue.

For example, consider an application suite expected to produce at least 100 TiB of data per year and a 3 year target before expansion.
The deployment has ~500TiB of usable storage in the initial server pool, such that the cluster safely met the 70% threshold with some buffer for data growth.
The new server pool should **ideally** meet at minimum 500TiB of additional storage to allow for a similar lifespan before further expansion.

Since Buckit :ref:`erasure coding <minio-erasure-coding>` requires some storage for parity, the total **raw** storage must exceed the planned **usable** capacity. 
Consider using the `Erasure Code Calculator <../../_static/ec-calculator.html>`__ for guidance in planning capacity around specific erasure code settings.

Recommended Operating Systems
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This tutorial assumes all hosts running Buckit use a :ref:`recommended Linux operating system <minio-installation-platform-support>`. 

All hosts in the deployment should run with matching :ref:`software configurations <minio-software-checklists>`.

.. _expand-minio-distributed-baremetal:

Expand a Distributed Buckit Deployment
--------------------------------------

The following procedure adds a :ref:`Server Pool <minio-intro-server-pool>`
to an existing Buckit deployment. Each Pool expands the total available
storage capacity of the cluster while maintaining the overall 
:ref:`availability <minio-erasure-coding>` of the cluster.

All commands provided below use example values. Replace these values with
those appropriate for your deployment.

Review the :ref:`expand-minio-distributed-prereqs` before starting this
procedure.

Complete any planned hardware expansion prior to :ref:`decommissioning older hardware pools <minio-decommissioning>`.

1) Install the Buckit Package on Each Node in the New Server Pool
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the package format appropriate for each new Linux host in the server pool.

.. tab-set::

   .. tab-item:: RPM (RHEL)

      Use the following commands to download, verify, and install the Buckit
      RPM for each new Linux host in the server pool.

      .. code-block:: shell
         :class: copyable

         curl -fsSL https://buckit-io.github.io/buckit/install-linux.sh | sh
         sudo dnf install ./buckit.rpm

   .. tab-item:: DEB (Debian/Ubuntu)

      Use the following commands to download, verify, and install the Buckit
      DEB for each new Linux host in the server pool.

      .. code-block:: shell
         :class: copyable

         curl -fsSL https://buckit-io.github.io/buckit/install-linux.sh | sh
         sudo apt install ./buckit.deb

2) Add TLS/SSL Certificates (Optional)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If the current deployment already has TLS enabled, configure matching TLS
certificates on each new node before continuing.

If the current deployment does not have TLS enabled, you can skip this step.

.. include:: /includes/common-installation.rst
   :start-after: start-install-minio-tls-desc
   :end-before: end-install-minio-tls-desc

3) Create the systemd Service File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /includes/linux/common-installation.rst
   :start-after: start-install-minio-systemd-desc
   :end-before: end-install-minio-systemd-desc

4) Create the Service Environment File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create an environment file at ``/etc/default/minio``. The Buckit 
service uses this file as the source of all 
:ref:`environment variables <minio-server-environment-variables>` used by
Buckit *and* the ``minio.service`` file.

The following examples assumes that:

- The deployment has a single server pool consisting of four Buckit server hosts
  with sequential hostnames.

  .. code-block:: shell

     buckit1.example.com   buckit3.example.com   
     buckit2.example.com   buckit4.example.com   

  Each host has 4 locally attached drives with
  sequential mount points:

  .. code-block:: shell

     /mnt/disk1/buckit   /mnt/disk3/buckit 
     /mnt/disk2/buckit   /mnt/disk4/buckit

- The new server pool consists of eight new Buckit hosts with sequential
  hostnames:

  .. code-block:: shell

     buckit5.example.com   buckit9.example.com
     buckit6.example.com   buckit10.example.com
     buckit7.example.com   buckit11.example.com
     buckit8.example.com   buckit12.example.com

- All hosts have eight locally-attached drives with sequential mount-points:

  .. code-block:: shell
     
     /mnt/disk1/buckit  /mnt/disk5/buckit
     /mnt/disk2/buckit  /mnt/disk6/buckit
     /mnt/disk3/buckit  /mnt/disk7/buckit
     /mnt/disk4/buckit  /mnt/disk8/buckit

- The deployment has a load balancer running at ``https://buckit.example.net``
  that manages connections across all Buckit hosts. The load balancer should
  not be routing requests to the new hosts at this step, but should have 
  the necessary configuration updates planned.

Modify the example to reflect your deployment topology:

.. code-block:: shell
   :class: copyable

   # Set the hosts and volumes Buckit uses at startup
   # The command uses Buckit expansion notation {x...y} to denote a
   # sequential series. 
   #
   # The following example starts the Buckit server with two server pools.
   #
   # The space delimiter indicates a seperate server pool
   #
   # The second set of hostnames and volumes is the newly added pool.
   # The pool has sufficient stripe size to meet the existing erasure code
   # parity of the deployment (2 x EC:4)
   #
   # The command includes the port on which the Buckit servers listen for each
   # server pool.

   MINIO_VOLUMES="https://buckit{1...4}.example.net:9000/mnt/disk{1...4}/buckit https://buckit{5...12}.example.net:9000/mnt/disk{1...8}/buckit"

   # Set all Buckit server options
   #
   # The following explicitly sets the Buckit Console listen address to
   # port 9001 on all network interfaces. The default behavior is dynamic
   # port selection.

   MINIO_OPTS="--console-address :9001"

   # Set the root username. This user has unrestricted permissions to
   # perform S3 and administrative API operations on any resource in the
   # deployment.
   #
   # Defer to your organizations requirements for superadmin user name.

   MINIO_ROOT_USER=buckitadmin

   # Set the root password
   #
   # Use a long, random, unique string that meets your organizations
   # requirements for passwords.

   MINIO_ROOT_PASSWORD=buckit-secret-key-CHANGE-ME

You may specify other :ref:`environment variables
<minio-server-environment-variables>` or server commandline options as required
by your deployment. All Buckit nodes in the deployment should include the same
environment variables with the matching values.

5) Restart the Buckit Deployment with Expanded Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Issue the following commands on each node **simultaneously** in the deployment
to restart the Buckit service:

.. include:: /includes/linux/common-installation.rst
   :start-after: start-install-minio-restart-service-desc
   :end-before: end-install-minio-restart-service-desc

.. include:: /includes/common-installation.rst
   :start-after: start-nondisruptive-upgrade-desc
   :end-before: end-nondisruptive-upgrade-desc

6) Next Steps
~~~~~~~~~~~~~

- Update any load balancers, reverse proxies, or other network control planes
  to route client requests to the new hosts in the Buckit distributed deployment.
  While Buckit automatically manages routing internally, having the control
  planes handle initial connection management may reduce network hops and
  improve efficiency.

- Review the :ref:`Buckit Console <minio-console>` to confirm the updated
  cluster topology and monitor performance.
