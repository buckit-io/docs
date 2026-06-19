==============
``bm encrypt``
==============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm encrypt


Description
-----------

.. start-mc-encrypt-desc

The :mc:`bm encrypt` commands set, update, or disable the default bucket Server-Side Encryption (SSE) mode. 
Buckit automatically encrypts objects using the specified SSE mode.

.. end-mc-encrypt-desc

Subcommands
-----------

:mc:`bm encrypt` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm encrypt clear`
     - .. include:: /reference/bm-cli/bm-encrypt-clear.rst
          :start-after: start-mc-encrypt-clear-desc
          :end-before: end-mc-encrypt-clear-desc

   * - :mc:`~bm encrypt info`
     - .. include:: /reference/bm-cli/bm-encrypt-info.rst
          :start-after: start-mc-encrypt-info-desc
          :end-before: end-mc-encrypt-info-desc

   * - :mc:`~bm encrypt set`
     - .. include:: /reference/bm-cli/bm-encrypt-set.rst
          :start-after: start-mc-encrypt-set-desc
          :end-before: end-mc-encrypt-set-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-encrypt-clear
   /reference/bm-cli/bm-encrypt-info
   /reference/bm-cli/bm-encrypt-set
