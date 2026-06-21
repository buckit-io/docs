.. _minio-mc-ilm-rule-add:

===================
``bm ilm rule add``
===================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm ilm rule add

.. versionchanged:: RELEASE.2022-12-24T15-21-38Z

   ``bm ilm rule rm`` replaces ``bm ilm add``.


Syntax
------

.. start-mc-ilm-rule-add-desc

The :mc:`bm ilm rule add` command adds an object lifecycle management rule to a bucket.

.. end-mc-ilm-rule-add-desc

The command supports adding both :ref:`Transition (Tiering) <minio-lifecycle-management-tiering>` and :ref:`Expiration <minio-lifecycle-management-expiration>` lifecycle management rules.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command adds new lifecycle management rules to the ``mydata`` bucket on the ``myminio`` deployment:

      .. code-block:: shell
         :class: copyable

         bm ilm rule add --expire-days 90 --noncurrent-expire-days 30  myminio/mydata
         
         bm ilm rule add --expire-delete-marker myminio/mydata

         bm ilm rule add --transition-days 30 --transition-tier "COLDTIER" myminio/mydata
         
         bm ilm rule add --noncurrent-transition-days 7 --noncurrent-transition-tier "COLDTIER" 

      The configured rules have the following effect:

      - Delete objects more than 90 days old
      - Delete objects 30 days after they become non-current
      - Delete ``DeleteMarker`` tombstones if that object has no other versions remaining.
      - Transition objects more than 30 days old to the ``COLDTIER`` remote tier.
      - Transition objects 7 days after they become non-current to the ``COLDTIER`` remote tier.

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] ilm rule add                               \
                          [--prefix string]                          \
                          [--tags string]                            \
                          [--expire-days "integer"]                  \
                          [--expire-all-object-versions]             \
                          [--expire-delete-marker]                   \
                          [--transition-days "string"]               \
                          [--transition-tier "string"]               \
                          [--noncurrent-expire-days "integer"]       \
                          [--noncurrent-expire-newer "integer"]      \
                          [--noncurrent-transition-days "integer"]   \
                          [--noncurrent-transition-tier "string"]    \
                          [--site-gt "string"]                       \
                          [--size-lt "string"]                       \
                          ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:
   
   The :ref:`alias <alias>` and bucket on the Buckit deployment to which to add the object lifecycle management rule. 
   
   For example:

   .. code-block:: none

      bm ilm rule add myminio/mydata

.. mc-cmd:: --prefix
   :optional:
   
   Restrict the management rule to a specific object prefix.
   
   For example:

   .. code-block:: none

      bm ilm rule add --prefix "meetingnotes/" myminio/mydata --expire-days "90"

   The command creates a rule that expires objects in the ``mydata`` bucket of the ``myminio`` ALIAS after 90 days for any object with the ``meetingnotes/`` prefix.

.. mc-cmd:: --tags
   :optional:

   One or more ampersand ``&``-delimited key-value pairs describing the object tags to use for filtering objects to which the lifecycle configuration rule applies.

   This option is mutually exclusive with the following option:

   - :mc-cmd:`~bm ilm rule add --expire-delete-marker`

.. mc-cmd:: --expire-all-object-versions
   :optional:   

   .. versionadded:: mc RELEASE.2024-02-24T01-33-20Z

   Expire all current **and** noncurrent versions of an object.
   Use with the :mc-cmd:`~bm ilm rule add --expire-days` option to specify the number of days after which all versions of an object should be deleted by the scanner process.

   After the :ref:`scanner <minio-concepts-scanner>` processes this command, no versions of the object remain on the deployment.

   .. versionchanged:: Buckit RELEASE.2024-05-01T01-11-10Z

   This flag *only* applies to objects that do **not** have a delete marker as the latest version.

.. mc-cmd:: --expire-days
   :optional:   

   The number of days to retain an object after being created. 
   Buckit marks the object for deletion after the specified number of days pass. 
   Specify the number of days as an integer, for example ``30`` for 30 days.

   For versioned buckets, the expiry rule applies only to the *current* object version. 
   Use either the :mc-cmd:`~bm ilm rule add --noncurrent-expire-days` flag or the :mc-cmd:`~bm ilm rule add --expire-all-object-versions` flag to apply expiration behavior to noncurrent object versions.

   Buckit uses a :ref:`scanner process <minio-concepts-scanner>` to check objects against all configured lifecycle management rules. 
   Slow scanning due to high IO workloads or limited system resources may delay application of lifecycle management rules. 
   See :ref:`minio-lifecycle-management-scanner` for more information.

   Mutually exclusive with the following options:

   - :mc-cmd:`~bm ilm rule add --expire-delete-marker`

   For more complete documentation on object expiration, see :ref:`minio-lifecycle-management-expiration` and :ref:`minio-object-delete`.

