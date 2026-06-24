:orphan:

.. _bm-web-operations:

============================
Cluster and Node Operations
============================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

You can use the :ref:`Buckit Manager web interface <buckit-manager-web>` to run
operations against a cluster, a set of hosts, or a single node. This page
describes the available operations and how they run.

Buckit Manager runs operations over two transports:

- **Admin API** — operations dispatched through the Buckit admin API. These
  require admin credentials for the cluster.
- **SSH** — operations that run commands on the hosts over SSH, such as
  ``systemctl`` actions, upgrades, reboots, and provisioning. These require
  :ref:`SSH credentials <bm-web-settings>` for the cluster.

After an operation finishes, it is recorded in :ref:`History
<bm-web-settings>` and the cluster view refreshes.

.. note::

   Some operations are available only on Buckit clusters. On clusters still
   running MinIO Community Edition, these actions are disabled with a hint to
   migrate the cluster first. See :ref:`bm-web-adding-clusters`.

.. _bm-web-cluster-operations:

Cluster Actions
---------------

Open the :guilabel:`Cluster Actions` menu on the :ref:`cluster detail page
<bm-web-cluster-detail>` to run cluster-wide operations. The menu groups
operations by transport.

Admin API
~~~~~~~~~

The :guilabel:`CLI equivalent` column lists the matching :mc:`bm admin`
command. Replace ``ALIAS`` with the :mc-cmd:`alias <bm alias>` of the cluster;
Buckit Manager creates an alias for each cluster it deploys or imports.

.. list-table::
   :header-rows: 1
   :widths: 24 50 26
   :width: 100%

   * - Operation
     - Description
     - CLI equivalent

   * - :guilabel:`Restart cluster`
     - Sends a restart signal through the admin API. Every node re-execs in
       place, causing roughly three seconds of cluster unavailability.
     - ``bm admin service restart ALIAS``

   * - :guilabel:`Stop cluster`
     - Stops the Buckit service on every node through the admin API. The S3 API
       and console are unreachable until you start the cluster again. Data and
       configuration are not affected. If the cluster runs under systemd, the
       service may respawn immediately — use :guilabel:`Stop cluster
       (systemctl)` to leave it down.
     - ``bm admin service stop ALIAS``

   * - :guilabel:`Freeze S3 API` / :guilabel:`Unfreeze S3 API`
     - Freezes or resumes all S3 API calls (reads and writes). The admin API
       continues to work while frozen. Use only during maintenance.
     - ``bm admin service freeze ALIAS`` / ``bm admin service unfreeze ALIAS``

   * - :guilabel:`Start heal`
     - Triggers a heal scan through the admin API. The scan runs server-side
       and may take hours on a large deployment. Buckit Manager follows the
       event stream live; stopping the follow does not stop the scan.
     - ``bm admin heal ALIAS``

   * - :guilabel:`Upgrade cluster via Admin API`
     - Uses the Buckit admin API self-update flow. Downloads the selected
       release binary and restarts every node together. Use this for clusters
       that are not managed by systemd.
     - ``bm admin update ALIAS``

SSH
~~~

.. list-table::
   :header-rows: 1
   :widths: 28 72
   :width: 100%

   * - Operation
     - Description

   * - :guilabel:`Rolling restart (systemctl)`
     - Restarts the Buckit service one node at a time over SSH, waiting for
       each node to report healthy before moving to the next. No cluster
       downtime.

   * - :guilabel:`Start cluster (systemctl)`
     - Starts a stopped cluster by running ``systemctl start`` on every node
       over SSH.

   * - :guilabel:`Stop cluster (systemctl)`
     - Stops the Buckit service on every node over SSH. Unlike the admin API
       stop, the systemd unit ends up inactive and is not respawned, so the
       cluster stays down until you start it again.

   * - :guilabel:`Upgrade Buckit systemd service`
     - Stages the selected version on every node without restarting, then
       restarts the cluster once through the admin API after all nodes are
       updated.

   * - :guilabel:`Rotate root password`
     - Rewrites the cluster root password on every node and restarts the
       cluster. If a node does not already use a separate reloadable
       environment file, Buckit Manager first moves the current password into
       one and performs a rolling restart. It then writes the new password to
       every node, restarts the cluster through the admin API, waits for
       health, and rolls back on failure.

       .. important::

          Existing S3 clients, applications, and CLI sessions using the old
          credentials stop working at cutover. Update them before clients
          reconnect.

