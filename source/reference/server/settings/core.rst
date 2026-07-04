.. _minio-server-envvar-core:

=============
Core Settings
=============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

This page covers settings that control core behavior of the Buckit process.

.. include:: /includes/common-mc-admin-config.rst
   :start-after: start-minio-settings-defined
   :end-before: end-minio-settings-defined

.. include:: /includes/common-mc-admin-config.rst
   :start-after: start-minio-settings-test-before-prod
   :end-before: end-minio-settings-test-before-prod

Buckit Server CLI Options
-------------------------

.. tab-set::

   .. tab-item:: Environment Variable
      :sync: envvar

      .. envvar:: MINIO_OPTS

   .. tab-item:: Configuration Setting
      :sync: config

      There is no configuration setting for this variable, as these settings apply at server startup.

*Optional*

Set a string of :ref:`parameters <minio-server-parameters>` to use when starting the Buckit Server.

For Unix-like systems using the recommended Buckit systemd service, use the ``/etc/default/minio`` file and create an environment variable ``MINIO_OPTS`` for specifying parameters to append to the ``minio`` systemd process:

.. code-block:: shell
   :class: copyable
   
   # Editing /etc/default/minio

   MINIO_OPTS=' --console-address=":9001" --ftp="address=:8021" --ftp="passive-port-range=30000-40000" '

For systems running ``minio`` on the command line, ``MINIO_OPTS`` is optional.
To use it, declare the environment variable using standard shell semantics, then reference the environment variable when starting up the Buckit Server:

.. code-block:: shell
   :class: copyable

   export MINIO_OPTS=' --console-address=":9001" --ftp="address=:8021" --ftp="passive-port-range=30000-40000" '

   buckit server $MINIO_OPTS ...

   # The above is equivalent to running the following:
   # minio server --console-address=":9001" \
   #              --ftp="address=:8021"     \
   #              --ftp="passive-port-range=30000-40000"

.. important::

   The ``minio server`` command does not read ``$MINIO_OPTS`` directly.
   The variable only functions if used as described above.

Storage Volumes
---------------

.. tab-set::

   .. tab-item:: Environment Variable

      .. envvar:: MINIO_VOLUMES

         The directories or drives the :mc:`buckit server <buckit server>` process uses as the storage backend.

         Functionally equivalent to setting :mc-cmd:`buckit server DIRECTORIES <buckit server DIRECTORIES>`.
         Use this value when configuring Buckit to run using an environment file.

   .. tab-item:: Configuration Setting

      .. include:: /includes/common-mc-admin-config.rst
         :start-after: start-minio-settings-no-config-option
         :end-before: end-minio-settings-no-config-option

Environment Variable File Path
------------------------------

.. tab-set::

   .. tab-item:: Environment Variable

      .. envvar:: MINIO_CONFIG_ENV_FILE

         Specifies the full path to the file the :mc:`buckit server <buckit server>` process uses for loading environment variables.

         For systemd-managed files, set this value to the path of the environment file (``/etc/default/minio``) to direct Buckit to reload changes to that file when using :mc-cmd:`bm admin service restart` to restart the deployment.

   .. tab-item:: Configuration Setting

      .. include:: /includes/common-mc-admin-config.rst
         :start-after: start-minio-settings-no-config-option
         :end-before: end-minio-settings-no-config-option

Workers for Expiration
----------------------

.. tab-set::

   .. tab-item:: Environment Variable
      :sync: envvar

      .. envvar:: MINIO_ILM_EXPIRY_WORKERS

         Specifies the number of workers to make available to expire objects configured with ILM rules for expiration.
         When not set, Buckit defaults to using up to half of the available processing cores available.

   .. tab-item:: Configuration Setting
      :sync: config

      .. include:: /includes/common-mc-admin-config.rst
         :start-after: start-minio-settings-no-config-option
         :end-before: end-minio-settings-no-config-option

Domain
------

