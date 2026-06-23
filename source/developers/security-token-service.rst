.. _minio-security-token-service:

============================
Security Token Service (STS)
============================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

The Buckit Security Token Service (STS) APIs allow applications to generate temporary credentials for accessing the Buckit deployment.

The STS API is *required* for Buckit deployments configured to use external identity managers, as the API allows conversion of the external IDP credentials into AWS Signature v4-compatible credentials.

STS API Endpoints
-----------------

Buckit supports the following STS API endpoints:

.. list-table::
   :header-rows: 1
   :widths: 30 30 40

   * - Endpoint
     - Supported IDP
     - Description

   * - :ref:`AssumeRole <minio-sts-assumerole>`
     - Built-in users
     - Generates temporary credentials from an existing built-in user's access key and secret key.

   * - :ref:`AssumeRoleWithWebIdentity <minio-sts-assumerolewithwebidentity>`
     - OpenID Connect
     - Generates an access key and secret key using the JWT token returned by the OIDC provider

   * - :ref:`AssumeRoleWithClientGrants <minio-sts-assumerolewithclientgrants>`
     - OpenID Connect / OAuth 2.0 client credentials grant
     - Generates an access key and secret key using an OAuth 2.0 access token returned by the identity provider.

   * - :ref:`AssumeRoleWithLDAPIdentity <minio-sts-assumerolewithldapidentity>`
     - Active Directory / LDAP
     - Generates an access key and secret key using the AD/LDAP credentials specified to the API endpoint.

   * - :ref:`AssumeRoleWithCustomToken <minio-sts-assumerolewithcustomtoken>`
     - Buckit Identity Plugin
     - Generates a token for use with an external identity provider and the :ref:`Buckit Identity Plugin <minio-external-identity-management-plugin>`.

   * - :ref:`AssumeRoleWithCertificate <minio-sts-assumerolewithcertificate>`
     - X.509 / TLS certificate
     - Generates an access key and secret key by mapping the subject common name (CN) of a client TLS certificate to a matching policy.
 

.. toctree::
   :titlesonly:
   :hidden:
   :glob:

   /developers/security-token-service/*
