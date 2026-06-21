.. _minio-mc-alias-set:
.. _minio-mc-alias:
.. _alias:

================
``bm alias set``
================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm alias set

.. |command| replace:: :mc:`bm alias set`

Syntax
------

.. start-mc-alias-set-desc

The :mc:`bm alias set` command adds or updates an alias to the local
:program:`bm` configuration.

.. end-mc-alias-set-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command adds an :ref:`alias <alias>` for a Buckit
      deployment ``myminio`` running at the URL
      ``https://myminio.example.net``. :program:`bm` uses the specified 
      username and password for authenticating to the Buckit deployment:

      .. code-block:: shell
         :class: copyable
         
         bm alias set myminio https://myminio.example.net minioadminuser minioadminpassword

      If the ``myminio`` alias already exists, the command overwrites that
      alias with the new URL, access key, and secret key.

   .. tab-item:: SYNTAX

      The :mc:`bm alias set` command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] alias set \ 
                          [--api "string"]                           \
                          [--path "string"]                          \
                          ALIAS                                      \ 
                          URL                                        \
                          ACCESSKEY                                  \
                          SECRETKEY

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS

   *Required* The name to associate to the S3-compatible service.
   Aliases are case-sensitive and must meet the following requirements:

   - Contain only `ASCII <https://en.wikipedia.org/wiki/ASCII>`__ lower case letters (``a-z``), upper case letters (``A-Z``), numbers (``[0-9]``), hyphen (``-``), or underscore (``_``).
   - 2 or more characters in length.
   - The first character must be a letter.

   .. versionchanged:: RELEASE.2024-01-11T05-49-32Z

      An alias may also be a single letter (``a-z`` or ``A-Z``).

   Examples of some valid alias values include:

   - ``myminio``
   - ``Test-1``
   - ``A``
   - ``a``

.. mc-cmd:: URL

   *Required* The URL to the S3-compatible service endpoint. For example:

   ``https://minio.example.net``

.. mc-cmd:: ACCESSKEY
   
   *Required*

   The access key for authenticating to the S3 service.

.. mc-cmd:: SECRETKEY

   *Required*

   The secret key for authenticating to the S3 service.

.. mc-cmd:: --api
   
   
   *Optional*

   Specifies the signature calculation method to use when connecting to the
   S3-compatible service. Supports the following values:

   - ``S3v4`` (Default)
   - ``S3v2``

   .. note::

      AWS Signature V2 is considered
      `deprecated <https://aws.amazon.com/blogs/aws/amazon-s3-update-sigv2-deprecation-period-extended-modified/>`__
      by AWS. :mc:`bm alias set` includes this option only for S3 buckets
      or services still reliant on the Signature V2.
      
      Use ``S3v4`` unless explicitly required by the S3-compatible service.
      Buckit server does not rely on nor require ``S3v2``, nor are all API
      operations available on ``S3v2``. 

.. mc-cmd:: --path
   

   *Optional*

   Specifies the bucket path lookup setting used by the server. Supports the
   following values:

   - ``"auto"`` (Default)
   - ``"on"``
   - ``"off"``

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Add or Update an Alias for a Buckit Deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm alias set` to add an S3-compatible service for use with
:program:`bm`:

.. tab-set::

   .. tab-item:: Example

      The following command creates a new alias ``myminio`` pointing at a
      Buckit deployment at ``https://minio.example.net``. The
      alias uses the ``miniouser`` and ``miniopassword`` credentials for
      performing operations against the deployment.

      .. code-block:: shell
         :class: copyable

         bm alias set myminio https://minio.example.net miniouser miniopassword

      If the ``myminio`` alias already exists, the 
      :mc:`bm alias set` command overwrites that alias with the specified
      arguments.

   .. tab-item:: Syntax

      .. code-block:: shell
         :class: copyable

         bm alias set ALIAS HOSTNAME ACCESSKEY SECRETKEY

      - Replace ``ALIAS`` with the the name to associate to the 
        Buckit service.

      - Replace ``HOSTNAME`` with the URL for any node in the Buckit
        deployment. You can alternatively specify the URL for a load balancer
        or reverse proxy managing connections to the Buckit deployment.

      - Replace ``ACCESSKEY`` and ``SECRETKEY`` with credentials for a user
        on the Buckit deployment.

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility

Required Credentials and Access Control
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:mc:`bm alias set` requires specifying an access key and corresponding
secret key for the S3-compatible host. :program:`bm` functionality is limited
based on the policies associated to the specified credentials. For example, if
the specified credentials do not have read/write access to a specific bucket,
:program:`bm` cannot perform read or write operations on that bucket.

For more information on Buckit Access Control, see
:ref:`minio-access-management`. 

For more complete documentation on S3 Access Control, see
:s3-docs:`Amazon S3 Security <security.html>`.

For all other S3-compatible services, defer to the documentation for that
service.

Certificates
~~~~~~~~~~~~

The Buckit Manager CLI fetches the peer certificate, computes the public key fingerprint, and asks the user whether to accept the deployment's certificate.

If trusted, the Buckit Manager CLI automatically adds the certificate authority to:

-  ``~/.config/bm/certs/CAs/`` on Linux and other Unix-like systems.
-  ``%APPDATA%\bm\certs\CAs\`` on Windows systems.
