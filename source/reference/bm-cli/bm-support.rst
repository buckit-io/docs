==============
``bm support``
==============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm support


Description
-----------

.. start-mc-support-desc

The Buckit Manager CLI :mc:`bm support` commands provides tools for analyzing deployment health or performance and for running diagnostics.
You can also upload generated health reports for further analysis by Buckit engineering.

.. end-mc-support-desc

.. important::

   The ``bm support`` commands require an active |SUBNET| registration.
   
   :mc-cmd:`bm support proxy set` and :mc-cmd:`bm support proxy remove` are exceptions, as you may need to set up a proxy to complete the deployment registration.


Subcommands
-----------

:mc:`bm support` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm support callhome`
     - .. include:: /reference/bm-cli/bm-support-callhome.rst
          :start-after: start-mc-support-callhome-desc
          :end-before: end-mc-support-callhome-desc

   * - :mc:`~bm support diag`
     - .. include:: /reference/bm-cli/bm-support-diag.rst
          :start-after: start-mc-support-diag-desc
          :end-before: end-mc-support-diag-desc

   * - :mc:`~bm support inspect`
     - .. include:: /reference/bm-cli/bm-support-inspect.rst
          :start-after: start-mc-support-inspect-desc
          :end-before: end-mc-support-inspect-desc

   * - :mc:`~bm support perf`
     - .. include:: /reference/bm-cli/bm-support-perf.rst
          :start-after: start-mc-support-perf-desc
          :end-before: end-mc-support-perf-desc

   * - :mc:`~bm support profile`
     - .. include:: /reference/bm-cli/bm-support-profile.rst
          :start-after: start-mc-support-profile-desc
          :end-before: end-mc-support-profile-desc

   * - :mc:`~bm support proxy`
     - .. include:: /reference/bm-cli/bm-support-proxy.rst
          :start-after: start-mc-support-proxy-desc
          :end-before: end-mc-support-proxy-desc

   * - :mc:`~bm support top`
     - .. include:: /reference/bm-cli/bm-support-top.rst
          :start-after: start-mc-support-top-desc
          :end-before: end-mc-support-top-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-support-callhome
   /reference/bm-cli/bm-support-diag
   /reference/bm-cli/bm-support-inspect
   /reference/bm-cli/bm-support-perf
   /reference/bm-cli/bm-support-profile
   /reference/bm-cli/bm-support-proxy
   /reference/bm-cli/bm-support-top
   /reference/bm-cli/bm-support-upload