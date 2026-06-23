.. _minio-mc-replicate-ls:

===================
``bm replicate ls``
===================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm replicate list
.. mc:: bm replicate ls


Syntax
------

.. start-mc-replicate-ls-desc

The :mc:`bm replicate ls` command lists all 
:ref:`replication rules <minio-bucket-replication-serverside>` on a 
Buckit bucket.

.. end-mc-replicate-ls-desc

The :mc:`bm replicate list` command has equivalent functionality to :mc:`bm replicate ls`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command lists all enabled replication rules for the
      ``mydata`` bucket on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm replicate ls --status "enabled" mybuckit/mydata

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] replicate ls         \
                          [--status "string"]  \
                          ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :ref:`alias <alias>` of the Buckit deployment and full path to
   the bucket or bucket prefix for which to list the replication rules. For
   example:

   .. code-block:: none

      bm replicate ls mybuckit/mybucket


.. mc-cmd:: --status
   :optional:

   Filter replication rules on the bucket based on their status.
   Specify one of the following values:

   - ``enabled`` - Show only enabled replication rules.
   - ``disabled`` - Show only disabled replication rules.

   If omitted, :mc:`bm replicate ls` defaults to showing all replication
   rules.

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

List Existing Replication Rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm replicate ls` to list bucket replication rules:

.. code-block:: shell
   :class: copyable

   bm replicate ls ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm replicate ls ALIAS>` with the 
  :mc:`alias <bm alias>` of the Buckit deployment.

- Replace :mc-cmd:`PATH <bm replicate ls ALIAS>` with the path to the 
  bucket or bucket prefix.

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
