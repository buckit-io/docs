.. _minio-mc-policy-set-json:

=========================
``bm anonymous set-json``
=========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm anonymous set-json

Syntax
------

.. start-mc-anonymous-set-json-desc

The :mc:`bm anonymous set-json` command sets anonymous (i.e. unauthenticated or
public) access :ref:`policies <minio-policy>` for a bucket using using an IAM
:s3-docs:`JSON policy document <using-iam-policies>`. 

.. end-mc-anonymous-set-json-desc

Buckets with anonymous policies allow clients to access the bucket contents
and perform actions consistent with the specified policy without 
:ref:`authentication <minio-authentication-and-identity-management>`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command applies the JSON-formatted anonymous policy
      to the ``mydata`` bucket on the ``myminio`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm anonymous set-json ~/mydata-anonymous.json myminio/mydata

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] set-json POLICY ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: POLICY
      
   *Required* The path to the JSON-formatted policy to assign to the specified
   ``ALIAS``. 

.. mc-cmd:: ALIAS

   *Required* The full path to the bucket or bucket prefix to which the
   command applies the specified :mc-cmd:`~bm anonymous set-json POLICY`. 
   
   Specify the :ref:`alias <alias>` of the Buckit or other
   S3-compatible service *and* the full path to the bucket or bucket
   prefix. For example:

   .. code-block:: shell
            
      bm anonymous set-json public play/mybucket

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Set Anonymous Policy for Bucket
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm anonymous set-json` to set the anonymous policy for a 
bucket:

.. code-block:: shell
   :class: copyable

   bm anonymous set-json POLICY ALIAS/PATH

- Replace :mc-cmd:`POLICY <bm anonymous set-json POLICY>` with a supported
  :mc-cmd:`POLICY <bm anonymous set-json POLICY>`.

- Replace :mc-cmd:`ALIAS <bm anonymous set-json ALIAS>` with the 
  :mc-cmd:`alias <bm alias>` of a configured S3-compatible host.

- Replace :mc-cmd:`PATH <bm anonymous set-json ALIAS>` with the destination bucket.

Remove Anonymous Policy for Bucket
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm anonymous set` to clear the anonymous policy for a 
bucket:

.. code-block:: shell
   :class: copyable

   bm anonymous set none ALIAS/PATH

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
