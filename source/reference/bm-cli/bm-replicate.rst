================
``bm replicate``
================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm replicate


Description
-----------

.. start-mc-replicate-desc

The :mc:`bm replicate <bm replicate add>` command configures and manages the :ref:`Server-Side Bucket Replication <minio-bucket-replication-serverside>` for a Buckit deployment, including :ref:`active-active replication configurations <minio-bucket-replication-serverside-twoway>` and :ref:`resynchronization <minio-replication-behavior-resync>`.

.. end-mc-replicate-desc

.. note::

   For multi-site replication, see :mc:`bm admin replicate`.

Subcommands
-----------

:mc:`bm replicate` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm replicate add`
     - .. include:: /reference/bm-cli/bm-replicate-add.rst
          :start-after: start-mc-replicate-add-desc
          :end-before: end-mc-replicate-add-desc

   * - :mc:`~bm replicate backlog`
     - .. include:: /reference/bm-cli/bm-replicate-backlog.rst
          :start-after: start-mc-replicate-backlog-desc
          :end-before: end-mc-replicate-backlog-desc

   * - :mc:`~bm replicate export`
     - .. include:: /reference/bm-cli/bm-replicate-export.rst
          :start-after: start-mc-replicate-export-desc
          :end-before: end-mc-replicate-export-desc

   * - :mc:`~bm replicate import`
     - .. include:: /reference/bm-cli/bm-replicate-import.rst
          :start-after: start-mc-replicate-import-desc
          :end-before: end-mc-replicate-import-desc

   * - :mc:`~bm replicate ls`
     - .. include:: /reference/bm-cli/bm-replicate-ls.rst
          :start-after: start-mc-replicate-ls-desc
          :end-before: end-mc-replicate-ls-desc

   * - :mc:`~bm replicate resync`
     - .. include:: /reference/bm-cli/bm-replicate-resync.rst
          :start-after: start-mc-replicate-resync-desc
          :end-before: end-mc-replicate-resync-desc

   * - :mc:`~bm replicate rm`
     - .. include:: /reference/bm-cli/bm-replicate-rm.rst
          :start-after: start-mc-replicate-rm-desc
          :end-before: end-mc-replicate-rm-desc

   * - :mc:`~bm replicate status`
     - .. include:: /reference/bm-cli/bm-replicate-status.rst
          :start-after: start-mc-replicate-status-desc
          :end-before: end-mc-replicate-status-desc

   * - :mc:`~bm replicate update`
     - .. include:: /reference/bm-cli/bm-replicate-update.rst
          :start-after: start-mc-replicate-update-desc
          :end-before: end-mc-replicate-update-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-replicate-add
   /reference/bm-cli/bm-replicate-backlog
   /reference/bm-cli/bm-replicate-ls
   /reference/bm-cli/bm-replicate-update
   /reference/bm-cli/bm-replicate-resync
   /reference/bm-cli/bm-replicate-rm
   /reference/bm-cli/bm-replicate-status
   /reference/bm-cli/bm-replicate-export
   /reference/bm-cli/bm-replicate-import