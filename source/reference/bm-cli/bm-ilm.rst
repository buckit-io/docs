==========
``bm ilm``
==========

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm ilm


Description
-----------

.. start-mc-ilm-desc

The :mc:`bm ilm` commands manage :ref:`object lifecycle management rules <minio-lifecycle-management>` and tiering on a Buckit deployment. 

.. end-mc-ilm-desc

Use these command to 

- create tiers
- create :ref:`tiering <minio-lifecycle-management-tiering>` rules
- manage :ref:`expiration <minio-lifecycle-management-expiration>` rules for objects on a bucket
     

Subcommands
-----------

:mc:`bm ilm` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm ilm restore`
     - .. include:: /reference/bm-cli/bm-ilm-restore.rst
          :start-after: start-mc-ilm-restore-desc
          :end-before: end-mc-ilm-restore-desc

   * - :mc:`~bm ilm rule`
     - .. include:: /reference/bm-cli/bm-ilm-rule.rst
          :start-after: start-mc-ilm-rule-desc
          :end-before: end-mc-ilm-rule-desc

   * - :mc:`~bm ilm tier`
     - .. include:: /reference/bm-cli/bm-ilm-tier.rst
          :start-after: start-mc-ilm-tier-desc
          :end-before: end-mc-ilm-tier-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-ilm-restore
   /reference/bm-cli/bm-ilm-rule
   /reference/bm-cli/bm-ilm-tier
