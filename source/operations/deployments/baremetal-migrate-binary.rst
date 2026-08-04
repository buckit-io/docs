.. _migrate-minio-binary:

==============================
Migrate a Manually Run Binary
==============================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

Overview
--------

Use this procedure when MinIO runs from a shell command, a script, or a process supervisor other than systemd, such as ``supervisord`` or ``runit``.

Review the :ref:`shared considerations <migrate-minio-to-buckit>` before starting.

Procedure
---------

1. Stop MinIO
~~~~~~~~~~~~~

Stop the running MinIO process using whatever mechanism starts it.
For distributed deployments, stop the process on every node before starting Buckit anywhere.

2. Download the Buckit Binary
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following command downloads the ``buckit`` binary for this host into the current directory.

.. tab-set::

   .. tab-item:: Linux

      .. code-block:: shell
         :class: copyable

         curl -fsSL https://buckit-io.github.io/buckit/install-linux-binary.sh | sh

   .. tab-item:: macOS

      .. code-block:: shell
         :class: copyable

         curl -fsSL https://buckit-io.github.io/buckit/install-mac.sh | sh

      Only Apple Silicon is supported.

   .. tab-item:: Windows PowerShell

      .. code-block:: powershell
         :class: copyable

         irm https://buckit-io.github.io/buckit/install-windows.ps1 | iex

You can also download the binary directly from the `Buckit releases page <https://github.com/buckit-io/buckit/releases/latest>`__, picking the asset matching the host, for example ``buckit-linux-amd64.RELEASE.<tag>`` for 64-bit Linux.

Move the binary to the directory holding the existing ``minio`` binary:

.. tab-set::

   .. tab-item:: Linux / macOS

      .. code-block:: shell
         :class: copyable

         sudo mv buckit MINIO_DIR/buckit

      Replace ``MINIO_DIR`` with the current ``minio`` binary directory, for example ``/usr/local/bin``.

   .. tab-item:: Windows PowerShell

      .. code-block:: powershell
         :class: copyable

         Move-Item -Force buckit.exe MINIO_DIR\buckit.exe

      Replace ``MINIO_DIR`` with the current ``minio.exe`` directory.

3. Start Buckit With the Same Arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Start Buckit with the same command that started MinIO, replacing ``minio`` with ``buckit``.
Every flag and environment variable carries over unchanged.

For example, a deployment started with this command:

.. code-block:: shell

   minio server /data --console-address ":9001"

now starts with this one:

.. code-block:: shell

   buckit server /data --console-address ":9001"

Use your own arguments rather than the ones shown here.

If a process supervisor (e.g. ``supervisord`` or ``runit``) starts MinIO, update the program path in its configuration from ``minio`` to ``buckit`` and reload the supervisor.

Validate
--------

Run the checks in :ref:`Validate the Migration <migrate-minio-validate>`.

Rollback
--------

Because no data was converted, rollback means stopping Buckit and starting the previous MinIO binary again with the same arguments.
Retain the original ``minio`` binary until the migration is validated.

For example, stop Buckit and then run:

.. code-block:: shell

   minio server /data --console-address ":9001"

Use your own arguments rather than the ones shown here.
