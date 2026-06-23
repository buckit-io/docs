===========
``bm tree``
===========

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm tree

.. |command| replace:: :mc:`bm tree`
.. |rewind| replace:: :mc-cmd:`~bm tree --rewind`
.. |alias| replace:: :mc-cmd:`~bm tree ALIAS`

Syntax
------

.. start-mc-tree-desc

The :mc:`bm tree` command lists all prefixes inside a Buckit bucket in a tree
format. The command optionally supports listing all objects inside of bucket
at each prefix, including the bucket root.

.. end-mc-tree-desc

You can also use :mc:`bm tree` against a local filesystem directory to
produce similar results to the ``tree`` commandline tool.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command prints a complete tree of all objects at any
      depth in the ``mydata`` bucket on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm tree --files mybuckit/mydata

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] tree                 \
                          [--depth int]        \
                          [--files]            \
                          [--rewind "string"]  \

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS

   *Required* The :ref:`alias <alias>` of a Buckit deployment and the
   full path to the bucket to list the tree hierarchy. For example:

   .. code-block:: shell

      bm tree mybuckit/mybucket

   You can specify multiple targets to the :mc:`bm tree` command. For
   example:

   .. code-block:: shell

      bm tree mybuckit/mybucket mybuckit/myotherbucket

   For retrieving the tree heirarchy of a local filesystem directory,
   specify the full path to that directory. For example:

   .. code-block:: shell

      bm tree ~/minio/mydata/

.. mc-cmd:: --depth, d
   

   *Optional* Limit the tree depth to the specified integer value. 
   
   Defaults to ``-1`` or unlimited depth.

.. mc-cmd:: --files, f
   

   *Optional* Includes files in the object or directory in the :mc:`bm tree`
   output.

.. mc-cmd:: --rewind
   :optional:

   .. include:: /includes/facts-versioning.rst
      :start-after: start-rewind-desc
      :end-before: end-rewind-desc

Examples
--------

.. code-block:: shell
   :class: copyable

   bm tree ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm tree ALIAS>` with the :ref:`alias <alias>` 
  of the Buckit deployment.

- Replace :mc-cmd:`PATH <bm tree ALIAS>` with the path to the bucket on the
  Buckit deployment.


Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
