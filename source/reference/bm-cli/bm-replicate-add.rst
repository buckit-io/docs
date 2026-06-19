.. _minio-mc-replicate-add:

====================
``bm replicate add``
====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm replicate add

.. versionchanged:: RELEASE.2022-12-24T15-21-38Z 

   ``bm replicate add`` replaces the ``bm admin bucket remote add`` command.

   Buckit automatically creates remote targets based on a given file path or resource location (such as an IP or DNS address).
   Users defining a remote target no longer need to determine an ARN for the remote bucket.

Syntax
------

.. start-mc-replicate-add-desc

The :mc:`bm replicate add` command creates a new :ref:`server-side replication
<minio-bucket-replication-serverside>` rule for a bucket on a Buckit deployment.

.. end-mc-replicate-add-desc

The remote bucket **must** be on a Buckit deployment running the same version of Buckit as the local deployment.

.. note::

   Where :mc:`bm mirror` only synchronizes the current version of an object, ``bm replicate`` synchronizes all versions, version information, and metadata for the objects.

The Buckit deployment automatically begins synchronizing new objects to the remote Buckit deployment after creating the rule. 
You can optionally configure synchronization of existing objects, delete operations, and fully-deleted objects.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command adds a new replication rule for the ``mydata`` bucket on the ``myminio`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm replicate add                                                     \
            --remote-bucket https://user:secret@minio.mysite.tld:9001/bucket  \
            --replicate "delete,delete-marker,existing-objects"               \
            myminio/mydata

      The replication rule synchronizes versioned delete operations, delete markers, and existing objects to the remote Buckit deployment.

      .. versionchanged:: mc RELEASE.2024-03-03T00-13-08Z

         You can use a configured ALIAS to the ``--remote-bucket`` flag.

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] replicate add                     \
                          --remote-bucket string          \
                          [--bandwidth "string"]            \
                          [--disable]                       \
                          [--disable-proxy]                 \
                          [--healthcheck-seconds integer]   \
                          [--id "string"]                   \
                          [--limit-upload "string"]         \
                          [--limit-download "string"]       \
                          [--path "string"]                 \
                          [--region "string"]               \
                          [--replicate "string"]            \
                          [--storage-class "string"]        \
                          [--sync]                          \
                          [--tags "string"]                 \
                          [--priority int]                  \
                          ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :ref:`alias <alias>` of the Buckit deployment and full path to the bucket or bucket prefix on which to create the replication rule. 
   For example:

   .. code-block:: none

      bm replicate add --remote-bucket https://user:secret@myminio.cloudprovider.tld:9001/bucket play/mybucket

.. mc-cmd:: --remote-bucket
   :required:

   .. versionchanged:: mc RELEASE.2024-03-03T00-13-08Z

      The ``--remote-bucket`` supports specifying an existing :ref:`alias <alias>`.

   Specify the credentials, destination deployment, and bucket of the remote location. 
   Value may be an IP address, URL, or :ref:`alias <alias>`/bucket.

   For example, a URL based target might look like the following:

   .. code-block::

      https://user:secret@myminio.cloudprovider.tld:9001/bucket

   An alias based target might look like the following:

   .. code-block::

      --remote-bucket minio-target/my-bucket

.. mc-cmd:: --bandwidth
   :optional:

   Limit bandwidth rates to no more than the specified rate in KiB/s, MiB/s, or GiB/s.
   Valid units include: 
   
   - ``B`` for bytes
   - ``K`` for kilobytes
   - ``G`` for gigabytes
   - ``T`` for terabytes
   - ``Ki`` for kibibytes
   - ``Gi`` for gibibytes
   - ``Ti`` for tebibytes

   For example, to limit bandwidth rates to no more than 1 GiB/s, use the following:

   .. code-block::

      --limit-upload 1Gi

   If not specified, Buckit does not limit the bandwidth rate.

    
.. mc-cmd:: --disable
   :optional:

   Creates the replication rule in the "disabled" state. 
   Buckit does not begin replicating objects using the rule until it is enabled using :mc:`bm replicate update`.

   Objects created while replication is disabled are not immediately eligible for replication after enabling the rule.
   You must explicitly enable replication of existing objects by including ``"existing-objects"`` to the list of replication features specified to :mc-cmd:`bm replicate update --replicate`. 
   See :ref:`minio-replication-behavior-existing-objects` for more information.

.. mc-cmd:: --disable-proxy
   :optional:

   When defining active-active replication between buckets, do not proxy.

   By default, Buckit proxies.

.. mc-cmd:: --healthcheck-seconds
   :optional:

   The length of time in seconds between checks on the health of the remote bucket.

   If not specified, Buckit uses an interval of 60 seconds.

.. mc-cmd:: --id
   :optional:

   Specify a unique ID for the replication rule. 
   Buckit automatically generates an ID if one is not specified.

.. mc-cmd:: --limit-download
   :optional:

   Limit download rates to no more than a specified rate in KiB/s, MiB/s, or GiB/s.
   Valid units include: 
   
   - ``B`` for bytes
   - ``K`` for kilobytes
   - ``G`` for gigabytes
   - ``T`` for terabytes
   - ``Ki`` for kibibytes
   - ``Gi`` for gibibytes
   - ``Ti`` for tebibytes

   For example, to limit download rates to no more than 1 GiB/s, use the following:

   .. code-block::

      --limit-download 1G

   If not specified, Buckit uses an unlimited download rate.

.. mc-cmd:: --limit-upload
   :optional:

   Limit upload rates to no more than the specified rate in KiB/s, MiB/s, or GiB/s.
   Valid units include: 
   
   - ``B`` for bytes
   - ``K`` for kilobytes
   - ``G`` for gigabytes
   - ``T`` for terabytes
   - ``Ki`` for kibibytes
   - ``Gi`` for gibibytes
   - ``Ti`` for tebibytes

   For example, to limit upload rates to no more than 1 GiB/s, use the following:

   .. code-block::

      --limit-upload 1G

   If not specified, Buckit uses an unlimited upload rate.


.. mc-cmd:: --path
   :optional:

   Enable path-style lookup support for the remote bucket.

   Valid values include:

   - ``on`` - use a path lookup to find the remote bucket
   - ``off`` - use a resource locator style (such as a domain or IP address) lookup to find the remote bucket
   - ``auto`` - ask Buckit to identify the correct type of lookup to use to find the remote bucket

   When not defined, Buckit uses the ``auto`` value.

.. mc-cmd:: --priority
   :optional:

   Specify the integer priority of the replication rule. 
   The value *must* be unique among all other rules on the source bucket. 
   Higher values imply a *higher* priority than all other rules.

   The default value is ``0``. 

.. mc-cmd:: --region
   :optional:

   The region of the destination bucket to replicate contents to.

.. mc-cmd:: --replicate
   :optional:

   Specify a comma-separated list of the following values to enable extended replication features. 

   - ``delete`` - Directs Buckit to replicate :ref:`DELETE operations <minio-object-delete>` to the destination bucket.

   - ``delete-marker`` - Directs Buckit to replicate delete markers to the destination bucket. 

   - ``existing-objects`` - Directs Buckit to replicate objects created before replication was enabled *or* while replication was suspended.

   - ``metadata-sync`` - Directs Buckit to replicate metadata for each object.
     For active-active replication situations only.

     Omitting this value directs Buckit to stop replicating metadata-only changes back to the source. 

   If not specified, Buckit syncs all options.

.. mc-cmd:: --storage-class
   :optional:

   Specify the Buckit :ref:`storage class <minio-ec-storage-class>` to apply to replicated objects. 

.. mc-cmd:: --sync
   :optional:

   Enable synchronous replication for this remote target.

   By default, Buckit uses asynchronous replication.

.. mc-cmd:: --tags
   :optional:

   Specify one or more ampersand ``&`` separated key-value pair tags which Buckit uses for filtering objects to replicate. 
   For example:

   .. code-block:: shell

      bm replicate add --tags "TAG1=VALUE&TAG2=VALUE&TAG3=VALUE" ALIAS

   Buckit applies the replication rule to any object whose tag set
   contains the specified replication tags.


Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Configure Bucket Replication
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following :mc:`bm replicate add` command creates a replication configuration that synchronizes all new objects, existing objects, delete operations, and delete markers to the remote target:

.. code-block:: shell
   :class: copyable

   bm replicate add myminio/mybucket \
      --remote-bucket https://user:secret@minio.mysite.tld/remotebucket \
      --replicate "delete,delete-marker,existing-objects"

- Replace ``myminio/mybucket`` with the :mc-cmd:`~bm replicate add ALIAS` and full bucket path for which to create the replication configuration.

- Replace the :mc-cmd:`~bm replicate add --remote-bucket` value with the URL or path of the remote target. 
  If using a file path format location, use the ``--path on`` option.

- The :mc-cmd:`~bm replicate add --replicate` flag directs Buckit to replicate all delete operations, delete markers, and existing objects to the remote. 
  See :ref:`minio-replication-behavior-delete` and :ref:`minio-replication-behavior-existing-objects` for more information on replication behavior.

Configure Bucket Replication for Historical Data Record
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following :mc:`bm replicate add` command creates a new bucket replication configuration that synchronizes all new and existing objects to the remote target:

.. code-block:: shell
   :class: copyable

   bm replicate add myminio/mybucket \
      --remote-bucket https://user:secret@minio.mysite.tld/remotebucket \
      --replicate "existing-objects"

- Replace ``myminio/mybucket`` with the :mc-cmd:`~bm replicate add ALIAS` and full bucket path for which to create the replication configuration.

- Replace the :mc-cmd:`~bm replicate add --remote-bucket` value with the location of the remote target. 
  If using a file path format location, use the ``--path on`` option.

- The :mc-cmd:`~bm replicate add --replicate` flag directs Buckit to replicate all existing objects to the remote. 
  See :ref:`minio-replication-behavior-existing-objects` for more information on replication behavior.

The resulting remote copy represents a historical record of objects on the remote, where delete operations on the source have no effect on the remote copy.

Behavior
--------

Server-Side Replication Requires Buckit Source and Destination
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit server-side replication only works between Buckit deployments. 
Both the source and destination deployments *must* run Buckit. 

To configure replication between arbitrary S3-compatible services, use :mc:`bm mirror`.

Enable Versioning on Source and Destination Buckets
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit relies on the immutability protections provided by versioning to synchronize objects between the source and replication target.

Use the :mc:`bm version enable` command to enable versioning on *both* the source and destination bucket before starting this procedure:

.. code-block:: shell
   :class: copyable

   bm version enable ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm version enable ALIAS>` with the :mc:`alias <bm alias>` of the Buckit deployment.

