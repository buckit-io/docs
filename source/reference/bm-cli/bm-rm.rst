=========
``bm rm``
=========

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm rm

.. |command| replace:: :mc:`bm rm`
.. |rewind| replace:: :mc-cmd:`~bm rm --rewind`
.. |versions| replace:: :mc-cmd:`~bm rm --versions`
.. |versionid| replace:: :mc-cmd:`~bm rm --version-id`
.. |alias| replace:: :mc-cmd:`~bm rm ALIAS`

Syntax
------

.. start-mc-rm-desc

The :mc:`bm rm` command :ref:`removes objects <minio-object-delete>` from a bucket on a Buckit deployment. 
To completely remove a bucket, use :mc:`bm rb` instead.

.. end-mc-rm-desc

You can also use :mc:`bm rm` against the local filesystem to produce similar
results to the ``rm`` commandline tool.

For more information on how Buckit performs ``DELETE`` actions on objects, see :ref:`minio-object-delete`.

.. important::

   :mc:`bm rm` supports removing multiple objects *or* files in a single
   command. Consider using the :mc-cmd:`~bm rm --dry-run`
   option to validate that the operation targets only the desired objects/files.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command removes multiple objects from the 
      ``mydata`` bucket on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm rm --recursive mybuckit/mydata

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] rm  \
                          [--bypass]               \
                          [--dangerous]            \
                          [--dry-run]              \
                          [--force]*               \
                          [--incomplete]           \
                          [--newer-than "string"]  \
                          [--non-current]          \
                          [--older-than "string"]  \
                          [--recursive]            \
                          [--rewind "string"]      \
                          [--stdin]                \
                          [--version-id "string"]* \
                          [--versions]             \
                          ALIAS [ALIAS ...]

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

      :mc-cmd:`bm rm --force` is required by multiple parameters.
      :mc-cmd:`bm rm --version-id` is mutually exclusive with multiple
      parameters. See the reference documentation for more information.

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:
   
   The :ref:`alias <alias>` of a Buckit deployment and the full path to
   the object to remove. For example:

   .. code-block:: shell

      bm rm play/mybucket/object.txt

   You can specify multiple objects on the same or different Buckit deployments.
   For example:

   .. code-block:: shell

      bm rm play/mybucket/object.txt play/mybucket/otherobject.txt

   If specifying the path to a bucket or bucket prefix, you **must** also
   specify the :mc-cmd:`~bm rm --recursive` and 
   :mc-cmd:`~bm rm --force` arguments. For example:

   .. code-block:: shell

      bm rm --recursive --force play/mybucket/

      bm rm --recursive --force play/mybucket/myprefix/

   Consider first running the command with the
   :mc-cmd:`~bm rm --dry-run` flag to validate the scope of the
   recursive delete operation.

   For removing a file from a local filesystem, specify the full path to that
   file:

   .. code-block:: shell

      bm rm ~/data/myoldobject.txt

.. mc-cmd:: --bypass
   :optional:
   
   Allows removing an object held under 
   :ref:`GOVERNANCE <minio-object-locking-governance>` object locking. 

.. mc-cmd:: --dangerous
   :optional:
   
   Allows running :mc:`bm rm` when the :mc-cmd:`~bm rm ALIAS`
   specifies the root (all buckets) on the Buckit deployment.

   When combined with :mc-cmd:`~bm rm --versions`, this flag
   directs :mc:`bm rm` to permanently remove all objects *and* versions from
   the ``ALIAS`` target.

   Consider first running the command with the :mc-cmd:`~bm rm --dry-run` to
   validate the scope of the site-wide delete operation.

   .. warning::

      Running :mc-cmd:`bm rm --dangerous` with the
      :mc-cmd:`~bm rm --versions` flag is irreversible. Exercise all 
      possible due diligence in ensuring the command applies to only the desired
      ``ALIAS`` targets prior to execution.

.. mc-cmd:: --dry-run
   :optional:

   Outputs the results of a command without actually removing any files.
   Use this flag to test that your command configuration removes only the objects you wish to remove.

.. mc-cmd:: --force
   :optional:

   Allows running :mc:`bm rm` with any of the following arguments:
   
   - :mc-cmd:`~bm rm --recursive`
   - :mc-cmd:`~bm rm --versions`
   - :mc-cmd:`~bm rm --stdin`

.. mc-cmd:: --incomplete, I
   :optional:

   Remove incomplete uploads for the specified object.

   If any :mc-cmd:`~bm rm ALIAS` specifies a bucket, 
   you **must** also specify :mc-cmd:`~bm rm --recursive`
   and :mc-cmd:`~bm rm --force`.

.. mc-cmd:: --newer-than
   :optional:

   Remove object(s) newer than the specified number of days. Specify
   a string in ``#d#hh#mm#ss`` format. For example: ``--newer-than 1d2hh3mm4ss``

   Defaults to ``0`` (all objects).

.. mc-cmd:: --non-current
   :optional:

   Removes all :ref:`non-current <minio-bucket-versioning-delete>`
   object versions from the specified :mc-cmd:`~bm rm ALIAS`.

   This option has no effect on buckets without 
   :ref:`versioning <minio-bucket-versioning>` enabled.

.. mc-cmd:: --older-than
   :optional:

   Remove object(s) older than the specified time limit. Specify a
   string in ``#d#h#m#s`` format. For example: ``--older-than 1d2h3m4s``.
      
   Defaults to ``0`` (all objects).

