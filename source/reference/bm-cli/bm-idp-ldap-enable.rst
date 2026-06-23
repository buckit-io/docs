.. _minio-mc-idp-ldap-enable:

======================
``bm idp ldap enable``
======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm idp ldap enable


Description
-----------

.. start-mc-idp-ldap-enable-desc

The :mc:`bm idp ldap enable` command enables the currently configured AD/LDAP provider.

.. end-mc-idp-ldap-enable-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following example enables the AD/LDAP configurations on the ``mybuckit`` deployment.

      .. code-block:: shell
         :class: copyable

         bm idp ldap enable   \
                     mybuckit

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] idp ldap enable  \
                                   ALIAS

      - Replace ``ALIAS`` with the :ref:`alias <alias>` of a Buckit deployment to enable the AD/LDAP integration.

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :ref:`alias <alias>` of the Buckit deployment for which to enable the AD/LDAP integration.

   For example:

   .. code-block:: none

      bm idp ldap enable mybuckit



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