.. mc-cmd:: --expire-delete-marker
   :optional:

   Specify this option to direct Buckit to remove delete markers for objects with no remaining object versions. 
   Specifically, the delete marker is the *only* remaining "version" of the given object.

   This option is mutually exclusive with the following option:
   
   - :mc-cmd:`~bm ilm rule add --tags`
   - :mc-cmd:`~bm ilm rule add --expire-days`

   Buckit uses a :ref:`scanner process <minio-concepts-scanner>` to check objects against all configured lifecycle management rules. 
   Slow scanning due to high IO workloads or limited system resources may delay application of lifecycle management rules. 
   See :ref:`minio-lifecycle-management-scanner` for more information.

   For more complete documentation on object expiration, see :ref:`minio-lifecycle-management-expiration` and :ref:`minio-object-delete`.

.. mc-cmd:: --transition-days
   :optional:
   
   The number of calendar days from object creation after which Buckit marks an object as eligible for transition. 
   Buckit transitions the object to the configured remote tier specified to the :mc-cmd:`~bm ilm rule add --transition-tier`. 
   Specify the number of days as an integer, e.g. ``30`` for 30 days.
   If the remote tier is another Buckit deployment, you can set the value to ``0`` to mark new objects as immediately eligible for transition to the remote tier.

   For versioned buckets, the transition rule applies only to the *current* object version. 
   Use the :mc-cmd:`~bm ilm rule add --noncurrent-transition-days` option to apply transition behavior to noncurrent object versions.

   Requires specifying :mc-cmd:`~bm ilm rule add --transition-tier`.

   Buckit uses a :ref:`scanner process <minio-concepts-scanner>` to check objects against all configured lifecycle management rules. 
   Slow scanning due to high IO workloads or limited system resources may delay application of lifecycle management rules. 
   See :ref:`minio-lifecycle-management-scanner` for more information.

   For more complete documentation on object transition, see :ref:`minio-lifecycle-management-tiering`.

.. mc-cmd:: --transition-tier
   :optional:

   The remote tier to which Buckit :ref:`transition objects <minio-lifecycle-management-tiering>`.
   Specify an existing remote tier created by :mc:`bm ilm tier add`. 

   Required if specifying :mc-cmd:`~bm ilm rule add --transition-days`.

.. mc-cmd:: --noncurrent-expire-days
   :optional:

   The number of days to retain an object version after becoming *non-current* (i.e. a different version of that object is now the `HEAD`).
   Buckit marks noncurrent object versions for deletion after the specified number of days pass.

   This option has the same behavior as the S3 ``NoncurrentVersionExpiration`` action.

   Buckit uses a :ref:`scanner process <minio-concepts-scanner>` to check objects against all configured lifecycle management rules. 
   Slow scanning due to high IO workloads or limited system resources may delay application of lifecycle management rules. 
   See :ref:`minio-lifecycle-management-scanner` for more information.

.. mc-cmd:: --noncurrent-transition-days
   :optional:

   The number of days an object has been non-current (i.e. replaced by a newer version of that same object) after which Buckit marks the object version as eligible for transition. 
   Buckit transitions the object to the configured remote tier specified to the :mc-cmd:`~bm ilm rule add --transition-tier` once the system host datetime passes that calendar date.

   This option has no effect on non-versioned buckets. 
   Requires specifying :mc-cmd:`~bm ilm rule add --noncurrent-transition-tier`.

   This option has the same behavior as the S3 ``NoncurrentVersionTransition`` action.

   Buckit uses a :ref:`scanner process <minio-concepts-scanner>` to check objects against all configured lifecycle management rules. 
   Slow scanning due to high IO workloads or limited system resources may delay application of lifecycle management rules. 
   See :ref:`minio-lifecycle-management-scanner` for more information.

.. mc-cmd:: --noncurrent-transition-tier
   :optional:

   The remote tier to which Buckit :ref:`transitions noncurrent objects versions <minio-lifecycle-management-tiering>`. 
   Specify a remote tier created by :mc:`bm ilm tier add`.

