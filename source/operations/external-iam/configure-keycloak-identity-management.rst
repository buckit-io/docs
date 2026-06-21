.. _minio-authenticate-using-keycloak:

==================================================
Configure Buckit for Authentication using Keycloak
==================================================

.. default-domain:: minio

.. |KEYCLOAK_URL| replace:: keycloak-url.example.net:8080
.. |MINIO_S3_URL| replace:: buckit.example.net:9000
.. |MINIO_CONSOLE_URL| replace:: console.buckit.example.net:9001


.. contents:: Table of Contents
   :local:
   :depth: 1

Overview
--------

This procedure configures Buckit to use `Keycloak <https://www.keycloak.org/>`__ as an external IDentity Provider (IDP) for authentication of users via the OpenID Connect (OIDC) protocol.

This procedure covers:

- Configure Keycloak for use with Buckit authentication and authorization
- Configure a new or existing Buckit cluster to use Keycloak as the OIDC provider
- Create policies to control access of Keycloak-authenticated users
- Log into the Buckit Console using SSO and a Keycloak-managed identity
- Generate temporary S3 access credentials using the ``AssumeRoleWithWebIdentity`` Security Token Service (STS) API

This procedure was written and tested against Keycloak ``21.0.0``. 
The provided instructions may work against other Keycloak versions.
This procedure assumes you have prior experience with Keycloak and have reviewed `their documentation <https://www.keycloak.org/documentation>`__ for guidance and best practices in deploying, configuring, and managing the service.

Prerequisites
-------------

Keycloak Deployment and Realm Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This procedure assumes an existing Keycloak deployment to which you have administrative access.
Specifically, you must have permission to create and configure Realms, Clients, Client Scopes, Realm Roles, Users, and Groups on the Keycloak deployment.

The Buckit deployment must have bidirectional access to the target OIDC service.

Ensure each user identity intended for use with Buckit has the appropriate :ref:`claim <minio-external-identity-management-openid-access-control>` configured such that Buckit can associate a :ref:`policy <minio-policy>` to the authenticated user.
An OpenID user with no assigned policy has no permission to access any action or resource on the Buckit cluster.


Access to Buckit Cluster
~~~~~~~~~~~~~~~~~~~~~~~~

This procedure uses :mc:`bm` for performing operations on the Buckit cluster.
Install ``bm`` on a machine with network access to the cluster.
See :ref:`Install the Buckit Manager <install-buckit-manager>` for instructions on downloading and installing ``bm``.

This procedure assumes a configured :mc:`alias <bm alias>` for the Buckit cluster.

.. _minio-external-identity-management-keycloak-configure:

Configure Buckit for Keycloak Identity Management
-------------------------------------------------

.. include:: /includes/baremetal/steps-configure-keycloak-identity-management.rst

Enable the Keycloak Admin REST API
----------------------------------

Buckit supports using the Keycloak Admin REST API for checking if an authenticated user exists *and* is enabled on the Keycloak realm.
This functionality allows Buckit to more quickly remove access from previously authenticated Keycloak users.
Without this functionality, the earliest point in time that Buckit could disable access for a disabled or removed user is when the last retrieved authentication token expires.

This procedure assumes an existing Buckit deployment configured with Keycloak as an external identity manager.

1) Create the Necessary Client Scopes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Navigate to the :guilabel:`Client scopes` view and create a new scope:

.. list-table::
   :stub-columns: 1
   :widths: 30 70
   :width: 100%

   * - :guilabel:`Name`
     - Set to a recognizable name for the scope (``minio-admin-API-access``)
   * - :guilabel:`Mappers`
     - Select :guilabel:`Configure a new mapper`
   * - :guilabel:`Audience`
     - Set the :guilabel:`Name` to any recognizable name for the mapping (``minio-admin-api-access-mapper``)
   * - :guilabel:`Included Client Audience`
     - Set to ``security-admin-console``.

Navigate to :guilabel:`Clients` and select the Buckit client

1. From :guilabel:`Service account roles`, select :guilabel:`Assign role` and assign the ``admin`` role
2. From :guilabel:`Client scopes`, select :guilabel:`Add client scope` and add the previously created scope

