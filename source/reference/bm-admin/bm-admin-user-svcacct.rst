.. _minio-mc-admin-user-svcacct:

=========================
``bm admin user svcacct``
=========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin user svcacct

.. important::

   These commands have been replaced and will be deprecated in a future Buckit Manager CLI release.

   As of Buckit Manager CLI RELEASE.2024-10-08T09-37-26Z, use the :mc:`bm admin accesskey` command and its subcommands for functions related to built-in Buckit IDP users and their access keys or STS tokens.

   For access keys for AD/LDAP users, use the :mc:`bm idp ldap accesskey` command and its subcommands.

Description
-----------

.. start-mc-admin-user-svcacct-desc

The :mc:`bm admin user svcacct` command and its subcommands create and manage :ref:`Access Keys <minio-idp-service-account>` on a Buckit deployment.

As of Buckit Manager CLI RELEASE.2024-10-08T09-37-26Z, these commands have been replaced by :mc:`bm admin accesskey` and :mc:`bm idp ldap accesskey`.
This command and its subcommands will be deprecated in a future Buckit Manager CLI release.

.. end-mc-admin-user-svcacct-desc

Each access key is linked to a :ref:`user identity <minio-authentication-and-identity-management>` and inherits the :ref:`policies <minio-policy>` attached to its parent user *or* those groups in which the parent user has membership.
Each access key also supports an optional inline policy which further restricts access to a subset of actions and resources available to the parent user.

:mc:`bm admin user svcacct` only supports creating access keys for :ref:`Buckit-managed <minio-users>` and :ref:`Active Directory/LDAP-managed <minio-external-identity-management-ad-ldap>` accounts. 

To create access keys for :ref:`OpenID Connect-managed users <minio-external-identity-management-openid>`, log into the :ref:`Buckit Console <minio-console>` and generate the access keys through the UI.

The :mc:`bm admin user svcacct` command has the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 40 60

   * - Subcommand
     - Description

   * - :mc:`~bm admin user svcacct add`
     - .. include:: /reference/bm-admin/bm-admin-user-svcacct-add.rst
          :start-after: start-mc-admin-svcacct-add-desc
          :end-before: end-mc-admin-svcacct-add-desc

   * - :mc:`~bm admin user svcacct disable`
     - .. include:: /reference/bm-admin/bm-admin-user-svcacct-disable.rst
          :start-after: start-mc-admin-svcacct-disable-desc
          :end-before: end-mc-admin-svcacct-disable-desc

   * - :mc:`~bm admin user svcacct edit`
     - .. include:: /reference/bm-admin/bm-admin-user-svcacct-edit.rst
          :start-after: start-mc-admin-svcacct-edit-desc
          :end-before: end-mc-admin-svcacct-edit-desc

   * - :mc:`~bm admin user svcacct enable`
     - .. include:: /reference/bm-admin/bm-admin-user-svcacct-enable.rst
          :start-after: start-mc-admin-svcacct-enable-desc
          :end-before: end-mc-admin-svcacct-enable-desc

   * - :mc:`~bm admin user svcacct info`
     - .. include:: /reference/bm-admin/bm-admin-user-svcacct-info.rst
          :start-after: start-mc-admin-svcacct-info-desc
          :end-before: end-mc-admin-svcacct-info-desc

   * - :mc:`~bm admin user svcacct list`
     - .. include:: /reference/bm-admin/bm-admin-user-svcacct-list.rst
          :start-after: start-mc-admin-svcacct-list-desc
          :end-before: end-mc-admin-svcacct-list-desc

   * - :mc:`~bm admin user svcacct rm`
     - .. include:: /reference/bm-admin/bm-admin-user-svcacct-remove.rst
          :start-after: start-mc-admin-svcacct-remove-desc
          :end-before: end-mc-admin-svcacct-remove-desc


.. toctree::
   :titlesonly:
   :hidden:

   /reference/bm-admin/bm-admin-user-svcacct-add
   /reference/bm-admin/bm-admin-user-svcacct-disable
   /reference/bm-admin/bm-admin-user-svcacct-edit
   /reference/bm-admin/bm-admin-user-svcacct-enable
   /reference/bm-admin/bm-admin-user-svcacct-info
   /reference/bm-admin/bm-admin-user-svcacct-list
   /reference/bm-admin/bm-admin-user-svcacct-remove

