.. _minio-mc-idp-ldap-add:

===================
``bm idp ldap add``
===================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm idp ldap add


Description
-----------

.. start-mc-idp-ldap-add-desc

The :mc:`bm idp ldap add` command creates an AD/LDAP IDP server configuration.

.. end-mc-idp-ldap-add-desc

Buckit supports no more than *one* (1) AD/LDAP provider per deployment.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following example sets the AD/LDAP configuration settings for the ``myminio`` deployment.

      .. code-block:: shell
         :class: copyable

         bm idp ldap add                                                            \
                     myminio                                                        \
                     server_addr=myldapserver:636                                   \
                     lookup_bind_dn=cn=admin,dc=min,dc=io                           \
                     lookup_bind_password=somesecret                                \
                     user_dn_search_base_dn=dc=min,dc=io                            \
                     user_dn_search_filter="(uid=%s)"                               \
                     group_search_base_dn=ou=swengg,dc=min,dc=io                    \
                     group_search_filter="(&(objectclass=groupofnames)(member=%d))"

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] idp ldap add               \
                                   ALIAS             \
                                   [CFG_PARAM1]      \
                                   [CFG_PARAM2]...

      - Replace ``ALIAS`` with the :ref:`alias <alias>` of a Buckit deployment to create for AD/LDAP integration.
      - Replace the ``[CFG_PARAM#]`` with each of the :ref:`configuration setting <minio-ldap-config-settings>` key-value pairs in the format of ``PARAMETER="value"``.

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :ref:`alias <alias>` of the Buckit deployment on which to add an AD/LDAP integration.

   For example:

   .. code-block:: none

      bm idp ldap add myminio                               \
                      server_addr=myldapserver:636          \
                      lookup_bind_dn=cn=admin,dc=min,dc=io  \
                      lookup_bind_password=somesecret       \
                      user_dn_search_base_dn=dc=min,dc=io   \
                      user_dn_search_filter="(uid=%s)"      \

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
