=========
``bm rb``
=========

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm rb

Syntax
------

.. start-mc-rb-desc

The :mc:`bm rb` command removes one or more buckets on Buckit *or*
another S3-compatible service.

To remove only the contents of a bucket, use :mc:`bm rm` instead.

.. end-mc-rb-desc

.. important::

   :mc:`bm rb` *permanently deletes bucket(s)* on the target deployment,
   including any and all :ref:`object versions <minio-bucket-versioning>`
   and bucket configurations such as 
   :ref:`lifecycle management <minio-lifecycle-management>` or
   :ref:`replication <minio-bucket-replication-serverside>`.

You can also use :mc:`bm rb` against the local filesystem to produce
similar results to the ``rm --rf`` commandline tool.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command removes the ``mydata`` bucket on the 
      ``myminio`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm rb --force myminio/mydata

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] rb             \
                          --force        \
                          [--dangerous]  \
                          ALIAS [ALIAS...]

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS

   *Required* The :ref:`alias <alias>` of a Buckit or other S3-compatible
   service and the full path to the bucket to remove. For example:

   .. code-block:: none

      bm rb --force myminio/mydata

   Omit the bucket path to perform a site-wide removal of buckets on the Buckit
   deployment. This operation *requires* specifying 
   :mc-cmd:`~bm rb --dangerous` to explicitly acknowledge the permanent
   removal of *all* data on the deployment. For example:

   .. code-block:: none

      bm rb --force --dangerous myminio

   For removing a directory and its contents on a local filesystem, specify
   the full path to that directory. The 
   :mc-cmd:`~bm rb --force` flag is ignored if specified. For example:

   .. code-block:: none

      bm rb ~/data/myolddata

   You can specify multiple ``ALIAS`` targets consisting of either
   Buckit or local filesystem directories. The command attempts to remove
   *all* specified targets. For example:

   .. code-block:: none

      bm rb --force myminio/mydata ~/data/myolddata

.. mc-cmd:: --force
   

   *Required* Safety flag to confirm removal of the bucket contents.

.. mc-cmd:: --dangerous
   

   *Optional* Directs :mc:`bm rb` to perform a site-wide removal of all
   buckets on each specified :mc-cmd:`~bm rb ALIAS` (e.g. ``myminio/``).

   If any ``ALIAS`` specifies a filesystem directory, this option
   results in the removal of all subdirectories and files at that directory
   path similar to ``rm --rf``.

   .. warning::

      Running :mc-cmd:`bm rb --dangerous` is irreversible. Exercise all
      possible due diligence in ensuring the command applies to only the 
      desired ``ALIAS`` targets prior to execution.

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Example
-------

Remove a Bucket
~~~~~~~~~~~~~~~

.. code-block:: shell
   :class: copyable

   bm rb --force ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm rb ALIAS>` with the :mc-cmd:`alias <bm alias>` of
  a configured S3-compatible host.

- Replace :mc-cmd:`PATH <bm rb ALIAS>` with the path to the bucket to remove.

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
