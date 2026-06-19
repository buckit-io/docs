====================
``bm admin scanner``
====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin scanner


Description
-----------

.. start-mc-admin-scanner-desc

The :mc:`bm admin scanner` commands provide information about the :ref:`scanner <minio-concepts-scanner>` process. 

.. end-mc-admin-scanner-desc

Subcommands
-----------

:mc:`bm admin scanner` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm admin scanner status`
     - .. include:: /reference/bm-admin/bm-admin-scanner-status.rst
          :start-after: start-mc-admin-scanner-status-desc
          :end-before: end-mc-admin-scanner-status-desc

   * - :mc:`~bm admin scanner trace`
     - .. include:: /reference/bm-admin/bm-admin-scanner-trace.rst
          :start-after: start-mc-admin-scanner-trace-desc
          :end-before: end-mc-admin-scanner-trace-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-admin/bm-admin-scanner-status
   /reference/bm-admin/bm-admin-scanner-trace
