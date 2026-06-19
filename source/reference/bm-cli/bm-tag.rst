==========
``bm tag``
==========

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm tag


Description
-----------

.. start-mc-tag-desc

The :mc:`bm tag` command adds, removes, and lists tags associated to a bucket or object.

.. end-mc-tag-desc

Buckit supports adding up to 10 custom tags to an object.

Subcommands
-----------

:mc:`bm tag` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm tag list`
     - .. include:: /reference/bm-cli/bm-tag-list.rst
          :start-after: start-mc-tag-list-desc
          :end-before: end-mc-tag-list-desc

   * - :mc:`~bm tag remove`
     - .. include:: /reference/bm-cli/bm-tag-remove.rst
          :start-after: start-mc-tag-remove-desc
          :end-before: end-mc-tag-remove-desc

   * - :mc:`~bm tag set`
     - .. include:: /reference/bm-cli/bm-tag-set.rst
          :start-after: start-mc-tag-set-desc
          :end-before: end-mc-tag-set-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-tag-set
   /reference/bm-cli/bm-tag-list
   /reference/bm-cli/bm-tag-remove