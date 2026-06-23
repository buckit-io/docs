.. _minio-mc-idp-ldap-policy:

======================
``bm idp ldap policy``
======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm idp ldap policy


Description
-----------

.. start-mc-idp-ldap-policy-desc

The :mc-cmd:`bm idp ldap policy` commands show the mapping relationships between policies and the associated groups or users. 

.. end-mc-idp-ldap-policy-desc

The :mc-cmd:`bm idp ldap policy` commands are only supported against Buckit deployments.

The :mc-cmd:`bm idp ldap policy` command has the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 40 60

   * - Subcommand
     - Description

   * - :mc-cmd:`bm idp ldap policy attach`
     - .. include:: /reference/bm-cli/bm-idp-ldap-policy-attach.rst
          :start-after: start-mc-idp-ldap-policy-attach-desc
          :end-before: end-mc-idp-ldap-policy-attach-desc

   * - :mc-cmd:`bm idp ldap policy detach`
     - .. include:: /reference/bm-cli/bm-idp-ldap-policy-detach.rst
          :start-after: start-mc-idp-ldap-policy-detach-desc
          :end-before: end-mc-idp-ldap-policy-detach-desc

   * - :mc-cmd:`bm idp ldap policy entities`
     - .. include:: /reference/bm-cli/bm-idp-ldap-policy-entities.rst
          :start-after: start-mc-idp-ldap-policy-entities-desc
          :end-before: end-mc-idp-ldap-policy-entities-desc

.. toctree::
   :titlesonly:
   :hidden:

   /reference/bm-cli/bm-idp-ldap-policy-attach
   /reference/bm-cli/bm-idp-ldap-policy-detach
   /reference/bm-cli/bm-idp-ldap-policy-entities
