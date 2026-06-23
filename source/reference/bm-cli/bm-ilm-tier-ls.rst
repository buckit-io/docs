.. _minio-mc-ilm-tier-ls:

==================
``bm ilm tier ls``
==================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm ilm tier list
.. mc:: bm ilm tier ls


Description
-----------

.. start-mc-ilm-tier-ls-desc

The :mc:`bm ilm tier ls` command shows the remote tiers configured on a deployment. 

.. end-mc-ilm-tier-ls-desc

The :mc:`bm ilm tier list` command has equivalent functionality to :mc:`bm ilm tier ls`.

Syntax
------

The command has the following syntax:

.. tab-set::

   .. tab-item:: EXAMPLE

      The following example outputs a list of the existing remote tiers on the ``mybuckit`` deployment.
      
      .. code-block:: shell
         :class: copyable

          bm ilm tier ls mybuckit


   .. tab-item:: SYNTAX
   
      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm ilm tier ls TARGET TIER_NAME 

Parameters
~~~~~~~~~~

The command accepts the following argument:

.. mc-cmd:: TARGET
   :required:

   The :mc-cmd:`alias <bm alias>` of a configured Buckit deployment on which the desired tier exists.


Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility

Required Permissions
--------------------

For permissions required for reviewing a tier, refer to the :ref:`required permissions <minio-mc-ilm-tier-permissions>` on the parent command.
