.. _minio-mc-legalhold-info:

=====================
``bm legalhold info``
=====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm legalhold info

.. |command| replace:: :mc:`bm legalhold info`
.. |rewind| replace:: :mc-cmd:`~bm legalhold info --rewind`
.. |versionid| replace:: :mc-cmd:`~bm legalhold info --version-id`
.. |alias| replace:: :mc-cmd:`~bm legalhold info ALIAS`

Syntax
------

.. start-mc-legalhold-info-desc

The :mc:`bm legalhold info` command returns the current :ref:`legal hold
<minio-object-locking-legalhold>` setting for an object or objects.

.. end-mc-legalhold-info-desc

:mc:`bm legalhold` *requires* that the specified bucket has object locking
enabled. You can **only** enable object locking at bucket creation. See
:mc-cmd:`bm mb --with-lock` for documentation on creating buckets with
object locking enabled. 

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command retrieves the current legalhold status for objects
      in the ``mydata`` bucket on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm legalhold info --recursive mybuckit/mydata

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] legalhold info  \
                          [--recursive]   \
                          [--rewind]      \
                          [--version-id]  \
                          ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The Buckit :ref:`alias <alias>` and path to the object or
   objects on which to enable the legal hold. For example:

   .. code-block:: shell
      
      bm legalhold info play/mybucket/myobjects/objects.txt

.. mc-cmd:: --recursive, r
   :optional:

   Returns the legal hold status of all objects in the 
   :mc-cmd:`~bm legalhold info ALIAS` bucket or bucket prefix.

.. mc-cmd:: --rewind
   :optional:

   .. include:: /includes/facts-versioning.rst
      :start-after: start-rewind-desc
      :end-before: end-rewind-desc

.. mc-cmd:: --version-id, vid
   :optional:

   .. include:: /includes/facts-versioning.rst
      :start-after: start-version-id-desc
      :end-before: end-version-id-desc

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Retrieve the Legal Hold Status Objects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm legalhold info` to retrieve the legal hold status of an object.
Include :mc-cmd:`~bm legalhold info --recursive` to return the legal hold
status of the contents of a bucket:

.. code-block:: shell
   :class: copyable

   bm legalhold clear [--recursive] ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm legalhold info ALIAS>` with the 
  :ref:`alias <alias>` of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm legalhold info ALIAS>` with the path to the bucket
  or object on the S3-compatible host. If specifying the path to a bucket or
  bucket prefix, include the :mc-cmd:`~bm legalhold info --recursive`
  option.


Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
