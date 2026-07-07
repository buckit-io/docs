.. _deploy-buckit-guided-bm-remote:

========================================
Deploy Buckit on Remote Servers
========================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

Use this workflow to deploy Buckit as a managed cluster on one or more Linux
servers over SSH.

Buckit Manager connects to each target server, checks the system and storage
layout, installs Buckit, writes configuration files, starts the systemd
service, and waits for health checks to pass.

Prerequisites
-------------

Prepare the following before you begin:

- A Windows, macOS, or Linux computer with Buckit Manager installed.
- One or more Linux target servers reachable over SSH.
- SSH credentials for a user with permission to install packages, write service
  configuration, create storage directories, and manage systemd services.
  Use ``root`` or a user with passwordless ``sudo`` access.
- One or more data drives or data directories on each target server.

For multi-server or multi-drive deployments, use a consistent data path pattern
on every target server, such as ``/mnt/data{1...4}``.

Start the Remote Servers Wizard
-------------------------------

1. Start the Buckit Manager web interface:

   .. code-block:: shell
      :class: copyable

      bm web

2. Open :guilabel:`Deploy a new cluster`.
3. Select :guilabel:`Remote servers`.

If ``bm web`` is running on Linux, Buckit Manager opens this wizard directly.

Settings
--------

Enter the basic settings for the new cluster:

- Cluster name: the name Buckit Manager uses to identify the cluster.
- Buckit version: the Buckit release to install on the target servers.
- Login credentials: the root username and password for the new cluster.
- API port: the S3 API port used by applications and tools to connect to
  Buckit.
- Console port: the port used for the Buckit web console.
- Region: the region label reported by the cluster to compatible clients.
- TLS certificate and key: optional files used to enable HTTPS during
  deployment.

Nodes and SSH
-------------

Provide the target server hostnames and SSH credentials.

For best results, use a consistent hostname pattern such as
``buckit{1...4}.example.net``.

Ensure the computer running ``bm`` can reach each target server over SSH. You
can also set different SSH settings for individual servers if needed.

Discover Servers
----------------

Buckit Manager connects to each server over SSH and collects basic system
information, including operating system, CPU, memory, and mounted drives.

Review the discovered details before continuing.

Storage Layout
--------------

Buckit Manager uses the discovered drives to suggest a cluster layout.

In this step, you:

- Choose which mounted data drives Buckit should use on each server.
- Confirm that the same drive mount path pattern exists on every server.
- Review the suggested layout for the cluster.

If the deployment uses 2 or more drives, Buckit Manager also suggests erasure
coding settings based on the total number of selected drives.

The main settings in this step are:

- Storage drives: choose which mounted data drives Buckit should use on each
  server.
- Set size: the number of drives in one Erasure Set. An Erasure Set is a group
  of drives Buckit uses together to store data and recovery data. If there are
  too many selected drives for one set, Buckit divides them into multiple
  Erasure Sets of this size.
- Parity: the number of drives in each Erasure Set reserved for recovery.
  Higher parity gives more protection, but leaves less usable storage capacity.

If Buckit Manager cannot find the same drive mount path pattern on all target
servers, the guided deployment wizard cannot build a valid shared layout for
the cluster.

Preflight and Deploy
--------------------

Run the preflight check before deployment. Fix any required errors before
continuing. Warnings do not always stop the deployment, but you should review
them before moving on.

After preflight succeeds:

1. Review the deployment settings.
2. Start the deployment.

Buckit Manager shows progress for each server while it downloads the package,
installs Buckit, writes configuration files, starts the systemd service, and
waits for health checks to pass.

Post-Deployment
---------------

After the guided deployment finishes successfully, the wizard shows a final
summary page. When you finish, ``bm web`` opens the Cluster Details page.

On the Cluster Details page, you can:

- Open the Buckit Console using the cluster console URL.
- Monitor cluster and node health, drive status, and basic cluster
  information.
- Run restart, upgrade, or heal actions at the cluster or node level.

The wizard also creates a ``bm`` alias for the new cluster using the committed
cluster ID. For example, if the cluster ID is ``buckit-prod-1``, you can run:

.. code-block:: shell
   :class: copyable

   bm admin info buckit-prod-1

See :doc:`/reference/bm-admin` for more ``bm`` CLI commands.
