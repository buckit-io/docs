.. _minio-mc-admin-svcacct-enable:

================================
``bm admin user svcacct enable``
================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin user svcacct enable

.. important::

   This command has been replaced and will be deprecated in a future Buckit Manager CLI release.

   As of Buckit Manager CLI RELEASE.2024-10-08T09-37-26Z, use the :mc:`bm admin accesskey enable` command to enable an access key for a built-in Buckit IDP user.

   To enable access keys for AD/LDAP users, use the :mc:`bm idp ldap accesskey enable` command.


Syntax
------

.. start-mc-admin-svcacct-enable-desc

The :mc-cmd:`bm admin user svcacct enable` command enables an existing access key.

.. end-mc-admin-svcacct-enable-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command enables the specified access key:
  
      .. code-block:: shell  
         :class: copyable 
  
         bm admin user svcacct enable mybuckit myuserserviceaccount  

   .. tab-item:: SYNTAX

      The command has the following syntax: 
  
      .. code-block:: shell  
         :class: copyable 
  
         bm [GLOBALFLAGS] admin user svcacct enable          \  
                                             ALIAS           \  
                                             SERVICEACCOUNT 

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :mc-cmd:`alias <bm alias>` of the Buckit deployment.

.. mc-cmd:: SERVICEACCOUNT
   :required:

   The service account access key to enable.


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
