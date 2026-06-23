=====================
Enable TLS for Buckit
=====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

Buckit supports Transport Layer Security (TLS) 1.2+ encryption of incoming and outgoing traffic.

Buckit automatically detects TLS certificates in the configured or default directory and starts with TLS enabled.

This procedure documents enabling TLS for a single domain in Buckit.
For instructions on TLS for multiple domains, see TODO

Prerequisites
-------------

Access to Buckit Cluster
~~~~~~~~~~~~~~~~~~~~~~~~

This procedure uses :mc:`bm` for performing operations on the Buckit cluster. 
Install ``bm`` on a machine with network access to the cluster.
See the ``bm`` :ref:`Installation Quickstart <mc-install>` for instructions on downloading and installing ``bm``.

This procedure assumes a configured :mc:`alias <bm alias>` for the Buckit cluster. 

This procedure also assumes SSH or similar shell-level access with administrative permissions to each Buckit host server.

TLS Certificates
~~~~~~~~~~~~~~~~

Provision the necessary TLS certificates with a :ref:`supported cipher suite <minio-TLS-supported-cipher-suites>` for use by Buckit.

Provision certificate susing your preferred path, such as through your organizations internal Certificate Authority or by using a well-known global provider such as Digicert or Verisign.

You can create self-signed certificates using ``openssl`` or the Buckit :minio-git:`certgen <certgen>` tool.

For example, the following command generates a self-signed certificate with a set of IP and DNS Subject Alternate Names (SANs) associated to the Buckit Server hosts:

.. code-block:: shell

   certgen -host "localhost,buckit-*.example.net"

See :ref:`minio-tls-baremetal` for more complete guidance on certificate generation and placement.


Procedure
---------

The Buckit Server searches for TLS keys and certificates for each node and uses those credentials for enabling TLS.
Buckit automatically enables TLS upon discovery and validation of certificates.
You can specify the path for the Buckit server to search for certificates using
``buckit server --certs-dir`` or ``-S``.

For example, the following command fragment directs the Buckit process to use
the ``/opt/buckit/certs`` directory for TLS certificates.

.. code-block:: shell

   buckit server --certs-dir /opt/buckit/certs ...

For systemd-managed deployments, modify ``MINIO_OPTS`` in
``/etc/default/minio`` to include the ``--certs-dir`` option.

The user running the Buckit service *must* have read and write permissions to
this directory.

Place the TLS certificates for the default domain (e.g. ``buckit.example.net``) in the ``/certs`` directory, with the private key as ``private.key`` and public certificate as ``public.crt``.

For example:

.. code-block:: shell

   /path/to/certs
   private.key
   public.crt

You can use the Buckit :minio-git:`certgen <certgen>` to mint self-signed certificates for evaluating Buckit with TLS enabled.
For example, the following command generates a self-signed certificate with a set of IP and DNS Subject Alternate Names (SANs) associated to the Buckit Server hosts:

.. code-block:: shell

   certgen -host "localhost,buckit-*.example.net"

Place the generated ``public.crt`` and ``private.key`` into the ``/path/to/certs`` directory to enable TLS for the Buckit deployment.
Applications can use the ``public.crt`` as a trusted Certificate Authority to allow connections to the Buckit deployment without disabling certificate validation.

If you are reconfiguring an existing deployment that did not previously have TLS enabled, update :envvar:`MINIO_VOLUMES` to specify ``https`` instead of ``http``.
You may also need to update URLs used by applications or clients.
