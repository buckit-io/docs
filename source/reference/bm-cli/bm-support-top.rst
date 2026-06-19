==================
``bm support top``
==================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm support top

.. note::

   .. versionchanged:: RELEASE.2022-08-11T00-30-48Z

   ``bm support top`` replaces the ``bm admin top`` command.

.. include:: /includes/common-mc-support.rst
   :start-after: start-minio-only
   :end-before: end-minio-only

Description
-----------

.. start-mc-support-top-desc

The :mc:`bm support top` command returns statistics for distributed
Buckit deployments, similar to the output of the ``top`` command in a shell. 

.. end-mc-support-top-desc

.. note::

   :mc:`bm support top` is not supported on single-node single-drive Buckit deployments.

:mc-cmd:`bm support top` has the following subcommands:

- :mc-cmd:`~bm support top api`
- :mc-cmd:`~bm support top locks`
- :mc-cmd:`~bm support top disk`
- :mc-cmd:`~bm support top net`
- :mc-cmd:`~bm support top rpc`

Refer to the pages linked above for each subcommand for details.

Syntax
------

The command has the following syntax:

.. code-block:: shell

   bm support top COMMAND [COMMAND FLAGS] [ARGUMENTS ...]

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-support-top-api
   /reference/bm-cli/bm-support-top-locks
   /reference/bm-cli/bm-support-top-disk
   /reference/bm-cli/bm-support-top-net
   /reference/bm-cli/bm-support-top-rpc