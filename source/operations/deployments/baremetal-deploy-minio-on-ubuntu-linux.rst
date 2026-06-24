.. _deploy-minio-ubuntu:

=============================
Deploy Buckit on Ubuntu Linux
=============================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

This page documents deploying Buckit on Ubuntu Linux operating systems.

Buckit officially supports Ubuntu Long Term Support (LTS) releases in the **Standard** or **Ubuntu Pro** support phases of the Ubuntu life cycle.
Buckit strongly recommends only those releases that include the Linux 5.X kernel and above for best performance.
At the time of writing, that includes:

- Ubuntu 24.04+ LTS (Noble Numbat) (**Recommended**)
- Ubuntu 22.04+ LTS (Jammy Jellyfish)
- Ubuntu 20.04+ LTS (Focal Fossa)
- Ubuntu 18.04.5 LTS (Bionic Beaver) (**Ubuntu Pro Only**)

The above list assumes your organization has the necessary service contracts with Ubuntu to ensure end-to-end supportability throughout the release's lifespan.

Buckit *may* run on versions of Ubuntu that use older kernels, are out of support, or are in legacy support phases, with limited support or troubleshooting from either Buckit or Ubuntu.

The procedure focuses on production-grade Multi-Node Multi-Drive (MNMD) "Distributed" configurations.
|MNMD| deployments provide enterprise-grade performance, availability, and scalability and are the recommended topology for all production workloads.

The procedure includes guidance for deploying Single-Node Multi-Drive (SNMD) and Single-Node Single-Drive (SNSD) topologies in support of early development and evaluation environments.

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

Capacity-Based Planning
~~~~~~~~~~~~~~~~~~~~~~~

Buckit recommends planning storage capacity sufficient to store **at least** 2 years of data before reaching 70% usage.
Performing :ref:`server pool expansion <expand-minio-distributed>` more frequently or on a "just-in-time" basis generally indicates an architecture or planning issue.

For example, consider an application suite expected to produce at least 100 TiB of data per year and a 3 year target before expansion.
By ensuring the deployment has ~500TiB of usable storage up front, the cluster can safely meet the 70% threshold with additional buffer for growth in data storage output per year.

Consider using the `Erasure Code Calculator <../../_static/ec-calculator.html>`__ for guidance in planning capacity around specific erasure code settings.

Procedure
---------

1. Download and install the Buckit DEB
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the following commands to download, verify, and install the Buckit DEB
for your Linux host.

.. code-block:: shell
   :class: copyable

   curl -fsSL https://buckit-io.github.io/buckit/install-linux.sh | sh
   sudo apt install ./buckit.deb

2. Review the systemd Service File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The DEB installs the Buckit binary at ``/usr/local/bin/buckit`` and the
following `systemd <https://www.freedesktop.org/wiki/Software/systemd/>`__
service file at ``/lib/systemd/system/buckit.service``:
    
.. code-block:: shell
   :class: copyable

   [Unit]
   Description=Buckit Object Storage
   Documentation=https://github.com/buckit-io/buckit
   Wants=network-online.target
   After=network-online.target
   AssertFileIsExecutable=/usr/local/bin/buckit

   [Service]
   Type=notify

   WorkingDirectory=/usr/local

   User=buckit
   Group=buckit
   ProtectProc=invisible

   EnvironmentFile=-/etc/default/minio
   ExecStart=/usr/local/bin/buckit server $MINIO_OPTS $MINIO_VOLUMES

   # Let systemd restart this service always
   Restart=always

   # Specifies the maximum file descriptor number that can be opened by this process
   LimitNOFILE=1048576

   # Turn-off memory accounting by systemd, which is buggy.
   MemoryAccounting=no

   # Specifies the maximum number of threads this process can create
   TasksMax=infinity

   # Disable timeout logic and wait until process is stopped
   TimeoutSec=infinity
   OOMScoreAdjust=-1000
   SendSIGKILL=no

   [Install]
   WantedBy=multi-user.target

3. Review the Buckit Service Account
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The package post-install script automatically creates the ``buckit`` system
user and group if they do not already exist.

You **must** ``chown`` the drive paths you intend to use with Buckit so the
``buckit`` user can access them.

