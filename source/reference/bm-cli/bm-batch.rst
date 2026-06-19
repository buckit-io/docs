============
``bm batch``
============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm batch


.. versionadded:: mc RELEASE.2023-03-20T17-17-53Z

   Added the ability to cancel jobs with the :mc:`bm batch cancel` command.


Description
-----------

.. start-mc-batch-desc

The :mc:`bm batch` commands allow you to run one or more job tasks on a Buckit deployment.

.. end-mc-batch-desc

Subcommands
-----------

:mc-cmd:`bm batch` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm batch cancel`
     - .. include:: /reference/bm-cli/bm-batch-cancel.rst
          :start-after: start-mc-batch-cancel-desc
          :end-before: end-mc-batch-cancel-desc

   * - :mc:`~bm batch describe`
     - .. include:: /reference/bm-cli/bm-batch-describe.rst
          :start-after: start-mc-batch-describe-desc
          :end-before: end-mc-batch-describe-desc
   
   * - :mc:`~bm batch generate`
     - .. include:: /reference/bm-cli/bm-batch-generate.rst
          :start-after: start-mc-batch-generate-desc
          :end-before: end-mc-batch-generate-desc

   * - :mc:`~bm batch list`
     - .. include:: /reference/bm-cli/bm-batch-list.rst
          :start-after: start-mc-batch-list-desc
          :end-before: end-mc-batch-list-desc

   * - :mc:`~bm batch start`
     - .. include:: /reference/bm-cli/bm-batch-start.rst
          :start-after: start-mc-batch-start-desc
          :end-before: end-mc-batch-start-desc

   * - :mc:`~bm batch status`
     - .. include:: /reference/bm-cli/bm-batch-status.rst
          :start-after: start-mc-batch-status-desc
          :end-before: end-mc-batch-status-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-batch-cancel
   /reference/bm-cli/bm-batch-describe
   /reference/bm-cli/bm-batch-generate
   /reference/bm-cli/bm-batch-list
   /reference/bm-cli/bm-batch-start
   /reference/bm-cli/bm-batch-status
