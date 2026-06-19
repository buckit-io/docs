.. _minio-mc-version-enable:

=====================
``bm version enable``
=====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm version enable


Syntax
------

.. start-mc-version-enable-desc

The :mc:`bm version enable` command enables versioning on the specified bucket.

.. end-mc-version-enable-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command enables versioning for the ``mybucket`` bucket on the ``myminio`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

          bm version enable myminio/mybucket

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] version enable ALIAS                \
	                                 --exclude-folders    \
					 --excluded-prefixes

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :ref:`alias <alias>` of a Buckit deployment and the full path to the bucket for which to enable versioning. For example:

   .. code-block:: shell

      bm version enable myminio/mybucket

.. mc-cmd:: --exclude-folders
   :optional:

   Disable versioning on all folders (objects whose name ends with ``/``) in the specified bucket.

.. mc-cmd:: --excluded-prefixes
   :optional:

   Disable versioning on objects matching a list of prefixes, up to 10.
   The list of prefixes match all objects containing the specified strings in their prefix or name, similar to a regular expression of the form ``prefix*``.
   To match objects by prefix only, use ``prefix/*``.

   For example, the following command excludes any objects containing ``_test`` or ``_temp`` in their prefix or name from versioning:

   .. code-block:: shell
      :class: copyable

      bm version enable --excluded-prefixes "_test, _temp" myminio/mybucket


Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals


Example
-------

Enable Bucket Versioning
~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm version enable` to enable versioning for a bucket:

.. code-block:: shell
   :class: copyable

   bm version enable ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm version enable ALIAS>` with the :mc:`alias <bm alias>` of a configured Buckit deployment.

- Replace :mc-cmd:`PATH <bm version enable ALIAS>` with the bucket on which to enable versioning.


Behavior
--------

Bucket Versioning with Existing Data
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Enabling bucket versioning on a bucket with existing data immediately creates a ``NULL`` value version ID for each unversioned object.


S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
