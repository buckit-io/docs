.. _migrate-minio-community-edition:
.. _migrate-minio-guided:

=======================================
Guided Migration using Buckit Manager
=======================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

Overview
--------

This workflow migrates a Linux package-installed MinIO deployment managed by ``minio.service``, in place and over SSH.
Buckit Manager replaces the MinIO binary and ``minio.service`` with the Buckit package and ``buckit.service``, reusing the existing service account and environment file.

If your environment requires a manual process, see :ref:`Manual Binary Replacement <migrate-minio-systemd-manual>`.

Review the :ref:`shared considerations <migrate-minio-to-buckit>` before starting.

Prerequisites
-------------

Host Requirements
~~~~~~~~~~~~~~~~~

The migration workflow expects the following on the source cluster:

- MinIO installed on Linux hosts with ``minio.service`` managed by systemd.
- SSH access as ``root`` or with passwordless ``sudo`` from the ``bm`` host to the MinIO cluster hosts.

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
- The SSH user must be able to install packages, write ``/etc`` configuration, and manage systemd services.
- You can test SSH connectivity from the wizard before continuing.
- You can optionally save the SSH credentials for future cluster operations.

4. Review the preflight results
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before cutover, Buckit Manager captures a pre-migration snapshot and runs preflight checks.

The snapshot records the current MinIO state and is used to verify the cluster after migration:

- buckets and sampled objects
- IAM users, groups, policies, and service accounts
- bucket lifecycle, notification, and related configuration

The preflight checks validate migration readiness across every host.
Fix any blocking preflight failures before starting the migration.

If a host is offline at snapshot time, Buckit Manager skips that host and leaves it on MinIO.
After a successful migration, you can use :guilabel:`Provision replacement node...` from the cluster details page to bring a clean replacement host online as a Buckit node.

5. Start the migration
~~~~~~~~~~~~~~~~~~~~~~

Click :guilabel:`Start migration` to begin cutover.

Buckit Manager installs the Buckit package on every host, stops and disables ``minio.service``, enables ``buckit.service``, and waits for the cluster to report healthy, rolling the hosts back automatically if it does not.
It then compares the migrated cluster against the snapshot and runs a smoke test, reporting any differences.

A systemd drop-in (``/etc/systemd/system/buckit.service.d/10-bm-migrated.conf``) carries over the service account and environment file from ``minio.service``, so ``buckit.service`` runs with the same user, typically ``minio-user``.

Object data, drive configuration, and the existing MinIO environment file remain in place throughout the migration.

Rollback
--------

If the cutover or the post-cutover health check fails, Buckit Manager automatically rolls the affected hosts back to MinIO.
The rollback disables ``buckit.service``, removes the Buckit package, removes the migration drop-in, and re-enables ``minio.service``.

If the informational report pass flags a difference after a committed migration, review the reported items and roll back manually if needed.

After a successful migration, rollback to MinIO remains available from the cluster detail page.
