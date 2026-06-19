.. _minio-mc-version-suspend:

======================
``bm version suspend``
======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm version suspend


Syntax
------

.. start-mc-version-suspend-desc

The :mc:`bm version suspend` command disables versioning on the specified bucket.

.. end-mc-version-suspend-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command disables versioning for the ``mybucket`` bucket on the ``myminio`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm version suspend myminio/mybucket

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] version suspend ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS

   The full path to the bucket on which to disable versioning.
   For example:

   .. code-block:: shell

      bm version suspend myminio/mybucket


Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals


Example
-------

Disable Bucket Versioning
~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm version suspend` to disable versioning for a bucket:

.. code-block:: shell
   :class: copyable

   bm version suspend ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm version suspend ALIAS>` with the :mc:`alias <bm alias>` of a configured Buckit deployment.

- Replace :mc-cmd:`PATH <bm version suspend ALIAS>` with the bucket on which to disable versioning.


Behavior
--------

Bucket Versioning with Existing Data
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Disabling bucket versioning on a bucket with existing versioned data does *not* remove any versioned objects.
Applications can continue to access versioned data after disabling bucket versioning.
Use :mc-cmd:`bm rm --versions ALIAS/BUCKET/OBJECT <bm rm --versions>` to delete an object *and* all its versions.


S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
