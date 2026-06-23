.. _minio-mc-replicate-edit:
.. _minio-mc-replicate-update:

=======================
``bm replicate update``
=======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm replicate edit
.. mc:: bm replicate update





Syntax
------

.. start-mc-replicate-update-desc

The :mc:`bm replicate update` command modifies an existing 
:ref:`bucket replication rule <minio-bucket-replication-serverside>`.

.. end-mc-replicate-update-desc

.. code-block:: shell

   bm [GLOBALFLAGS] replicate update FLAGS [FLAGS] ARGUMENTS [ARGUMENTS]

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command modifies an existing replication rule for the
      ``mydata`` bucket on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm replicate update --id "c76um9h4b0t1ijr36mug"           \
            --replicate "delete,delete-marker,existing-objects"  \
            mybuckit/mydata

      The new replication configuration synchronizes all versioned delete
      operations, delete marker creation, and existing objects to the remote
      Buckit deployment.

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] replicate update              \
                          --remote-bucket string          \
                          [--bandwidth "string"]            \
                          [--healthcheck-seconds integer]   \
                          [--id "string"]                   \
                          [--limit-upload "string"]         \
                          [--limit-download "string"]       \
                          [--path "string"]                 \
                          [--priority int]                  \
                          [--proxy]
                          [--replicate "string"]            \
                          [--state string]
                          [--storage-class "string"]        \
                          [--sync string]                          \
                          [--tags "string"]                 \
                          ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :ref:`alias <alias>` of the Buckit deployment and full path to the bucket or bucket prefix on which to modify the replication rule. 
   For example:

   .. code-block:: none

      bm replicate update --id "c75nrap4b0talo3ipthg" [FLAGS]

.. mc-cmd:: --id
   :required:
   
   Specify the unique ID for a configured replication rule. 
   Use the :mc:`bm replicate ls` command to list the replication rules for a bucket.

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

.. mc-cmd:: --healthcheck-seconds
   :optional:

   The length of time in seconds between checks on the health of the remote bucket.

   If not specified, Buckit uses an interval of 60 seconds.

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

.. mc-cmd:: --proxy
   :optional:

   When defining active-active replication between buckets, do not proxy.

   Valid values include:

   - ``enable`` - Enable proxying in active-active replication.
   - ``disable`` - Disable proxying in active-active replication.

   By default, Buckit defaults to ``enable``.


.. mc-cmd:: --remote-bucket
   :optional:

   Specify the credentials, destination deployment, and bucket of the remote location.
   Value may be an :ref:`alias <alias>` and bucket, location based (IP or URL), or path based.

   For example, a URL based target might look like the following:

   .. code-block::

      --remote-bucket https://user:secret@mybuckit.cloudprovider.tld:9001/bucket

   An alias based target might look like the following:

   .. code-block::

      --remote-bucket minio-target/my-bucket

.. mc-cmd:: --replicate
   :optional:

   Specify a comma-separated list of the following values to enable extended replication features:

   - ``delete`` - Directs Buckit to replicate :ref:`DELETE operations <minio-object-delete>` to the destination bucket.

   - ``delete-marker`` - Directs Buckit to replicate delete markers to the destination bucket. 

   - ``replica-metadata-sync`` - Directs Buckit to synchronize metadata-only changes on a replicated object back to the source. 
     This feature only effects :ref:`two-way active-active <minio-bucket-replication-serverside-twoway>` replication configurations.

     Omitting this value directs Buckit to stop replicating metadata-only changes back to the source. 

   - ``existing-objects`` - Directs Buckit to replicate objects created prior to configuring or enabling replication. 
     Buckit by default does *not* synchronize existing objects to the remote target.

     See :ref:`minio-replication-behavior-existing-objects` for more information.

.. mc-cmd:: --state
   :optional:

   Enables or disables the replication rule. 
   Specify one of the following values:

   - ``"enable"`` - Enables the replication rule.
   - ``"disable"`` - Disables the replication rule. 

   Objects created while replication is disabled are not immediately eligible for replication after enabling the rule. 
   You must explicitly enable replication of existing objects by including ``"existing-objects"`` to the list of replication features specified to :mc-cmd:`bm replicate update --replicate`. 
   
   See :ref:`minio-replication-behavior-existing-objects` for more information.

.. mc-cmd:: --storage-class
   :optional:

   Specify the Buckit :ref:`storage class <minio-ec-storage-class>` to apply to replicated objects. 

.. mc-cmd:: --sync
   :optional:

   Enable synchronous replication for this remote target.

   By default, Buckit uses asynchronous replication.

.. mc-cmd:: --tags
   :optional:

   Specify one or more ampersand ``&`` separated key-value pair tags which Buckit uses for filtering objects to replicate. For example:

   .. code-block:: shell

      bm replicate update --id "ID" --tags "TAG1=VALUE&TAG2=VALUE&TAG3=VALUE"

   Buckit applies the replication rule to any object whose tag set
   contains the specified replication tags.

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Modify an Existing Replication Rule
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm replicate update` to modify an existing replication rule.

.. code-block:: shell
   :class: copyable

   bm replicate update ALIAS/PATH \
      --id ID                     \
      [--FLAGS]

- Replace :mc-cmd:`ALIAS <bm replicate update ALIAS>` with the :mc:`alias <bm alias>` of the Buckit deployment.

- Replace :mc-cmd:`PATH <bm replicate update ALIAS>` with the path to the bucket or bucket prefix on which the rule exists.

- Replace :mc-cmd:`ID <bm replicate update --id>` with the unique identifier for the rule to modify. 
  Use :mc:`bm replicate ls` to retrieve the list of replication rules on the bucket and their corresponding identifiers.

.. note::

   Modifying a replication configuration rule does not affect already replicated objects. 
   For example, modifying the :mc-cmd:`~bm replicate update --tags` filter does not result in the removal of replicated objects which do not meet the filter.


Update the Credentials for an Existing Replication Rule
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm replicate update` to modify an existing replication rule.

