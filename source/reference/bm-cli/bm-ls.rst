=========
``bm ls``
=========

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm ls

.. Replacement substitutions

.. |command| replace:: :mc:`bm ls`
.. |rewind| replace:: :mc-cmd:`~bm ls --rewind`
.. |versions| replace:: :mc-cmd:`~bm ls --versions`
.. |alias| replace:: :mc-cmd:`~bm ls ALIAS`

Syntax
------

.. start-mc-ls-desc

The :mc:`bm ls` command lists buckets and objects on Buckit or another
S3-compatible service. 

.. end-mc-ls-desc

You can also use :mc:`bm ls` against the local filesystem to produce similar
results as the ``ls`` command.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command lists all objects *and* object versions in the
      ``mydata`` bucket on the ``myminio`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm ls --recursive --versions myminio/mydata

      The output resembles the following:

      .. code-block:: shell

         [2022-11-08 11:30:24 PST]    52MB  STANDARD log-data.csv
         [2022-11-09 12:20:18 PST]    120MB WARM videos/event-2022-11-09.mp4

      - ``STANDARD`` marks objects stored on the Buckit deployment
      - ``WARM`` marks objects stored on the remote tier with matching name
      - ``videos/`` indicates the prefix for the object

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] ls              \
                          [--incomplete]  \
                          [--recursive]   \
                          [--rewind]      \
                          [--versions]    \
                          [--summarize]   \
                          ALIAS [ALIAS ...]

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS

   *Required* The object or objects to copy. 

   For listing objects on Buckit,
   specify the :ref:`alias <alias>` and the full path to that 
   object (e.g. bucket and path to object). For example:

   .. code-block:: none

      bm ls play/mybucket/object.txt


   For listing objects on a local filesystem, specify the full
   path to that object. For example:

   .. code-block:: none

      bm ls ~/mydata/object.txt
   
   If you specify a directory or bucket to :mc-cmd:`~bm ls ALIAS`, you must
   also specify :mc-cmd:`~bm ls --recursive` to recursively list the
   contents of that directory or bucket. If you omit the ``--recursive``
   argument, :mc:`~bm ls` only lists objects in the top level of the specified
   directory or bucket.


.. mc-cmd:: incomplete, -I
   

   *Optional* Returns any incomplete uploads on the specified 
   :mc-cmd:`~bm ls ALIAS` bucket.

.. mc-cmd:: --recursive, r
   

   *Optional* Recursively lists the contents of each bucket or directory in the
   :mc-cmd:`~bm ls ALIAS`.

.. mc-cmd:: --rewind
   :optional:
   
   .. include:: /includes/facts-versioning.rst
      :start-after: start-rewind-desc
      :end-before: end-rewind-desc

   Use :mc-cmd:`~bm ls --rewind` and 
   :mc-cmd:`~bm ls --versions` together to display on those object
   versions which existed at a specific point in time.

.. mc-cmd:: --versions
   :optional:   

   .. include:: /includes/facts-versioning.rst
      :start-after: start-versions-desc
      :end-before: end-versions-desc

   Use :mc-cmd:`~bm ls --versions` and 
   :mc-cmd:`~bm ls --rewind` together to display on those object
   versions which existed at a specific point in time.

.. mc-cmd:: --summarize
   

   *Optional* Displays summarized information for the specified ``ALIAS`` path.

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

List Bucket Contents
~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm ls <bm ls ALIAS>` to list the contents of a bucket:

.. code-block:: shell
   :class: copyable

   bm ls [--recursive] ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm ls ALIAS>` with the 
  :mc:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm ls ALIAS>` with the path to the bucket on the
  S3-compatible host.

  If specifying the path to the S3 root (``ALIAS`` only), include the
  :mc-cmd:`~bm ls --recursive` option.

List Object Versions
~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm ls --versions` to list all versions of an object:

.. code-block:: shell
   :class: copyable

   bm ls --versions ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm ls ALIAS>` with the 
  :mc:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm ls ALIAS>` with the path to the bucket or object on
  the S3-compatible host.

.. include:: /includes/facts-versioning.rst
   :start-after: start-versioning-admonition
   :end-before: end-versioning-admonition

List Bucket Contents at Point in Time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm ls --versions` to list all versions of an object:

.. code-block:: shell
   :class: copyable

   bm ls --rewind DURATION ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm ls ALIAS>` with the 
  :mc:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm ls ALIAS>` with the path to the bucket or object on
  the S3-compatible host.

- Replace :mc-cmd:`DURATION <bm ls --rewind>` with the point-in-time in the past
  at which the command returns the object. For example, specify ``30d`` to
  return the version of the object 30 days prior to the current date.

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
