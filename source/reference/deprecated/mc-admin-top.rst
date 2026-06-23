================
``mc admin top``
================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: mc admin top


Description
-----------

.. start-mc-admin-top-desc

The :mc-cmd:`bm admin top` command returns statistics for distributed
Buckit deployments, similar to the output of the ``top`` command. 

.. end-mc-admin-top-desc

.. admonition:: Use ``mc admin`` on Buckit Deployments Only
   :class: note

   .. include:: /includes/facts-mc-admin.rst
      :start-after: start-minio-only
      :end-before: end-minio-only

Syntax
------

.. mc-cmd:: locks
   :fullpath:

   Returns the 10 oldest locks on the Buckit deployment.

   The command has the following syntax:

   .. code-block:: shell
      :class: copyable

      mc admin top locks TARGET

   The command supports the following arguments:

   .. mc-cmd:: TARGET

      The :mc-cmd:`alias <bm alias>` of a configured Buckit deployment from which
      the command retrieves statistics.

      The alias *must* correspond to a distributed (multi-node) Buckit deployment.
      The command returns an error for :term:`single-node single-drive` deployments.
      

