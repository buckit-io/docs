.. _minio-mc-cat:

==========
``bm cat``
==========

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm cat

.. Replacement substitutions

.. |command| replace:: :mc:`bm cat`
.. |rewind| replace:: :mc-cmd:`~bm cat --rewind`
.. |versionid| replace:: :mc-cmd:`~bm cat --version-id`
.. |alias| replace:: :mc-cmd:`~bm cat ALIAS`

Syntax
------

.. start-mc-cat-desc

The :mc:`bm cat` command concatenates the contents of a file or
object to another file or object. You can also use the command to
display the contents of the specified file or object to ``STDOUT``. 
:mc:`~bm cat` has similar functionality to ``cat``. 

.. end-mc-cat-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command concatenates the contents of an object on a 
      Buckit deployment to ``STDOUT``:

      .. code-block:: shell
         :class: copyable

         bm cat play/mybucket/myobject.txt

   .. tab-item:: SYNTAX

      The :mc:`bm cat` command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] cat                       \
                          ALIAS [ALIAS ...]         \
                          [--enc-c "value"]         \
                          [--offset "int"]          \
                          [--part-number "int"]     \
                          [--rewind]                \
                          [--tail "int"]            \
                          [--version-id "string"]   \
                          [--zip] 

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


You can also use :mc:`bm cat` against a local filesystem to produce similar results to the ``cat`` commandline tool.

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :ref:`alias <alias>` of a Buckit deployment and the full
   path to the object. For example:

   .. code-block:: shell

      bm cat mybuckit/mybucket/myobject.txt

   You can specify multiple objects on the same or different Buckit
   deployment. For example:

   .. code-block:: shell

      bm cat mybuckit/mybucket/object.txt mybuckit/myotherbucket/object.txt

   For an object on a local filesystem, specify the full path to that
   object. For example:

   .. code-block:: shell

      bm cat ~/data/object.txt

.. block include of enc-c

.. include:: /includes/common-minio-sse.rst
   :start-after: start-minio-mc-sse-c-only
   :end-before: end-minio-mc-sse-options

.. mc-cmd:: --offset
   :optional:

   Specify an integer that is the number of bytes from which the command offsets the output.

   Mutually exclusive with the :mc-cmd:`~bm cat --part-number` flag.

.. mc-cmd:: --part-number
   :optional:

   Download a specific part number of a multi-part upload.
   Specify the integer of the part number to download.

   Mutually exclusive with the :mc-cmd:`~bm cat --offset` and :mc-cmd:`~bm cat --tail` flags.

.. mc-cmd:: --rewind
   :optional:

   .. include:: /includes/facts-versioning.rst
      :start-after: start-rewind-desc
      :end-before: end-rewind-desc

.. mc-cmd:: --tail
   :optional:

   Specify an integer that is the number of bytes from which the command trims the output.

   Mutually exclusive with the :mc-cmd:`~bm cat --part-number` flag.

.. mc-cmd:: --version-id, vid
   :optional:

   .. include:: /includes/facts-versioning.rst
      :start-after: start-version-id-desc
      :end-before: end-version-id-desc

.. mc-cmd:: --zip
   :optional:

   Extracts the contents from a zip file on the source to the remote.
   Requires a Buckit deployment as the source ``ALIAS``.

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

View an S3 Object
~~~~~~~~~~~~~~~~~

Use :mc:`bm cat` to return the object:

.. code-block:: shell
   :class: copyable

   bm cat ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm cat ALIAS>` with the 
  :mc:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm cat ALIAS>` with the path to the object on the
  S3-compatible host.

View an S3 Object at a Point-In-Time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm cat --rewind` to return the object at a specific
point-in-time in the past:

.. code-block:: shell
   :class: copyable

   bm cat ALIAS/PATH --rewind DURATION

- Replace :mc-cmd:`ALIAS <bm cat ALIAS>` with the 
  :mc:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm cat ALIAS>` with the path to the object on the
  S3-compatible host.

- Replace :mc-cmd:`DURATION <bm cat --rewind>` with the point-in-time in the past
  at which the command returns the object. For example, specify ``30d`` to
  return the version of the object 30 days prior to the current date.

.. include:: /includes/facts-versioning.rst
   :start-after: start-versioning-admonition
   :end-before: end-versioning-admonition

View an S3 Object with Specific Version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm cat --version-id` to return a specific version of the 
object:

.. code-block:: shell

   bm cat ALIAS/PATH --version-id VERSION

- Replace :mc-cmd:`ALIAS <bm cat ALIAS>` with the 
  :mc:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm cat ALIAS>` with the path to the object on the
  S3-compatible host.

- Replace :mc-cmd:`VERSION <bm cat --version-id>` with the specific version of the
  object to return.

.. include:: /includes/facts-versioning.rst
   :start-after: start-versioning-admonition
   :end-before: end-versioning-admonition

Download a particular part
~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm cat --part-number` to download a particular part of a multi-part upload:

.. code-block:: shell
   :class: copyable

   bm cat ALIAS/PATH --part-number=#

- Replace :mc-cmd:`ALIAS <bm cat ALIAS>` with the :mc:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm cat ALIAS>` with the path to the object on the S3-compatible host.

- Replace ``#`` with the integer of the part number to download.
  For example, to download part 3 of at 16-part multi-part file, use ``--part-number=3``.

You cannot use the ``--part-number`` flag if you are using either the ``--offset`` or the ``--tail`` flags.

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
