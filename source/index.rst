======================================
Buckit High Performance Object Storage
======================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

Buckit is a Kubernetes-native S3-compatible object storage solution designed to deploy wherever your applications are - on premises, in the private cloud, in the public cloud, and edge infrastructure.
Buckit is designed to support modern application workload patterns where high performance distributed computing meets petabyte-scale storage requirements.

This site documents Operations, Administration, and Development of Buckit Community Object Storage deployments on supported platforms. 

.. todo: More marketing/SEO below?

Quickstart
----------

.. tab-set::

   .. tab-item:: Sandbox

      Buckit maintains a sandbox instance of the community server at https://play.min.io. 
      You can use this instance for experimenting or evaluating the Buckit product on your local system.

      Follow the :mc:`bm` CLI :ref:`installation guide <mc-install>` to install the utility on your local host.

      :mc:`bm` includes a pre-configured ``play`` alias for connecting to the sandbox.
      For example, you can use the following commands to create a bucket and copy objects to ``play``:

      .. code-block:: shell
         :class: copyable

         bm mb play/mynewbucket

         bm cp /path/to/file play/mynewbucket/prefix/filename.extension

         bm stat play/mynewbucket/prefix/filename.extension

      .. important::

         Buckit's Play sandbox is an ephemeral public-facing deployment with well-known access credentials.
         Any private, confidential, internal, secured, or other important data uploaded to Play is effectively made public.
         Exercise caution and discretion in any data you upload to Play.

   .. tab-item:: Baremetal

      1. Download the Buckit Server Process for your Operating System

         Follow the instructions on the `Buckit Download Page <https://min.io/downloads?ref=docs>`__ for your operating system to download and install the :mc:`buckit server <buckit server>` process.

      2. Create a folder for use with Buckit

         For example, create a folder ``~/minio`` in Linux/MacOS or ``C:\minio`` in Windows.

      3. Start the Buckit Server

         Run the :mc:`buckit server <buckit server>` specifying the path to the directory and the :mc:`~buckit server --console-address` parameter to set a static console listen path:

         .. code-block:: shell
            :class: copyable

            buckit server ~/minio --console-address :9001
            # For windows, use minio.exe server ~/minio --console-address :9001`

         The output includes connection instructions for both :mc:`bm` and connecting to the Console using your browser.

   .. tab-item:: Kubernetes

      Download `minio-dev.yaml <https://raw.githubusercontent.com/minio/docs/master/source/extra/examples/minio-dev.yaml>`__ to your host machine:

      .. code-block:: shell
         :class: copyable

         curl https://raw.githubusercontent.com/minio/docs/master/source/extra/examples/minio-dev.yaml -O

      The file describes two Kubernetes resources:

      - A new namespace ``minio-dev``, and
      - A Buckit pod using a drive or volume on the Worker Node for serving data

      Use ``kubectl port-forward`` to access the Pod, or create a service for the pod for which you can configure Ingress, Load Balancing, or similar Kubernetes-level networking.

.. toctree::
   :titlesonly:
   :hidden:

   /installation-and-upgrade
   /cluster-management
   /object-and-bucket-operations
   Developers </reference/s3-api-compatibility>
   /reference/baremetal
   /glossary
