=====================================
Enable Multiple Domain TLS for Buckit
=====================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

Buckit supports Transport Layer Security (TLS) 1.2+ encryption of incoming and outgoing traffic.

Buckit automatically detects TLS certificates in the configured or default directory and starts with TLS enabled.

The Buckit server supports multiple TLS certificates, where the server uses `Server Name Indication (SNI) <https://en.wikipedia.org/wiki/Server_Name_Indication>`__ to identify which certificate to use when responding to a client request.
When a client connects using a specific hostname, Buckit uses :abbr:`SNI (Server Name Indication)` to select the appropriate TLS certificate for that hostname.

This procedure documents enabling TLS for multiple domains in Buckit.
For instructions on TLS for single domains, see TODO

Prerequisites
-------------

Access to Buckit Cluster
~~~~~~~~~~~~~~~~~~~~~~~~

This procedure uses :mc:`mc` for performing operations on the Buckit cluster. 
Install ``mc`` on a machine with network access to the cluster.
See the ``mc`` :ref:`Installation Quickstart <mc-install>` for instructions on downloading and installing ``mc``.

This procedure assumes a configured :mc:`alias <mc alias>` for the Buckit cluster. 

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
The search location depends on your Buckit configuration:

.. tab-set::

   .. tab-item:: Default Path
      :sync: baremetal-default

      By default, the Buckit server looks for the TLS keys and certificates for each node in the following directory:

      .. code-block:: shell

         ${HOME}/.minio/certs

      Where ``${HOME}`` is the home directory of the user running the Buckit Server process.
      You may need to create the ``${HOME}/.minio/certs`` directory if it does not exist.

      For ``systemd`` managed deployments this must correspond to the ``USER`` running the Buckit process.
      If that user has no home directory, use the :guilabel:`Custom Path` option instead.

   .. tab-item:: Custom Path
      :sync: baremetal-custom

      You can specify a path for the Buckit server to search for certificates using ``buckit server --certs-dir`` or ``-S``.

      For example, the following command fragment directs the Buckit process to use the ``/opt/buckit/certs`` directory for TLS certificates.

      .. code-block:: shell

         buckit server --certs-dir /opt/buckit/certs ...

      The user running the Buckit service *must* have read and write permissions to this directory.

Place the certificates in the ``/certs`` folder, creating a subfolder in ``/certs`` for each additional domain for which Buckit should present TLS certificates.
While Buckit has no requirements for folder names, consider creating subfolders whose name matches the domain to improve human readability. 
Place the TLS private and public key for that domain in the subfolder.

.. code-block:: shell

   /path/to/certs
      private.key
      public.crt
      s3-example.net/
         private.key
         public.crt
      internal-example.net/
         private.key
         public.crt
