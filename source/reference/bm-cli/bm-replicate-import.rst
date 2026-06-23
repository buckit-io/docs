.. _minio-mc-replicate-import:

=======================
``bm replicate import``
=======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm replicate import

Syntax
------

.. start-mc-replicate-import-desc

The :mc:`bm replicate import` command imports JSON-formatted
:ref:`replication rules <minio-bucket-replication-serverside>` for a 
Buckit bucket from ``STDIN``.

.. end-mc-replicate-import-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command imports the replication configuration for the
      ``mydata`` bucket on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm replicate import mybuckit/mydata < mydata-replication.json

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] import ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS

   *Required* the :ref:`alias <alias>` of the Buckit deployment and full path to
   the bucket or bucket prefix for which to import the replication rules. For
   example:

   .. code-block:: none

      bm replicate import mybuckit/mybucket

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Import Existing Replication Rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm replicate import` to import bucket replication rules:

.. code-block:: shell
   :class: copyable

   bm replicate import ALIAS/PATH < bucket-replication-rules.json

- Replace :mc-cmd:`ALIAS <bm replicate import ALIAS>` with the 
  :mc:`alias <bm alias>` of the Buckit deployment.

- Replace :mc-cmd:`PATH <bm replicate import ALIAS>` with the path to the 
  bucket or bucket prefix.

Behavior
--------

Importing Configuration Overrides Existing Rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:mc:`bm replicate import` replaces the current bucket replication
rules with those defined in the imported JSON configuration.

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
