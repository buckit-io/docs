.. _minio-mc-policy-get-json:

=========================
``bm anonymous get-json``
=========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm anonymous get-json

Syntax
------

.. start-mc-anonymous-get-json-desc

The :mc:`bm anonymous get-json` command gets anonymous (i.e. unauthenticated or
public) access :ref:`policies <minio-policy>` for a bucket. 

.. end-mc-anonymous-get-json-desc

Buckets with anonymous policies allow clients to access the bucket contents
and perform actions consistent with the specified policy without 
:ref:`authentication <minio-authentication-and-identity-management>`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command retrieves the JSON-formatted anonymous 
      policy for the ``mydata`` bucket on the ``myminio`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm anonymous get-json myminio/mydata

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] get-json ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS

   *Required* The full path to the bucket or bucket prefix for which to get the
   anonymous bucket policy.
   
   Specify the :ref:`alias <alias>` of the Buckit or other
   S3-compatible service *and* the full path to the bucket or bucket
   prefix. For example:

   .. code-block:: shell
            
      bm anonymous get-json public play/mybucket

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Get Anonymous Policy for Bucket
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm anonymous get-json` to get the anonymous policy for a 
bucket:

.. code-block:: shell
   :class: copyable

   bm anonymous get-json ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm anonymous get-json ALIAS>` with the 
  :mc-cmd:`alias <bm alias>` of a configured S3-compatible host.

- Replace :mc-cmd:`PATH <bm anonymous get-json ALIAS>` with the destination bucket.

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