- Replace :mc-cmd:`PATH <bm version enable ALIAS>` with the bucket on which to enable versioning.

Required Permissions
~~~~~~~~~~~~~~~~~~~~

Buckit strongly recommends creating users specifically for supporting bucket replication operations. 
See :mc:`bm admin user` and :mc:`bm admin policy` for more complete documentation on adding users and policies to a Buckit deployment.

.. tab-set::

   .. tab-item:: Replication Admin

      The following policy provides permissions for configuring and enabling replication on a deployment. 

      .. literalinclude:: /extra/examples/ReplicationAdminPolicy.json
         :class: copyable
         :language: json

      - The ``"EnableRemoteBucketConfiguration"`` statement grants permission for creating a remote target for supporting replication.

      - The ``"EnableReplicationRuleConfiguration"`` statement grants permission for creating replication rules on a bucket. 
        The ``"arn:aws:s3:::*`` resource applies the replication permissions to *any* bucket on the source deployment. 
        You can restrict the user policy to specific buckets as-needed.

      Use the :mc-cmd:`bm admin policy create` to add this policy to each deployment acting as a replication source. 
      Use :mc-cmd:`bm admin user add` to create a user on the deployment and :mc-cmd:`bm admin policy attach` to associate the policy to that new user.

   .. tab-item:: Replication Remote User

      The following policy provides permissions for enabling synchronization of replicated data *into* the deployment. 

      .. literalinclude:: /extra/examples/ReplicationRemoteUserPolicy.json
         :class: copyable
         :language: json

      - The ``"EnableReplicationOnBucket"`` statement grants permission for a remote target to retrieve bucket-level configuration for supporting replication operations on *all* buckets in the Buckit deployment. 
        To restrict the policy to specific buckets, specify those buckets as an element in the ``Resource`` array similar to ``"arn:aws:s3:::bucketName"``.

      - The ``"EnableReplicatingDataIntoBucket"`` statement grants permission for a remote target to synchronize data into *any* bucket in the Buckit deployment. 
        To restrict the policy to specific buckets, specify those buckets as an element in the ``Resource`` array similar to ``"arn:aws:s3:::bucketName/*"``.

      Use the :mc-cmd:`bm admin policy create` to add this policy to each deployment acting as a replication target. 
      Use :mc-cmd:`bm admin user add` to create a user on the deployment and :mc-cmd:`bm admin policy attach` to associate the policy to that new user.

