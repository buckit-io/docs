.. _minio-mc-admin-cluster-bucket:

===========================
``bm admin cluster bucket``
===========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin cluster bucket

Description
-----------

.. start-mc-admin-cluster-bucket-desc

The :mc:`bm admin cluster bucket` command and its subcommands provide tools for manually importing and exporting Buckit bucket metadata.

.. end-mc-admin-cluster-bucket-desc

This metadata includes configurations related to features like :ref:`lifecycle management rules <minio-lifecycle-management>`.
You can use this metadata as a snapshot of the bucket configuration for restoration later, such as part of :abbr:`BC/DR (Business Continuity / Disaster Recovery)` or backup/restore operations.

You can use this command on individual buckets *or* on all buckets in a Buckit deployment.
For automatic synchronization of all buckets in a deployment to a remote site, use :ref:`site replication <minio-site-replication-overview>`.

The :mc:`bm admin cluster bucket` command has the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 40 60

   * - Subcommand
     - Description

   * - :mc:`~bm admin cluster bucket import`
     - .. include:: /reference/bm-admin/bm-admin-cluster-bucket-import.rst
          :start-after: start-mc-admin-cluster-bucket-import-desc
          :end-before: end-mc-admin-cluster-bucket-import-desc

   * - :mc:`~bm admin cluster bucket export`
     - .. include:: /reference/bm-admin/bm-admin-cluster-bucket-export.rst
          :start-after: start-mc-admin-cluster-bucket-export-desc
          :end-before: end-mc-admin-cluster-bucket-export-desc



.. toctree::
   :titlesonly:
   :hidden:

   /reference/bm-admin/bm-admin-cluster-bucket-import
   /reference/bm-admin/bm-admin-cluster-bucket-export


