==============
``bm version``
==============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm version

Description
-----------

.. start-mc-version-desc

The :mc:`bm version` commands enable, disable, and retrieve the :ref:`versioning <minio-bucket-versioning>` status for a Buckit bucket.

.. end-mc-version-desc

For more information about object versioning in Buckit, see :ref:`minio-bucket-versioning`.

:mc:`bm version` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm version enable`
     - .. include:: /reference/bm-cli/bm-version-enable.rst
          :start-after: start-mc-version-enable-desc
          :end-before: end-mc-version-enable-desc

   * - :mc:`~bm version info`
     - .. include:: /reference/bm-cli/bm-version-info.rst
          :start-after: start-mc-version-info-desc
          :end-before: end-mc-version-info-desc

   * - :mc:`~bm version suspend`
     - .. include:: /reference/bm-cli/bm-version-suspend.rst
          :start-after: start-mc-version-suspend-desc
          :end-before: end-mc-version-suspend-desc


Behavior
--------

Object Locking Enables Bucket Versioning
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

While bucket versioning is disabled by default, configuring object locking on a bucket or an object in that bucket automatically enables versioning for the bucket.
See :mc:`bm retention` for more information on configuring object locking.

Bucket Versioning with Existing Data
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Enabling bucket versioning on a bucket with existing data immediately creates a null value version ID for each unversioned object.

Disabling bucket versioning on a bucket with existing versioned data does *not* remove any versioned objects.
Applications can continue to access versioned data after disabling bucket versioning.
Use :mc-cmd:`bm rm --versions ALIAS/BUCKET/OBJECT <bm rm --versions>` to delete an object *and* all its versions.

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility

.. toctree::
   :titlesonly:
   :hidden:

   /reference/bm-cli/bm-version-enable
   /reference/bm-cli/bm-version-info
   /reference/bm-cli/bm-version-suspend
