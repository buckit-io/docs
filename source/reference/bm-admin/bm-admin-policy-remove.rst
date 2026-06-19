======================
``bm admin policy rm``
======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin policy remove
.. mc:: bm admin policy rm

Syntax
------

.. start-mc-admin-policy-remove-desc

Removes an IAM policy from the target Buckit deployment. 

.. end-mc-admin-policy-remove-desc

The :mc:`bm admin policy remove` command has equivalent functionality to :mc:`bm admin policy rm`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command removes the policy names ``writeonly`` from the ``myminio`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm admin policy rm myminio writeonly

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm admin policy rm TARGET POLICYNAME 

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

The :mc-cmd:`bm admin policy rm` command accepts the following arguments:

.. mc-cmd:: TARGET

   The :mc-cmd:`alias <bm alias>` of a configured Buckit deployment from which to remove the policy.

.. mc-cmd:: POLICYNAME

   The name of the policy to remove. 
      
Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Remove a policy called ``listbuckets``.

.. code-block:: shell
   :class: copyable

   bm admin policy rm myminio listbuckets