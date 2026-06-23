.. _minio-mc-policy-set:
.. _minio-mc-anonymous-set:

====================
``bm anonymous set``
====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm anonymous set

Syntax
------

.. start-mc-anonymous-set-desc

The :mc:`bm anonymous set` command sets anonymous (i.e. unauthenticated or public)
access :ref:`policies <minio-policy>` for a bucket. 

.. end-mc-anonymous-set-desc

Buckets with anonymous policies allow clients to access the bucket contents
and perform actions consistent with the specified policy without 
:ref:`authentication <minio-authentication-and-identity-management>`.

To set anonymous bucket policies using an IAM 
:s3-docs:`JSON policy <using-iam-policies>`, use the
:mc-cmd:`bm anonymous set-json` command.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command sets anonymous access policies for several
      buckets on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm anonymous set upload mybuckit/uploads
         bm anonymous set download mybuckit/downloads
         bm anonymous set public mybuckit/public

      Applications can perform the following operations without authentication:

      - ``PUT`` objects to ``mybuckit/uploads`` and ``mybuckit/public``.
      - ``GET`` objects from ``mybuckit/downloads`` and ``mybuckit/public``.

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] policy set PERMISSION ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: PERMISSION
      
   *Required* Name of the policy to assign to the specified ``ALIAS``.
   Specify one of the following values:

   - ``none`` - Disable anonymous access to the ``ALIAS``.
   - ``download`` - Enable download-only access to the ``ALIAS``.
   - ``upload`` - Enable upload-only access to the ``ALIAS``.
   - ``public`` - Enable download and upload access to the ``ALIAS``.

.. mc-cmd:: ALIAS

   *Required* The full path to the bucket or bucket prefix to which the
   command applies the specified :mc-cmd:`~bm anonymous set PERMISSION`. 
   
   Specify the :ref:`alias <alias>` of the Buckit or other
   S3-compatible service *and* the full path to the bucket or bucket
   prefix. For example:

   .. code-block:: shell

      bm anonymous set public play/mybucket

   Specify a bucket prefix to set the policy on only that prefix. For example,
   this command sets distinct anonymous bucket policies on the 
   ``mybucket/downloads`` and ``mybucket/uploads`` prefixes:

   .. code-block:: shell

      bm anonymous set download play/mybucket/downloads
      bm anonymous set upload play/mybucket/uploads

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Set Anonymous Policy for Bucket
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm anonymous set` to set the anonymous policy for a 
bucket:

.. code-block:: shell
   :class: copyable

   bm anonymous set POLICY ALIAS/PATH

- Replace :mc-cmd:`POLICY <bm anonymous set PERMISSION>` with a supported
  :mc-cmd:`permission <bm anonymous set PERMISSION>`.

- Replace :mc-cmd:`ALIAS <bm anonymous set ALIAS>` with the 
  :mc-cmd:`alias <bm alias>` of a configured S3-compatible host.

- Replace :mc-cmd:`PATH <bm anonymous set ALIAS>` with the destination bucket.

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
