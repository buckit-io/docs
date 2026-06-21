.. _minio-tls:
.. _minio-TLS-third-party-ca:
.. _minio-tls-user-generated:

========================
Network Encryption (TLS)
========================

.. default-domain:: minio

.. note::

   If you deploy a new cluster using :ref:`Guided Deployment using Buckit Manager <deploy-buckit-guided-bm>`,
   the deployment wizard configures TLS as part of the cluster setup.

.. contents:: Table of Contents
   :local:
   :depth: 2

.. admonition:: SSL is Deprecated
   :class: note

   TLS is the successor to Secure Socket Layer (SSL) encryption.
   SSL is fully `deprecated <https://tools.ietf.org/html/rfc7568>`__ as of June 30th, 2018.

Overview
--------

Buckit supports Transport Layer Security (TLS) 1.2+ encryption of incoming and outgoing traffic. 
Buckit can automatically detect certificates specified to either a default or custom search path and enable TLS for all connections.
Buckit supports Server Name Indication (SNI) requests from clients, where Buckit attempts to locate the appropriate TLS certificate for the hostname specified by the client.

.. todo: add an image

Buckit requires *at minimum* a single default TLS certificate and can support multiple TLS certificates in support of SNI connectivity.
Buckit uses the TLS Subject Alternate Name (SAN) list to determine which certificate to return to the client.
If Buckit cannot find a TLS certificate whose SAN covers the client-requested hostname, Buckit uses the default certificate and attempts to establish the handshake.

You can specify a single TLS certificate which covers all possible SANs for which the Buckit deployment accepts connections.

This configuration requires the least configuration, but necessarily exposes all hostnames configured in the TLS SAN to connecting clients.
Depending on your TLS configuration, this may include internal or private SAN domains.

You can instead specify multiple TLS certificates separated by domain(s) with a single default certificate for any non-matching hostname requests.
This configuration requires more configuration, but only exposes those hostnames configured in the returned TLS SAN array.

.. _minio-tls-baremetal:

TLS for Buckit
--------------

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

      You can specify a path for the Buckit server to search for certificates using ``buckit server --certs-dir`` or ``-S``.

      For example, the following command fragment directs the Buckit process to use the ``/opt/buckit/certs`` directory for TLS certificates.

      .. code-block:: shell

         buckit server --certs-dir /opt/buckit/certs ...

      The user running the Buckit service *must* have read and write permissions to this directory.

Place the TLS certificates for the default domain (e.g. ``buckit.example.net``) in the ``/certs`` directory, with the private key as ``private.key`` and public certificate as ``public.crt``.

For distributed Buckit deployments, each node in the deployment must have matching TLS certificate configurations.

Self-signed, Internal, Private Certificates, and Public CAs with Intermediate Certificates
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If using Certificates signed by a non-global or non-public Certificate Authority, *or* if using a global CA that requires the use of intermediate certificates, you must provide those CAs to the Buckit Server.
If the Buckit server does not have the necessary CAs, it may return warnings or errors related to TLS validation when connecting to other services.

Place the CA certificates in the ``/certs/CAs`` folder.
The root path for this folder depends on whether you use the default certificate path *or* a custom certificate path (``buckit server --certs-dir`` or ``-S``)

.. tab-set::

   .. tab-item:: Default Certificate Path

      .. code-block:: shell

         mv myCA.crt ${HOME}/.minio/certs/CAs

   .. tab-item:: Custom Certificate Path

      The following example assumes the Buckit Server was started with ``--certs dir /opt/buckit/certs``:

      .. code-block:: shell

         mv myCA.crt /opt/buckit/certs/CAs/

For a self-signed certificate, the Certificate Authority is typically the private key used to sign the cert.

For certificates signed by an internal, private, or other non-global Certificate Authority, use the same CA that signed the cert.
A non-global CA must include the full chain of trust from the intermediate certificate to the root.

If the provided file is not an X.509 certificate, Buckit ignores it and may return errors for validating certificates signed by that CA.

Third-Party Certificate Authorities
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Buckit Server validates the TLS certificate presented by each connecting client against the host system's trusted root certificate store.

Place the CA certificates in the ``/certs/CAs`` folder.
The root path for this folder depends on whether you use the default certificate path *or* a custom certificate path (``buckit server --certs-dir`` or ``-S``)

.. tab-set::

   .. tab-item:: Default Certificate Path

      .. code-block:: shell

         mv myCA.crt ${HOME}/.minio/certs/CAs

   .. tab-item:: Custom Certificate Path

      The following example assumes the Buckit Server was started with ``--certs dir /opt/buckit/certs``:

      .. code-block:: shell

         mv myCA.crt /opt/buckit/certs/CAs/

Place the certificate file for each CA into the ``/CAs`` subdirectory.
Ensure all hosts in the Buckit deployment have a consistent set of trusted CAs in that directory.
If the Buckit Server cannot match an incoming client's TLS certificate issuer against any of the available CAs, the server rejects the connection as invalid.

.. _minio-TLS-supported-cipher-suites:

Supported TLS Cipher Suites
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit recommends generating ECDSA (e.g. `NIST P-256 curve <https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.186-4.pdf>`__) or EdDSA (e.g. :rfc:`Curve25519 <7748>`) TLS private keys/certificates due to their lower computation requirements compared to RSA.

Buckit supports the following TLS 1.2 and 1.3 cipher suites as supported by `Go <https://cs.opensource.google/go/go/+/refs/tags/go1.17.1:src/crypto/tls/cipher_suites.go;l=52>`__. The lists mark recommended algorithms with a :octicon:`star-fill` icon:

.. tab-set::

   .. tab-item:: TLS 1.3

      - ``TLS_CHACHA20_POLY1305_SHA256`` :octicon:`star-fill`
      - ``TLS_AES_128_GCM_SHA256``
      - ``TLS_AES_256_GCM_SHA384``

   .. tab-item:: TLS 1.2

      - ``TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305`` :octicon:`star-fill`
      - ``TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256`` :octicon:`star-fill`
      - ``TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384`` :octicon:`star-fill`
      - ``TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305``
      - ``TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256``
      - ``TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384``

.. toctree::
   :hidden:

   /operations/network-encryption/enable-minio-tls
   /operations/network-encryption/enable-multiple-domain-minio-tls