Replication of Existing Objects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Starting with :mc:`mc` :minio-git:`RELEASE.2021-06-13T17-48-22Z <mc/releases/tag/RELEASE.2021-06-13T17-48-22Z>` and :mc:`minio` :minio-git:`RELEASE.2021-06-07T21-40-51Z <minio/releases/tag/RELEASE.2021-06-07T21-40-51Z>`, Buckit supports automatically replicating existing objects in a bucket. 
Buckit existing object replication implements functionality similar to `AWS Replicating existing objects between S3 buckets <https://aws.amazon.com/blogs/storage/replicating-existing-objects-between-s3-buckets/>`__ without the overhead of contacting technical support. 

- To enable replication of existing objects when creating a new replication rule, include ``"existing-objects"`` to the list of replication features specified to :mc-cmd:`bm replicate add --replicate`.

- To enable replication of existing objects for an existing replication rule, add ``"existing-objects"`` to the list of existing replication features using :mc-cmd:`bm replicate add --replicate`. 
  You must specify *all* desired replication features when editing the replication rule. 

See :ref:`minio-replication-behavior-existing-objects` for more complete documentation on this behavior.

Synchronization of Metadata Changes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit supports :ref:`two-way active-active <minio-bucket-replication-serverside-twoway>` replication configurations, where Buckit synchronizes new and modified objects between a bucket on two Buckit deployments. 
Starting with :mc:`mc` :minio-git:`RELEASE.2021-05-18T03-39-44Z <mc/releases/tag/RELEASE.2021-05-18T03-39-44Z>`, Buckit by default synchronizes metadata-only changes to a replicated object back to the "source" deployment. 
Prior to the this update, Buckit did not support synchronizing metadata-only changes to a replicated object.

