====================
Enable TLS for Buckit
====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

Buckit supports Transport Layer Security (TLS) 1.2+ encryption of incoming and outgoing traffic.

.. tab-set::
   :class: parent

   .. tab-item:: Kubernetes
      :sync: k8s

      The Buckit Operator supports the following approaches to enabling TLS on a Buckit Tenant:

      - Automatic TLS provisioning using Kubernetes Cluster Signing Certificates
      - User-specified TLS using Kubernetes secrets
      - Certmanager-managed TLS certificates

   .. tab-item:: Baremetal
      :sync: baremetal

      Buckit automatically detects TLS certificates in the configured or default directory and starts with TLS enabled.

This procedure documents enabling TLS for a single domain in Buckit.
For instructions on TLS for multiple domains, see TODO

Prerequisites
-------------

Access to Buckit Cluster
~~~~~~~~~~~~~~~~~~~~~~~

.. tab-set::
   

   .. tab-item:: Kubernetes
      :sync: k8s

      You must have access to the Kubernetes cluster, with administrative permissions associated to your ``kubectl`` configuration.
      
      This procedure assumes your permission sets extends sufficiently to support deployment or modification of Buckit-associated resources on the Kubernetes cluster, including but not limited to pods, statefulsets, replicasets, deployments, and secrets.

   .. tab-item:: Baremetal
      :sync: baremetal

      This procedure uses :mc:`mc` for performing operations on the Buckit cluster. 
      Install ``mc`` on a machine with network access to the cluster.
      See the ``mc`` :ref:`Installation Quickstart <mc-install>` for instructions on downloading and installing ``mc``.

      This procedure assumes a configured :mc:`alias <mc alias>` for the Buckit cluster. 

      This procedure also assumes SSH or similar shell-level access with administrative permissions to each Buckit host server.

TLS Certificates
~~~~~~~~~~~~~~~~

Provision the necessary TLS certificates with a :ref:`supported cipher suite <minio-TLS-supported-cipher-suites>` for use by Buckit.

.. tab-set::
   

   .. tab-item:: Kubernetes
      :sync: k8s

      See :ref:`minio-tls-kubernetes` for more complete guidance on the supported Tenant TLS configurations.

   .. tab-item:: Baremetal
      :sync: k8s

      Provision certificate susing your preferred path, such as through your organizations internal Certificate Authority or by using a well-known global provider such as Digicert or Verisign.

      You can create self-signed certificates using ``openssl`` or the Buckit :minio-git:`certgen <certgen>` tool.

      For example, the following command generates a self-signed certificate with a set of IP and DNS Subject Alternate Names (SANs) associated to the Buckit Server hosts:

      .. code-block:: shell

         certgen -host "localhost,minio-*.example.net"

      See :ref:`minio-tls-baremetal` for more complete guidance on certificate generation and placement.


Procedure
---------

