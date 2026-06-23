:orphan:

===================
Deprecated Commands
===================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

The following table lists the commands deprecated by Buckit.
The table includes:

- Deprecated Command
- Replacement command (if applicable)
- Version of deprecation

Table of Deprecated Commands
----------------------------

.. list-table::
   :header-rows: 1
   :widths: 30 30 40
   :width: 100%

   * - Deprecated Command
     - Replacement Command
     - Version of Change

   * - ``mc ilm add``
     - :mc-cmd:`bm ilm rule add`
     - mc RELEASE.2022-12-24T15-21-38Z

   * - ``mc ilm edit``
     - :mc-cmd:`bm ilm rule edit`
     - mc RELEASE.2022-12-24T15-21-38Z

   * - ``mc ilm export``
     - :mc-cmd:`bm ilm rule export`
     - mc RELEASE.2022-12-24T15-21-38Z

   * - ``mc ilm import``
     - :mc-cmd:`bm ilm rule import`
     - mc RELEASE.2022-12-24T15-21-38Z

   * - ``mc ilm ls``
     - :mc-cmd:`bm ilm rule ls`
     - mc RELEASE.2022-12-24T15-21-38Z

   * - ``mc ilm rm``
     - :mc-cmd:`bm ilm rule rm`
     - mc RELEASE.2022-12-24T15-21-38Z

   * - ``mc quota``
     - None
     - mc RELEASE.2024-07-31T15-58-33Z

   * - ``mc quota clear``
     - None
     - mc RELEASE.2024-07-31T15-58-33Z

   * - ``mc quota info``
     - None
     - mc RELEASE.2024-07-31T15-58-33Z

   * - ``mc quota set``
     - None
     - mc RELEASE.2024-07-31T15-58-33Z

   * - ``mc replicate diff``
     - :mc-cmd:`bm replicate backlog`
     - mc RELEASE.2023-07-18T21-05-38Z


Table of Deprecated Admin Commands
----------------------------------

