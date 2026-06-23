.. _minio-mc-tag-list:

===============
``bm tag list``
===============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm tag list

.. |command| replace:: :mc:`bm tag list`
.. |rewind| replace:: :mc-cmd:`~bm tag list --rewind`
.. |versions| replace:: :mc-cmd:`~bm tag list --versions`
.. |versionid| replace:: :mc-cmd:`~bm tag list --version-id`
.. |alias| replace:: :mc-cmd:`~bm tag list ALIAS`

Syntax
------

.. start-mc-tag-list-desc

The :mc:`bm tag list` command lists all tags from a bucket or object.

.. end-mc-tag-list-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command lists tags for the ``mydata`` bucket on the
      ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm tag list mybuckit/mydata

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] tag set                   \
                          [--rewind "string"]       \
                          [--versions]              \
                          [--version-id "string"]*  \
                          ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

      :mc-cmd:`bm tag list --version-id` is mutually exclusive with
      multiple parameters. See the reference documentation for more information.

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :ref:`alias <alias>` for a Buckit deployment and the
   full path to the object for which to list all tags (e.g. bucket and path to
   object). For example:

   .. code-block:: none

      bm tag list mybuckit/mybucket/object.txt

.. mc-cmd:: --recursive, r
   :optional:


.. mc-cmd:: --rewind
   :optional:

   .. include:: /includes/facts-versioning.rst
      :start-after: start-rewind-desc
      :end-before: end-rewind-desc

.. mc-cmd:: --versions
   :optional:   

   .. include:: /includes/facts-versioning.rst
      :start-after: start-versions-desc
      :end-before: end-versions-desc

   Use :mc-cmd:`~bm tag list --versions` and 
   :mc-cmd:`~bm tag list --rewind` together to list tags from all
   object versions which existed at a specific point in time.

.. mc-cmd:: --version-id, vid
   :optional:

   .. include:: /includes/facts-versioning.rst
      :start-after: start-version-id-desc
      :end-before: end-version-id-desc

   Mutually exclusive with the following parameters:

   - :mc-cmd:`~bm tag list --rewind`
   - :mc-cmd:`~bm tag list --versions`

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

List Tags for a Bucket or Object
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm tag list` to list tags for a bucket or object:

.. code-block:: shell
   :class: copyable

   bm tag list ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm tag list ALIAS>` with the 
  :ref:`alias <alias>` of the Buckit deployment.

- Replace :mc-cmd:`PATH <bm tag list ALIAS>` with the path to the bucket
  or object on the Buckit deployment.

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
