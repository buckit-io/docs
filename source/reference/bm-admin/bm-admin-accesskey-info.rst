.. _minio-mc-admin-accesskey-info:

===========================
``bm admin accesskey info``
===========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin accesskey info


Syntax
------

.. start-mc-admin-accesskey-info-desc

The :mc-cmd:`bm admin accesskey info` command returns a description of the specified :ref:`access key(s) <minio-id-access-keys>`.

.. end-mc-admin-accesskey-info-desc

The description output includes the following details, as available:

- Access Key
- Parent user of the specified access key
- Access key status (``on`` or ``off``)
- Policy or policies
- Comment
- Expiration

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command returns information on the specified access key:
  
      .. code-block:: shell  
         :class: copyable 
  
         bm admin accesskey info mybuckit myuseraccesskey 

   .. tab-item:: SYNTAX

      The command has the following syntax: 
  
      .. code-block:: shell  
         :class: copyable 
  
         bm [GLOBALFLAGS] admin accesskey info      \  
                                          ALIAS     \  
                                          ACCESSKEY

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :mc-cmd:`alias <bm alias>` of the Buckit deployment.

.. mc-cmd:: ACCESSKEY
   :required:

   The access key to display.

   Return information for multiple access keys by separating each access key with a space.

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Display access key details
~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm admin accesskey info` to display details of an access key on a Buckit deployment:

.. code-block:: shell
   :class: copyable

      bm admin accesskey info mybuckit myaccesskey

- Replace ``mybuckit`` with the :mc-cmd:`alias <bm alias>` of the Buckit deployment.

- Replace :mc-cmd:`myaccesskey <bm admin user svcacct info ACCESSKEY>` with the access key for which to display information.
  List multiple keys by separating each with a space.

The output resembles the following:

.. code-block:: shell

   AccessKey: myuserserviceaccount
   ParentUser: myuser
   Status: on
   Comment: 
   Policy: implied
   Expiration: no-expiry

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
