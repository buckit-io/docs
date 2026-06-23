.. _minio-mc-admin-svcacct-edit:

==============================
``bm admin user svcacct edit``
==============================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin user svcacct edit

.. important::

   This command has been replaced and will be deprecated in a future Buckit Manager CLI release.

   As of Buckit Manager CLI RELEASE.2024-10-08T09-37-26Z, use the :mc:`bm admin accesskey edit` command to modify access keys for built-in Buckit IDP users.

   To modify access keys for AD/LDAP users, use the :mc:`bm idp ldap accesskey edit` command.

Syntax
------

.. start-mc-admin-svcacct-edit-desc

The :mc-cmd:`bm admin user svcacct edit` command modifies the configuration of an access key associated to the specified user.

.. end-mc-admin-svcacct-edit-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command applies a new policy and secret key to the ``myuserserviceaccount`` access key on the ``mybuckit`` deployment:

      .. code-block:: shell  
         :class: copyable 

         bm admin user svcacct edit                                             \  
                               --secret-key "myuserserviceaccountnewsecretkey"  \     
                               --policy "/path/to/new/policy.json"              \  
                               mybuckit myuserserviceaccount

   .. tab-item:: SYNTAX

      The command has the following syntax: 
  
      .. code-block:: shell  
         :class: copyable 

         bm [GLOBALFLAGS] admin user svcacct edit            \  
                                             [--secret-key]  \  
                                             [--policy]      \  
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

   The service account to modify.

.. mc-cmd:: --description
   :optional:


.. mc-cmd:: --expiry
   :optional:


.. mc-cmd:: --name
   :optional:


.. mc-cmd:: --policy
   :optional:

   The path to a :ref:`policy document <minio-policy>` to attach to the new access key, with a maximum size of 2048 characters.
   The attached policy cannot grant access to any action or resource not explicitly allowed by the parent user's policies.

   The new policy overwrites any previously attached policy.

.. mc-cmd:: --secret-key
   :optional:

   The secret key to associate with the new access key.
   Overwrites the previous secret key.
   Applications using the access keys *must* update to use the new credentials to continue performing operations.


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
