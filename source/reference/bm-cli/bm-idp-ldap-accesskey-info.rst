.. _minio-mc-idp-ldap-accesskey-info:

==============================
``bm idp ldap accesskey info``
==============================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2


.. mc:: bm idp ldap accesskey info


Description
-----------

.. start-mc-idp-ldap-accesskey-info-desc

The :mc:`bm idp ldap accesskey info` outputs information about the specified access key(s).

.. end-mc-idp-ldap-accesskey-info-desc

.. include:: /includes/common-minio-ad-ldap-params.rst
   :start-after: start-minio-ad-ldap-accesskey-creation
   :end-before: end-minio-ad-ldap-accesskey-creation

.. tab-set::

   .. tab-item:: EXAMPLE

         The following example outputs details for the access key ``mykey`` from the ``buckit`` deployment:

      .. code-block:: shell
         :class: copyable

         bm idp ldap accesskey info buckit/ mykey

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] idp ldap accesskey info      \
                                             ALIAS     \
                                             KEY       \
                                             [KEY2] ...


      - Replace ``ALIAS`` with the :ref:`alias <alias>` of a Buckit deployment configured for AD/LDAP integration.
      - Replace ``KEY`` with the access key to delete.
        You can list more than one access key by separating each key with a space.
        
      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :ref:`alias <alias>` of the Buckit deployment configured for AD/LDAP.

   For example:

   .. code-block:: none

         bm idp ldap accesskey ls buckit

.. mc-cmd:: KEY
   :required:

   The configured access key to output information about.

   You can list more than one access key by separating each key with a space.


Example
~~~~~~~

Output information about the access keys ``mykey`` and ``mykey2`` from the ``buckit`` deployment.

.. code-block:: shell
   :class: copyable

   bm idp ldap accesskey info buckit/ mykey mykey2

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
