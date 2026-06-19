.. _minio-mc-legalhold-set:

====================
``bm legalhold set``
====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm legalhold set

.. |command| replace:: :mc:`bm legalhold set`
.. |rewind| replace:: :mc-cmd:`~bm legalhold set --rewind`
.. |versionid| replace:: :mc-cmd:`~bm legalhold set --version-id`
.. |alias| replace:: :mc-cmd:`~bm legalhold set ALIAS`

Syntax
------

.. start-mc-legalhold-set-desc

The :mc:`bm legalhold set` command enables :ref:`legal hold
<minio-object-locking-legalhold>` Write-Once Read-Many (WORM) object locking on
an object or objects.

.. end-mc-legalhold-set-desc

:mc:`bm legalhold` *requires* that the specified bucket has 
:ref:`object locking enabled <minio-object-locking>`. You can **only** enable
object locking at bucket creation. See :mc-cmd:`bm mb --with-lock` for
documentation on creating buckets with object locking enabled. 

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command enables legalhold WORM locking on all existing objects
      in the ``mydata`` bucket on the ``myminio`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm legalhold set --recursive myminio/mydata

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] legalhold set  \
                          [--recursive]  \
                          [--rewind]     \
                          [--version-id] \
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
      
      bm legalhold set play/mybucket/myobjects/objects.txt

.. mc-cmd:: --recursive, r
   :optional:

   Applies the legal hold to all existing objects in the 
   :mc-cmd:`~bm legalhold set ALIAS` bucket or bucket prefix.

   .. admonition:: ``--recursive`` only applies to existing objects
      :class: note

      To enable legal hold for future objects, periodically repeat the :mc:`bm legalhold` command as new objects are created.

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

Use :mc:`bm legalhold set` to enable legal hold on objects:

.. code-block:: shell
   :class: copyable

   bm legalhold set [--recursive] ALIAS/PATH 

- Replace :mc-cmd:`ALIAS <bm legalhold set ALIAS>` with the 
  :ref:`alias <alias>` of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm legalhold set ALIAS>` with the path to the bucket
  or object on the S3-compatible host. If specifying the path to a bucket or
  bucket prefix, include the :mc-cmd:`~bm legalhold set --recursive`
  option.

Behavior
--------

Legal Holds Require Explicit Removal
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Legal holds are indefinite and enforce complete immutability for locked objects.
Only privileged users with the :policy-action:`s3:PutObjectLegalHold` can set or
lift the legal hold.

Legal Holds Complement Other Retention Modes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Legal holds are complementary to both :ref:`minio-object-locking-governance` and
:ref:`minio-object-locking-compliance` retention settings. An object held under
both legal hold *and* a ``GOVERNANCE/COMPLIANCE`` retention rule remains WORM
locked until the legal hold is lifed *and* the rule expires.

For ``GOVERNANCE`` locked objects, the legal hold prevents mutating the object
*even if* the user has the necessary privileges to bypass retention.

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