.. tab-set::
   

   .. tab-item:: Kubernetes
      :sync: k8s

      The Buckit Operator supports three methods of TLS certificate management on Buckit Tenants:

      - Buckit automatic TLS certificate generation
      - ``cert-manager`` managed TLS certificates
      - User managed TLS certificates

      You can use any combination of the above methods to enable and configure TLS.
      Buckit strongly recommends using ``cert-manager`` for user-specified certificates for a streamlined management and renewal proces.

      You can also deploy Buckit Tenants without TLS enabled.

      .. tab-set::

         .. tab-item:: Buckit Auto-TLS

            The following steps apply to both new and existing Buckit Deployments using ``Kustomize``:

            1. Review the :ref:`Tenant CRD <minio-operator-crd>` ``TenantSpec.requestAutoCert`` and ``TenantSpec.certConfig`` fields.

               For existing Buckit Tenants, review the Kustomize resources used to create the Tenant and introspect those fields and their current configuration, if any.

            2. Create or Modify your Tenant YAML to set the values of ``requestAutoCert`` and ``certConfig`` as necessary.
               For example:

               .. code-block:: yaml

                  spec:
                     requestAutoCert: true
                     certConfig:
                       commonName: "CN=MinioTenantCommonName"
                       organizationName: "O=MyOrganizationName"
                       dnsNames:
                         - '*.minio-tenant.domain.tld'

               See the :minio-git:`Kustomize Tenant base YAML <operator/blob/master/examples/kustomization/base/tenant.yaml>` for a baseline template for guidance in creating or modifying your Tenant resource.

            3. Apply the new Kustomization template

               Once you apply the changes, the Buckit Operator automatically redeploys the Tenant with the updated configuration.

         .. tab-item:: CertManager

            The following steps apply to both new and existing Buckit Deployments using ``Kustomize``:

            1. Review the :ref:`Tenant CRD <minio-operator-crd>` ``TenantSpec.externalCertsCecret`` fields

               For existing Buckit Tenants, review the Kustomize resources used to create the Tenant and introspect that field's current configuration, if any.

            2. Create or Modify your Tenant YAML to reference the appropriate ``cert-manager`` resource.

               For example, the following Tenant YAML fragment references a cert-manager resource ``myminio-tls``:

               .. code-block:: yaml

                  apiVersion: minio.min.io/v2
                  kind: Tenant
                  metadata:
                  name: myminio
                  namespace: minio-tenant
                  spec:
                     ## Disable default tls certificates.
                     requestAutoCert: false
                     ## Use certificates generated by cert-manager.
                     externalCertSecret:
                        - name: myminio-tls
                           type: cert-manager.io/v1

            3. Apply the new Kustomization Template

               Once you apply the changes, the Buckit Operator automatically redeploys the Tenant with the updated configuration.

         .. tab-item:: User-Managed

            The following steps apply to both new and existing Buckit deployments using ``Kustomize``:

            1. Review the :ref:`Tenant CRD <minio-operator-crd>` ``TenantSpec.externalCertSecret`` field.

               For existing Buckit Tenants, review the Kustomize resources used to create the Tenant and introspect that field's current configuration, if any.

            2. Create or modify your Tenant YAML to reference a secret of type ``kubernetes.io/tls``:

               For example, the following Tenant YAML fragment references a TLS secret which covers the domain on which the Buckit Tenant accepts connections.

               .. code-block:: yaml

                  apiVersion: minio.min.io/v2
                  kind: Tenant
                  metadata:
                  name: myminio
                  namespace: minio-tenant
                  spec:
                     ## Disable default tls certificates.
                     requestAutoCert: false
                     ## Use certificates generated by cert-manager.
                     externalCertSecret:
                     - name: domain-certificate
                       type: kubernetes.io/tls

            3. Apply the new Kustomization Template

               Once you apply the changes, the Buckit Operator automatically redeploys the Tenant with the updated configuration.

   .. tab-item:: Baremetal
      :sync: baremetal

      The Buckit Server searches for TLS keys and certificates for each node and uses those credentials for enabling TLS.
      Buckit automatically enables TLS upon discovery and validation of certificates.
      The search location depends on your Buckit configuration:

      .. tab-set::

         .. tab-item:: Default Path

            By default, the Buckit server looks for the TLS keys and certificates for each node in the following directory:

            .. code-block:: shell

               ${HOME}/.minio/certs

            Where ``${HOME}`` is the home directory of the user running the Buckit Server process.
            You may need to create the ``${HOME}/.minio/certs`` directory if it does not exist.

            For ``systemd`` managed deployments this must correspond to the ``USER`` running the Buckit process.
            If that user has no home directory, use the :guilabel:`Custom Path` option instead.

         .. tab-item:: Custom Path

            You can specify a path for the Buckit server to search for certificates using the :mc-cmd:`minio server --certs-dir` or ``-S`` parameter.

            For example, the following command fragment directs the Buckit process to use the ``/opt/minio/certs`` directory for TLS certificates.

            .. code-block:: shell

               minio server --certs-dir /opt/minio/certs ...

            The user running the Buckit service *must* have read and write permissions to this directory.

      Place the TLS certificates for the default domain (e.g. ``minio.example.net``) in the ``/certs`` directory, with the private key as ``private.key`` and public certificate as ``public.crt``.

      For example:

      .. code-block:: shell

         /path/to/certs
         private.key
         public.crt

      You can use the Buckit :minio-git:`certgen <certgen>` to mint self-signed certificates for evaluating Buckit with TLS enabled.
      For example, the following command generates a self-signed certificate with a set of IP and DNS Subject Alternate Names (SANs) associated to the Buckit Server hosts:

      .. code-block:: shell

         certgen -host "localhost,minio-*.example.net"

      Place the generated ``public.crt`` and ``private.key`` into the ``/path/to/certs`` directory to enable TLS for the Buckit deployment.
      Applications can use the ``public.crt`` as a trusted Certificate Authority to allow connections to the Buckit deployment without disabling certificate validation.

      If you are reconfiguring an existing deployment that did not previously have TLS enabled, update :envvar:`MINIO_VOLUMES` to specify ``https`` instead of ``http``.
      You may also need to update URLs used by applications or clients.