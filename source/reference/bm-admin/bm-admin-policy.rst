===================
``bm admin policy``
===================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin policy

.. versionchanged:: mc RELEASE.2023-03-20T17-17-53Z

   The following commands are deprecated:
   
   - ``bm admin policy add`` use :mc:`bm admin policy create` instead
   - ``bm admin policy set`` use :mc:`bm admin policy attach` instead
   - ``bm admin policy unset`` use :mc:`bm admin policy detach` instead
   - ``bm admin policy update`` use :mc:`~bm admin policy attach` or :mc:`~bm admin policy detach` instead

   The following command is added:

   - :mc-cmd:`bm admin policy entities`

Description
-----------

.. start-mc-admin-policy-desc

The :mc:`bm admin policy` commands manage policies for use with :ref:`Buckit Policy-Based Access Control <minio-policy>` (PBAC). 
Buckit PBAC uses IAM-compatible policy JSON documents to define rules for accessing resources on a Buckit server.

.. end-mc-admin-policy-desc

For complete documentation on Buckit PBAC, including policy document JSON structure and syntax, see :ref:`minio-policy`. To manage policies for deployments that use LDAP authentication, see :mc:`bm idp ldap policy`.

Subcommands
-----------

:mc:`bm admin policy` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm admin policy attach`
     - .. include:: /reference/bm-admin/bm-admin-policy-attach.rst
          :start-after: start-mc-admin-policy-attach-desc
          :end-before: end-mc-admin-policy-attach-desc

   * - :mc:`~bm admin policy create`
     - .. include:: /reference/bm-admin/bm-admin-policy-create.rst
          :start-after: start-mc-admin-policy-create-desc
          :end-before: end-mc-admin-policy-create-desc

   * - :mc:`~bm admin policy detach`
     - .. include:: /reference/bm-admin/bm-admin-policy-detach.rst
          :start-after: start-mc-admin-policy-detach-desc
          :end-before: end-mc-admin-policy-detach-desc

   * - :mc:`~bm admin policy entities`
     - .. include:: /reference/bm-admin/bm-admin-policy-entities.rst
          :start-after: start-mc-admin-policy-entities-desc
          :end-before: end-mc-admin-policy-entities-desc

   * - :mc:`~bm admin policy info`
     - .. include:: /reference/bm-admin/bm-admin-policy-info.rst
          :start-after: start-mc-admin-policy-info-desc
          :end-before: end-mc-admin-policy-info-desc

   * - :mc:`~bm admin policy ls`
     - .. include:: /reference/bm-admin/bm-admin-policy-list.rst
          :start-after: start-mc-admin-policy-list-desc
          :end-before: end-mc-admin-policy-list-desc

   * - :mc:`~bm admin policy rm`
     - .. include:: /reference/bm-admin/bm-admin-policy-remove.rst
          :start-after: start-mc-admin-policy-remove-desc
          :end-before: end-mc-admin-policy-remove-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-admin/bm-admin-policy-attach
   /reference/bm-admin/bm-admin-policy-create
   /reference/bm-admin/bm-admin-policy-detach
   /reference/bm-admin/bm-admin-policy-entities
   /reference/bm-admin/bm-admin-policy-info
   /reference/bm-admin/bm-admin-policy-list
   /reference/bm-admin/bm-admin-policy-remove
