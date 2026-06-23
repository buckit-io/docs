.. _minio-mc-du:

==========
``bm du``
==========

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm du

.. Replacement substitutions

.. |command| replace:: :mc:`bm du`
.. |rewind| replace:: :mc-cmd:`~bm du --rewind`
.. |versions| replace:: :mc-cmd:`~bm du --versions`
.. |alias| replace:: :mc-cmd:`~bm du ALIAS`

Syntax
------

.. start-mc-du-desc

The :mc:`bm du` command summarizes the disk usage of buckets and folders. 
You can also use :mc:`~bm du` against the local filesystem to produce similar results as the ``du`` command. 

.. end-mc-du-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command prints the disk usage of the ``mybucket`` bucket on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm du play/mybucket

      The output resembles the following:
      
      .. code-block:: shell

         825KiB	3 objects        mybucket

   .. tab-item:: SYNTAX

      The :mc:`bm du` command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] du                    \
                          [--depth]             \
                          [--recursive]         \
                          [--rewind]            \
                          [--versions]          \
                          ALIAS [ALIAS ...]

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:
   
   The :ref:`alias <alias>` of a Buckit deployment and the full path to the folder. For example:

   .. code-block:: shell

      bm du mybuckit/mybucket

   You can specify multiple buckets and folders on the same or different Buckit deployment. For example:

   .. code-block:: shell

      bm du mybuckit/mybucket mybuckit/myotherbucket/myfolder

   For a folder on a local filesystem, specify the full path to that folder. For example:

   .. code-block:: shell

      bm du ~/data/images

   The time required for :mc:`bm du` to complete depends on the size of the target buckets and folders. A large bucket may take some time to generate a disk usage summary.
   
.. mc-cmd:: --depth, d
   :optional:

   Print the total for all folders N or fewer levels below the path specified in the command. Default is 0, for the specified path only.

.. mc-cmd:: --recursive, r
   :optional:

   Recursively print the total for each bucket or child folder.

.. mc-cmd:: --rewind
   :optional:

   .. include:: /includes/facts-versioning.rst
      :start-after: start-rewind-desc
      :end-before: end-rewind-desc

   Use :mc-cmd:`~bm du --rewind` and :mc-cmd:`~bm du --versions` together to show the disk usage for those object versions which existed at a specific point in time.

.. mc-cmd:: --versions
   :optional:

   .. include:: /includes/facts-versioning.rst
      :start-after: start-versions-desc
      :end-before: end-versions-desc

   Use :mc-cmd:`~bm du --versions` and :mc-cmd:`~bm du --rewind` together to show the disk usage for those object versions which existed at a specific point in time.


Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

View the Disk Usage for a Bucket or Folder
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm du` to print a summary of the disk usage for a bucket or folder:

.. code-block:: shell
   :class: copyable

   bm du ALIAS/PATH

- Replace ``ALIAS`` with the  :mc:`alias <bm alias>` of the S3-compatible host.

- Replace ``PATH`` with the path to the bucket or folder on the S3-compatible host.

View the Disk Usage at a Point-In-Time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm du --rewind` to print a summary of disk usage at a specific point-in-time in the past:

.. code-block:: shell
   :class: copyable

   bm du --rewind DURATION ALIAS/PATH

- Replace ``DURATION`` with the desired point-in-time in the past. For example, specify ``30d`` to show the disk usage 30 days prior to the current date.

- Replace ``ALIAS`` with the :mc:`alias <bm alias>` of the S3-compatible host.

- Replace ``PATH`` with the path to the bucket or folder on the S3-compatible host.

.. include:: /includes/facts-versioning.rst
   :start-after: start-versioning-admonition
   :end-before: end-versioning-admonition

View the Disk Usage Recursively
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm du --recursive` to print a summary for each folder recursively:

.. code-block:: shell
   :class: copyable

   bm du --recursive ALIAS/PATH

- Replace ``ALIAS`` with the :mc:`alias <bm alias>` of the S3-compatible host.

- Replace ``PATH`` with the path to the bucket or folder on the S3-compatible host.


Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
