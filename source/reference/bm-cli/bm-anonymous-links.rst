.. _minio-mc-policy-links:

======================
``bm anonymous links``
======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm anonymous links

Syntax
------

.. start-mc-anonymous-links-desc

The :mc:`bm anonymous links` retrieves the HTTP URL for anonymous (i.e.
unauthenticated or public) access to a bucket. 

.. end-mc-anonymous-links-desc

Buckets with anonymous policies allow clients to access the bucket contents
and perform actions consistent with the specified policy without 
:ref:`authentication <minio-authentication-and-identity-management>`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command retrieves HTTP URLs for the ``mydata`` bucket
      on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm anonymous links --recursive mybuckit/mydata

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] policy links   \
                          [--recursive]  \
                          ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS

   *Required* The full path to the bucket or bucket prefix for which the
   command retrieves the anonymous bucket policies.
   
   Specify the :ref:`alias <alias>` of the Buckit or other
   S3-compatible service *and* the full path to the bucket or bucket
   prefix. For example:

   .. code-block:: shell
            
      bm anonymous links public [FLAGS] play/mybucket

.. mc-cmd:: --recursive
   

   *Optional* Retrieve the HTTP links recursively.

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

List Anonymous Policies for Bucket
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm anonymous links` to links the anonymous policies for a 
bucket:

.. code-block:: shell
   :class: copyable

   bm anonymous links ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm anonymous get ALIAS>` with the 
  :mc-cmd:`alias <bm alias>` of a configured S3-compatible host.

- Replace :mc-cmd:`PATH <bm anonymous get ALIAS>` with the destination bucket.

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
