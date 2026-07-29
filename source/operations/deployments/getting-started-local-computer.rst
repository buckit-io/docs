.. _buckit-getting-started-local:

=====================================
Getting Started on a Local Computer
=====================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

Use this page to try Buckit on the same macOS or Windows computer where you run
Buckit Manager.

Buckit Manager downloads Buckit, creates the local files, and provides a
launcher you use to start the server. It does not install Buckit as a
background system service.

What You Need
-------------

Prepare the following before you begin:

- A macOS or Windows computer with a web browser.
- One or more local filesystem paths for Buckit object data.

Install Buckit Manager
----------------------

Buckit Manager (``bm``) is the deployment and management tool for Buckit. It
provides the web interface and wizard used to prepare the local server.

Install ``bm`` on the macOS or Windows computer where you want to run Buckit.

.. tab-set::

   .. tab-item:: macOS

      .. code-block:: shell
         :class: copyable

         curl -fsSL https://buckit-io.github.io/bm/install.sh | sh

   .. tab-item:: Windows PowerShell

      .. code-block:: powershell
         :class: copyable

         irm https://buckit-io.github.io/bm/install.ps1 | iex

Start Buckit Manager
--------------------

Run:

.. code-block:: shell
   :class: copyable

   bm web

By default, Buckit Manager starts on ``http://127.0.0.1:9443/`` and opens your
browser automatically.

Prepare the Local Deployment
----------------------------

After ``bm web`` starts, the browser opens :guilabel:`Welcome to Buckit
Manager`.

1. Select :guilabel:`Deploy a new cluster`.
2. Select :guilabel:`This computer only`.
3. Choose the Buckit version and enter the root user and root password.
4. Enter one or more local filesystem paths for storing object data, such as
   ``/tmp/buckit/data{1...4}``. The wizard creates missing paths.
5. Review the settings and select :guilabel:`Prepare deploy`.

Buckit Manager downloads Buckit, verifies the checksum, creates missing data
directories, writes the start script, and prepares the local configuration.

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

      Run this command in PowerShell. Press the Windows key, type
      ``PowerShell``, then select Windows PowerShell:

      .. code-block:: powershell
         :class: copyable

         & "C:\Users\YOUR-USER-NAME\buckit\local\Start-Buckit.cmd"

The Buckit server runs in that terminal session. Stop it with ``Ctrl+C``.

Import the Local Deployment
---------------------------

After Buckit server starts successfully, use the import link shown on the Ready
page to import the local deployment into Buckit Manager for easy monitoring and
management.

Create Bucket and Upload Files in Admin Console
-----------------------------------------------

After import succeeds, Buckit Manager opens the cluster detail page.

From there:

1. Click the :guilabel:`Open Buckit Console` button on the top right of the
   page.
2. Sign in with the root credentials you set during preparation.
3. Select the :guilabel:`Buckets` menu on the left and create a new bucket.
4. Select the :guilabel:`Object Browser` menu on the left, open the new
   bucket, and upload one or more files.
5. Confirm that the uploaded objects appear in the bucket browser.

Download Files Using bm CLI
---------------------------

After the local deployment is imported, use the ``bm`` alias from the command
line to inspect the local deployment, list the uploaded objects, and copy one
file back to your local system.

List the configured aliases:

.. code-block:: shell
   :class: copyable

   bm alias list

If the list is empty, create an alias manually. Replace ``{CLUSTER-ALIAS}``
with a name for this local deployment, ``{API-URL}`` with the API address you
configured (for example, ``http://127.0.0.1:9000``), and the credentials with
the root user and password you set during preparation:

.. code-block:: shell
   :class: copyable

   bm alias set {CLUSTER-ALIAS} {API-URL} {ROOT-USER} {ROOT-PASSWORD}

For example, for a local deployment using the default API port:

.. code-block:: shell
   :class: copyable

   bm alias set local http://127.0.0.1:9000 ROOT-USER ROOT-PASSWORD

Inspect the deployment. Replace ``{CLUSTER-ALIAS}`` with an alias from the
list, or the alias you created in the preceding step:

.. code-block:: shell
   :class: copyable

   bm admin info {CLUSTER-ALIAS}

List the buckets on the deployment:

.. code-block:: shell
   :class: copyable

   bm ls {CLUSTER-ALIAS}/

List the objects in the bucket you created. Replace ``{BUCKET}`` with the
bucket name from the last step:

.. code-block:: shell
   :class: copyable

   bm ls {CLUSTER-ALIAS}/{BUCKET}

Copy one object from Buckit to your local system. Replace ``{OBJECT}`` with one
of the files you uploaded:

.. code-block:: shell
   :class: copyable

   bm cp {CLUSTER-ALIAS}/{BUCKET}/{OBJECT} ./{OBJECT}

Next Steps
----------

- Learn the Buckit concepts in :doc:`/operations/concepts`
- See the detailed local deployment guide in
  :ref:`deploy-buckit-guided-bm-local`
