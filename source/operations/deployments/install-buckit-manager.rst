.. _install-buckit-manager:

==========================
Install the Buckit Manager
==========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

Buckit Manager (``bm``) is the operational client for Buckit deployments. It
is a single binary that includes a web UI and a command line (CLI).

With the web UI or CLI, Buckit Manager can:

- deploy a new Buckit cluster on Linux servers
- import an existing Buckit or MinIO cluster
- migrate an imported MinIO cluster to Buckit
- run cluster and node operations such as restart, stop, start, heal,
  upgrade, root password rotation, replacement node provisioning, and log
  viewing
- run Buckit CLI commands for server administration and object storage tasks

Install Buckit Manager
----------------------

Install ``bm`` on the system you will use to manage the deployment.

``bm`` is installed as a per-user binary. It does not require ``sudo`` or a
system-wide installation.

.. tab-set::

   .. tab-item:: macOS / Linux

      .. code-block:: shell
         :class: copyable

         curl -fsSL https://buckit-io.github.io/bm/install.sh | sh

   .. tab-item:: Windows PowerShell

      .. code-block:: powershell
         :class: copyable

         irm https://buckit-io.github.io/bm/install.ps1 | iex

The installer downloads the latest stable build for your operating system and
architecture, verifies its SHA-256 checksum, and installs it into your user
account.

By default, the installer places ``bm`` in ``~/.local/bin`` on macOS and Linux,
or ``%LOCALAPPDATA%\Programs\bm`` on Windows.

Verify the Installation
-----------------------

Run the following command to verify that ``bm`` is installed:

.. code-block:: shell
   :class: copyable

   bm --version

For command syntax and examples, see :doc:`/reference/bm-cli`.

Start the Web Interface
-----------------------

Run the following command on the system where you installed ``bm``:

.. code-block:: shell
   :class: copyable

   bm web

By default, ``bm web`` starts the application on ``http://127.0.0.1:9443/`` and
opens your default browser automatically.

Use the CLI with a Buckit Deployment
------------------------------------

After installing ``bm``, you can use the CLI to connect to a Buckit deployment.

1. Create an alias for the deployment:

   .. code-block:: shell
      :class: copyable

      bm alias set mybuckit https://buckit1.example.net:9000 ACCESS_KEY SECRET_KEY

   Replace the hostname, access key, and secret key to match your deployment.
   The hostname can be any Buckit node in the deployment, or a load balancer or
   reverse proxy in front of the deployment.

2. Check the deployment with ``bm admin info``:

   .. code-block:: shell
      :class: copyable

      bm admin info mybuckit

If your deployment uses a third-party or self-signed TLS certificate, ``bm``
may prompt you to trust the certificate when run in an interactive terminal.
For non-interactive use, or to bypass certificate verification temporarily, use
``--insecure``.

See :doc:`/reference/bm-cli` for more alias and object-storage commands, and
:doc:`/reference/bm-admin` for more administration commands.
