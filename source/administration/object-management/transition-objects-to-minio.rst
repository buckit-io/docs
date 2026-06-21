.. _minio-lifecycle-management-transition-to-minio:

==============================================
Transition Objects to Remote Buckit Deployment
==============================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

The procedure on this page creates a new object lifecycle management rule that transitions objects from a bucket on a primary Buckit deployment to a bucket on a remote Buckit deployment.
This procedure supports cost-management strategies such as tiering objects from a "hot" Buckit deployment using NVMe storage to a "warm" Buckit deployment using SSD.

.. todo: diagram

Requirements
------------

Install and Configure ``mc``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This procedure uses :mc:`mc` for performing operations on the Buckit cluster.
Install :mc:`mc` on a machine with network access to both source and destination
clusters. See the ``mc`` :ref:`Installation Quickstart <mc-install>` for
instructions on downloading and installing ``mc``.

Use the :mc:`mc alias set` command to create an alias for the source Buckit cluster.
Alias creation requires specifying an access key for a user on the source and
destination clusters. The specified users must have :ref:`permissions
<minio-lifecycle-management-transition-to-minio-permissions>` for configuring and
applying transition operations.

.. _minio-lifecycle-management-transition-to-minio-permissions:

Required Source Buckit Permissions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit requires the following permissions scoped to the bucket or buckets 
for which you are creating lifecycle management rules.

- :policy-action:`s3:PutLifecycleConfiguration`
- :policy-action:`s3:GetLifecycleConfiguration`

Buckit also requires the following administrative permissions on the cluster
in which you are creating remote tiers for object transition lifecycle
management rules:

- :policy-action:`admin:SetTier`
- :policy-action:`admin:ListTier`

For example, the following policy provides permission for configuring object
transition lifecycle management rules on any bucket in the cluster:

.. literalinclude:: /extra/examples/LifecycleManagementAdmin.json
   :language: json
   :class: copyable

.. _minio-lifecycle-management-transition-to-minio-permissions-remote:

Required Remote Buckit Permissions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Object transition lifecycle management rules require additional permissions
on the remote storage tier. Specifically, Buckit requires the remote
tier credentials provide read, write, list, and delete permissions for the
remote bucket.

For example, the following policy on the remote Buckit deployment provides the necessary permission
for transitioning objects into and out of the remote tier:

.. literalinclude:: /extra/examples/LifecycleManagementUser.json
   :language: json
   :class: copyable

Modify the ``Resource`` for the bucket into which Buckit tiers objects.

Refer to the :ref:`minio-policy` documentation for more complete guidance on configuring the required permissions.

Remote Bucket Must Exist
~~~~~~~~~~~~~~~~~~~~~~~~

Create the remote bucket *prior* to configuring lifecycle management tiers or rules using that bucket as the target.

If the remote bucket contains existing data, use the :mc-cmd:`prefix <mc ilm tier add --prefix>` feature to isolate transitioned objects from any other objects on that bucket.

Considerations
--------------

Lifecycle Management Object Scanner
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit uses a :ref:`scanner process <minio-concepts-scanner>` to check objects against all configured
lifecycle management rules. Slow scanning due to high IO workloads or
limited system resources may delay application of lifecycle management rules.

Exclusive Access to Remote Data
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-tiering.rst
   :start-after: start-transition-bucket-access-desc
   :end-before: end-transition-bucket-access-desc

Availability of Remote Data
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-tiering.rst
   :start-after: start-transition-data-loss-desc
   :end-before: end-transition-data-loss-desc

Procedure
---------

1) Configure User Accounts and Policies for Lifecycle Management
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. |permissions| replace:: :ref:`permissions <minio-lifecycle-management-transition-to-minio-permissions>`

.. include:: /includes/common-minio-tiering.rst
   :start-after: start-create-transition-user-desc
   :end-before: end-create-transition-user-desc

2) Configure the Remote Storage Tier
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :mc:`mc ilm tier add` command to add the remote Buckit deployment as the
new remote storage tier:

.. code-block:: shell
   :class: copyable

   mc ilm tier add minio TARGET TIER_NAME  \
      --endpoint https://HOSTNAME       \
      --access-key ACCESS_KEY           \
      --secret-key SECRET_KEY           \
      --bucket BUCKET                   \
      --prefix PREFIX                   \
      --storage-class STORAGE_CLASS     \
      --region REGION 

The example above uses the following arguments:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Argument
     - Description
   
   * - :mc-cmd:`ALIAS <mc ilm tier add TARGET>`
     - The :mc:`alias <mc alias>` of the Buckit deployment on which to configure
       the Buckit remote tier.
   
   * - :mc-cmd:`TIER_NAME <mc ilm tier add TIER_NAME>`
     - The name to associate with the new Buckit remote storage tier. Specify the
       name in all-caps, e.g. ``MINIO_WARM_TIER``. This value is required in the next
       step.

   * - :mc-cmd:`HOSTNAME <mc ilm tier add --endpoint>`
     - The URL endpoint for the Buckit storage backend.

   * - :mc-cmd:`ACCESS_KEY <mc ilm tier add --access-key>`
     - The access key Buckit uses to access the bucket. The
       access key *must* correspond to an IAM user with the 
       required 
       :ref:`permissions 
       <minio-lifecycle-management-transition-to-minio-permissions-remote>`.

   * - :mc-cmd:`SECRET_KEY <mc ilm tier add --secret-key>`
     - The corresponding secret key for the specified ``ACCESS_KEY``.

   * - :mc-cmd:`BUCKET <mc ilm tier add --bucket>`
     - The name of the bucket on the remote Buckit deployment to which the ``SOURCE``
       transitions objects.

   * - :mc-cmd:`PREFIX <mc ilm tier add --prefix>`
     - The optional bucket prefix within which Buckit transitions objects.

       Buckit stores all transitioned objects in the specified ``BUCKET`` under a
       unique per-deployment prefix value. Omit this argument to use only that
       value for isolating and organizing data within the remote storage.

       Buckit recommends specifying this optional prefix for remote storage tiers
       which contain other data, including transitioned objects from other Buckit
       deployments. This prefix should provide a clear reference back to the
       source Buckit deployment to facilitate ease of operations related to
       diagnostics, maintenance, or disaster recovery.

   * - :mc-cmd:`STORAGE_CLASS <mc ilm tier add --storage-class>`
     - The :ref:`Erasure Coding storage class <minio-ec-storage-class>` Buckit applies to objects transitions to the remote Buckit bucket. 
       Specify one of the following supported storage classes:

       - ``STANDARD`` *Recommended*
       - ``REDUCED``

   * - :mc-cmd:`REGION <mc ilm tier add --region>`
     - The Buckit region of the specified ``BUCKET``.

       Buckit deployments typically do not require setting a region as part of setup.
       Only include this option if you explicitly set the ``MINIO_SITE_REGION`` configuration setting for the deployment.

3) Create and Apply the Transition Rule
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-tiering.rst
   :start-after: start-create-transition-rule-desc
   :end-before: end-create-transition-rule-desc


4) Verify the Transition Rule
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :mc:`mc ilm rule ls` command to review the configured transition
rules:

.. code-block:: shell
   :class: copyable

   mc ilm rule ls ALIAS/PATH --transition

- Replace :mc-cmd:`ALIAS <mc ilm rule ls ALIAS>` with the :mc:`alias <mc alias>`
  of the Buckit deployment.

- Replace :mc-cmd:`PATH <mc ilm rule ls ALIAS>` with the name of the bucket for
  which to retrieve the configured lifecycle management rules.
