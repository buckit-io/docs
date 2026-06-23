.. _minio-mc-admin-accesskey:

======================
``bm admin accesskey``
======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin accesskey

These commands replace the Buckit IDP functionality of the :mc:`bm admin user svcacct` command and its subcommands.

Description
-----------

.. start-mc-admin-accesskey-desc

The :mc:`bm admin accesskey` command and its subcommands create and manage :ref:`Access Keys <minio-idp-service-account>` for internally managed users on a Buckit deployment.

.. end-mc-admin-accesskey-desc

Each access key is linked to a :ref:`user identity <minio-authentication-and-identity-management>` and inherits the :ref:`policies <minio-policy>` attached to its parent user *or* those groups in which the parent user has membership.
Each access key also supports an optional inline policy which further restricts access to a subset of actions and resources available to the parent user.

:mc:`bm admin user svcacct` only supports creating access keys for :ref:`Buckit-managed <minio-users>` accounts.

To create access keys for :ref:`Active Directory/LDAP-managed <minio-external-identity-management-ad-ldap>` accounts, use :mc:`bm idp ldap accesskey` and its subcommands.
To manage access keys for :ref:`OpenID Connect-managed users <minio-external-identity-management-openid>`, log into the :ref:`Buckit Console <minio-console>` and generate the access keys through the UI.

:mc:`bm admin accesskey` command has the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 40 60

   * - Subcommand
     - Description

   * - :mc:`~bm admin accesskey create`
     - .. include:: /reference/bm-admin/bm-admin-accesskey-create.rst
          :start-after: start-mc-admin-accesskey-create-desc
          :end-before: end-mc-admin-accesskey-create-desc

   * - :mc:`~bm admin accesskey disable`
     - .. include:: /reference/bm-admin/bm-admin-accesskey-disable.rst
          :start-after: start-mc-admin-accesskey-disable-desc
          :end-before: end-mc-admin-accesskey-disable-desc

   * - :mc:`~bm admin accesskey edit`
     - .. include:: /reference/bm-admin/bm-admin-accesskey-edit.rst
          :start-after: start-mc-admin-accesskey-edit-desc
          :end-before: end-mc-admin-accesskey-edit-desc

   * - :mc:`~bm admin accesskey enable`
     - .. include:: /reference/bm-admin/bm-admin-accesskey-enable.rst
          :start-after: start-mc-admin-accesskey-enable-desc
          :end-before: end-mc-admin-accesskey-enable-desc

   * - :mc:`~bm admin accesskey info`
     - .. include:: /reference/bm-admin/bm-admin-accesskey-info.rst
          :start-after: start-mc-admin-accesskey-info-desc
          :end-before: end-mc-admin-accesskey-info-desc

   * - :mc:`~bm admin accesskey ls`
     - .. include:: /reference/bm-admin/bm-admin-accesskey-list.rst
          :start-after: start-mc-admin-accesskey-list-desc
          :end-before: end-mc-admin-accesskey-list-desc

   * - :mc:`~bm admin accesskey rm`
     - .. include:: /reference/bm-admin/bm-admin-accesskey-remove.rst
          :start-after: start-mc-admin-accesskey-remove-desc
          :end-before: end-mc-admin-accesskey-remove-desc


.. toctree::
   :titlesonly:
   :hidden:

   /reference/bm-admin/bm-admin-accesskey-create
   /reference/bm-admin/bm-admin-accesskey-disable
   /reference/bm-admin/bm-admin-accesskey-edit
   /reference/bm-admin/bm-admin-accesskey-enable
   /reference/bm-admin/bm-admin-accesskey-info
   /reference/bm-admin/bm-admin-accesskey-list
   /reference/bm-admin/bm-admin-accesskey-remove

