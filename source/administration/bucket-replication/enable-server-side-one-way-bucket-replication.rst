.. _minio-bucket-replication-serverside-oneway:

=============================================
Enable One-Way Server-Side Bucket Replication
=============================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2


The procedure on this page creates a new bucket replication rule for one-way synchronization of objects from one Buckit bucket to another Buckit bucket.
The buckets can be on the same Buckit deployment or on separate Buckit deployments.

.. image:: /images/replication/active-passive-oneway-replication.svg
   :width: 800px
   :alt: Active-Passive Replication synchronizes data from a source Buckit deployment to a remote Buckit deployment.
   :align: center


- To configure two-way "active-active" replication between Buckit buckets, see :ref:`minio-bucket-replication-serverside-twoway`.
- To configure multi-site "active-active" replication between Buckit deployments, see :ref:`minio-bucket-replication-serverside-multi`

.. note::

   To configure replication between arbitrary S3-compatible services (not necessarily Buckit), use :mc:`bm mirror`.


Requirements
------------


Replication requires all participating clusters meet the :ref:`following requirements <minio-bucket-replication-requirements>`. 
This procedure assumes you have reviewed and validated those requirements.

For more details, see the :ref:`Bucket Replication Requirements <minio-bucket-replication-requirements>` page.


Considerations
--------------

Click to expand any of the following:

.. dropdown:: Replication of Existing Objects
   :icon: fold-down

   Buckit supports automatically replicating existing objects in a bucket.

   Buckit requires explicitly enabling replication of existing objects using the :mc-cmd:`bm replicate add --replicate` or :mc-cmd:`bm replicate update --replicate` and including the ``existing-objects`` replication feature flag. 
   This procedure includes the required flags for enabling replication of existing objects.

.. dropdown:: Replication of Delete Operations
   :icon: fold-down

   Buckit supports replicating S3 ``DELETE`` operations onto the target bucket. 
   Specifically, Buckit can replicate versioning :s3-docs:`Delete Markers <versioning-workflows.html>` and the deletion of specific versioned objects:

   - For delete operations on an object, Buckit replication also creates the delete marker on the target bucket.

   - For delete operations on versions of an object, Buckit replication also deletes those versions on the target bucket.

   Buckit requires explicitly enabling replication of delete operations using the :mc-cmd:`bm replicate add --replicate` or :mc-cmd:`bm replicate update --replicate`. 
   This procedure includes the required flags for enabling replication of delete operations and delete markers.

   Buckit does *not* replicate delete operations resulting from the application of :ref:`lifecycle management expiration rules <minio-lifecycle-management-expiration>`.

   See :ref:`minio-replication-behavior-delete` and :ref:`minio-object-delete` for more complete documentation.

.. dropdown:: Multi-Site Replication
   :icon: fold-down

   Buckit supports configuring multiple remote targets per bucket or bucket prefix. 
   For example, you can configure a bucket to replicate data to two or more remote Buckit deployments, where one deployment is a 1:1 copy (replication of all operations including deletions) and another is a full historical record (replication of only non-destructive write operations).

   This procedure documents one-way replication to a single remote Buckit deployment. 
   You can repeat this tutorial to replicate a single bucket to multiple remote targets.

Procedure
---------

- :ref:`Configure One-Way Bucket Replication Using the Command Line <minio-bucket-replication-one-way-minio-cli-procedure>`
   - :ref:`Create a Replication Remote Target <minio-bucket-replication-one-way-minio-cli-create-remote-targets>`
   - :ref:`Create a New Bucket Replication Rule <minio-bucket-replication-one-way-minio-cli-create-replication-rules>`
   - :ref:`Validate the Replication Configuration <minio-bucket-replication-one-way-minio-cli-verify-replication-config>` 


.. _minio-bucket-replication-one-way-minio-cli-procedure:

Configure One-Way Bucket Replication Using the Command Line ``bm``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This procedure uses the :ref:`aliases <alias>` ``SOURCE`` and ``REMOTE`` to reference each Buckit deployment being configured for replication. 
Replace these values with the appropriate alias for your target Buckit deployments.

This procedure assumes each alias corresponds to a user with the :ref:`necessary replication permissions <minio-bucket-replication-serverside-oneway-permissions>`.


.. _minio-bucket-replication-one-way-minio-cli-create-remote-targets:

.. _minio-bucket-replication-one-way-minio-cli-create-replication-rules:

1) Create a New Bucket Replication Rule
+++++++++++++++++++++++++++++++++++++++

.. include:: /includes/common/bucket-replication.rst
   :start-after: start-create-bucket-replication-rule-cli-desc
   :end-before: end-create-bucket-replication-rule-cli-desc

.. _minio-bucket-replication-one-way-minio-cli-verify-replication-config:

2) Validate the Replication Configuration
+++++++++++++++++++++++++++++++++++++++++

.. include:: /includes/common/bucket-replication.rst
   :start-after: start-validate-bucket-replication-cli-desc
   :end-before: end-validate-bucket-replication-cli-desc

.. seealso::

   - Use the :mc:`bm replicate update` command to modify an existing replication rule.

   - Use the :mc:`bm replicate update` command with the :mc-cmd:`--state "disable" <bm replicate update --state>` flag to disable an existing replication rule.

   - Use the :mc:`bm replicate rm` command to remove an existing replication rule.
