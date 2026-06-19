.. _minio-mc-admin-cluster-iam:

========================
``bm admin cluster iam``
========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin cluster iam

Description
-----------

.. versionadded:: RELEASE.2022-06-26T18-51-48Z

.. start-mc-admin-cluster-iam-desc

The :mc:`bm admin cluster iam` command and its subcommands provide tools for manually importing and exporting Buckit :ref:`identity and access management (IAM) <minio-authentication-and-identity-management>` metadata.

.. end-mc-admin-cluster-iam-desc

For automatic synchronization of all IAM configurations in a deployment to a remote site, use :ref:`site replication <minio-site-replication-overview>`.

The :mc:`bm admin cluster iam` command has the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 40 60

   * - Subcommand
     - Description

   * - :mc:`~bm admin cluster iam import`
     - .. include:: /reference/bm-admin/bm-admin-cluster-iam-import.rst
          :start-after: start-mc-admin-cluster-iam-import-desc
          :end-before: end-mc-admin-cluster-iam-import-desc

   * - :mc:`~bm admin cluster iam export`
     - .. include:: /reference/bm-admin/bm-admin-cluster-iam-export.rst
          :start-after: start-mc-admin-cluster-iam-export-desc
          :end-before: end-mc-admin-cluster-iam-export-desc



.. toctree::
   :titlesonly:
   :hidden:

   /reference/bm-admin/bm-admin-cluster-iam-import
   /reference/bm-admin/bm-admin-cluster-iam-export


