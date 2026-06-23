.. _minio-mc-admin-accesskey-enable:

=============================
``bm admin accesskey enable``
=============================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin accesskey enable


Syntax
------

.. start-mc-admin-accesskey-enable-desc

The :mc-cmd:`bm admin accesskey enable` command enables an existing access key.

.. end-mc-admin-accesskey-enable-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command enables the specified access key:
  
      .. code-block:: shell  
         :class: copyable 
  
         bm admin accesskey enable mybuckit myuserserviceaccount  

   .. tab-item:: SYNTAX

      The command has the following syntax: 
  
      .. code-block:: shell  
         :class: copyable 
  
         bm [GLOBALFLAGS] admin accesskey enable          \  
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

   The access key to enable.


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
