============
``mc quota``
============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: mc quota


Description
-----------

.. start-mc-quota-desc

The :mc:`bm quota` commands configure, display, or remove a quota limit on a bucket. 

.. end-mc-quota-desc

When a bucket with a quota configured reaches the specified limit, as determined by the Buckit object scanner, Buckit rejects further ``PUT`` requests for the bucket.

Each time the Buckit :ref:`object scanner <minio-lifecycle-management-scanner>` scans a bucket for pending :ref:`object lifecycle transitions <minio-lifecycle-management>`, it also checks if the bucket has exceeded a configured quota.

.. admonition:: Quota enforcement is not immediate
   :class: note

   Bucket quotas are not intended to enforce a strict hard limit on a bucket's size.
   If a bucket exceeds its quota between scanner passes, Buckit continues to accept ``PUT`` requests for that bucket until _after_ the next scanner pass identifies the quota violation.


Subcommands
-----------

:mc:`bm quota` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm quota clear`
     - .. include:: /reference/deprecated/mc-quota-clear.rst
          :start-after: start-mc-quota-clear-desc
          :end-before: end-mc-quota-clear-desc

   * - :mc:`~bm quota info`
     - .. include:: /reference/deprecated/mc-quota-info.rst
          :start-after: start-mc-quota-info-desc
          :end-before: end-mc-quota-info-desc

   * - :mc:`~bm quota set`
     - .. include:: /reference/deprecated/mc-quota-set.rst
          :start-after: start-mc-quota-set-desc
          :end-before: end-mc-quota-set-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/deprecated/mc-quota-clear
   /reference/deprecated/mc-quota-info
   /reference/deprecated/mc-quota-set
