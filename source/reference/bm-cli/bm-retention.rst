================
``bm retention``
================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm retention


Description
-----------

.. start-mc-retention-desc

The :mc:`bm retention` command configures the :ref:`Write-Once Read-Many (WORM) locking <minio-object-locking>` settings for an object or object(s) in a bucket. 
You can also set the default object lock settings for a bucket, where all objects without explicit object lock settings inherit the bucket default.

.. end-mc-retention-desc

Subcommands
-----------

:mc:`bm retention` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm retention clear`
     - .. include:: /reference/bm-cli/bm-retention-clear.rst
          :start-after: start-mc-retention-clear-desc
          :end-before: end-mc-retention-clear-desc

   * - :mc:`~bm retention info`
     - .. include:: /reference/bm-cli/bm-retention-info.rst
          :start-after: start-mc-retention-info-desc
          :end-before: end-mc-retention-info-desc

   * - :mc:`~bm retention set`
     - .. include:: /reference/bm-cli/bm-retention-set.rst
          :start-after: start-mc-retention-set-desc
          :end-before: end-mc-retention-set-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-retention-set
   /reference/bm-cli/bm-retention-info
   /reference/bm-cli/bm-retention-clear