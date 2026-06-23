.. _minio-mc-admin-cluster-iam-import:

===============================
``bm admin cluster iam import``
===============================

.. default-domain:: minio

.. mc:: bm admin cluster iam import

Description
-----------

.. start-mc-admin-cluster-iam-import-desc

The :mc:`bm admin cluster iam import` command imports :ref:`IAM <minio-authentication-and-identity-management>` metadata as created by the :mc:`bm admin cluster iam export` command.

.. end-mc-admin-cluster-iam-import-desc

You can use this command to manually restore IAM metadata settings for a Buckit deployment.


.. tab-set::

   .. tab-item:: EXAMPLE

      The following command imports the IAM metadata of the specified file onto the ``mybuckit`` deployment.
  
      .. code-block:: shell  
         :class: copyable 
  
         bm admin cluster iam import mybuckit ~/minio-metadata-backup/mybuckit-cluster.zip

   .. tab-item:: SYNTAX

      The command has the following syntax: 
  
      .. code-block:: shell  
         :class: copyable 
  
         bm [GLOBALFLAGS] admin cluster iam import  \
                                            ALIAS \
                                            IAM-METADATA.ZIP  
                                             
      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

:mc:`bm admin cluster iam import` adds support for aliases ending with a trailing forward slash ``ALIAS/``.
Prior to this release, the command would fail when provided a trailing forward slash.

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :mc-cmd:`alias <bm alias>` of the Buckit deployment.

.. mc-cmd:: IAM-METADATA.ZIP
   :required:

   The path to the IAM metadata file to import.
   
   Use the :mc:`bm admin cluster iam export` to export IAM metadata for use with this command.

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals
