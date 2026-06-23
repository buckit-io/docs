.. _deploy-minio-macos:

======================
Deploy Buckit on macOS
======================

.. default-domain:: minio

This page documents deploying Buckit onto Apple macOS hosts.

Buckit officially supports macOS operating systems in service status, which is typically 3 years from initial release.
At the time of writing, that includes:

- macOS 14 (Sonoma) (**Recommended**)
- macOS 13 (Ventura)
- macOS 12 (Monterey) 

Buckit *may* run on older or out-of-support macOS releases, with limited support or troubleshooting from either Buckit or Apple.

Buckit currently publishes macOS binaries for Apple Silicon only.

The procedure includes guidance for deploying Single-Node Multi-Drive (SNMD) and Single-Node Single-Drive (SNSD) topologies in support of early development and evaluation environments.

Buckit does not officially support Multi-Node Multi-Drive (MNMD) "Distributed" configurations on macOS hosts.

Considerations
--------------

Review Checklists
~~~~~~~~~~~~~~~~~

Ensure you have reviewed our published Hardware, Software, and Security checklists before attempting this procedure.

Erasure Coding Parity
~~~~~~~~~~~~~~~~~~~~~

Buckit automatically determines the default :ref:`erasure coding <minio-erasure-coding>` configuration for the cluster based on the total number of nodes and drives in the topology.
You can configure the per-object :term:`parity` setting when you set up the cluster *or* let Buckit select the default (``EC:4`` for production-grade clusters).

Parity controls the relationship between object availability and storage on disk. 
Use the `Erasure Code Calculator <../../_static/ec-calculator.html>`__ for guidance in selecting the appropriate erasure code parity level for your cluster.

While you can change erasure parity settings at any time, objects written with a given parity do **not** automatically update to the new parity settings.

Procedure
---------

1. Download the Buckit Binary
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the following commands to download, verify, and install the latest stable
Buckit binary for macOS:

.. code-block:: shell
   :class: copyable

   curl -fsSL https://buckit-io.github.io/buckit/install-mac.sh | sh
   chmod +x ./buckit
   sudo mv ./buckit /usr/local/bin/

2. Enable TLS Connectivity
~~~~~~~~~~~~~~~~~~~~~~~~~~

You can skip this step to deploy without TLS enabled. 
Buckit strongly recommends *against* non-TLS deployments outside of early development.

Create or provide :ref:`Transport Layer Security (TLS) <minio-tls>` certificates to Buckit to automatically enable HTTPS-secured connections between the server and clients.

Place the certificates in a dedicated directory:

.. code-block:: shell
   :class: copyable

   mkdir -p /opt/buckit/certs

   cp private.key /opt/buckit/certs
   cp public.crt /opt/buckit/certs


Buckit verifies client certificates against the OS list of trusted Certificate Authorities.
To enable verification of third-party or internally-signed certificates, place the CA file in the ``/opt/buckit/certs/CAs`` folder.
The CA file should include the full chain of trust from leaf to root to ensure successful verification.

For more specific guidance on configuring Buckit for TLS, including multi-domain support via Server Name Indication (SNI), see :ref:`minio-tls`. 

.. dropdown:: Certificates for Early Development

   For local testing or development environments, you can use the Buckit :minio-git:`certgen <certgen>` to mint self-signed certificates.
   For example, the following command generates a self-signed certificate with a set of IP and DNS Subject Alternate Names (SANs) associated to the Buckit Server hosts:

   .. code-block:: shell

      certgen -host "localhost,buckit-*.example.net"

   Place the generated ``public.crt`` and ``private.key`` into the ``/path/to/certs`` directory to enable TLS for the Buckit deployment.
   Applications can use the ``public.crt`` as a trusted Certificate Authority to allow connections to the Buckit deployment without disabling certificate validation.

3. Create the Buckit Environment File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create an environment file at ``/etc/default/minio``. 
The Buckit server uses this file as the source of all :ref:`environment variables <minio-server-environment-variables>` used by Buckit.

Modify the example to reflect your deployment topology. 