For example, the following command sets ``buckit:buckit`` as the user-group
owner of all drives at ``/mnt/drives-n`` where ``n`` is between 1 and 16
inclusive:

.. code-block:: shell
   :class: copyable

   chown -R buckit:buckit /mnt/drives-{1...16}

4. Enable TLS Connectivity
~~~~~~~~~~~~~~~~~~~~~~~~~~

Create or provide :ref:`Transport Layer Security (TLS) <minio-tls>` certificates to Buckit to automatically enable HTTPS-secured connections between the server and clients.

Place the certificates in a directory accessible by the ``buckit`` user/group:

.. code-block:: shell
   :class: copyable

   mkdir -p /opt/buckit/certs
   chown -R buckit:buckit /opt/buckit/certs

   cp private.key /opt/buckit/certs
   cp public.crt /opt/buckit/certs

For local testing or development environments, you can use the Buckit :minio-git:`certgen <certgen>` to mint self-signed certificates.
For example, the following command generates a self-signed certificate with a set of IP and DNS Subject Alternate Names (SANs) associated to the Buckit Server hosts:

.. code-block:: shell

   certgen -host "localhost,buckit-*.example.net"

Place the generated ``public.crt`` and ``private.key`` into the ``/path/to/certs`` directory to enable TLS for the Buckit deployment.
Applications can use the ``public.crt`` as a trusted Certificate Authority to allow connections to the Buckit deployment without disabling certificate validation.

When Buckit runs with TLS enabled, it also verifies connecting client certificates against the OS list of trusted Certificate Authorities.
To enable verification of third-party or internally-signed certificates, place the CA file in the ``/opt/buckit/certs/CAs`` folder.
The CA file should include the full chain of trust from leaf to root to ensure successful verification.

For more specific guidance on configuring Buckit for TLS, including multi-domain support via Server Name Indication (SNI), see :ref:`minio-tls`. 
You can optionally skip this step to deploy without TLS enabled. Buckit strongly recommends *against* non-TLS deployments outside of early development.

5. Create the Buckit Environment File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create an environment file at ``/etc/default/minio``. 
The Buckit service uses this file as the source of all :ref:`environment variables <minio-server-environment-variables>` used by Buckit and by ``buckit.service``.

Modify the example to reflect your deployment topology. 

.. tab-set::

   .. tab-item:: Multi-Node Multi-Drive

      Use Multi-Node Multi-Drive ("Distributed") deployment topologies in production environments.

      .. code-block:: shell
         :class: copyable

         # Set the hosts and volumes Buckit uses at startup
         # The command uses Buckit expansion notation {x...y} to denote a
         # sequential series. 
         #
         # The following example covers four Buckit hosts
         # with 4 drives each at the specified hostname and drive locations.
         #
         # The command includes the port that each Buckit server listens on
         # (default 9000).
         # If you run without TLS, change https -> http

         MINIO_VOLUMES="https://buckit{1...4}.example.net:9000/mnt/disk{1...4}/buckit"

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

      .. important::

         SNSD deployments do not support storage expansion through adding new server pools.

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

For distributed deployments, all nodes **must** have matching ``/etc/default/minio`` environment files.
Use a utility such as ``shasum -a 256 /etc/default/minio`` on each node to verify an exact match across all nodes.

6. Start the Buckit Deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Enable and start the Buckit service on each node:

.. code-block:: shell
   :class: copyable

   sudo systemctl enable --now buckit

Check service status and startup logs:

.. code-block:: shell
   :class: copyable

   sudo systemctl status buckit
   sudo journalctl -u buckit -f

You may see increased log churn as the cluster starts up and synchronizes. 

Common reasons for startup failure include:

- The Buckit process does not have read-write-list access to the specified drives
- The drives are not empty or contain non-Buckit data
- The drives are not formatted or mounted properly
- One or more hosts are not reachable over the network

Following our checklists typically mitigates the risk of encountering those or similar issues.

7. Connect to the Deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. tab-set::

   .. tab-item:: Console

      Open your browser and access any of the Buckit hostnames at port ``:9001`` to open the :ref:`Buckit Console <minio-console>` login page. 
      For example, ``https://buckit1.example.com:9001``.

      Log in with the :guilabel:`MINIO_ROOT_USER` and :guilabel:`MINIO_ROOT_PASSWORD`
      from the previous step.

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
