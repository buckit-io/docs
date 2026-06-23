.. _minio-mc-version-info:

===================
``bm version info``
===================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm version info


Syntax
------

.. start-mc-version-info-desc

The :mc:`bm version info` command returns the versioning status for the specified bucket.

.. end-mc-version-info-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command returns the versioning status for the ``mybucket`` bucket on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm version info mybuckit/mybucket

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] version info ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS

   The full path to the bucket on which to retrieve the versioning status.
   For example:

   .. code-block:: shell

      bm version info mybuckit/mybucket


Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals


Example
-------

Get Bucket Versioning Status
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm version info` to retrieve the versioning status for a bucket:

.. code-block:: shell
   :class: copyable

   bm version info ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm version info ALIAS>` with the :mc:`alias <bm alias>` of a configured Buckit deployment.

- Replace :mc-cmd:`PATH <bm version info ALIAS>` with the bucket on which to retrieve the versioning status.


Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
