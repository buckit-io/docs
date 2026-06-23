.. _minio-mc-idp-ldap-disable:

=======================
``bm idp ldap disable``
=======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm idp ldap disable


Description
-----------

.. start-mc-idp-ldap-disable-desc

The :mc:`bm idp ldap disable` command disables the currently configured AD/LDAP provider.

.. end-mc-idp-ldap-disable-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following example disables the AD/LDAP configurations on the ``mybuckit`` deployment.

      .. code-block:: shell
         :class: copyable

         bm idp ldap disable  \
                     mybuckit

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] idp ldap disable  \
                                   ALIAS

      - Replace ``ALIAS`` with the :ref:`alias <alias>` of a Buckit deployment to disable the AD/LDAP integration.

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :ref:`alias <alias>` of the Buckit deployment for which to disable the AD/LDAP integration.

   For example:

   .. code-block:: none

      bm idp ldap disable mybuckit



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
