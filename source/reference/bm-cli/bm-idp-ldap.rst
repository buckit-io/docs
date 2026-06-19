.. _minio-mc-idp-ldap:

===============
``bm idp ldap``
===============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm idp ldap

.. versionadded:: RELEASE.2023-05-26T23-31-54Z

   :mc-cmd:`bm idp ldap` and its subcommands replace ``bm admin idp ldap``.

Description
-----------

.. start-mc-idp-ldap-desc

The :mc-cmd:`bm idp ldap` commands allow you to manage configurations to 3rd party :ref:`Active Directory or LDAP Identity and Access Management (IAM) integrations <minio-external-identity-management-ad-ldap>`.

.. end-mc-idp-ldap-desc

The :mc-cmd:`bm idp ldap` commands are an alternative to using environment variables when :ref:`setting up an AD/LDAP connection <minio-authenticate-using-ad-ldap-generic>`. They are only supported against Buckit deployments.

See :ref:`minio-external-identity-management-ad-ldap` for a tutorial on using these commands.

.. note::

   Buckit :ref:`AD/LDAP environment variables <minio-server-envvar-external-identity-management-ad-ldap>` override their corresponding configuration settings as modified or set by this command.

The :mc-cmd:`bm idp ldap` command has the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 40 60

   * - Subcommand
     - Description

   * - :mc-cmd:`bm idp ldap add`
     - .. include:: /reference/bm-cli/bm-idp-ldap-add.rst
          :start-after: start-mc-idp-ldap-add-desc
          :end-before: end-mc-idp-ldap-add-desc

   * - :mc-cmd:`bm idp ldap disable`
     - .. include:: /reference/bm-cli/bm-idp-ldap-disable.rst
          :start-after: start-mc-idp-ldap-disable-desc
          :end-before: end-mc-idp-ldap-disable-desc

   * - :mc-cmd:`bm idp ldap enable`
     - .. include:: /reference/bm-cli/bm-idp-ldap-enable.rst
          :start-after: start-mc-idp-ldap-enable-desc
          :end-before: end-mc-idp-ldap-enable-desc

   * - :mc-cmd:`bm idp ldap info`
     - .. include:: /reference/bm-cli/bm-idp-ldap-info.rst
          :start-after: start-mc-idp-ldap-info-desc
          :end-before: end-mc-idp-ldap-info-desc

   * - :mc-cmd:`bm idp ldap ls`
     - .. include:: /reference/bm-cli/bm-idp-ldap-ls.rst
          :start-after: start-mc-idp-ldap-ls-desc
          :end-before: end-mc-idp-ldap-ls-desc

   * - :mc-cmd:`bm idp ldap policy` subcommands
     - .. include:: /reference/bm-cli/bm-idp-ldap-policy.rst
          :start-after: start-mc-idp-ldap-policy-desc
          :end-before: end-mc-idp-ldap-policy-desc

   * - :mc-cmd:`bm idp ldap rm`
     - .. include:: /reference/bm-cli/bm-idp-ldap-rm.rst
          :start-after: start-mc-idp-ldap-rm-desc
          :end-before: end-mc-idp-ldap-rm-desc

   * - :mc-cmd:`bm idp ldap update`
     - .. include:: /reference/bm-cli/bm-idp-ldap-update.rst
          :start-after: start-mc-idp-ldap-update-desc
          :end-before: end-mc-idp-ldap-update-desc


.. toctree::
   :titlesonly:
   :hidden:

   /reference/bm-cli/bm-idp-ldap-add
   /reference/bm-cli/bm-idp-ldap-disable
   /reference/bm-cli/bm-idp-ldap-enable
   /reference/bm-cli/bm-idp-ldap-info
   /reference/bm-cli/bm-idp-ldap-ls
   /reference/bm-cli/bm-idp-ldap-rm
   /reference/bm-cli/bm-idp-ldap-update

