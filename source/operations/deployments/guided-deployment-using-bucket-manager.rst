.. _deploy-buckit-guided-bm:

======================================
Guided Deployment using Buckit Manager
======================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

This page explains the deployment choices available from the Buckit Manager
(``bm``) web interface.

Buckit Manager can prepare two kinds of new deployments:

- :ref:`Local computer (macOS/Windows) <deploy-buckit-guided-bm-local>`:
  download and configure Buckit to run as a local single-node server.
- :ref:`Remote servers (Linux) <deploy-buckit-guided-bm-remote>`: deploy
  Buckit as a managed cluster on one or more Linux servers over SSH.

Install Buckit Manager
----------------------

Install ``bm`` on the system you will use to prepare or manage the deployment.

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
architecture and installs it into your user account.

Start the Web Interface
-----------------------

Run the following command on the system where you installed ``bm``:

.. code-block:: shell
   :class: copyable

   bm web

By default, ``bm web`` starts the application on ``http://127.0.0.1:9443/`` and
opens your default browser automatically.

Choose a Deployment Type
------------------------

Open the Buckit Manager web interface and select
:guilabel:`Deploy a new cluster`.

If ``bm web`` is running on macOS or Windows, Buckit Manager asks where Buckit
should be deployed:

- :guilabel:`This computer only`: prepare a local single-node Buckit
  deployment on the same computer.
- :guilabel:`Remote servers`: install Buckit on one or more Linux servers over
  SSH as a managed systemd service.

If ``bm web`` is running on Linux, Buckit Manager opens the remote servers
deployment wizard directly.

Use the following pages for detailed steps:

.. toctree::
   :titlesonly:

   /operations/deployments/guided-deployment-local-computer
   /operations/deployments/guided-deployment-remote-servers
