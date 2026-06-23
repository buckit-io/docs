.. _minio-mc-admin-sts-info:

==============================
``bm admin user sts info``
==============================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin user sts info


Syntax
------

.. start-mc-admin-sts-info-desc

The :mc-cmd:`bm admin user sts info` command retrieves information on the specified STS credential, such as the parent :ref:`Buckit user <minio-internal-idp>` who generated the credentials, associated policies, and expiration.

.. end-mc-admin-sts-info-desc

:abbr:`STS (Security Token Service)` credentials provide temporary access to the Buckit deployment.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command retrieves information on the STS credentials with specified access key:

      .. code-block:: shell  
         :class: copyable 
  
         bm admin user sts info mybuckit/ "J123C4ZXEQN8RK6ND35I"

   .. tab-item:: SYNTAX

      The command has the following syntax: 
  
      .. code-block:: shell  
         :class: copyable 

         bm [GLOBALFLAGS] admin user sts info          \
                                         [--policy]    \
                                         ALIAS         \
                                         STSACCESSKEY

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :mc-cmd:`alias <bm alias>` of the Buckit deployment.

.. mc-cmd:: STSACCESSKEY
   :required:

   The access key for the STS credentials.

.. mc-cmd:: --policy
   :optional:

   Prints the policy attached to the specified STS credentials in JSON format.


Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals


Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
