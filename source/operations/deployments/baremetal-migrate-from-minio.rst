.. _migrate-minio-to-buckit:

============================
Migrate from MinIO to Buckit
============================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

Overview
--------

Buckit is derived from MinIO Community Edition and is fully compatible with it.

Migrating is therefore just a binary replacement: stop MinIO and start Buckit on the same configuration.

Choose Your Deployment Type
---------------------------

Select the procedure matching how MinIO runs today:

- :ref:`Migrate a Manually Run Binary <migrate-minio-binary>`: MinIO started from a shell command, a script, or a supervisor other than systemd.

- :ref:`Migrate a Container Deployment <migrate-minio-container>`: MinIO running under Docker, Docker Compose, or Kubernetes.

- :ref:`Migrate a systemd Deployment <migrate-minio-systemd>`: MinIO installed from a package on Linux and managed as a ``systemd`` service by the ``minio.service`` unit.
  Buckit Manager provides a guided workflow for this deployment type.
  Manual migration is also an option.

The rest of this page applies to all three procedures.

Considerations
--------------

Back Up the Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~

The migration does not modify object data, but a rollback point is inexpensive insurance.

Export the deployment configuration with MinIO still running:

.. code-block:: shell
   :class: copyable

   mc admin cluster iam export ALIAS
   mc admin cluster bucket export ALIAS
   mc admin config export ALIAS > buckit-config-backup.txt

Replace ``ALIAS`` with the alias of the deployment.

The first two commands write ``ALIAS-iam-info.zip`` and ``ALIAS-bucket-metadata.zip`` to the current directory.
Store all three files outside the cluster.

Plan a Restart Window
~~~~~~~~~~~~~~~~~~~~~

Buckit and MinIO nodes must not run in the same cluster at the same time.
For distributed deployments, stop every node, replace the binary on every node, then start every node.
Mixed MinIO and Buckit clusters are not supported.

Set Root Credentials Explicitly
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the rare case that your MinIO deployment does not explicitly set ``MINIO_ROOT_USER`` and ``MINIO_ROOT_PASSWORD``, set them before migrating.
Buckit's built-in default credentials differ from MinIO's, so leaving them unset changes the root credentials at cutover.

Confirm which case applies:

.. code-block:: shell
   :class: copyable

   grep -E "MINIO_ROOT_(USER|PASSWORD)" /etc/default/minio

If the command prints both variables, nothing further is needed.

If it returns nothing, add the credentials the cluster currently uses to the environment file and restart MinIO before migrating:

.. code-block:: shell
   :class: copyable

   MINIO_ROOT_USER=minioadmin
   MINIO_ROOT_PASSWORD=minioadmin

.. _migrate-minio-validate:

Validate the Migration
----------------------

Run these checks after completing any of the three procedures.

Existing ``mc`` aliases continue to work without reconfiguration:

.. code-block:: shell
   :class: copyable

   mc admin info ALIAS
   mc ls ALIAS
   mc ls ALIAS/BUCKET

Replace ``ALIAS`` with the alias of the migrated deployment and ``BUCKET`` with the name of an existing bucket.

Open the Buckit Console at ``http://HOSTNAME:9001`` and confirm the expected buckets, users, and policies are present.

Run an end-to-end check:

.. code-block:: shell
   :class: copyable

   mc cp ~/testfile ALIAS/BUCKET/
   mc cat ALIAS/BUCKET/testfile
   mc rm ALIAS/BUCKET/testfile

Applications require no changes.
The endpoint, access keys, region, and SDKs are the same.

Appendix: What Carries Over
---------------------------

Because Buckit is a fork rather than a rewrite, the only thing that changes is the binary name, from ``minio`` to ``buckit``.
Everything below carries over unchanged:

.. list-table::
   :header-rows: 1
   :widths: 45 55

   * - Component
     - Status

   * - On-disk format (``xl.meta``, ``format.json``, ``.minio.sys``)
     - Identical. Same drives, no conversion.

   * - Buckets, objects, versions, tags, and object lock
     - Read in place.

   * - Users, policies, groups, and service accounts
     - Read in place from ``.minio.sys``.

   * - Bucket lifecycle, replication, notification, and encryption configuration
     - Read in place.

   * - Environment variables (``MINIO_ROOT_USER`` and all ``MINIO_*`` settings)
     - Same names.

   * - S3 API endpoints and request signing
     - Unchanged.

   * - Admin API paths (``/minio/admin/v3/...``)
     - Unchanged. Existing ``mc`` binaries, aliases, and scripts keep working.

   * - Prometheus metrics endpoints
     - Unchanged. Existing dashboards and alerts keep reporting.

   * - Server flags (``--address``, ``--console-address``, ``--certs-dir``)
     - Unchanged.

   * - Server configuration file (``/etc/default/minio``)
     - Same path, same variables.

.. toctree::
   :titlesonly:
   :hidden:

   /operations/deployments/baremetal-migrate-binary
   /operations/deployments/baremetal-migrate-container
   /operations/deployments/baremetal-migrate-systemd
