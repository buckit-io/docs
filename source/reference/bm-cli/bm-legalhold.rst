================
``bm legalhold``
================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm legalhold


Description
-----------

.. start-mc-legalhold-desc

The :mc:`bm legalhold` command sets, removes, or retrieves the :ref:`object legal hold (WORM) <minio-object-locking-legalhold>` settings for object(s).

.. end-mc-legalhold-desc

Subcommands
-----------

:mc:`bm legalhold` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm legalhold clear`
     - .. include:: /reference/bm-cli/bm-legalhold-clear.rst
          :start-after: start-mc-legalhold-clear-desc
          :end-before: end-mc-legalhold-clear-desc

   * - :mc:`~bm legalhold info`
     - .. include:: /reference/bm-cli/bm-legalhold-info.rst
          :start-after: start-mc-legalhold-info-desc
          :end-before: end-mc-legalhold-info-desc

   * - :mc:`~bm legalhold set`
     - .. include:: /reference/bm-cli/bm-legalhold-set.rst
          :start-after: start-mc-legalhold-set-desc
          :end-before: end-mc-legalhold-set-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-legalhold-clear
   /reference/bm-cli/bm-legalhold-info
   /reference/bm-cli/bm-legalhold-set