.. mc-cmd:: --recursive, r
   :optional:
   
   Recursively remove the contents of each :mc-cmd:`~bm rm ALIAS`
   bucket or bucket prefix.

   If specifying :mc-cmd:`~bm rm --recursive`, you **must** also
   specify :mc-cmd:`~bm rm --force`.

   For buckets with :ref:`versioning <minio-bucket-versioning>` enabled,
   this option by default produces a delete marker for each removed object.
   Include the :mc-cmd:`~bm rm --versions` flag to recursively remove
   all objects *and* object versions from the bucket.

   Consider first running the command with the 
   :mc-cmd:`~bm rm --dry-run` flag to validate the scope of the
   recursive delete operation.

   Mutually exclusive with :mc-cmd:`bm rm --version-id`

.. mc-cmd:: --rewind
   :optional:

   .. include:: /includes/facts-versioning.rst
      :start-after: start-rewind-desc
      :end-before: end-rewind-desc

.. mc-cmd:: --stdin
   :optional:   

   Read object names or buckets from ``STDIN``.

.. mc-cmd:: --versions
   :optional:   

   .. include:: /includes/facts-versioning.rst
      :start-after: start-versions-desc
      :end-before: end-versions-desc

   Use :mc-cmd:`~bm rm --versions` and 
   :mc-cmd:`~bm rm --rewind` together to remove all object
   versions which existed at a specific point in time.

.. mc-cmd:: --version-id, vid
   :optional:

   .. include:: /includes/facts-versioning.rst
      :start-after: start-version-id-desc
      :end-before: end-version-id-desc

   Mutually exclusive with any of the following flags:
   
   - :mc-cmd:`~bm rm --versions`
   - :mc-cmd:`~bm rm --rewind`
   - :mc-cmd:`~bm rm --recursive`

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Remove a Single Object
~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: shell
   :class: copyable

   bm rm ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm rm ALIAS>` with the :mc:`alias <bm alias>` of
  a configured S3-compatible service.

- Replace :mc-cmd:`PATH <bm rm ALIAS>` with the path to the object.


Recursively Remove a Bucket's Contents
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm rm` with the
:mc-cmd:`~bm rm --recursive` and :mc-cmd:`~bm rm --force` options
to recursively remove a bucket's contents.

.. code-block:: shell
   :class: copyable

   bm rm --recursive --force ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm rm ALIAS>` with the :mc:`alias <bm alias>` of
  a configured S3-compatible service.

- Replace :mc-cmd:`PATH <bm rm ALIAS>` with the path to the bucket.

This operation does *not* remove the bucket. Use :mc:`bm rb` to remove the
bucket along with all contents and associated configurations.

Remove All Incomplete Upload Files for an Object
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm rm` with the :mc-cmd:`~bm rm --incomplete` option to remove
incomplete upload files for an object. 

.. code-block:: shell
   :class: copyable

   bm rm --incomplete --recursive --force ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm rm ALIAS>` with the :mc:`alias <bm alias>` of
  a configured S3-compatible service.

- Replace :mc-cmd:`PATH <bm rm ALIAS>` with the path to the object.


Roll Object Back To Previous Version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm rm` with :mc-cmd:`~bm rm --versions` and 
:mc-cmd:`~bm rm --newer-than` to
remove all object versions newer than the specified duration of time. This
effectively "rolls back" the object to its state at that time.

.. important::

   Removing specific versions of an object is a *destructive* action. You cannot
   restore the deleted object versions.

.. code-block:: shell
   :class: moveable

   bm rm ALIAS/PATH --versions --newer-than DURATION

- Replace :mc-cmd:`ALIAS <bm rm ALIAS>` with the :mc:`alias <bm alias>` of
  a configured S3-compatible service.

- Replace :mc-cmd:`PATH <bm rm ALIAS>` with the path to the object. For 
  example, ``/mybucket/myobject``.

- Replace :mc-cmd:`DURATION <bm rm --newer-than>` with the number of days in the
  past from the current host time from which the operation begins removing
  versions of the object. For example, to remove all versions of the object
  created in the last 30 days, specify ``"30d"``.

Behavior
--------

Deleting Bucket Contents
~~~~~~~~~~~~~~~~~~~~~~~~

Using :mc:`bm rm` to remove all contents in a bucket does not delete the bucket
itself. Any configurations associated to the bucket remain in place, such as
:mc-cmd:`default object lock settings <bm retention set --default>`.

To completely remove a bucket, use :mc:`bm rb` instead of :mc:`bm rm`.

Buckit Trims Empty Prefixes on Object Removal
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /includes/common-admonitions.rst
   :start-after: start-remove-api-trims-prefixes
   :end-before: end-remove-api-trims-prefixes

.. include:: /includes/common-admonitions.rst
   :start-after: start-remove-api-trims-prefixes-fs
   :end-before: end-remove-api-trims-prefixes-fs

Delete Operations in Versioned Buckets
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit supports keeping multiple :ref:`versions <minio-bucket-versioning>` of an
object in a single bucket. :ref:`Deleting <minio-bucket-versioning-delete>` an
object in a versioned bucket results in a special ``DeleteMarker`` tombstone
that marks an object as deleted while retaining all previous versions of that
object.

- To remove a specific object version from a bucket, use
  :mc-cmd:`bm rm --version-id`

- To remove all versions of an object from a bucket, use
  :mc-cmd:`bm rm --versions`

- To remove all non-current versions of an object from a bucket, use
  :mc-cmd:`bm rm --non-current`


S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