Manager
~~~~~~~

The gear menu next to the cluster name holds manager-level settings that do not
change cluster state directly:

- :guilabel:`Configure SSH credentials` — set the SSH credentials Buckit
  Manager uses to reach this cluster. See :ref:`bm-web-settings`.
- :guilabel:`Set admin credentials` — set the admin API root credentials
  Buckit Manager uses for this cluster.
- :guilabel:`Remove cluster definition` — stop tracking the cluster in this
  manager. Hosts and data are not changed; you can re-import the cluster later.
  This action requires typing the cluster name to confirm.

.. _bm-web-host-operations:

Host Actions
------------

On the :ref:`cluster detail page <bm-web-cluster-detail>`, select one or more
hosts using the row checkboxes to enable the host action bar above the nodes
table. Host actions run over SSH against every selected host:

.. list-table::
   :header-rows: 1
   :widths: 28 72
   :width: 100%

   * - Operation
     - Description

   * - :guilabel:`Systemctl restart service`
     - Restarts the Buckit service on each selected host, one at a time,
       waiting for each node to report healthy before moving on.

   * - :guilabel:`Reboot host`
     - Reboots each selected host over SSH, one at a time, then waits for the
       node to rejoin the cluster. Requires typing ``REBOOT`` to confirm.

   * - :guilabel:`Shut down host`
     - Powers off each selected host. The hosts stay down until you power them
       on manually. Requires typing ``SHUTDOWN`` to confirm.

.. warning::

   Do not reboot or shut down more than one host at a time, or the cluster may
   lose quorum.

.. _bm-web-node-operations:

Node Actions
------------

The :guilabel:`Actions` menu on the :ref:`node detail page
<bm-web-node-detail>` runs operations scoped to that single node, grouped by
category:

.. list-table::
   :header-rows: 1
   :widths: 22 28 50
   :width: 100%

   * - Group
     - Operation
     - Description

   * - Service
     - :guilabel:`Systemctl restart service`
     - Restarts the Buckit service on this node and waits for it to report
       healthy.

   * - Service
     - :guilabel:`Systemctl stop service`
     - Stops the Buckit service on this node. The pool continues serving
       through other nodes, but with reduced quorum margin.

   * - Service
     - :guilabel:`Systemctl start service`
     - Starts the Buckit service on this node and waits for it to report
       healthy.

   * - Software
     - :guilabel:`Provision replacement node`
     - Brings a clean replacement host online as a full cluster member by
       mirroring a healthy same-pool peer's configuration, then installs and
       starts the matching Buckit version. The replacement host must meet the
       following requirements:

       - A supported Linux operating system is already installed, matching the
         same distribution version and kernel as the other nodes in the
         cluster, and the host is reachable over SSH using the cluster's
         :ref:`SSH credentials <bm-web-ssh-credentials>`.
       - The host uses the same hostname as the node it replaces. The cluster
         references each node by hostname in its volume configuration, so the
         replacement must come up under that hostname to rejoin in place.
       - The data drives are formatted as XFS and mounted at the same mount
         points the other nodes in the pool use. Buckit Manager verifies that
         each data path lands on a real mount point and fails preflight if an
         intended drive is not mounted — otherwise data could be written to the
         system disk.
       - The host is clean: no existing Buckit or MinIO configuration files,
         and the data drives contain no leftover data.

   * - Diagnostics
     - :guilabel:`View service log`
     - Opens the :ref:`service log viewer <bm-web-node-logs>` for the node.

   * - Host
     - :guilabel:`Reboot host`
     - Reboots this host and waits for it to rejoin the cluster. Requires
       typing ``REBOOT`` to confirm.

   * - Host
     - :guilabel:`Shut down host`
     - Powers off this host. It stays down until you power it on manually.
       Requires typing ``SHUTDOWN`` to confirm.
