=======================
``bm admin prometheus``
=======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin prometheus

Description
-----------

.. start-mc-admin-prometheus-desc

The :mc:`bm admin prometheus` command and its subcommands provide access to Buckit Prometheus metrics.

.. end-mc-admin-prometheus-desc

Subcommands
-----------

:mc:`bm admin prometheus` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm admin prometheus generate`
     - .. include:: /reference/bm-admin/bm-admin-prometheus-generate.rst
          :start-after: start-mc-admin-prometheus-generate-desc
          :end-before: end-mc-admin-prometheus-generate-desc

   * - :mc:`~bm admin prometheus metrics`
     - .. include:: /reference/bm-admin/bm-admin-prometheus-metrics.rst
          :start-after: start-mc-admin-prometheus-metrics-desc
          :end-before: end-mc-admin-prometheus-metrics-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-admin/bm-admin-prometheus-generate
   /reference/bm-admin/bm-admin-prometheus-metrics
