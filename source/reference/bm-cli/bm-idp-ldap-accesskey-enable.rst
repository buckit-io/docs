.. _minio-mc-idp-ldap-accesskey-enable:

================================
``bm idp ldap accesskey enable``
================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2


.. mc:: bm idp ldap accesskey enable


Description
-----------

.. start-mc-idp-ldap-accesskey-enable-desc

The :mc:`bm idp ldap accesskey enable` enables the specified :ref:`access key <minio-id-access-keys>` on the local server.

.. end-mc-idp-ldap-accesskey-enable-desc

.. tab-set::

   .. tab-item:: EXAMPLE

         The following example enables the access key ``mykey`` from the ``buckit`` deployment:

      .. code-block:: shell
         :class: copyable

         bm idp ldap accesskey enable buckit/ mykey

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] idp ldap accesskey enable  \
                                          ALIAS      \
                                          KEY


      - Replace ``ALIAS`` with the :ref:`alias <alias>` of a Buckit deployment configured for AD/LDAP integration.
      - Replace ``KEY`` with the access key to enable.
        
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

         bm idp ldap accesskey enable buckit mykey

.. mc-cmd:: KEY
   :required:

   The configured access key to enable.

Example
~~~~~~~

Enable the access key ``mykey`` from the ``buckit`` deployment.

.. code-block:: shell
   :class: copyable

   bm idp ldap accesskey enable buckit/ mykey

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
