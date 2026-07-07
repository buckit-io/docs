.. _buckit-getting-started:

===============
Getting Started
===============

.. default-domain:: minio

Buckit is an object storage server. Object storage keeps data as objects inside
buckets instead of files in folders or blocks on a disk device.

Applications use object storage to store and retrieve unstructured data such as
documents, images, videos, backups, logs, and application assets through an
API.

Use this section when you want the fastest way to try Buckit with Buckit
Manager.

Choose the path that matches where you want Buckit to run:

- :ref:`Local computer <buckit-getting-started-local>`: prepare a local
  single-node Buckit server on a macOS or Windows computer.
- :ref:`Remote servers <buckit-getting-started-remote>`: deploy Buckit as a
  managed cluster on one or more Linux servers over SSH.

These pages are for evaluation and first-time setup, not for production
planning. For production deployment guidance, see :doc:`/operations/checklists`.

.. toctree::
   :titlesonly:

   /operations/deployments/getting-started-local-computer
   /operations/deployments/getting-started-remote-servers
