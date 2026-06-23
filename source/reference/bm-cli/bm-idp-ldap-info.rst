.. _minio-mc-idp-ldap-info:

====================
``bm idp ldap info``
====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm idp ldap info


Description
-----------

.. start-mc-idp-ldap-info-desc

The :mc:`bm idp ldap info` command outputs the current configuration for an AD/LDAP provider on a specified Buckit deployment.

.. end-mc-idp-ldap-info-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following example outputs the AD/LDAP configuration settings on the ``mybuckit`` deployment.

      .. code-block:: shell
         :class: copyable

         bm idp ldap info     \
                     mybuckit

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] idp ldap info   \
                                   ALIAS

      - Replace ``ALIAS`` with the :ref:`alias <alias>` of a Buckit deployment to retrieve info on the AD/LDAP integration.

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :ref:`alias <alias>` of the Buckit deployment for which to output the current AD/LDAP configuration.

   For example:

   .. code-block:: none

      bm idp ldap info mybuckit



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
