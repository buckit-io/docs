================
``bm anonymous``
================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm anonymous


Description
-----------

.. start-mc-anonymous-desc

The :mc:`bm anonymous` command supports setting or removing anonymous :ref:`policies <minio-policy>` to a bucket and its contents. 
Buckets with anonymous policies allow public access where clients can perform any action granted by the policy without :ref:`authentication <minio-authentication-and-identity-management>`.

.. end-mc-anonymous-desc

Subcommands
-----------

:mc-cmd:`bm anonymous` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm anonymous get`
     - .. include:: /reference/bm-cli/bm-anonymous-get.rst
          :start-after: start-mc-anonymous-get-desc
          :end-before: end-mc-anonymous-get-desc

   * - :mc:`~bm anonymous get-json`
     - .. include:: /reference/bm-cli/bm-anonymous-get-json.rst
          :start-after: start-mc-anonymous-get-json-desc
          :end-before: end-mc-anonymous-get-json-desc

   * - :mc:`~bm anonymous links`
     - .. include:: /reference/bm-cli/bm-anonymous-links.rst
          :start-after: start-mc-anonymous-links-desc
          :end-before: end-mc-anonymous-links-desc

   * - :mc:`~bm anonymous list`
     - .. include:: /reference/bm-cli/bm-anonymous-list.rst
          :start-after: start-mc-anonymous-list-desc
          :end-before: end-mc-anonymous-list-desc

   * - :mc:`~bm anonymous set`
     - .. include:: /reference/bm-cli/bm-anonymous-set.rst
          :start-after: start-mc-anonymous-set-desc
          :end-before: end-mc-anonymous-set-desc

   * - :mc:`~bm anonymous set-json`
     - .. include:: /reference/bm-cli/bm-anonymous-set-json.rst
          :start-after: start-mc-anonymous-set-json-desc
          :end-before: end-mc-anonymous-set-json-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-anonymous-set
   /reference/bm-cli/bm-anonymous-get
   /reference/bm-cli/bm-anonymous-list
   /reference/bm-cli/bm-anonymous-links
   /reference/bm-cli/bm-anonymous-get-json
   /reference/bm-cli/bm-anonymous-set-json
