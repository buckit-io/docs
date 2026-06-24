============
Introduction
============

.. default-domain:: minio

Buckit is an high-performance open source, S3-compatible object storage
platform built for high-throughput workloads and large-scale unstructured data. Use it to store
and retrieve backups, logs, media, analytics data, AI datasets, and application
artifacts across local infrastructure or cloud environments.

Main Components
---------------

Buckit consists of a few core components:

- :doc:`Buckit Server </operations/concepts>`, the object storage server that
  stores data and serves the S3-compatible API.
- :ref:`Buckit Console <minio-console>`, the web interface embedded in each
  Buckit Server for working with buckets, objects, users, access policies, and
  server settings on a deployment.
- :doc:`Buckit Manager web UI </administration/buckit-manager>`, a desktop
  client tool you run on your own computer to install clusters, monitor health,
  and run cluster and node operations remotely.
- :doc:`Buckit Manager CLI </reference/bm-cli>` (bm), used to work with Buckit
  from the command line.

This documentation covers how to install Buckit, deploy a cluster, manage and
secure it, and work with it through the console, APIs, and command line tools.

Start here:

- :doc:`Getting Started </operations/deployments/getting-started>`

.. toctree::
   :titlesonly:
   :hidden:

   self
   /operations/deployments/getting-started
   /installation-and-upgrade
   /cluster-management
   /object-and-bucket-operations
   Developers </reference/s3-api-compatibility>
   /reference/baremetal
   /glossary
