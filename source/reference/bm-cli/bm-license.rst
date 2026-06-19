==============
``bm license``
==============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm license


Description
-----------

.. start-mc-license-desc

The :mc:`bm license` commands work with cluster registration for |SUBNET|. 
Use the commands to register a deployment, display information about the cluster's current license, or update the license key for a cluster.

.. end-mc-license-desc

Subcommands
-----------

:mc:`bm license` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm license info`
     - .. include:: /reference/bm-cli/bm-license-info.rst
          :start-after: start-mc-license-info-desc
          :end-before: end-mc-license-info-desc

   * - :mc:`~bm license register`
     - .. include:: /reference/bm-cli/bm-license-register.rst
          :start-after: start-mc-license-register-desc
          :end-before: end-mc-license-register-desc

   * - :mc:`~bm license update`
     - .. include:: /reference/bm-cli/bm-license-update.rst
          :start-after: start-mc-license-update-desc
          :end-before: end-mc-license-update-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-license-info
   /reference/bm-cli/bm-license-register
   /reference/bm-cli/bm-license-update
