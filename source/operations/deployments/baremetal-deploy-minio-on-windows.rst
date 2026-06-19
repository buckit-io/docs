.. _deploy-minio-windows:

=======================
Deploy Buckit on Windows
=======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

This page documents deploying Buckit onto Microsoft Windows hosts.

Buckit officially supports Windows operating systems in the Active Support of the Microsoft Modern Lifecycle Policy.

At the time of writing, that includes:

- Windows Server 23H2 (**Recommended**)
- Windows Server 2022 LTSC 
- Windows 11 Enterprise/Workstation 23H2
- Windows 11 Enterprise/Workstation 22H2
- Windows 10 Enterprise 21H2 (LTS)
- Windows 10 IoT 21H2 (LTS)
- Windows 10 Enterprise 22H2

Buckit *may* run on older or out-of-support Windows releases, with limited support or troubleshooting from either Buckit or Microsoft.

The procedure includes guidance for deploying Single-Node Multi-Drive (SNMD) and Single-Node Single-Drive (SNSD) topologies in support of early development and evaluation environments.

Buckit does not officially support Multi-Node Multi-Drive (MNMD) "Distributed" configurations on Windows hosts.

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

Use the following command in PowerShell to download and verify the latest
stable Buckit executable for Windows:

.. code-block:: powershell
   :class: copyable

   irm https://buckit-io.github.io/buckit/install-windows.ps1 | iex

The installer downloads the executable to the current directory as
``.\buckit.exe``. Run it from PowerShell or Command Prompt.

2. Launch the Buckit Server
~~~~~~~~~~~~~~~~~~~~~~~~~~


In PowerShell or the Command Prompt, navigate to the location of the
``buckit.exe`` file or add its folder path to the system ``PATH``.

.. tab-set::

   .. tab-item:: Multi-Drive

      For Windows hosts with multiple drives, you can specify a sequential set of drives to use for configuring Buckit in the Single-Node Multi-Drive (SNMD) topology:

      .. code-block::
         :class: copyable

         .\buckit.exe server {D...G}:\buckit --console-address :9001

      The Buckit server process prints its output to the system console, similar to the following:

      .. code-block:: shell

         INFO: Formatting 1st pool, 1 set(s), 1 drives per set.
         Buckit Object Storage Server
         License: GNU AGPLv3 - https://www.gnu.org/licenses/agpl-3.0.html
         Version: RELEASE.2026-06-18T00-00-00Z (go1.26.2 windows/amd64)

         API: http://192.0.2.10:9000  http://127.0.0.1:9000
         WebUI: http://192.0.2.10:9001 http://127.0.0.1:9001
         
         Docs: https://buckit-io.github.io/docs

      The process is tied to the current PowerShell or Command Prompt window.
      Closing the window stops the server and ends the process.

   .. tab-item:: Single-Drive

      Use this command to start a local Buckit instance in the ``C:\buckit`` folder.
      You can replace ``C:\buckit`` with another drive or folder path on the local host.

      .. code-block::
         :class: copyable

         .\buckit.exe server C:\buckit --console-address :9001

      The Buckit server process prints its output to the system console, similar to the following:

      .. code-block:: shell

         INFO: Formatting 1st pool, 1 set(s), 1 drives per set.
         Buckit Object Storage Server
         License: GNU AGPLv3 - https://www.gnu.org/licenses/agpl-3.0.html
         Version: RELEASE.2026-06-18T00-00-00Z (go1.26.2 windows/amd64)

         API: http://192.0.2.10:9000  http://127.0.0.1:9000
         WebUI: http://192.0.2.10:9001 http://127.0.0.1:9001

         Docs: https://buckit-io.github.io/docs

      The process is tied to the current PowerShell or Command Prompt window.
      Closing the window stops the server and ends the process.

3. Connect your Browser to the Buckit Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Access the :ref:`minio-console` by going to a browser (such as Microsoft Edge) and going to ``http://127.0.0.1:9001`` or one of the Console addresses specified in the Buckit server command output.
For example, ``WebUI: http://192.0.2.10:9001 http://127.0.0.1:9001`` in the example output indicates two possible addresses to use for connecting to the Console.

While port ``9000`` is used for connecting to the API, Buckit automatically redirects browser access to the Buckit Console.

Log in to the Console with the ``MINIO_ROOT_USER`` and
``MINIO_ROOT_PASSWORD`` credentials you configured before starting the server.

.. image:: /images/minio-console/console-login.png
   :width: 600px
   :alt: Buckit Console displaying login screen
   :align: center

You can use the Buckit Console for general administration tasks like Identity and Access Management, Metrics and Log Monitoring, or Server Configuration. 
Each Buckit server includes its own embedded Buckit Console.

.. image:: /images/minio-console/minio-console.png
   :width: 600px
   :alt: Buckit Console displaying bucket start screen
   :align: center

For more information, see the :ref:`minio-console` documentation.

4. `(Optional)` Install the Buckit Client
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The :ref:`Buckit Client <minio-client>` allows you to work with your Buckit deployment from PowerShell.

Download the standalone Buckit client for Windows from the following link:

https://dl.min.io/client/mc/release/windows-amd64/mc.exe

Double click on the file to run it.
Or, run the following in the Command Prompt or PowerShell.

.. code-block::
   :class: copyable

   \path\to\mc.exe --help
   
Use :mc:`mc.exe alias set <mc alias set>` to quickly authenticate and connect to the Buckit deployment.

.. code-block:: shell
   :class: copyable

   mc.exe alias set local http://127.0.0.1:9000 minioadmin minioadmin
   mc.exe admin info local

The :mc:`mc.exe alias set <mc alias set>` takes four arguments:

- The name of the alias
- The hostname or IP address and port of the Buckit server
- The Access Key for a Buckit :ref:`user <minio-users>`
- The Secret Key for a Buckit :ref:`user <minio-users>`

For additional details about this command, see :ref:`alias`.
