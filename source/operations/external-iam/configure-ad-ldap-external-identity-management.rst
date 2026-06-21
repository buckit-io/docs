.. _minio-authenticate-using-ad-ldap-generic:

=================================================================
Configure Buckit for Authentication using Active Directory / LDAP
=================================================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2


Overview
--------

Buckit supports configuring a single Active Directory / LDAP Connect for external management of user identities.

The procedure on this page provides instructions for:

- Configuring a Buckit cluster for an external AD/LDAP provider.
- Accessing the Buckit Console using AD/LDAP credentials.
- Using the Buckit ``AssumeRoleWithLDAPIdentity`` Security Token Service (STS) API to generate temporary credentials for use by applications.

This procedure is generic for AD/LDAP services.
See the documentation for the AD/LDAP provider of your choice for specific instructions or procedures on configuration of user identities.

Prerequisites
-------------

Access to Buckit Cluster
~~~~~~~~~~~~~~~~~~~~~~~~

This procedure uses :mc:`bm` for performing operations on the Buckit cluster.
Install ``bm`` on a machine with network access to the cluster.
See :ref:`Install the Buckit Manager <install-buckit-manager>` for instructions on downloading and installing ``bm``.

This procedure assumes a configured :mc:`alias <bm alias>` for the Buckit cluster.

Active Directory / LDAP Compatible IDentity Provider
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This procedure assumes an existing Active Directory or LDAP service.
Instructions on configuring AD/LDAP are out of scope for this procedure.

The Buckit deployment must have bidirectional network connectivity to the target AD / LDAP service.

Buckit requires a read-only access keys with which it :ref:`binds <minio-external-identity-management-ad-ldap-lookup-bind>` to perform authenticated user and group queries.
Ensure each AD/LDAP user and group intended for use with Buckit has a corresponding :ref:`policy <minio-external-identity-management-ad-ldap-access-control>` on the Buckit deployment. 
An AD/LDAP user with no assigned policy *and* with membership in groups with no assigned policy has no permission to access any action or resource on the Buckit cluster.

.. _minio-external-identity-management-ad-ldap-configure:

Configure Buckit with Active Directory or LDAP External Identity Management
---------------------------------------------------------------------------

.. include:: /includes/baremetal/steps-configure-ad-ldap-external-identity-management.rst

Disable a Configured Active Directory / LDAP Connection
-------------------------------------------------------

You can enable and disable the configured AD/LDAP connection as needed.

Use :mc:`bm idp ldap disable` to deactivate a configured connection.
Use :mc:`bm idp ldap enable` to activate a previously configured connection.
