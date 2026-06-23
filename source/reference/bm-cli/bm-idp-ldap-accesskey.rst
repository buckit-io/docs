.. _minio-mc-idp-ldap-accesskey:

=========================
``bm idp ldap accesskey``
=========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm idp ldap accesskey

Description
-----------

.. start-mc-idp-ldap-accesskey-desc

The :mc-cmd:`bm idp ldap accesskey` commands allow you to list, delete, or display information about LDAP access key pairs. 

.. end-mc-idp-ldap-accesskey-desc

The :mc-cmd:`bm idp ldap accesskey` commands are only supported against Buckit deployments.

.. include:: /includes/common-minio-ad-ldap-params.rst
   :start-after: start-minio-ad-ldap-accesskey-creation
   :end-before: end-minio-ad-ldap-accesskey-creation

The :mc-cmd:`bm idp ldap accesskey` command has the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 40 60

   * - Subcommand
     - Description

   * - :mc-cmd:`bm idp ldap accesskey create`
     - .. include:: /reference/bm-cli/bm-idp-ldap-accesskey-create.rst
          :start-after: start-mc-idp-ldap-accesskey-create-desc
          :end-before: end-mc-idp-ldap-accesskey-create-desc

   * - :mc-cmd:`bm idp ldap accesskey disable`
     - .. include:: /reference/bm-cli/bm-idp-ldap-accesskey-disable.rst
          :start-after: start-mc-idp-ldap-accesskey-disable-desc
          :end-before: end-mc-idp-ldap-accesskey-disable-desc

   * - :mc-cmd:`bm idp ldap accesskey edit`
     - .. include:: /reference/bm-cli/bm-idp-ldap-accesskey-edit.rst
          :start-after: start-mc-idp-ldap-accesskey-edit-desc
          :end-before: end-mc-idp-ldap-accesskey-edit-desc

   * - :mc-cmd:`bm idp ldap accesskey enable`
     - .. include:: /reference/bm-cli/bm-idp-ldap-accesskey-enable.rst
          :start-after: start-mc-idp-ldap-accesskey-enable-desc
          :end-before: end-mc-idp-ldap-accesskey-enable-desc

   * - :mc-cmd:`bm idp ldap accesskey info`
     - .. include:: /reference/bm-cli/bm-idp-ldap-accesskey-info.rst
          :start-after: start-mc-idp-ldap-accesskey-info-desc
          :end-before: end-mc-idp-ldap-accesskey-info-desc

   * - :mc-cmd:`bm idp ldap accesskey ls`
     - .. include:: /reference/bm-cli/bm-idp-ldap-accesskey-ls.rst
          :start-after: start-mc-idp-ldap-accesskey-ls-desc
          :end-before: end-mc-idp-ldap-accesskey-ls-desc

   * - :mc-cmd:`bm idp ldap accesskey rm`
     - .. include:: /reference/bm-cli/bm-idp-ldap-accesskey-rm.rst
          :start-after: start-mc-idp-ldap-accesskey-rm-desc
          :end-before: end-mc-idp-ldap-accesskey-rm-desc

.. toctree::
   :titlesonly:
   :hidden:

   /reference/bm-cli/bm-idp-ldap-accesskey-disable
   /reference/bm-cli/bm-idp-ldap-accesskey-edit
   /reference/bm-cli/bm-idp-ldap-accesskey-enable
   /reference/bm-cli/bm-idp-ldap-accesskey-info
   /reference/bm-cli/bm-idp-ldap-accesskey-ls
   /reference/bm-cli/bm-idp-ldap-accesskey-rm
