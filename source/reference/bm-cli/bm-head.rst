.. _minio-mc-head:

===========
``bm head``
===========

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc::  bm head


.. |command| replace:: :mc:`bm head`
.. |rewind| replace:: :mc-cmd:`~bm head --rewind`
.. |versionid| replace:: :mc-cmd:`~bm head --version-id`
.. |alias| replace:: :mc-cmd:`~bm head ALIAS`

Syntax
------

.. start-mc-head-desc

The :mc:`bm head` command displays the first ``n`` lines of an object,
where ``n`` is an argument specified to the command.

.. end-mc-head-desc

:mc:`bm head` does not perform any transformation or formatting of object
contents to facilitate readability. You can also use :mc:`bm head` against
the local filesystem to produce similar results to the ``head`` commandline 
tool.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command returns the first 10 lines of an object in the
      ``mydata`` bucket on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm head mybuckit/mydata/myobject.txt

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] head                     \
                          [--lines int]            \
                          [--rewind "string"]      \
                          [--version-id "string"]  \
                          [--enc-c "string"]       \
                          ALIAS [ALIAS ...]

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The object or objects to print. 
   
   For an object on Buckit, specify the :ref:`alias <alias>` and the full path to
   that object (e.g. bucket and path to object). For example:

   .. code-block:: none

      bm head play/mybucket/object.txt

   You can specify multiple objects on the same or different Buckit
   deployments. For example:

   .. code-block:: none

      bm head ~/mydata/object.txt mybuckit/mydata/object.txt

   For an object on a local filesystem, specify the full path to that object.
   For example:

   .. code-block:: none

      bm head ~/mydata/object.txt

.. mc-cmd:: --lines, n
   :optional:

   The number of lines to print.

   Defaults to ``10``.

.. block include of enc-c

.. include:: /includes/common-minio-sse.rst
   :start-after: start-minio-mc-sse-c-only
   :end-before: end-minio-mc-sse-options

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

View Partial Contents of an Object
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm head` to return the first 10 lines of an object:

.. code-block:: shell
   :class: copyable

   bm head ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm head ALIAS>` with the 
  :mc:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm head ALIAS>` with the path to the object on the
  S3-compatible host.

View Partial Contents of an Object at a Point in Time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm head --rewind` to return the first 10 lines of the
object at a specific point-in-time in the past:

.. code-block:: shell
   :class: copyable

   bm head ALIAS/PATH --rewind DURATION

- Replace :mc-cmd:`ALIAS <bm head ALIAS>` with the 
  :mc:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm head ALIAS>` with the path to the object on the
  S3-compatible host.

- Replace :mc-cmd:`DURATION <bm head --rewind>` with the point-in-time in the past
  at which the command returns the object. For example, specify ``30d`` to
  return the version of the object 30 days prior to the current date.

.. include:: /includes/facts-versioning.rst
   :start-after: start-versioning-admonition
   :end-before: end-versioning-admonition

View Partial Contents of an Object with Specific Version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm head --version-id` to return the first 10 lines of the
object at a specific point-in-time in the past:

.. code-block:: shell
   :class: copyable

   bm head ALIAS/PATH --version-id VERSION

- Replace :mc-cmd:`ALIAS <bm head ALIAS>` with the 
  :mc:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm head ALIAS>` with the path to the object on the
  S3-compatible host.

- Replace :mc-cmd:`VERSION <bm head --version-id>` with the version of the object.
  For example, specify ``30d`` to return the version of the object 30 days prior
  to the current date.

.. include:: /includes/facts-versioning.rst
   :start-after: start-versioning-admonition
   :end-before: end-versioning-admonition


Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
