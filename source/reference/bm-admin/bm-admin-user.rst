=================
``bm admin user``
=================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin user

Description
-----------

.. start-mc-admin-user-desc

The :mc:`bm admin user` command and its subcommands manage :ref:`Buckit users <minio-internal-idp>`.

.. end-mc-admin-user-desc

Clients *must* authenticate to the Buckit deployment with the access key and secret key associated to a user on the deployment.
Buckit users constitute a key component in Buckit Identity and Access Management.

To manage users who authenticate using a 3rd party IDP, use the command for the appropriate provider:

- For AD/LDAP, use :mc:`bm idp ldap`
- For OpenID Connect (OIDC) compatible providers, use :mc:`bm idp openid`

.. admonition:: Use ``bm idp`` commands on Buckit Deployments Only
   :class: note

   :mc:`bm idp ldap` and :mc:`bm idp openid` and their subcommands are only supported against Buckit deployments.


Subcommands
-----------

:mc:`bm admin user` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm admin user add`
     - .. include:: /reference/bm-admin/bm-admin-user-add.rst
          :start-after: start-mc-admin-user-add-desc
          :end-before: end-mc-admin-user-add-desc

   * - :mc:`~bm admin user disable`
     - .. include:: /reference/bm-admin/bm-admin-user-disable.rst
          :start-after: start-mc-admin-user-disable-desc
          :end-before: end-mc-admin-user-disable-desc

   * - :mc:`~bm admin user enable`
     - .. include:: /reference/bm-admin/bm-admin-user-enable.rst
          :start-after: start-mc-admin-user-enable-desc
          :end-before: end-mc-admin-user-enable-desc

   * - :mc:`~bm admin user info`
     - .. include:: /reference/bm-admin/bm-admin-user-info.rst
          :start-after: start-mc-admin-user-info-desc
          :end-before: end-mc-admin-user-info-desc

   * - :mc:`~bm admin user ls`
     - .. include:: /reference/bm-admin/bm-admin-user-list.rst
          :start-after: start-mc-admin-user-list-desc
          :end-before: end-mc-admin-user-list-desc

   * - :mc:`~bm admin user rm`
     - .. include:: /reference/bm-admin/bm-admin-user-remove.rst
          :start-after: start-mc-admin-user-remove-desc
          :end-before: end-mc-admin-user-remove-desc

   * - :mc-cmd:`sts info <bm admin user sts info>`
     - .. include:: /reference/bm-admin/bm-admin-user-sts-info.rst
          :start-after: start-mc-admin-sts-info-desc
          :end-before: end-mc-admin-sts-info-desc

   * - :mc:`~bm admin user svcacct`
     - .. include:: /reference/bm-admin/bm-admin-user-svcacct.rst
          :start-after: start-mc-admin-user-svcacct-desc
          :end-before: end-mc-admin-user-svcacct-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-admin/bm-admin-user-add
   /reference/bm-admin/bm-admin-user-disable
   /reference/bm-admin/bm-admin-user-enable
   /reference/bm-admin/bm-admin-user-info
   /reference/bm-admin/bm-admin-user-list
   /reference/bm-admin/bm-admin-user-remove
   /reference/bm-admin/bm-admin-user-sts-info
   /reference/bm-admin/bm-admin-user-svcacct