.. tab-set::

   .. tab-item:: Environment Variable

      .. envvar:: MINIO_DOMAIN

         Enables Virtual Host-style requests to the Buckit deployment.
         Set the value to the Fully Qualified Domain Name (FQDN) for Buckit to accept incoming virtual host requests.

         Omitting this setting directs Buckit to only accept the default path-style requests.

         For example, consider a Buckit deployment with an assigned FQDN of ``buckit.example.net``.

         - With path-style lookups, applications can access the bucket using its full path as ``buckit.example.net/mybucket``.
         - With virtual-host lookups, application can access the bucket as a virtual host as ``mybucket.buckit.example.net/``.

         .. important::

            If you configure ``MINIO_DOMAIN``, you **must** consider all subdomains of the specified FQDN as exclusively assigned for use as bucket names.
            Any Buckit services which conflict with those domains, such as replication targets, may exhibit unexpected or undesired behavior as a result of the collision.

            For example, if setting ``MINIO_DOMAIN=buckit.example.net``, you **cannot** assign any subdomains of ``buckit.example.net`` (in the form of ``*.buckit.example.net``) to any Buckit service or target.
            This includes hostnames for use with :ref:`bucket <minio-bucket-replication>`, :ref:`batch <minio-batch-framework-replicate-job>`, or :ref:`site replication <minio-site-replication-overview>`.

   .. tab-item:: Configuration Setting

      .. include:: /includes/common-mc-admin-config.rst
         :start-after: start-minio-settings-no-config-option
         :end-before: end-minio-settings-no-config-option

.. _minio-scanner-speed-options:

Scanner Speed
-------------

.. tab-set::

   .. tab-item:: Environment Variable
      :sync: envvar

      .. envvar:: MINIO_SCANNER_SPEED

   .. tab-item:: Configuration Setting
      :sync: config

      .. mc-conf:: scanner speed
         :delimiter: " "

Manage the maximum wait period for the :ref:`scanner <minio-concepts-scanner>` when balancing Buckit read/write performance to scanner processes.

.. include:: /includes/common/scanner.rst
   :start-after: start-scanner-speed-values
   :end-before: end-scanner-speed-values

Batch Replication
-----------------

.. tab-set::

   .. tab-item:: Configuration Setting

      .. include:: /includes/common-mc-admin-config.rst
         :start-after: start-minio-settings-no-config-option
         :end-before: end-minio-settings-no-config-option


Data Compression
----------------

The following section documents settings for enabling data compression for objects.
See :ref:`minio-data-compression` for tutorials on using these configuration settings.

All of the settings in this section fall under the following top-level key:

.. mc-conf:: compression

Enable Compression
~~~~~~~~~~~~~~~~~~

.. tab-set::

   .. tab-item:: Environment Variable
      :sync: envvar

      .. envvar:: MINIO_COMPRESSION_ENABLE

   .. tab-item:: Configuration Setting
      :sync: config

      .. mc-conf:: compression enable
         :delimiter: " "

*Optional*

Set to ``on`` to enable data compression for new objects.
Defaults to ``off``.

Enabling or disabling data compression does not change existing objects.

Allow Encryption
~~~~~~~~~~~~~~~~

.. tab-set::

   .. tab-item:: Environment Variable
      :sync: envvar

      .. envvar:: MINIO_COMPRESSION_ALLOW_ENCRYPTION

   .. tab-item:: Configuration Setting
      :sync: config

      .. mc-conf:: compression allow_encryption
         :delimiter: " "

*Optional*

Set to ``on`` to encrypt objects after compressing them.
Defaults to ``off``.

.. admonition:: Encrypting compressed objects may compromise security
   :class: warning

   Buckit strongly recommends against encrypting compressed objects.
   If you require encryption, carefully evaluate the risk of potentially leaking information about the contents of encrypted objects.

Compression Extensions
~~~~~~~~~~~~~~~~~~~~~~

