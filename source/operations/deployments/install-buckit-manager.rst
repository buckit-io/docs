.. _install-buckit-manager:

=========================
Install the Buckit Manager
=========================

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
or ``%LOCALAPPDATA%\Programs\bm`` on Windows. Set ``BM_INSTALL_DIR`` to use a
different install directory.

Verify the Installation
-----------------------

Run the following command to verify that ``bm`` is installed:

.. code-block:: shell
   :class: copyable

   bm --version

Start the Web Interface
-----------------------

Run the following command on the system where you installed ``bm``:

.. code-block:: shell
   :class: copyable

   bm web

By default, ``bm web`` starts the application on ``http://127.0.0.1:9443/`` and
opens your default browser automatically.

Next Step
---------

Continue with :ref:`Guided Deployment using Buckit Manager
<deploy-buckit-guided-bm>` to deploy a new Buckit cluster.
