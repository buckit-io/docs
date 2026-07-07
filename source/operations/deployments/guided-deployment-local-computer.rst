.. _deploy-buckit-guided-bm-local:

================================
Deploy Buckit on Local Computer
================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

Use this workflow to prepare a local, single-node Buckit deployment on the
same macOS or Windows computer where you run Buckit Manager.

This workflow is useful for development, testing, demos, and learning Buckit.
It does not install Buckit as a background system service. Buckit Manager
downloads and creates the local files and prints a command you run in a
terminal to start the server.

Prerequisites
-------------

Prepare the following before you begin:

- A macOS or Windows computer with Buckit Manager installed.
- One or more local filesystem paths for Buckit object data.
- Optional TLS certificate and private key if you want the local server to use
  HTTPS.

Start the Local Deployment Wizard
---------------------------------

1. Start the Buckit Manager web interface:

   .. code-block:: shell
      :class: copyable

      bm web

2. Open :guilabel:`Deploy a new cluster`.
3. Select :guilabel:`This computer only`.

Settings
--------

Configure the local Buckit server settings:

- Buckit version: the Buckit release to download.
- Root user and root password: the credentials used to sign in to the Buckit
  server.
- API port: the S3 API port used by applications and tools.
- Console port: the Buckit Console port.
- TLS: optionally provide a certificate and private key.

If you enable TLS, the certificate should include every hostname or IP address
you will use to connect to the local Buckit server, such as ``localhost``,
``127.0.0.1``, or your computer's DNS name.

Storage
-------

Input one or more local filesystem paths for storing object data.

You can enter one path per row, or use a numeric expansion pattern.

.. tab-set::

   .. tab-item:: macOS

      Example:

      .. code-block:: shell
         :class: copyable

         /Volumes/data/buckit/data{1...4}

   .. tab-item:: Windows

      Example:

      .. code-block:: powershell
         :class: copyable

         D:\buckit\data{1...4}

For a single data path, Buckit runs as a standalone single-node deployment.

For multiple data paths, Buckit uses erasure coding on the local paths. The
wizard shows the erasure set size and lets you choose the parity value. Higher
parity reserves more paths for recovery and leaves less usable capacity.

If one or more data paths are on the root or operating-system drive, Buckit
Manager shows a warning. Using root drives is acceptable for development or
testing, but it is not recommended for production deployments.

Review and Prepare
------------------

On the review step, Buckit Manager shows the local deployment plan and any
warnings you should review before continuing.

Select :guilabel:`Prepare deploy` to create the local deployment files.

Buckit Manager downloads the Buckit binary, verifies the checksum, creates the
local data directories, writes TLS files if configured, and creates the start
script. It does not start the Buckit server.

Start Buckit
------------

After preparation finishes, Buckit Manager shows a command similar to one of
the following:

.. tab-set::

   .. tab-item:: macOS

      .. code-block:: shell
         :class: copyable

         ~/buckit/local/start-buckit.sh

   .. tab-item:: Windows PowerShell

      .. code-block:: powershell
         :class: copyable

         powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\buckit\local\Start-Buckit.ps1"

Run the command in a terminal. The Buckit server runs in that terminal session.
Stop it with ``Ctrl+C``.

Import into Buckit Manager
--------------------------

After the Buckit server starts successfully, use the import link shown on the
Ready page to import the local deployment into Buckit Manager for easy
monitoring and management.

After import, Buckit Manager opens the Cluster Details page, where you can
manage the deployment.
