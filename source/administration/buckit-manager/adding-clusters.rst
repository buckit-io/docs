:orphan:

.. _bm-web-adding-clusters:

===============
Adding Clusters
===============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

You can use the :ref:`Buckit Manager web interface <buckit-manager-web>` to add
clusters in three ways: deploy a brand new cluster, import a running
deployment, or migrate a MinIO Community Edition cluster to Buckit. The
:guilabel:`Wizards` section and the buttons on the :ref:`Clusters page
<bm-web-clusters-list>` start these flows.

When the manager has no clusters yet, the web interface opens on a welcome page
that offers the deploy and import flows directly.

.. _bm-web-deploy-new:

Deploy a New Cluster
--------------------

The :guilabel:`Deploy a new cluster` wizard installs Buckit on fresh Linux
hosts you can reach over SSH and forms them into a new cluster. The wizard
guides you through these steps:

#. :guilabel:`Basics` — name the cluster and choose the Buckit version, root
   credentials, S3 API and console ports, region, and optional TLS certificate
   and key.
#. :guilabel:`Nodes` — enter the target hostnames and the SSH credentials
   Buckit Manager uses to reach them. You can override SSH settings per host.
#. :guilabel:`Discover` — Buckit Manager connects to each host over SSH and
   collects the operating system, CPU, memory, and mounted drives.
#. :guilabel:`Topology` — choose which data drives to use and confirm the
   erasure-coding set size and parity for the cluster layout.
#. :guilabel:`Preflight` — Buckit Manager validates each host. Blocking errors
   must be resolved before continuing; advisory warnings do not stop the
   deploy.
#. :guilabel:`Review` — review the full deployment plan.
#. :guilabel:`Deploy` — Buckit Manager downloads the package, installs Buckit,
   writes configuration, starts the service, and waits for health on each host,
   showing per-node progress.
#. :guilabel:`Done` — a summary of the new cluster.

.. note::

   The guided deployment wizard installs Buckit only on Linux target hosts.

For a step-by-step walkthrough of this wizard, see
:ref:`deploy-buckit-guided-bm`.

.. _bm-web-import:

Import an Existing Cluster
--------------------------

The :guilabel:`Import existing cluster` flow registers a running Buckit or
MinIO deployment so you can monitor and operate it from Buckit Manager.

Provide the cluster's S3 endpoint and root credentials:

- :guilabel:`Cluster URL` — the S3 endpoint of any node in the cluster, or the
  load balancer if you have one.
- :guilabel:`Access key` and :guilabel:`Secret key` — the root credentials the
  server was started with.

Buckit Manager contacts the admin API and discovers every node, drive, and
pool. While discovery runs, the interface streams progress. When discovery
finishes, it shows a summary — engine (Buckit or MinIO), version, node, pool,
and drive counts, parity, and capacity — and lets you name the cluster before
saving. After you save, Buckit Manager opens the cluster detail page.

.. _bm-web-migrate:

Migrate MinIO to Buckit
-----------------------

Clusters imported as MinIO Community Edition can be upgraded in place to the
latest Buckit — same disks, same data. Start the migration from the
:guilabel:`Migrate to Buckit` button on the detail page of an imported MinIO
cluster.

The migration wizard guides you through these steps:

#. :guilabel:`Overview` — choose the target Buckit version and review the plan.
#. :guilabel:`SSH credentials` — provide the SSH credentials and per-host ports
   Buckit Manager uses to run the cutover. These are saved to the cluster so
   later operations can reuse them.
#. :guilabel:`Preflight Check` — Buckit Manager takes a snapshot of the MinIO
   deployment's configuration (buckets, users, groups, policies, service
   accounts, lifecycle rules, notifications, and replication targets) and runs
   preflight validation. Blocking failures must be resolved before continuing.
#. :guilabel:`Migrate` — Buckit Manager performs the cutover node by node:
   stopping MinIO, installing the Buckit package, switching the systemd unit,
   and waiting for health. It then verifies that the migrated cluster's
   buckets, objects, and identity configuration match the snapshot, and rolls
   back on failure.

For a complete migration guide, including prerequisites and rollback behavior,
see :ref:`migrate-minio-community-edition`.

.. important::

   Existing applications and clients continue to use the same S3 endpoint and
   credentials after migration. The underlying data and drives are preserved.
