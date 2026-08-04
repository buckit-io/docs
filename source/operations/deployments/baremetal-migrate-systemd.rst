.. _migrate-minio-systemd:

============================
Migrate a systemd Deployment
============================

.. default-domain:: minio

Use these procedures if MinIO was installed from a Linux package, such as with ``apt`` or ``dnf``, and runs as a ``minio.service`` systemd unit.

You can choose between a guided and a manual migration:

- :ref:`Guided Migration using Buckit Manager <migrate-minio-community-edition>`: the ``bm web`` wizard migrates the cluster over SSH, with automatic verification and rollback.
  **This is the recommended path.**

- :ref:`Manual Binary Replacement <migrate-minio-systemd-manual>`: install the Buckit package and swap the systemd units by hand.

.. toctree::
   :titlesonly:
   :hidden:

   /operations/deployments/baremetal-migrate-guided
   /operations/deployments/baremetal-migrate-systemd-manual