Navigate to :guilabel:`Settings` and ensure :guilabel:`Authentication flow` includes ``Service accounts roles``.

2) Validate Admin API Access
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can validate the functionality by using the Admin REST API with the Buckit client credentials to retrieve a bearer token and user data:

1. Retrieve the bearer token:

   .. code-block:: shell
      :class: copyable

      curl -d "client_id=minio" \
           -d "client_secret=secretvalue" \
           -d "grant_type=password" \
           http://keycloak-url:port/admin/realms/REALM/protocol/openid-connect/token

2. Use the value returned as the ``access_token`` to access the Admin API:

   .. code-block:: shell
      :class: copyable

      curl -H "Authentication: Bearer ACCESS_TOKEN_VALUE" \
           http://keycloak-url:port/admin/realms/REALM/users/UUID

   Replace ``UUID`` with the unique ID for the user which you want to retrieve.
   The response should resemble the following:

   .. code-block:: json
      
      {
         "id": "954de141-781b-4eaf-81bf-bf3751cdc5f2",
         "createdTimestamp": 1675866684976,
         "username": "minio-user-1",
         "enabled": true,
         "totp": false,
         "emailVerified": false,
         "firstName": "",
         "lastName": "",
         "attributes": {
            "policy": [
               "readWrite"
            ]
         },
         "disableableCredentialTypes": [],
         "requiredActions": [],
         "notBefore": 0,
         "access": {
            "manageGroupMembership": true,
            "view": true,
            "mapRoles": true,
            "impersonate": true,
            "manage": true
         }
      }

   Buckit would revoke access for an authenticated user if the returned value has ``enabled: false`` or ``null`` (user was removed from Keycloak).

3) Enable Keycloak Admin Support on Buckit
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit supports multiple methods for configuring Keycloak Admin API Support:

- Using a terminal/shell and the :mc:`bm idp openid` command
- Using environment variables set prior to starting Buckit

.. tab-set::

   .. tab-item:: CLI

      You can use the :mc-cmd:`bm idp openid update` command to modify the configuration settings for an existing Keycloak service.
      You can alternatively include the following configuration settings when setting up Keycloak for the first time.
      The command takes all supported :ref:`OpenID Configuration Settings <minio-open-id-config-settings>`:

      .. code-block:: shell
         :class: copyable

         bm idp openid update ALIAS KEYCLOAK_IDENTIFIER \
            vendor="keycloak" \
            keycloak_admin_url="https://keycloak-url:port/admin"
            keycloak_realm="REALM"

      - Replace ``KEYCLOAK_IDENTIFIER`` with the name of the configured Keycloak IDP.
        You can use :mc-cmd:`bm idp openid ls` to view all configured IDP configurations on the Buckit deployment
        
      - Specify the Keycloak admin URL in the :mc-conf:`keycloak_admin_url <identity_openid.keycloak_admin_url>` configuration setting

      - Specify the Keycloak Realm name in the :mc-conf:`keycloak_realm <identity_openid.keycloak_realm>`

   .. tab-item:: Environment Variables

      Set the following :ref:`environment variables <minio-server-envvar-external-identity-management-openid>` in the appropriate configuration location, such as ``/etc/default/minio``.

      The following example code sets the minimum required environment variables related to enabling the Keycloak Admin API for an existing Keycloak configuration.
      Replace the suffix ``_PRIMARY_IAM`` with the unique identifier for the target Keycloak configuration.

      .. code-block:: shell
         :class: copyable

         MINIO_IDENTITY_OPENID_VENDOR_PRIMARY_IAM="keycloak"
         MINIO_IDENTITY_OPENID_KEYCLOAK_ADMIN_URL_PRIMARY_IAM="https://keycloak-url:port/admin"
         MINIO_IDENTITY_OPENID_KEYCLOAK_REALM_PRIMARY_IAM="REALM"

      - Specify the Keycloak admin URL in the :envvar:`MINIO_IDENTITY_OPENID_KEYCLOAK_ADMIN_URL`
      - Specify the Keycloak Realm name in the :envvar:`MINIO_IDENTITY_OPENID_KEYCLOAK_REALM`
