:orphan:

.. _bm-web-monitoring:

=============================
Monitoring Clusters and Nodes
=============================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

You can use the :ref:`Buckit Manager web interface <buckit-manager-web>` to
monitor the health and status of every cluster you manage, drill into
individual nodes, and review per-node service logs. This page describes the
monitoring views.

.. _bm-web-clusters-list:

Clusters List
-------------

The :guilabel:`Clusters` page is the default landing page and lists every
cluster registered with this manager. Each row summarizes one cluster:

.. list-table::
   :header-rows: 1
   :widths: 20 80
   :width: 100%

   * - Column
     - Description

   * - :guilabel:`Name`
     - The cluster's display name. Clusters still running MinIO Community
       Edition are tagged with a :guilabel:`MinIO` pill. Select the name to
       open the cluster detail page.

   * - :guilabel:`Pools`
     - The number of server pools in the cluster.

   * - :guilabel:`Nodes (Online/Total)`
     - The number of nodes reporting online out of the total. The online count
       is highlighted when it is below the total.

   * - :guilabel:`Drives (Ready/Total)`
     - The number of drives in the ready state out of the total, highlighted
       when below the total.

   * - :guilabel:`Version`
     - The Buckit (or MinIO) version the cluster is running.

   * - :guilabel:`Health`
     - An overall health pill: :guilabel:`Healthy`, :guilabel:`Degraded`,
       :guilabel:`Critical`, or :guilabel:`Unknown`.

   * - :guilabel:`Used`
     - Used capacity out of usable capacity.

Buckit Manager fetches fresh cluster state in the background. The page header
shows how long ago the data was last fetched and provides a :guilabel:`Refresh`
button to fetch on demand. If the data becomes stale, Buckit Manager refreshes
it automatically.

From this page you can also start the :guilabel:`Deploy new cluster` and
:guilabel:`Import existing cluster` flows. See :ref:`bm-web-adding-clusters`.

.. _bm-web-cluster-detail:

Cluster Details
---------------

Selecting a cluster opens the cluster detail page. When the page opens and at a
regular interval while it is open, Buckit Manager refreshes the cluster state
and re-probes connectivity so the view stays current.

The header shows the cluster name, an overall health pill, and the cluster
metadata (version, node count, pool count, and erasure-coding parity). For
clusters migrated from MinIO, the header also notes the original MinIO version.

Summary Cards
~~~~~~~~~~~~~

Three summary cards sit below the header:

- :guilabel:`Health` — the overall health pill plus a breakdown of nodes online
  (and any degraded or offline) and drives ready (and any healing or failed).
- :guilabel:`Capacity` — used capacity out of usable capacity, with a usage
  bar and percent used.
- :guilabel:`Pools` — a per-pool health rollup. Each pool shows its own health
  pill and node and drive counts. When a cluster has many pools, the card shows
  the worst-health pools first and lets you expand to see the rest, so a
  problem is never hidden behind healthy pools.

Nodes Table
~~~~~~~~~~~

The nodes table lists every node in the cluster. Each row links to the
:ref:`node detail page <bm-web-node-detail>` and shows:

.. list-table::
   :header-rows: 1
   :widths: 18 82
   :width: 100%

   * - Column
     - Description

   * - :guilabel:`Host`
     - The node hostname. Select it to open the node detail page.

   * - :guilabel:`Pool`
     - The server pool the node belongs to.

   * - :guilabel:`State`
     - The node state: :guilabel:`Online`, :guilabel:`Degraded`,
       :guilabel:`Offline`, :guilabel:`Unreachable`, or :guilabel:`Unknown`.

   * - :guilabel:`Version`
     - The Buckit version running on the node.

   * - :guilabel:`Ping`, :guilabel:`SSH`, :guilabel:`S3 API`,
       :guilabel:`Console`
     - Connectivity probes. A green dot indicates the probe succeeded; a red
       mark indicates it failed. The probes cover ICMP/TCP reachability, a TCP
       connection to the SSH port, the S3 API, and the Buckit web console.

   * - :guilabel:`Kernel`
     - The node's kernel version.

   * - :guilabel:`Uptime`
     - How long the node has been up.

The table supports per-column filtering (host, pool, state, version, and
kernel) and column sorting. By default, nodes are grouped by pool in ascending
order, with hostnames sorted alphabetically within each pool.

Use the row checkboxes to select one or more hosts and run host-level
operations from the action bar above the table. See
:ref:`bm-web-host-operations`.

You can run cluster-wide operations from the :guilabel:`Cluster Actions` menu,
and open cluster settings from the gear menu next to the cluster name. See
:ref:`bm-web-operations`. If the cluster is still running MinIO, the header also
offers :guilabel:`Migrate to Buckit` and a link to open the MinIO console.

.. _bm-web-node-detail:

Node Details
------------

Selecting a node opens the node detail page, which provides a focused view of a
single host. Buckit Manager refreshes the node and re-runs its connectivity
probes when the page opens and at a regular interval while it is open.

The page presents three cards:

- :guilabel:`System` — operating system, kernel version and architecture, and
  the last boot time.
- :guilabel:`Hardware` — CPU model, socket and core counts, clock speed, total
  and free RAM, and the primary network interface and link speed.
- :guilabel:`Connectivity` — the same Ping, SSH, S3 API, and Console probe
  results shown in the nodes table, in an expanded form.

.. note::

   Detailed hardware facts (CPU, memory, NIC) require valid admin credentials
   for the cluster. If admin credentials are not configured, Buckit Manager
   shows a note in the System card. See :ref:`bm-web-settings`.

Below the cards, the :guilabel:`Drives` table lists each data drive on the node
with its mount point, device, size, used percentage, and status
(:guilabel:`Ready`, :guilabel:`Healing` with percent complete,
:guilabel:`Failed`, or :guilabel:`Unknown`). Boot drives are excluded.

The :guilabel:`Actions` menu on this page runs node-scoped operations. See
:ref:`bm-web-node-operations`.

.. _bm-web-node-logs:

Service Logs
------------

From the node :guilabel:`Actions` menu, select :guilabel:`View service log` to
open the per-node log viewer. Buckit Manager fetches recent ``journalctl``
output for the Buckit service from the node over SSH.

The log viewer provides:

- A :guilabel:`Range` selector (last 15 minutes, hour, 6 hours, 24 hours, or
  7 days).
- A :guilabel:`Filter` field for client-side substring matching.
- A :guilabel:`Refresh` button to re-fetch the latest lines.

The log viewer performs a one-shot fetch each time you choose a range or select
:guilabel:`Refresh`; it is not a continuous live tail. Lines that look like
errors or warnings are color-coded.

.. note::

   Viewing service logs requires SSH credentials for the cluster. If SSH is not
   configured, Buckit Manager prompts you to set it up. See
   :ref:`bm-web-settings`.
