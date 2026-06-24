.. _minio-restore-hardware-failure-node:

=====================
Node Failure Recovery
=====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

If a Buckit node suffers complete hardware failure (e.g. loss of all drives,
data, etc.), the node begins :ref:`healing operations <minio-concepts-healing>` once it rejoins the deployment.
Buckit healing occurs only on the replaced hardware and does not typically impact
deployment performance.

Buckit healing ensures consistency and correctness of all data restored onto the
drive.

.. include:: /includes/common-admonitions.rst
   :start-after: start-exclusive-drive-access
   :end-before: end-exclusive-drive-access

The replacement node hardware should be substantially similar to the failed
node. There are no negative performance implications to using improved hardware.

The replacement drive hardware should be substantially similar to the failed
drive. For example, replace a failed SSD with another SSD drive of the same
capacity. While you can use drives with larger capacity, Buckit uses the
*smallest* drive's capacity as the ceiling for all drives in the 
:ref:`Server Pool <minio-intro-server-pool>`.

The following steps provide a more detailed walkthrough of node replacement.
These steps assume a Buckit deployment where each node has a DNS hostname 
as per the :ref:`documented prerequisites <minio-installation>`.

1) Start the Replacement Node
-----------------------------

Ensure the new node has received all necessary security, firmware, and OS
updates as per industry, regulatory, or organizational standards and
requirements.

The new node software configuration *must* match that of the other nodes in the
deployment, including but not limited to the OS and Kernel versions and
configurations. Heterogeneous software configurations may result in unexpected
or undesired behavior in the deployment.

2) Update Hostname for the New Node
-----------------------------------

*Optional* This step is only required if the replacement node has a
different IP address from the failed host.

Ensure the hostname associated to the failed node now resolves to the new node.

For example, if ``https://buckit-1.example.net`` previously resolved to the
failed host, it should now resolve to the new host.

3) Prepare and Rejoin the Replacement Node
------------------------------------------

Choose one of the following options to prepare the replacement node and
rejoin it to the deployment.

Option 1: Use Buckit Manager Web UI (bm web)
++++++++++++++++++++++++++++++++++++++++++++

1. Install Buckit Manager if needed. See :ref:`Install the Buckit Manager <install-buckit-manager>`.
2. If the cluster is not already registered in Buckit Manager, click
   :guilabel:`+ Import existing cluster` and complete the import.
3. Open the target cluster.
4. If SSH credentials are not already configured for the cluster, open the
   cluster settings and save the :guilabel:`SSH credentials` Buckit Manager
   uses to reach the cluster hosts.
5. Click the failed node's replacement host to open its node details page.
6. Click the :guilabel:`Node Actions` dropdown menu.
7. Select :guilabel:`Provision replacement node...` and follow the prompts.

Buckit Manager copies the required configuration from a healthy peer in the
same pool, installs the matching Buckit package version, starts the service,
and waits for the node to report healthy.

The replacement host must be clean before starting this workflow:

- No existing Buckit or MinIO configuration files on the target host.
- Data drives mounted at the intended mount points with no remaining data.

Option 2: Use CLI
++++++++++++++++++++

Follow the :ref:`deployment procedure <minio-installation>` to install and
run Buckit on the replacement node using a matching configuration as the
other nodes in the deployment.

- The Buckit server version *must* match across all nodes.
- The Buckit service and environment file configurations *must* match across
  all nodes.

Start the :mc:`buckit server <buckit server>` process on the node and monitor
the process output using :mc:`bm admin logs` or by monitoring the Buckit
service logs using ``journalctl -u buckit`` for systemd managed installations.

The server output should indicate that it has detected the other nodes in the
deployment and begun :ref:`healing operations <minio-concepts-healing>`.

4) Monitor Healing
------------------

Use :mc:`bm admin heal` to monitor overall healing status on the deployment.
Buckit aggressively heals the node to ensure rapid recovery from the degraded
state.

5) Next Steps
-------------

Continue monitoring the deployment until healing completes. Deployments with
persistent and repeated node failures should schedule dedicated maintenance to
identify the root cause.
