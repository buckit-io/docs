.. _minio-mc-replicate-export:

=======================
``bm replicate export``
=======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm replicate export

Syntax
------

.. start-mc-replicate-export-desc

The :mc:`bm replicate export` command exports the JSON-formatted
:ref:`replication rules <minio-bucket-replication-serverside>` for a 
Buckit bucket to ``STDOUT``.

.. end-mc-replicate-export-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command exports the replication configuration for the
      ``mydata`` bucket on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm replicate export mybuckit/mydata > mydata-replication.json

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] export ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS

   *Required* the :ref:`alias <alias>` of the Buckit deployment and full path to
   the bucket or bucket prefix for which to export the replication rules. For
   example:

   .. code-block:: none

      bm replicate export mybuckit/mybucket

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Export Existing Replication Rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm replicate export` to export bucket replication rules:

.. code-block:: shell
   :class: copyable

   bm replicate export ALIAS/PATH > bucket-replication-rules.json

- Replace :mc-cmd:`ALIAS <bm replicate export ALIAS>` with the 
  :mc:`alias <bm alias>` of the Buckit deployment.

- Replace :mc-cmd:`PATH <bm replicate export ALIAS>` with the path to the 
  bucket or bucket prefix.

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
