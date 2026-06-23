==================
``mc quota clear``
==================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: mc quota clear



Description
-----------

.. start-mc-quota-clear-desc

The :mc-cmd:`bm quota clear` command removes a configured storage quota for a bucket.

.. end-mc-quota-clear-desc


Examples
--------


Clear Configured Bucket Quota
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm quota clear` flag to remove the quota from a bucket.

.. code-block:: shell
   :class: copyable

   mc quota clear TARGET/BUCKET

- Replace ``TARGET`` with the :mc-cmd:`alias <bm alias>` of a configured Buckit deployment. 
  Replace ``BUCKET`` with the name of the bucket on which to clear the quota.

Syntax
------

:mc-cmd:`bm quota clear` has the following syntax:

.. code-block:: shell
   :class: copyable

   mc quota clear TARGET [ARGUMENTS]

:mc-cmd:`bm quota clear` supports the following arguments:

.. mc-cmd:: TARGET
   :required:

   The full path to the bucket for which the command creates the quota. 
   Specify the :mc-cmd:`alias <bm alias>` of the Buckit deployment as a prefix to the path. 
   For example:

   .. code-block:: shell
      :class: copyable

      mc quota clear play/mybucket


Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

   
S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