With metadata synchronization enabled, Buckit resets the object :ref:`replication status <minio-replication-process>` to indicate replication eligibility. 
Specifically, when an application performs a metadata-only update to an object with the ``REPLICA`` status, Buckit marks the object as ``PENDING`` and eligible for replication.

To disable metadata synchronization, use the :mc-cmd:`bm replicate update --replicate` command and omit ``replica-metadata-sync`` from the replication feature list. 

Replication of Delete Operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit supports replicating delete operations onto the target bucket. 
Specifically, Buckit can replicate both :s3-docs:`Delete Markers <versioning-workflows.html>` *and* the deletion of specific versioned objects:

- For delete operations on an object, Buckit replication also creates the delete marker on the target bucket. 

- For delete operations on versions of an object, Buckit replication also deletes those versions on the target bucket.

Buckit does *not* replicate objects deleted due to :ref:`lifecycle management expiration rules <minio-lifecycle-management-expiration>`. 
Buckit only replicates explicit client-driven delete operations.

Buckit requires explicitly enabling replication of delete operations using the :mc-cmd:`bm replicate add --replicate` flag. 
This procedure includes the required flags for enabling replication of delete operations and delete markers.
See :ref:`minio-replication-behavior-delete` for more complete documentation on this behavior.

Replication of Encrypted Objects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit supports replicating objects encrypted with automatic Server-Side Encryption (SSE-S3). 
Both the source and destination buckets *must* have automatic SSE-S3 enabled for Buckit to replicate an encrypted object.

As part of the replication process, Buckit *decrypts* the object on the source bucket and transmits the unencrypted object. 
The destination Buckit deployment then re-encrypts the object using the destination bucket SSE-S3 configuration.
Buckit *strongly recommends* :ref:`enabling TLS <minio-TLS>` on both source and destination deployments to ensure the safety of objects during transmission.

Buckit does *not* support replicating client-side encrypted objects (SSE-C).

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
