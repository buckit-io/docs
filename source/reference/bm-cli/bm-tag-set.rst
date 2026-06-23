.. _minio-mc-tag-set:

==============
``bm tag set``
==============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm tag set

.. |command| replace:: :mc:`bm tag set`
.. |rewind| replace:: :mc-cmd:`~bm tag set --rewind`
.. |versions| replace:: :mc-cmd:`~bm tag set --versions`
.. |versionid| replace:: :mc-cmd:`~bm tag set --version-id`
.. |alias| replace:: :mc-cmd:`~bm tag set ALIAS`

Syntax
------

.. start-mc-tag-set-desc

The :mc:`bm tag set` command sets one or more tags to a bucket or object.

.. end-mc-tag-set-desc

Buckit supports adding up to 10 custom tags to an object.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command sets tags for the ``mydata`` bucket on the
      ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm tag set mybuckit/mydata "tag1=value1&tag2=value2"

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] tag set                   \
                          [--rewind "string"]       \
                          [--versions]              \
                          [--version-id "string"]*  \
                          ALIAS                     \
                          "TAGS"

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

      :mc-cmd:`bm tag set --version-id` is mutually exclusive with
      multiple parameters. See the reference documentation for more information.


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :ref:`alias <alias>` for a Buckit deployment and the
   full path to the object on which to apply the tag (e.g. bucket and path to
   object). For example:

   .. code-block:: none

      bm tag set mybuckit/mybucket/object.txt

.. mc-cmd:: TAGS
   :required:

   An ampersand-seperated (``&``) list of key-value pairs
   (``KEY=VALUE``), where each pair represents one tag to assign to the object.
   For example:

   .. code-block:: none

      bm tag set mybuckit/mybucket/object.txt "key1=value1&key2=value2"

.. mc-cmd:: --exclude-folders
   :optional:

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

   Use :mc-cmd:`~bm tag set --versions` and 
   :mc-cmd:`~bm tag set --rewind` together to apply the tag all object
   versions which existed at a specific point in time.

.. mc-cmd:: --version-id, --vid
   :optional:

   .. include:: /includes/facts-versioning.rst
      :start-after: start-version-id-desc
      :end-before: end-version-id-desc

   Mutually exclusive with the following parameters:

   - :mc-cmd:`~bm tag set --rewind`
   - :mc-cmd:`~bm tag set --versions`

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Apply Tags to a Bucket or Object
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm tag set` to apply tags to a bucket or object:

.. code-block:: shell
   :class: copyable

   bm tag set ALIAS/PATH "TAGS"

- Replace :mc-cmd:`ALIAS <bm tag set ALIAS>` with the 
  :ref:`alias <alias>` of the Buckit deployment.

- Replace :mc-cmd:`PATH <bm tag set ALIAS>` with the path to the bucket
  or object on the Buckit deployment.

- Replace :mc-cmd:`TAGS <bm tag set TAGS>` with one or more ampersand-separated
  (``&``) key-value pairs for each tag and its corresponding value.

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
