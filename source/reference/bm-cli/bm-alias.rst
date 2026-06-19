============
``bm alias``
============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm alias


Description
-----------

.. start-mc-alias-desc

The :mc:`bm alias` commands provide a convenient interface for managing the list of S3-compatible hosts that :mc-cmd:`bm` can connect to and run operations against.

.. end-mc-alias-desc

.. important:: 
   
   :mc-cmd:`bm` commands that operate on S3-compatible services *require* specifying an alias for that service.

Subcommands
-----------

:mc:`bm alias` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm alias list`
     - .. include:: /reference/bm-cli/bm-alias-list.rst
          :start-after: start-mc-alias-list-desc
          :end-before: end-mc-alias-list-desc

   * - :mc:`~bm alias remove`
     - .. include:: /reference/bm-cli/bm-alias-remove.rst
          :start-after: start-mc-alias-remove-desc
          :end-before: end-mc-alias-remove-desc

   * - :mc:`~bm alias set`
     - .. include:: /reference/bm-cli/bm-alias-set.rst
          :start-after: start-mc-alias-set-desc
          :end-before: end-mc-alias-set-desc

   * - :mc:`~bm alias import`
     - .. include:: /reference/bm-cli/bm-alias-import.rst
          :start-after: start-mc-alias-import-desc
          :end-before: end-mc-alias-import-desc

   * - :mc:`~bm alias export`
     - .. include:: /reference/bm-cli/bm-alias-export.rst
          :start-after: start-mc-alias-export-desc
          :end-before: end-mc-alias-export-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-alias-list
   /reference/bm-cli/bm-alias-remove
   /reference/bm-cli/bm-alias-set
   /reference/bm-cli/bm-alias-import
   /reference/bm-cli/bm-alias-export
