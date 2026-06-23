===================
``bm share ls``
===================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm share list
.. mc:: bm share ls

Syntax
-----------

.. start-mc-share-list-desc

The :mc:`bm share ls` command displays any unexpired presigned URLs generated
by :mc:`bm share upload` or :mc:`bm share download`

.. end-mc-share-list-desc

The :mc:`bm share list` command has equivalent functionality to :mc:`bm share ls`.

Applications can perform a ``PUT`` to retrieve the object from the URL. 

For more information on shareable object URLs, see the Amazon S3 
documentation on :aws-docs:`Pre-Signed URLs 
<AmazonS3/latest/dev/ShareObjectPreSignedURL.html>`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command lists all upload and download presigned URLs
      respectively for the ``mydata`` bucket on the ``mybuckit`` Buckit
      deployment:

      .. code-block:: shell
         :class: copyable

         bm share ls upload mybuckit/mydata
         bm share ls download mybuckit/mydata

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] share list           \
                          [download | upload]  \
                          ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: download

   *Required* Lists all unexpired presigned download (``GET``) URLs.

   Mutually exclusive with :mc:`bm share ls upload`

.. mc-cmd:: upload

   *Required* Lists all unexpired presigned upload (``PUT``) URLs.

   Mutually exclusive with :mc:`bm share ls download`

.. mc-cmd:: ALIAS

   *Required* The :ref:`alias <alias>` of a Buckit deplyment and the full path to
   the object for which to list unexpired presigned URLs. 



Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

List Generated Download and Upload URLs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. tab-set::

   .. tab-item:: List Active Download Presigned URLs

      Use :mc:`bm share ls download` to generate a URL
      that supports ``POST`` requests for uploading a file to a specific object
      location on an S3-compatible host:

      .. code-block:: shell
         :class: copyable

         bm share ls download ALIAS

      - Replace :mc-cmd:`ALIAS <bm share ls ALIAS>` with the 
        :ref:`alias <alias>` of the Buckit deployment.

   .. tab-item:: List Active Upload Presigned URLs

      Use :mc:`bm share ls upload` to generate a URL that
      supports ``POST`` requests for uploading a file to a specific object
      location on an S3-compatible host:

      .. code-block:: shell
         :class: copyable

         bm share ls upload ALIAS

      - Replace :mc-cmd:`ALIAS <bm share upload ALIAS>` with the 
        :ref:`alias <alias>` of the Buckit deployment.

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
