======================
``bm admin policy ls``
======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin policy ls
.. mc:: bm admin policy list

Syntax
------

.. start-mc-admin-policy-list-desc

Lists all policies on the target Buckit deployment.

.. end-mc-admin-policy-list-desc

The :mc:`bm admin policy list` command has equivalent functionality to :mc:`bm admin policy ls`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command displays a list of the policies currently current on the :term:`alias` ``play``.

      .. code-block:: shell
         :class: copyable

         bm admin policy ls play

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm admin policy ls TARGET

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

The :mc-cmd:`bm admin policy ls` command accepts the following arguments:

.. mc-cmd:: TARGET
   
   The :mc-cmd:`alias <bm alias>` of a configured Buckit deployment from which the command lists the available policies.

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

List the policies that exist on the deployment at alias ``mybuckit``.

.. code-block:: shell
   :class: copyable

   bm admin policy ls mybuckit

Output
~~~~~~

The command returns output that resembles the following:

.. code-block:: shell

   readwrite
   writeonly