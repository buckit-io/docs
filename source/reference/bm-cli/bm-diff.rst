.. _minio-mc-diff:

===========
``bm diff``
===========

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm diff

Syntax
------

.. start-mc-diff-desc

The :mc:`bm diff` bm computes the differences between two filesystem directories
or Buckit buckets. :mc:`bm diff` lists only those objects which are missing or
which differ in size. :mc:`bm diff` does **not** compare the contents of
objects.

.. end-mc-diff-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command computes the difference between an object on
      a local filesystem and an object in the ``mydata`` bucket on the
      ``myminio`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm diff ~/mydata/myobject.txt myminio/mydata/myobject.txt

   .. tab-item:: SYNTAX

      The :mc:`bm diff` command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] diff SOURCE TARGET

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: SOURCE

   *Required* The object to compare to the ``TARGET``.

   For an object from Buckit,
   specify the :mc:`alias <bm alias>` and the full path to that 
   object (e.g. bucket and path to object). For example:

   .. code-block:: none

      bm diff play/mybucket/object.txt ~/mydata/object.txt


   For an object from a local filesystem, specify the full
   path to that object. For example:

   .. code-block:: none

      bm diff ~/mydata/object.txt play/mybucket/object.txt

.. mc-cmd:: TARGET

   *Required* The object to compare to the ``SOURCE``.

   For an object from Buckit,
   specify the :mc:`alias <bm alias>` and the full path to that 
   object (e.g. bucket and path to object). For example:

   .. code-block:: none

      bm diff play/mybucket/object.txt ~/mydata/object.txt


   For an object from a local filesystem, specify the full
   path to that object. For example:

   .. code-block:: none

      bm diff ~/mydata/object.txt play/mybucket/object.txt

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

.. include:: /includes/play-alias-available.rst
   :start-after: play-alias-only
   :end-before: end-play-alias-only

.. code-block:: shell
   :class: copyable

   bm diff play/bucket1 play/bucket2

Behavior
--------

Output Legend
~~~~~~~~~~~~~

:mc:`bm diff` uses the following legend when formatting the diff output:

.. code-block:: none
   
   FIRST < SECOND - object exists only in FIRST 
   FIRST > SECOND - object exists only in SECOND 
   FIRST ! SECOND - Newer object exists in FIRST

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
