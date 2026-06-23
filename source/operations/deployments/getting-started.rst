.. _buckit-getting-started:

===============
Getting Started
===============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

Buckit is an object storage server. Object storage keeps data as objects inside
buckets instead of files in folders or blocks on a disk device.

Applications use object storage to store and retrieve unstructured data such as
documents, images, videos, backups, logs, and application assets through an
API.

Use this page when you want the fastest way to try Buckit on Linux servers.

This page is for evaluation and first-time setup, not for production planning.
For production deployment guidance, see :doc:`/operations/checklists`.

What You Need
-------------

Prepare the following before you begin:

- A Windows, macOS, or Linux system with a web browser as the operator UI
- One or more Linux target hosts, each with one or more data drives
- SSH access from the operator UI system to each target host

If the operator UI system is Linux, it can also be the target host.

For a quick trial, use a small set of Linux hosts with simple storage layouts.

Install Buckit Manager
----------------------

Buckit Manager (``bm``) is the deployment and management tool for Buckit. It provides
the web interface and wizard used to install Buckit on target hosts.

Install ``bm`` on the Windows, macOS, or Linux system that has a web browser.

.. tab-set::

   .. tab-item:: macOS / Linux

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

Try the New Deployment Wizard
-----------------------------

After ``bm web`` starts, the browser opens :guilabel:`Welcome to Buckit Manager`.

1. Select :guilabel:`Deploy a new cluster` to open the deployment wizard.
2. Enter a cluster name and root credentials.
3. Add the target hostnames and SSH credentials.
4. Let Buckit Manager discover the hosts and drives.
5. Select the drives you want to use.
6. Review the settings and start the deployment.

Buckit Manager connects to each server, installs Buckit, writes the
configuration, starts the service, and waits for health checks to pass.

Create Bucket and Upload Files in Admin Console
-----------------------------------------------

After the deployment succeeds, Buckit Manager opens the cluster detail page.

From there:

1. Select :guilabel:`Open Buckit Console`.
2. Sign in with the root credentials you set during deployment.
3. In the :guilabel:`Buckets` view, create a new bucket.
4. Open the bucket and upload one or more files.
5. Confirm that the uploaded objects appear in the bucket browser.

Download Files Using bm CLI
---------------------------

Use the created ``bm`` alias from the command line to inspect the cluster, list
the uploaded objects, and copy one file back to your local system.

List the configured aliases:

.. code-block:: shell
   :class: copyable

   bm alias list

Inspect the cluster. Replace ``{CLUSTER-ALIAS}`` with the alias shown in the
last step:

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
