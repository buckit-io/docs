.. _minio-mc-idp-ldap-update:

======================
``bm idp ldap update``
======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm idp ldap update


Description
-----------

.. start-mc-idp-ldap-update-desc

The :mc:`bm idp ldap update` command modifies an existing set of configurations for an AD/LDAP provider.

.. end-mc-idp-ldap-update-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following example changes two of the AD/LDAP configuration settings for the ``mybuckit`` deployment.

      .. code-block:: shell
         :class: copyable

         bm idp ldap update                                \
                     mybuckit                               \
                     lookup_bind_dn=cn=admin,dc=min,dc=io  \
                     lookup_bind_password=somesecret

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] idp ldap update           \
                                   ALIAS            \
                                   [CFG_PARAM1]     \
                                   [CFG_PARAM2]...

      - Replace ``ALIAS`` with the :ref:`alias <alias>` of a Buckit deployment to update for AD/LDAP integration.
      - Replace the ``[CFG_PARAM#]`` with each of the :ref:`configuration setting <minio-ldap-config-settings>` key-value pairs in the format of ``PARAMETER="value"``.

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :ref:`alias <alias>` of the Buckit deployment on which to modify an AD/LDAP integration.

   For example:

   .. code-block:: none

      bm idp ldap update mybuckit                               \
                         lookup_bind_dn=cn=admin,dc=min,dc=io  \

.. include:: /includes/common-minio-ad-ldap-params.rst
   :start-after: start-minio-ad-ldap-params
   :end-before: end-minio-ad-ldap-params


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