.. tab-set::

   .. tab-item:: Environment Variable
      :sync: envvar

      .. envvar:: MINIO_COMPRESSION_EXTENSIONS

   .. tab-item:: Configuration Setting
      :sync: config

      .. mc-conf:: compression extensions
         :delimiter: " "

*Optional*

Comma-separated list of the file extensions to compress.
Setting a new list of file extensions replaces the previously configured list.
Defaults to ``".txt, .log, .csv, .json, .tar, .xml, .bin"``.


Buckit does not support compressing file types on the :ref:`Excluded File Types <minio-data-compression-excluded-types>` list, even if explicitly specified in this argument.

Compression MIME Types
~~~~~~~~~~~~~~~~~~~~~~

.. tab-set::

   .. tab-item:: Environment Variable
      :sync: envvar

      .. envvar:: MINIO_COMPRESSION_MIME_TYPES

   .. tab-item:: Configuration Variable
      :sync: config

      .. mc-conf:: compression mime_types
         :delimiter: " "

*Optional*

Comma-separated list of the MIME types to compress.
Setting	a new list of types replaces the previously configured list.
Defaults to ``"text/*, application/json, application/xml, binary/octet-stream"``.

.. admonition:: Default excluded files
   :class: note

   Some	types of files cannot be significantly reduced in size.
   Buckit will *not* compress these, even if specified in an :mc-conf:`~compression.mime_types` argument.
   See :ref:`Excluded types <minio-data-compression-excluded-types>` for details.

Comments
~~~~~~~~

.. tab-set::

   .. tab-item:: Environment Variable

      This setting does not have an environment variable option.
      Use the configuration setting instead.

   .. tab-item:: Configuration Setting
      :selected:

      .. envvar:: compression comment

*Optional*

Specify a comment to associate with the data compression configuration.

Erasure Stripe Size
-------------------

.. tab-set::

   .. tab-item:: Environment Variable
      :sync: envvar

      .. envvar:: MINIO_ERASURE_SET_DRIVE_COUNT

   .. tab-item:: Configuration Variable
      :sync: config

      .. include:: /includes/common-mc-admin-config.rst
         :start-after: start-minio-settings-no-config-option
         :end-before: end-minio-settings-no-config-option

*Optional*

The :ref:`erasure set size <minio-ec-basics>` to apply for all drives in a given :term:`server pool`.

If you set this value, you **must** do so *before* you initialize the cluster
The selected stripe size is **immutable** after the cluster has been initialized and affects any future server pools added to the cluster.

Review stripe size settings carefully before implementing them in any environment.

.. warning::

   **Do not** change the stripe size setting unless directed to by Buckit engineering.

   Changes to stripe size have significant impact to deployment functionality, availability, performance, and behavior.
   Buckit's stripe selection algorithms set appropriate defaults for the majority of workloads.
   Changing the stripe size from this default is unusual and generally not necessary or advised.

Maximum Object Versions
-----------------------

.. tab-set::

   .. tab-item:: Environment Variable
      :sync: envvar

      .. envvar:: MINIO_API_OBJECT_MAX_VERSIONS

   .. tab-item:: Configuration Setting
      :sync: config

      .. mc-conf:: api object_max_versions
         :delimiter: " "

*Optional*

Defines the default maximum versions to allow per object.

By default, Buckit allows up to the maximum value of an Int64 versions per object, or over 9.2 quintillion.

.. note::

   Buckit versions from ``RELEASE.2023-08-04T17-40-21Z``to ``RELEASE.2024-03-26T22-10-45Z`` had a default limit of 10,000 object versions.
   This setting can be used to override that limit to another value.

Arbitrarily high versions per objects may cause performance degradation on some operations, such as ``LIST``.
This is especially true on systems running budget hardware or spinning drives (HDD).
Applications or workloads which produce thousands or more versions per object may require design or architecture review to mitigate potential performance degradations.

Setting a limit of no more than ``100`` should provide enough versions for most typical use cases.
