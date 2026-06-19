============
``bm share``
============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm share


Description
-----------

.. start-mc-share-desc

Use the :mc:`bm share` commands to manage presigned URLs for downloading and uploading objects to a Buckit bucket.

.. end-mc-share-desc

Subcommands
-----------

:mc:`bm share` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm share download`
     - .. include:: /reference/bm-cli/bm-share-download.rst
          :start-after: start-mc-share-download-desc
          :end-before: end-mc-share-download-desc

   * - :mc:`~bm share list`
     - .. include:: /reference/bm-cli/bm-share-list.rst
          :start-after: start-mc-share-list-desc
          :end-before: end-mc-share-list-desc

   * - :mc:`~bm share upload`
     - .. include:: /reference/bm-cli/bm-share-upload.rst
          :start-after: start-mc-share-upload-desc
          :end-before: end-mc-share-upload-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-share-download
   /reference/bm-cli/bm-share-upload
   /reference/bm-cli/bm-share-list