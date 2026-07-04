.. _deploy-minio-container:

============================
Deploy Buckit as a Container
============================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

This page documents deploying Buckit as a Container onto any operating system that supports containerized processes.

This documentation assumes installation of Docker, Podman, or a similar runtime which supports the standard container image format.
Buckit container images are built from `Red Hat Universal Base Image 9 Micro <https://catalog.redhat.com/software/container-stacks/detail/609560d9e2b160d361d24f98>`__.
Buckit publishes container images to both ``ghcr.io/buckit-io/buckit`` and ``docker.io/buckitio/buckit`` for ``linux/amd64`` and ``linux/arm64``.
Stable releases are also published with the ``:latest`` tag. Release candidate images use their release tag only.

Functionality and performance of the Buckit container may be constrained by the base OS.

The procedure includes guidance for deploying Single-Node Multi-Drive (SNMD)
and Single-Node Single-Drive (SNSD) topologies in support of early
development and evaluation environments. For Multi-Node Multi-Drive (MNMD)
deployments, you can also use orchestrated container environments such as
Docker Swarm, Docker Compose, or similar platforms.

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

Container Storage
~~~~~~~~~~~~~~~~~

This procedure assumes you mount one or more dedicated storage devices to the container to act as persistent storage for Buckit.

Data stored on ephemeral container paths is lost when the container restarts or is deleted.
Use any such paths at your own risk.

Procedure
---------

1. Start the Container
~~~~~~~~~~~~~~~~~~~~~~

This procedure provides instructions for Podman and Docker in rootful mode.
For rootless deployments, defer to documentation by each runtime for configuration and container startup.

For all other container runtimes, follow the documentation for that runtime and specify the equivalent options, parameters, or configurations.

.. tab-set::

   .. tab-item:: Podman

      The following command creates a folder in your home directory, then starts the Buckit container using Podman:

      .. code-block:: shell
         :class: copyable

         mkdir -p ~/buckit/data

         podman run \
            -p 9000:9000 \
            -p 9001:9001 \
            --name buckit \
            -v ~/buckit/data:/data \
            -e "MINIO_ROOT_USER=ROOTNAME" \
            -e "MINIO_ROOT_PASSWORD=CHANGEME123" \
            ghcr.io/buckit-io/buckit:latest server /data --console-address ":9001"

      The command binds ports ``9000`` and ``9001`` to the Buckit S3 API and Web Console respectively.

      The local drive ``~/buckit/data`` is mounted to the ``/data`` folder on the container.
      You can modify the :envvar:`MINIO_ROOT_USER` and :envvar:`MINIO_ROOT_PASSWORD` variables to change the root login as needed.

      For multi-drive deployments, bind each local drive or folder to a sequentially numbered path in the container.
      You can then modify the :mc:`buckit server <buckit server>` startup to specify those paths:

      .. code-block:: shell
         :class: copyable

         mkdir -p ~/buckit/data-{1..4}

         podman run \
            -p 9000:9000 \
            -p 9001:9001 \
            --name buckit \
            -v /mnt/drive-1:/mnt/drive-1 \
            -v /mnt/drive-2:/mnt/drive-2 \
            -v /mnt/drive-3:/mnt/drive-3 \
            -v /mnt/drive-4:/mnt/drive-4 \
            -e "MINIO_ROOT_USER=ROOTNAME" \
            -e "MINIO_ROOT_PASSWORD=CHANGEME123" \
            ghcr.io/buckit-io/buckit:latest server /mnt/drive-{1...4} --console-address ":9001"

      For Windows hosts, specify the local folder path using Windows filesystem semantics ``C:\buckit\:/data``.

   .. tab-item:: Docker

      The following command creates a folder in your home directory, then starts the Buckit container using Docker:

      .. code-block:: shell
         :class: copyable

         mkdir -p ~/buckit/data

         docker run \
            -p 9000:9000 \
            -p 9001:9001 \
            --name buckit \
            -v ~/buckit/data:/data \
            -e "MINIO_ROOT_USER=ROOTNAME" \
            -e "MINIO_ROOT_PASSWORD=CHANGEME123" \
            ghcr.io/buckit-io/buckit:latest server /data --console-address ":9001"

      The command binds ports ``9000`` and ``9001`` to the Buckit S3 API and Web Console respectively.

      The local drive ``~/buckit/data`` is mounted to the ``/data`` folder on the container.
      You can modify the :envvar:`MINIO_ROOT_USER` and :envvar:`MINIO_ROOT_PASSWORD` variables to change the root login as needed.

      For multi-drive deployments, bind each local drive or folder to a sequentially numbered path in the container.
      You can then modify the :mc:`buckit server <buckit server>` startup to specify those paths:

      .. code-block:: shell
         :class: copyable

         mkdir -p ~/buckit/data-{1..4}

         docker run \
            -p 9000:9000 \
            -p 9001:9001 \
            --name buckit \
            -v /mnt/drive-1:/mnt/drive-1 \
            -v /mnt/drive-2:/mnt/drive-2 \
            -v /mnt/drive-3:/mnt/drive-3 \
            -v /mnt/drive-4:/mnt/drive-4 \
            -e "MINIO_ROOT_USER=ROOTNAME" \
            -e "MINIO_ROOT_PASSWORD=CHANGEME123" \
            ghcr.io/buckit-io/buckit:latest server /mnt/drive-{1...4} --console-address ":9001"

      For Windows hosts, specify the local folder path using Windows filesystem semantics ``C:\buckit\:/data``.

2. Connect to the Deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. tab-set::

   .. tab-item:: Console

      Open your browser to ``http://localhost:9001`` to open the :ref:`Buckit Console <minio-console>` login page. 

      Log in with the :guilabel:`MINIO_ROOT_USER` and :guilabel:`MINIO_ROOT_PASSWORD`
      from the previous step.

      You can use the Buckit Console for general administration tasks like Identity and Access Management, Metrics and Log Monitoring, or Server Configuration. 
      Each Buckit server includes its own embedded Buckit Console.

   .. tab-item:: CLI

      Install ``bm`` on your local host.
      Run ``bm --version`` to verify the installation.

      Once installed, create an alias for the Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm alias set mybuckit http://localhost:9000 USERNAME PASSWORD

      Change the hostname, username, and password to reflect your deployment.
