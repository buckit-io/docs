.. _deploy-buckit-guided-bm:

==========================================
Guided Deployment using Buckit Manager
==========================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

This page explains how to deploy a new Buckit cluster using the Buckit Manager
(``bm``) web interface.

Buckit Manager provides a guided deployment wizard for new servers that you can
reach over SSH. The web interface asks for your cluster settings, checks each
server, and then installs and starts Buckit on the selected nodes.

.. important::

   The guided deployment wizard in Buckit Manager currently supports installing
   Buckit only on Linux target hosts.

   If your environment requires a fully manual deployment process, use the
   platform-specific Linux, container, macOS, or Windows deployment guides in
   this section instead.

Overview
--------

The guided deployment wizard in ``bm web`` does the following:

- Collect target host information from the user, connect to each server over
  SSH, and gather basic system information.
- Suggest a cluster layout, check storage drives, server access, and package
  download access.
- Install Buckit systemd service and verify cluster health.

Install Buckit Manager
----------------------

Install ``bm`` on the system you will use to manage the deployment.

.. tab-set::

   .. tab-item:: macOS / Linux

      .. code-block:: shell
         :class: copyable

         curl -fsSL https://buckit-io.github.io/bm/install.sh | sh

   .. tab-item:: Windows PowerShell

      .. code-block:: powershell
         :class: copyable

         irm https://buckit-io.github.io/bm/install.ps1 | iex

The installer downloads the latest stable build for your operating system and
architecture and installs it into your user account.

Start the Web Interface
-----------------------

Run the following command on the system where you installed ``bm``:

.. code-block:: shell
   :class: copyable

   bm web

By default, ``bm web`` starts the application on ``http://127.0.0.1:9443/`` and
opens your default browser automatically.

Deploy a New Cluster
--------------------

Open the Buckit Manager web interface and start a new deployment.

1. Enter the basic settings for the new cluster.

   - Cluster name: the name Buckit Manager uses to identify the cluster.
   - Buckit version: the Buckit release to install on the target servers.
   - Login credentials: the root username and password for the new cluster.
   - API port: the S3 API port used by applications and tools to connect to
     Buckit.
   - Console port: the port used for the Buckit web console.
   - Region: the region label reported by the cluster to compatible clients.
   - TLS certificate and key: optional files used to enable HTTPS during
     deployment.

2. Provide the server hostnames and SSH credentials.

   For best results, use a consistent hostname pattern such as
   ``buckit{1...4}.example.net``.

   Ensure the system running ``bm`` can reach each target server over SSH.
   The SSH user must have permission to install and configure system packages, either
   as root or with passwordless sudo access.

   You can also set different SSH settings for individual servers if needed.

3. Review the server details discovered by Buckit Manager.

   Buckit Manager connects to each server over SSH and collects basic system
   information, including operating system, CPU, memory, and mounted drives.

   All target servers must use the same data drive mount path pattern, such as
   ``/mnt/data{1...4}`` on each server.

4. Configure the cluster storage layout.

   Buckit Manager uses the discovered drives to suggest a cluster layout.

   In this step, you:

   - Choose which mounted data drives Buckit should use on each server.
   - Confirm that the same drive mount path pattern exists on every server.
   - Review the suggested layout for the cluster.

   If the deployment uses 2 or more drives, Buckit Manager also suggests
   erasure coding settings based on the total number of selected drives. In
   simple terms, these settings control how much space is used for data and
   how much space is reserved to protect against drive or server failures.

   The main settings in this step are:

   - Storage drives: choose which mounted data drives Buckit should use on
     each server.
   - Set size: the number of drives in one Erasure Set. An Erasure Set is a
     group of drives Buckit uses together to store data and recovery data.
     If there are too many selected drives for one set, Buckit divides them
     into multiple Erasure Sets of this size.
   - Parity: the number of drives in each Erasure Set reserved for recovery.
     Higher parity gives more protection, but leaves less usable storage
     capacity.

   If Buckit Manager cannot find the same drive mount path pattern on all
   target servers, the guided deployment wizard cannot build a valid shared
   layout for the cluster.

5. Preflight check before deployment.

   Fix any required errors before continuing. Warnings do not always stop the
   deployment, but you should review them before moving on.

6. Review the deployment settings.

7. Start the deployment.

   Buckit Manager shows progress for each server while it downloads the
   package, installs Buckit, writes configuration files, starts the service,
   and waits for health checks to pass.

Post-Deployment
---------------

After the guided deployment finishes successfully, the wizard shows a final
summary page. When you finish, ``bm web`` opens the Cluster Details page.

On the Cluster Details page, you can:

- Open the Buckit Console using the cluster console URL.
- Confirm that the cluster, nodes, and drives are healthy.
- Review the deployed nodes and basic cluster information.
- Open the SSH settings for later node management tasks.
