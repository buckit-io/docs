.. _buckit-manager-web:

=====================
Buckit Manager Web UI
=====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

The Buckit Manager web interface is a graphical user interface for deploying,
importing, monitoring, and operating Buckit clusters from your own workstation.

This page provides an overview of the Buckit Manager web interface and
describes how to start it and log in. For installation instructions, see
:ref:`install-buckit-manager`.

Overview
--------

Buckit Manager (``bm``) is a single binary that includes both a command line
and a local web interface. The web interface is a personal operations console:
you run it on your own Mac, Windows, or Linux machine to manage one or more
Buckit clusters. It is closer in spirit to tools like ``gh`` or
``jupyter notebook`` than to a centralized, always-on cluster console.

Unlike the :ref:`Buckit Console <minio-console>`, which is embedded in each
Buckit Server and serves bucket and object browsing for a single deployment,
the Buckit Manager web interface runs as a client on your workstation and
manages the lifecycle and health of entire clusters: deploying new clusters
over SSH, importing and migrating existing deployments, and running cluster,
host, and node operations.

With the Buckit Manager web interface you can:

- :ref:`Monitor cluster, node, and drive health <bm-web-monitoring>` across all
  of your clusters.
- :ref:`Run cluster, host, and node operations <bm-web-operations>` such as
  restart, stop, start, heal, upgrade, and root password rotation.
- :ref:`Add clusters <bm-web-adding-clusters>` by deploying new ones, importing
  running deployments, or migrating MinIO Community Edition to Buckit.
- :ref:`Configure connection credentials and application settings
  <bm-web-settings>` such as SSH and admin credentials, action history, and
  updates.

Supported Browsers
~~~~~~~~~~~~~~~~~~~

The Buckit Manager web interface runs on current, stable releases of common
desktop browsers, including:

- Chrome
- Edge
- Safari
- Firefox
- Opera

For the best experience, use the latest stable release of your preferred
browser.

.. note::

   The Buckit Manager web interface is a desktop tool. The cluster detail page
   uses a wide monitoring grid that is not designed for mobile screens.

Starting the Web Interface
--------------------------

Run the following command on the system where you installed ``bm``:

.. code-block:: shell
   :class: copyable

   bm web

By default, ``bm web`` starts the application on ``http://127.0.0.1:9443/`` and
opens your default browser automatically.

The ``bm web`` process is long-running. Leave it running while you work in the
browser; stop it with :kbd:`Ctrl-C` in the terminal when you are done.

.. _bm-web-loopback:

Local-Only by Default
~~~~~~~~~~~~~~~~~~~~~~

By default, ``bm web`` listens only on the loopback address
(``127.0.0.1``), so the interface is reachable only from the machine where it
runs. Because the listener is local-only, the default mode does not require a
login.

.. toctree::
   :titlesonly:
   :hidden:

   /administration/buckit-manager/monitoring-clusters
   /administration/buckit-manager/cluster-and-node-operations
   /administration/buckit-manager/adding-clusters
   /administration/buckit-manager/manager-settings