.. mc-cmd:: --noncurrent-expire-newer
   :optional:

   The maximum number of non-current object versions to retain, ordered from newest to oldest.
   
   Use this flag to retain a certain number of past versions of a file in a first in, first out fashion.
   After retaining the maximum number of non-current versions, Buckit marks any remaining older non-current object versions as eligible for expiration.
   
   The following table lists a number of object versions and their expiration eligibility based on ``--noncurrent-expire-newer 3``:

   .. list-table::
      :widths: 50 50
      :width: 100% 

      * - v5 (current version)
        - Current version not affected by ILM rules.
      * - v4
        - retained
      * - v3
        - retained
      * - v2
        - retained
      * - v1
        - marked for expiry

   Buckit retains the current version, v5.
   Buckit also retains the next ``3`` non-current versions, starting with the newest.
   This means Buckit marks ``v4``, ``v3``, and ``v2`` for the three non-current version to retain.

   ``v1`` would be a fourth non-current version, which falls outside the limit of non-current versions to retain, so Buckit marks ``v1`` for expiration.

   Updating the number for this flag only impacts the unmarked versions of objects.
   Any versions already marked for expiration do not change if you increase the number to retain.

   Buckit uses a :ref:`scanner process <minio-concepts-scanner>` to check objects against all configured lifecycle management rules. 
   Slow scanning due to high IO workloads or limited system resources may delay application of lifecycle management rules. 
   See :ref:`minio-lifecycle-management-scanner` for more information.
   
.. mc-cmd:: --size-gt
   :optional:

   .. versionadded:: mc RELEASE.2023-12-02T02-03-28Z 

   Select objects larger than the specified value.
   Enter the value as a number and a unit, such as ``5GiB`` for 5 gibibytes.

   Valid units include:

   .. list-table::
      :header-rows: 1
      :widths: 20 80
      :width: 100%
   
      * - Suffix
        - Unit Size
   
      * - ``k``
        - KB (Kilobyte, 1000 Bytes)
   
      * - ``m``
        - MB (Megabyte, 1000 Kilobytes)
   
      * - ``g``
        - GB (Gigabyte, 1000 Megabytes)
   
      * - ``t``
        - TB (Terrabyte, 1000 Gigabytes)
   
      * - ``ki``
        - KiB (Kibibyte, 1024 Bites)
   
      * - ``mi``
        - MiB (Mebibyte, 1024 Kibibytes)
   
      * - ``gi``
        - GiB (Gibibyte, 1024 Mebibytes)
   
      * - ``ti``
        - TiB (Tebibyte, 1024 Gibibytes)

.. mc-cmd:: --size-lt
   :optional:
  
   .. versionadded:: mc RELEASE.2023-12-02T02-03-28Z

   Select objects smaller than the specified value.
   Enter the value as a number and a unit, such as ``1M`` for 1 megabyte.

   Valid units include:

   .. list-table::
      :header-rows: 1
      :widths: 20 80
      :width: 100%
   
      * - Suffix
        - Unit Size
   
      * - ``k``
        - KB (Kilobyte, 1000 Bytes)
   
      * - ``m``
        - MB (Megabyte, 1000 Kilobytes)
   
      * - ``g``
        - GB (Gigabyte, 1000 Megabytes)
   
      * - ``t``
        - TB (Terrabyte, 1000 Gigabytes)
   
      * - ``ki``
        - KiB (Kibibyte, 1024 Bites)
   
      * - ``mi``
        - MiB (Mebibyte, 1024 Kibibytes)
   
      * - ``gi``
        - GiB (Gibibyte, 1024 Mebibytes)
   
      * - ``ti``
        - TiB (Tebibyte, 1024 Gibibytes)

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Expire All Bucket Contents After Number of Days
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm ilm rule add` with the :mc-cmd:`~bm ilm rule add --expire-all-object-versions` and :mc-cmd:`~bm ilm rule add --expire-days` flags to mark all current and non-current bucket contents for expiration after a number of days pass from the object's creation:

.. code-block:: shell
   :class: copyable

   bm ilm rule add ALIAS/PATH --expire-all-object-versions --expire-days "DAYS" 

- Replace :mc-cmd:`ALIAS <bm ilm rule add ALIAS>` with the :mc:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm ilm rule add ALIAS>` with the path to the bucket on the S3-compatible host.

