.. _migrate-minio-community-edition:

====================================
Migrate from MinIO Community Edition
====================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

Overview
--------

Buckit Manager can migrate an imported MinIO Community Edition cluster to Buckit in place.
Buckit is compatible with MinIO Community Edition because it is derived from it.
The migration leaves the existing object data on disk untouched and reuses the existing MinIO user/group and environment files.
The workflow replaces the MinIO binary and ``minio.service`` runtime with the Buckit package and ``buckit.service``.
If cutover or verification fails, Buckit Manager rolls the affected hosts back to MinIO automatically.

Prerequisites
-------------

Buckit Manager
~~~~~~~~~~~~~~

Install Buckit Manager first if needed.
See :ref:`Install the Buckit Manager <install-buckit-manager>`.

Import the Source Cluster
~~~~~~~~~~~~~~~~~~~~~~~~~

If the MinIO cluster is not already registered in Buckit Manager:

1. Open ``bm web``.
2. Click :guilabel:`Import existing cluster`.
3. In :guilabel:`Import existing Buckit or MinIO cluster`, provide the :guilabel:`Cluster URL`, :guilabel:`Access key`, and :guilabel:`Secret key`.
4. Click :guilabel:`Add cluster`.

Host Requirements
~~~~~~~~~~~~~~~~~

The migration workflow expects the following on the source cluster:

- MinIO installed on Linux hosts with ``minio.service`` managed by ``systemd``.
- SSH access as ``root`` or with passwordless ``sudo`` from the ``bm`` host to the MinIO cluster hosts.

Procedure
---------

1. Open the migration wizard
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Open the imported MinIO cluster in ``bm web``.
2. Click :guilabel:`Migrate to Buckit`.

2. Choose the Buckit version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

On :guilabel:`Migration overview`, select the Buckit version to install on every host.
Buckit Manager loads this version list from the available Buckit releases.

3. Configure SSH access
~~~~~~~~~~~~~~~~~~~~~~~

Provide the SSH credentials Buckit Manager should use for the migration.

- Use ``root`` directly, or a non-root SSH user with passwordless ``sudo``.
- The SSH user must be able to install packages, write ``/etc`` configuration, and manage ``systemd`` services.
- You can test SSH connectivity from the wizard before continuing.
- You can optionally save the SSH credentials for future cluster operations.

4. Review the preflight results
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before cutover, Buckit Manager captures a pre-migration snapshot and runs preflight checks.

The snapshot records the current MinIO state, including:

- buckets and sampled objects
- IAM users, groups, policies, and service accounts
- bucket lifecycle, notification, and related configuration

The preflight checks validate migration readiness, including:

- SSH reachability
- passwordless ``sudo`` when required
- package manager availability and consistency across hosts
- package URL reachability
- architecture consistency across hosts
- required MinIO service configuration

Fix any blocking preflight failures before starting the migration.

If a host is offline at snapshot time, Buckit Manager skips that host and leaves it on MinIO.
After a successful migration, you can use :guilabel:`Provision replacement node...` from the cluster details page to bring a clean replacement host online as a Buckit node.

5. Start the migration
~~~~~~~~~~~~~~~~~~~~~~

Click :guilabel:`Start migration` to begin cutover.

Buckit Manager performs the migration in the following phases:

1. Pre-stage:
   Download the Buckit package, verify its checksum, install it, and write a ``systemd`` drop-in so ``buckit.service`` uses the same user and environment file as MinIO.
2. Cutover:
   Stop ``minio.service``, reload ``systemd``, disable ``minio.service``, and enable ``buckit.service``.
3. Verify:
   Wait for the migrated hosts to report healthy, compare the Buckit cluster against the pre-migration snapshot, and run a smoke test.

Object data, drive configuration, and the existing MinIO environment file remain in place throughout the migration.

Rollback
--------

If cutover or verification fails, Buckit Manager automatically rolls the affected hosts back to MinIO.
The rollback disables ``buckit.service``, removes the Buckit package, removes the migration drop-in, and re-enables ``minio.service``.

After a successful migration, rollback to MinIO remains available from the cluster detail page.