.. code-block:: shell
   :class: copyable

   bm replicate update ALIAS/PATH \
      --id ID                     \
      --remote-bucket https://user:secret@minio.mycloud.tld:9001/mybucket

- Replace :mc-cmd:`ALIAS <bm replicate update ALIAS>` with the :mc:`alias <bm alias>` of the Buckit deployment.

- Replace :mc-cmd:`PATH <bm replicate update ALIAS>` with the path to the bucket or bucket prefix on which the rule exists.

- Replace :mc-cmd:`ID <bm replicate update --remote-bucket>` with the updated credentials, path, and bucket.


Disable or Enable an Existing Replication Rule
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm replicate update` with the :mc-cmd:`~bm replicate update --state` flag to disable or enable a replication rule.

.. code-block:: shell
   :class: copyable

   bm replicate update ALIAS/PATH \
      --id ID \
      --state "disable"|"enable"

- Replace :mc-cmd:`ALIAS <bm replicate update ALIAS>` with the :mc:`alias <bm alias>` of the Buckit deployment.

- Replace :mc-cmd:`PATH <bm replicate update ALIAS>` with the path to the bucket or bucket prefix on which the rule exists.

- Replace :mc-cmd:`ID <bm replicate update --id>` with the unique identifier for the rule to modify. 
  Use :mc:`bm replicate ls` to retrieve the list of replication rules on the bucket and their corresponding identifiers.

- Specify either ``"disable"`` or ``"enable"`` to the :mc-cmd:`~bm replicate update --state` flag to disable or enable the replication rule.

.. note::

   Buckit requires enabling :ref:`existing object replication <minio-replication-behavior-existing-objects>` to synchronize objects written or removed after disabling a replication rule. 

   For rules *without* existing object replication, Buckit synchronizes only those write or delete operations issued while the replication rule is *enabled*.

Behavior
--------

Required Permissions
~~~~~~~~~~~~~~~~~~~~

Buckit strongly recommends creating users specifically for supporting bucket replication operations.
See :doc:`the user administration reference </reference/bm-admin/bm-admin-user>` and
:doc:`the policy administration reference </reference/bm-admin/bm-admin-policy>` for more complete
documentation on adding users and policies to a Buckit deployment.

.. tab-set::

   .. tab-item:: Replication Admin

      The following policy provides permissions for configuring and enabling
      replication on a deployment. 

      .. literalinclude:: /extra/examples/ReplicationAdminPolicy.json
         :class: copyable
         :language: json

      - The ``"EnableRemoteBucketConfiguration"`` statement grants permission
        for creating a remote target for supporting replication.

      - The ``"EnableReplicationRuleConfiguration"`` statement grants permission
        for creating replication rules on a bucket. The ``"arn:aws:s3:::*``
        resource applies the replication permissions to *any* bucket on the
        source deployment. You can restrict the user policy to specific buckets
        as-needed.

      Use :doc:`bm admin policy create </reference/bm-admin/bm-admin-policy-create>`
      to add this policy to each deployment acting as a replication source.
      Use :doc:`bm admin user add </reference/bm-admin/bm-admin-user-add>` to create a user
      on the deployment and :doc:`bm admin policy attach </reference/bm-admin/bm-admin-policy-attach>`
      to associate the policy to that new user.

   .. tab-item:: Replication Remote User

      The following policy provides permissions for enabling synchronization of
      replicated data *into* the deployment. 

      .. literalinclude:: /extra/examples/ReplicationRemoteUserPolicy.json
         :class: copyable
         :language: json

      - The ``"EnableReplicationOnBucket"`` statement grants permission for 
        a remote target to retrieve bucket-level configuration for supporting
        replication operations on *all* buckets in the Buckit deployment. To
        restrict the policy to specific buckets, specify those buckets as an
        element in the ``Resource`` array similar to
        ``"arn:aws:s3:::bucketName"``.

      - The ``"EnableReplicatingDataIntoBucket"`` statement grants permission
        for a remote target to synchronize data into *any* bucket in the Buckit
        deployment. To restrict the policy to specific buckets, specify those 
        buckets as an element in the ``Resource`` array similar to 
        ``"arn:aws:s3:::bucketName/*"``.

      Use :doc:`bm admin policy create </reference/bm-admin/bm-admin-policy-create>`
      to add this policy to each deployment acting as a replication target.
      Use :doc:`bm admin user add </reference/bm-admin/bm-admin-user-add>` to create a user
      on the deployment and :doc:`bm admin policy attach </reference/bm-admin/bm-admin-policy-attach>`
      to associate the policy to that new user.

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
