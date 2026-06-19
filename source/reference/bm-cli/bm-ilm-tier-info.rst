.. _minio-mc-ilm-tier-info:

====================
``bm ilm tier info``
====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm ilm tier info

Description
-----------

.. start-mc-ilm-tier-info-desc

The :mc:`bm ilm tier info` command outputs statistics about a tier or all tiers for a deployment. 

.. end-mc-ilm-tier-info-desc

Required Permissions
~~~~~~~~~~~~~~~~~~~~

Buckit requires the following permissions scoped to to the bucket or buckets 
for which you are creating lifecycle management rules.

- :policy-action:`s3:PutLifecycleConfiguration`
- :policy-action:`s3:GetLifecycleConfiguration`

Buckit also requires the following administrative permissions on the cluster
in which you are creating remote tiers for object transition lifecycle
management rules:

- :policy-action:`admin:SetTier`
- :policy-action:`admin:ListTier`

For example, the following policy provides permission for configuring object
transition lifecycle management rules on any bucket in the cluster:.

.. literalinclude:: /extra/examples/LifecycleManagementAdmin.json
   :language: json
   :class: copyable

Syntax
------

The command has the following syntax:

.. tab-set::

   .. tab-item:: EXAMPLE

      The following example outputs the configuration for an existing remote tier called ``WARM-TIER`` on the ``myminio`` deployment.
      
      .. code-block:: shell
         :class: copyable

          bm ilm tier info myminio WARM-TIER


   .. tab-item:: SYNTAX
   
      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm ilm tier info TARGET TIER_NAME 

Parameters
~~~~~~~~~~

The command accepts the following arguments:

.. mc-cmd:: TARGET
   :required:

   The :mc-cmd:`alias <bm alias>` of a configured Buckit deployment on which the desired tier exists.
      
.. mc-cmd:: TIER_NAME
   :optional:

   The name of an existing remote tier to display. 

   You **must** specify the tier in all-caps, e.g. ``WARM_TIER``.

   If not specified, Buckit lists statistics for all existing tiers on the deployment.
   

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Example
-------

Display the Statistics for an Existing Tier
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following example displays the statistics of the tier ``WARM-TIER`` on the ``myminio`` deployment.

.. code-block:: shell
   :class: copyable

   bm ilm tier info myminio WARM-TIER 

Display the Statistics for all Existing Tiers on a Deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following example displays the statistics of all existing tiers on the ``myminio`` deployment.

.. code-block:: shell
   :class: copyable

   bm ilm tier info myminio

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility

Required Permissions
--------------------

For permissions required to review a tier, refer to the :ref:`required permissions <minio-mc-ilm-tier-permissions>` on the parent command.