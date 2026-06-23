.. |KEYCLOAK_URL| replace:: keycloak-url.example.net:8080
.. |MINIO_S3_URL| replace:: buckit-url.example.net:9000
.. |MINIO_CONSOLE_URL| replace:: buckit-url.example.net:9001

1) Configure or Create a Client for Accessing Keycloak
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Authenticate to the Keycloak :guilabel:`Administrative Console` and navigate to :guilabel:`Clients`.

.. include:: /includes/common/common-configure-keycloak-identity-management.rst
   :start-after: start-configure-keycloak-client
   :end-before: end-configure-keycloak-client

2) Create Client Scope for Buckit Client
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Client scopes allow Keycloak to map user attributes as part of the JSON Web Token (JWT) returned in authentication requests.
This allows Buckit to reference those attributes when assigning policies to the user.
This step creates the necessary client scope to support Buckit authorization after successful Keycloak authentication.

.. include:: /includes/common/common-configure-keycloak-identity-management.rst
   :start-after: start-configure-keycloak-client-scope
   :end-before: end-configure-keycloak-client-scope

3) Apply the Necessary Attribute to Keycloak Users/Groups
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You must assign an attribute named ``policy`` to the Keycloak Users or Groups. 
Set the value to any :ref:`policy <minio-policy>` on the Buckit deployment.

.. include:: /includes/common/common-configure-keycloak-identity-management.rst
   :start-after: start-configure-keycloak-user-group-attributes
   :end-before: end-configure-keycloak-user-group-attributes

4) Configure Buckit for Keycloak Authentication
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit supports multiple methods for configuring Keycloak authentication:

- Using a terminal/shell and the :mc:`bm idp openid` command
- Using environment variables set prior to starting Buckit

.. tab-set::

   .. tab-item:: CLI

      .. include:: /includes/common/common-configure-keycloak-identity-management.rst
         :start-after: start-configure-keycloak-minio-cli
         :end-before: end-configure-keycloak-minio-cli

   .. tab-item:: Environment Variables

      .. include:: /includes/common/common-configure-keycloak-identity-management.rst
         :start-after: start-configure-keycloak-minio-envvar
         :end-before: end-configure-keycloak-minio-envvar

Restart the Buckit deployment for the changes to apply.

Check the Buckit logs and verify that startup succeeded with no errors related to the OIDC configuration.

5) Generate Application Credentials using the Security Token Service (STS)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /includes/common/common-configure-keycloak-identity-management.rst
   :start-after: start-configure-keycloak-sts
   :end-before: end-configure-keycloak-sts

Next Steps
~~~~~~~~~~

Applications should implement the :ref:`STS AssumeRoleWithWebIdentity <minio-sts-assumerolewithwebidentity>` flow using their :ref:`SDK <minio-drivers>` of choice.
When STS credentials expire, applications should have logic in place to regenerate the JWT token, STS token, and Buckit credentials before retrying and continuing operations.