.. tab-set::

   .. tab-item:: Single-Node Multi-Drive

      Use Single-Node Multi-Drive deployments in development and evaluation environments.
      You can also use them for smaller storage workloads which can tolerate data loss or unavailability due to node downtime.

      .. code-block:: shell
         :class: copyable

         # Set the volumes Buckit uses at startup
         # The command uses Buckit expansion notation {x...y} to denote a
         # sequential series. 
         #
         # The following specifies a single host with 4 drives at the specified location
         #
         # The command includes the port that the Buckit server listens on
         # (default 9000).
         # If you run without TLS, change https -> http

         MINIO_VOLUMES="https://buckit1.example.net:9000/mnt/drive{1...4}/buckit"

         # Set all Buckit server command-line options
         #
         # The following explicitly sets the Buckit Console listen address to
         # port 9001 on all network interfaces. 
         # The default behavior is dynamic port selection.

         MINIO_OPTS="--console-address :9001 --certs-dir /opt/buckit/certs"

         # Set the root username. 
         # This user has unrestricted permissions to perform S3 and 
         # administrative API operations on any resource in the deployment.
         #
         # Defer to your organizations requirements for superadmin user name.

         MINIO_ROOT_USER=buckitadmin

         # Set the root password
         #
         # Use a long, random, unique string that meets your organizations
         # requirements for passwords.

         MINIO_ROOT_PASSWORD=buckit-secret-key-CHANGE-ME

   .. tab-item:: Single-Node Single-Drive

      Use Single-Node Single-Drive ("Standalone") deployments in early development and evaluation environments.
      Buckit does not recommend Standalone deployments in production, as the loss of the node or its storage medium results in data loss.

      .. code-block:: shell
         :class: copyable

         # Set the volume Buckit uses at startup
         #
         # The following specifies the drive or folder path

         MINIO_VOLUMES="/mnt/drive1/buckit"

         # Set all Buckit server command-line options
         #
         # The following explicitly sets the Buckit Console listen address to
         # port 9001 on all network interfaces. 
         # The default behavior is dynamic port selection.

         MINIO_OPTS="--console-address :9001 --certs-dir /opt/buckit/certs"

         # Set the root username. 
         # This user has unrestricted permissions to perform S3 and 
         # administrative API operations on any resource in the deployment.
         #
         # Defer to your organizations requirements for superadmin user name.

         MINIO_ROOT_USER=buckitadmin

         # Set the root password
         #
         # Use a long, random, unique string that meets your organizations
         # requirements for passwords.

         MINIO_ROOT_PASSWORD=buckit-secret-key-CHANGE-ME

Specify any other :ref:`environment variables <minio-server-environment-variables>` or server command-line options as required by your deployment. 

4. Start the Buckit Server
~~~~~~~~~~~~~~~~~~~~~~~~~~

The following command starts the Buckit Server attached to the current terminal/shell window:

.. code-block:: shell
   :class: copyable

   . /etc/default/minio
   ./buckit server $MINIO_OPTS $MINIO_VOLUMES

The command output resembles the following:

.. code-block:: shell

   INFO: Formatting 1st pool, 1 set(s), 1 drives per set.
   Buckit Object Storage Server
   License: GNU AGPLv3 - https://www.gnu.org/licenses/agpl-3.0.html
   Version: RELEASE.2026-06-18T00-00-00Z (go1.26.2 darwin/arm64)

   API: https://buckit1.example.net:9000 https://203.0.113.10:9000 https://127.0.0.1:9000
   WebUI: https://buckit1.example.net:9001 https://203.0.113.10:9001 https://127.0.0.1:9001
   Docs: https://buckit-io.github.io/docs

The ``API`` block lists the network interfaces and port on which clients can access the Buckit S3 API.
The ``WebUI`` block lists the network interfaces and port on which clients can access the Buckit Web Console.

To run the :mc:`buckit server <buckit server>` process in the background or as a daemon, defer to your macOS documentation for best practices and procedures.

5. Connect to the Deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. tab-set::

   .. tab-item:: Console

      Open your browser and access any of the Buckit hostnames at port ``:9001`` to open the :ref:`Buckit Console <minio-console>` login page. 
      For example, ``https://buckit1.example.com:9001``.

      Log in with the :guilabel:`MINIO_ROOT_USER` and :guilabel:`MINIO_ROOT_PASSWORD`
      values from your environment file.

      .. image:: /images/minio-console/console-login.png
         :width: 600px
         :alt: Buckit Console Login Page
         :align: center

      You can use the Buckit Console for general administration tasks like Identity and Access Management, Metrics and Log Monitoring, or Server Configuration. 
      Each Buckit server includes its own embedded Buckit Console.

   .. tab-item:: CLI

      Install ``bm`` on your local host.
      Run ``bm --version`` to verify the installation.

      Once installed, create an alias for the Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm alias set mybuckit https://buckit1.example.net:9000 USERNAME PASSWORD

      If your Buckit deployment uses third-party or self-signed TLS certificates,
      ``bm`` may prompt you to trust the certificate when run in an interactive
      terminal.

      For non-interactive use, or to bypass certificate verification
      temporarily, use ``--insecure``:

      .. code-block:: shell
         :class: copyable

         bm --insecure alias set mybuckit https://buckit1.example.net:9000 USERNAME PASSWORD

      Change the hostname, username, and password to reflect your deployment.
      The hostname can be any Buckit node in the deployment.
      You can also specify the hostname load balancer, reverse proxy, or similar network control plane that handles connections to the deployment.