.. list-table::
   :header-rows: 1
   :widths: 30 30 40
   :width: 100%

   * - Deprecated Command
     - Replacement Command
     - Version of Change

   * - ``mc admin bucket remote``
     - :mc-cmd:`bm replicate`
     - mc RELEASE.2022-12-24T15-21-38Z

   * - ``mc admin bucket remote add``
     - :mc-cmd:`bm replicate add`
     - mc RELEASE.2022-12-24T15-21-38Z

   * - ``mc admin bucket remote ls``
     - :mc-cmd:`bm replicate ls`
     - mc RELEASE.2022-12-24T15-21-38Z

   * - ``mc admin bucket remote rm``
     - :mc-cmd:`bm replicate rm`
     - mc RELEASE.2022-12-24T15-21-38Z

   * - ``mc admin bucket remote update``
     - :mc-cmd:`bm replicate update`
     - mc RELEASE.2022-12-24T15-21-38Z

   * - ``mc admin bucket quota``
     - :mc-cmd:`bm quota clear`, :mc-cmd:`bm quota info`, :mc-cmd:`bm quota set`
     - mc RELEASE.2022-12-13T00-23-28Z

   * - ``mc admin console``
     - :mc-cmd:`bm admin logs`
     - mc RELEASE.2022-06-26T18-51-48Z

   * - ``mc admin idp ldap add``
     - :mc-cmd:`bm idp ldap add`
     - mc RELEASE.2023-05-26T23-31-54Z

   * - ``mc admin idp ldap disable``
     - :mc-cmd:`bm idp ldap disable`
     - mc RELEASE.2023-05-26T23-31-54Z

   * - ``mc admin idp ldap enable``
     - :mc-cmd:`bm idp ldap enable`
     - mc RELEASE.2023-05-26T23-31-54Z

   * - ``mc admin idp ldap info``
     - :mc-cmd:`bm idp ldap info`
     - mc RELEASE.2023-05-26T23-31-54Z

   * - ``mc admin idp ldap ls``
     - :mc-cmd:`bm idp ldap ls`
     - mc RELEASE.2023-05-26T23-31-54Z

   * - ``mc admin idp ldap policy``
     - :mc-cmd:`bm idp ldap policy`
     - mc RELEASE.2023-05-26T23-31-54Z

   * - ``mc admin idp ldap rm``
     - :mc-cmd:`bm idp ldap rm`
     - mc RELEASE.2023-05-26T23-31-54Z

   * - ``mc admin idp ldap update``
     - :mc-cmd:`bm idp ldap update`
     - mc RELEASE.2023-05-26T23-31-54Z

   * - ``mc admin idp openid add``
     - :mc-cmd:`bm idp openid add`
     - mc RELEASE.2023-05-26T23-31-54Z

   * - ``mc admin idp openid disable``
     - :mc-cmd:`bm idp openid disable`
     - mc RELEASE.2023-05-26T23-31-54Z

   * - ``mc admin idp openid enable``
     - :mc-cmd:`bm idp openid enable`
     - mc RELEASE.2023-05-26T23-31-54Z

   * - ``mc admin idp openid info``
     - :mc-cmd:`bm idp openid info`
     - mc RELEASE.2023-05-26T23-31-54Z

   * - ``mc admin idp openid ls``
     - :mc-cmd:`bm idp openid ls`
     - mc RELEASE.2023-05-26T23-31-54Z

   * - ``mc admin idp openid rm``
     - :mc-cmd:`bm idp openid rm`
     - mc RELEASE.2023-05-26T23-31-54Z

   * - ``mc admin idp openid update``
     - :mc-cmd:`bm idp openid update`
     - mc RELEASE.2023-05-26T23-31-54Z

   * - ``mc admin policy add``
     - :mc-cmd:`bm admin policy create`
     - mc RELEASE.2023-03-20T17-17-53Z 

   * - ``mc admin policy set``
     - :mc-cmd:`bm admin policy attach`
     - mc RELEASE.2023-03-20T17-17-53Z 

   * - ``mc admin policy unset``
     - :mc-cmd:`bm admin policy detach`
     - mc RELEASE.2023-03-20T17-17-53Z 

   * - ``mc admin policy update``
     - :mc-cmd:`bm admin policy attach` or :mc-cmd:`bm admin policy detach`
     - mc RELEASE.2023-03-20T17-17-53Z 

   * - ``mc admin profile``
     - :mc:`bm support profile`
     - mc RELEASE.2023-04-06T16-51-10Z

   * - ``mc admin replicate edit``
     - :mc:`bm admin replicate update`
     - mc RELEASE.2023-01-11T03-14-16Z

   * - ``mc admin replicate remove``
     - :mc:`bm admin replicate rm`
     - mc RELEASE.2023-01-11T03-14-16Z

   * - ``mc admin speedtest``
     - :mc:`bm support perf`
     - mc RELEASE.2022-07-24T02-25-13Z

   * - ``mc admin tier add``
     - :mc:`bm ilm tier add`
     - mc RELEASE.2022-12-24T15-21-38Z

   * - ``mc admin tier edit``
     - :mc-cmd:`bm ilm tier update`
     - mc RELEASE.2022-12-24T15-21-38Z

   * - ``mc admin tier ls``
     - :mc:`bm ilm tier ls`
     - mc RELEASE.2022-12-24T15-21-38Z

   * - ``mc admin top``
     - :mc:`bm support top`
     - mc RELEASE.2022-08-11T00-30-48Z

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/deprecated/mc-ilm-add
   /reference/deprecated/mc-ilm-edit
   /reference/deprecated/mc-ilm-export
   /reference/deprecated/mc-ilm-import
   /reference/deprecated/mc-ilm-ls
   /reference/deprecated/mc-ilm-rm
   /reference/deprecated/mc-quota
   /reference/deprecated/mc-quota-clear
   /reference/deprecated/mc-quota-info
   /reference/deprecated/mc-quota-set
   /reference/deprecated/mc-admin-bucket-quota
   /reference/deprecated/mc-admin-bucket-remote
   /reference/deprecated/mc-admin-console
   /reference/deprecated/mc-admin-idp-ldap
   /reference/deprecated/mc-admin-idp-ldap-policy
   /reference/deprecated/mc-admin-idp-openid
   /reference/deprecated/mc-admin-profile
   /reference/deprecated/mc-admin-speedtest
   /reference/deprecated/mc-admin-tier
   /reference/deprecated/mc-admin-top