- Replace :mc-cmd:`DAYS <bm ilm rule add --expire-days>` with the number of days after which to expire each object. 
  For example, specify ``30`` to expire objects 30 days after creation.

Transition Non-Current Object Versions at a Prefix to a Different Tier
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :mc:`bm ilm rule add` with :mc-cmd:`~bm ilm rule add --prefix` and :mc-cmd:`~bm ilm rule add --transition-tier` to transition older non-current versions of an object to a different storage tier.

.. code-block:: shell
   :class: copyable

   bm ilm rule add --prefix "doc/" --transition-days "90" --transition-tier "MINIOTIER-1"  \
          --noncurrent-transition-days "45" --noncurrent-transition-tier "MINIOTIER-2"    \
          myminio/mybucket

This command looks at the contents with the ``doc/`` prefix in the ``mybucket`` bucket on the ``myminio`` deployment.

- Current objects in the prefix older than 90 days move to the ``MINIOTIER-1`` storage tier.
- Non-current objects in the prefix older than 45 days move to the ``MINIOTIER-2`` storage tier.
- Both ``MINIOTIER-1`` and ``MINIOTIER-2`` have already been created with :mc:`bm ilm tier add`.

Expire All Objects at a Prefix, Retain Current Object Versions Longer Than Non-Current Object Versions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :mc:`bm ilm rule add` command with :mc-cmd:`~bm ilm rule add --prefix`, :mc-cmd:`~bm ilm rule add --expire-days`, and :mc-cmd:`~bm ilm rule add --noncurrent-expire-days` to expire current and non-current versions of an object at different times.

.. code-block:: shell
   :class: copyable

   bm ilm rule add --prefix "doc/" --expire-days "300" --noncurrent-expire-days "100" myminio/mybucket

This command looks at the contents with the ``doc/`` prefix in the ``mybucket`` bucket on the ``myminio`` deployment.

- Current objects expire after 300 days.
- Non-current objects expire after 100 days.

Transition noncurrent versions in the prefix ``/doc`` with a size greater the 1MiB
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :mc:`bm ilm rule add` command with :mc-cmd:`~bm ilm rule add --prefix`, :mc-cmd:`~bm ilm rule add --size-gt`, and :mc-cmd:`~bm ilm rule add --noncurrent-expire-days` to expire current and non-current versions of an object at different times.

.. code-block:: shell
   :class: copyable

   bm ilm rule add --prefix "doc/" --size-gt 1MiB --transition-days "90" --transition-tier "MINIOTIER-1" \
         --noncurrent-transition-days "45" --noncurrent-transition-tier "MINIOTIER-1" \
         myminio/mybucket/

This command looks at the contents with the ``doc/`` prefix in the ``mybucket`` bucket on the ``myminio`` deployment.

The command selects the following objects:

- Current objects older than 90 days larger than 1MiB.
- Non-current objects older than 45 days larger than 1MiB.
  
Selected objects transition to ``MINIOTIER-1``.

Remove Delete Markers
~~~~~~~~~~~~~~~~~~~~~

The following command removes delete markers for objects where the delete marker is the only version of the object that remains.

.. code-block:: shell
   :class: copyable

   bm ilm rule add ALIAS/PATH --expire-delete-marker 

- Replace :mc-cmd:`ALIAS <bm ilm rule add ALIAS>` with the :mc:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm ilm rule add ALIAS>` with the path to the bucket on the S3-compatible host.

.. note::

   To delete all versions of an object with a delete marker as its latest version, *including the delete marker*, consider using :ref:`batch expiration <minio-mc-batch-generate-expire-job>`.

Required Permissions
--------------------

For permissions required to add a rule, refer to the :ref:`required permissions <minio-mc-ilm-rule-permissions>` on the parent command.


Behavior
--------

Lifecycle Management Object Scanner
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit uses a :ref:`scanner process <minio-concepts-scanner>` to check objects against all configured
lifecycle management rules. Slow scanning due to high IO workloads or
limited system resources may delay application of lifecycle management
rules. See :ref:`minio-lifecycle-management-scanner` for more information.

Expiry vs Transition
~~~~~~~~~~~~~~~~~~~~

Buckit supports specifying both expiry and transition rules in the same
bucket or bucket prefix. Buckit can execute an expiration rule on an object
regardless of its transition status. Use
:mc:`bm ilm rule ls` to review the currently configured object lifecycle
management rules for any potential interactions between expiry and transition
rules.

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
