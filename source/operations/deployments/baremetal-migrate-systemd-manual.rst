.. _migrate-minio-systemd-manual:

==========================
Manual Binary Replacement
==========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

Overview
--------

This procedure migrates a Linux package-installed MinIO deployment managed by ``minio.service`` by replacing the binary and swapping the systemd units by hand.

.. note::

   Buckit recommends :ref:`Guided Migration using Buckit Manager <migrate-minio-community-edition>` for this deployment type.
   The guided workflow runs preflight checks, captures a pre-migration snapshot, verifies the result, and rolls back automatically on failure.
   Use this manual procedure when the ``bm`` host cannot reach the cluster hosts over SSH, or when your environment requires a manual process.

Review the :ref:`shared considerations <migrate-minio-to-buckit>` before starting.

Procedure
---------

1. Install Buckit
~~~~~~~~~~~~~~~~~

The installer script downloads the ``.deb``, ``.rpm``, or ``.apk`` matching the host, verifies its SHA-256 checksum, and prints the package manager command to run.

.. code-block:: shell
   :class: copyable

   curl -fsSL https://buckit-io.github.io/buckit/install-linux.sh | sh
   sudo apt install ./buckit.deb

Substitute ``sudo dnf install ./buckit.rpm`` or ``sudo apk add --allow-untrusted ./buckit.apk`` as appropriate for the host.

The package installs ``/usr/local/bin/buckit`` and a ``buckit.service`` unit that reads the existing ``/etc/default/minio``, including the ``MINIO_VOLUMES`` and ``MINIO_OPTS`` variables.
The existing environment file does not need to be rewritten.

2. Preserve the Existing Service Account
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Identify the account the MinIO service runs as:

.. code-block:: shell
   :class: copyable

   systemctl show -p User -p Group minio.service

Create a systemd drop-in so Buckit runs as the same account and retains access to the data drives:

.. code-block:: shell
   :class: copyable

   sudo systemctl edit buckit.service

Add the following, substituting the user and group reported above:

.. code-block:: ini
   :class: copyable

   [Service]
   User=minio-user
   Group=minio-user

3. Cut Over
~~~~~~~~~~~

Stop and disable MinIO, then enable and start Buckit:

.. code-block:: shell
   :class: copyable

   sudo systemctl disable --now minio.service
   sudo systemctl enable --now buckit.service
   sudo systemctl status buckit.service

The drives, credentials, and endpoints are unchanged.

Distributed Deployments
-----------------------

For multi-node deployments, run step 1 and step 2 on every node, then replace step 3 with the following.

Run this on **all** nodes:

.. code-block:: shell
   :class: copyable

   sudo systemctl disable --now minio.service

Only after every node has stopped, start Buckit on every node:

.. code-block:: shell
   :class: copyable

   sudo systemctl enable --now buckit.service

The ``MINIO_VOLUMES`` value, such as ``http://node{1...4}.example.com/data{1...4}``, remains as it is.

Validate
--------

Run the checks in :ref:`Validate the Migration <migrate-minio-validate>`.

Rollback
--------

Because no data was converted, rollback reverses the cutover:

.. code-block:: shell
   :class: copyable

   sudo systemctl disable --now buckit.service
   sudo systemctl enable --now minio.service
