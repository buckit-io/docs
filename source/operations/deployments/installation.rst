:orphan:

.. _deploy-minio-distributed:
.. _minio-mnmd:
.. _minio-installation:
.. _minio-snmd:
.. _minio-snsd:

===========================
Installation and Management
===========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

This section documents steps for installing Buckit Object Storage on baremetal infrastructure.

.. meta::
   :description: Buckit Deployment Topologies and Installation Instructions
   :keywords: Buckit, Deploy, Architecture, Topology, Distributed, Replication, Install

Buckit is a software-defined high performance distributed object storage server.
You can run Buckit on consumer or enterprise-grade hardware and a variety
of operating systems and architectures.

All Buckit deployments implement :ref:`Erasure Coding <minio-erasure-coding>` backends.
You can deploy Buckit using one of the following topologies: 

.. _minio-installation-comparison:

:ref:`Single-Node Single-Drive <minio-snsd>` (SNSD or "Standalone")
  Local development and evaluation with no/limited reliability

:ref:`Single-Node Multi-Drive <minio-snmd>` (SNMD or "Standalone Multi-Drive")
  Workloads with lower performance, scale, and capacity requirements

  Drive-level reliability with configurable tolerance for loss of up to 1/2 all drives

  Evaluation of multi-drive topologies and failover behavior.

:ref:`Multi-Node Multi-Drive <minio-mnmd>` (MNMD or "Distributed")
  Enterprise-grade high-performance object storage

  Multi Node/Drive level reliability with configurable tolerance for loss of up to 1/2 all nodes/drives
       
  Primary storage for AI/ML, Distributed Query, Analytics, and other Data Lake components
       
  Scalable for Petabyte+ workloads - both storage capacity and performance

Baremetal
---------

Buckit supports deploying onto baremetal infrastructure - physical machines or virtualized hosts - running Linux, MacOS, and Windows.
You can also deploy Buckit as a container onto supported Operating Systems.

- :ref:`Deploy Buckit onto RedHat Linux <deploy-minio-rhel>`
- :ref:`Deploy Buckit onto Ubuntu Linux <deploy-minio-ubuntu>`
- :ref:`Deploy Buckit as a Container <deploy-minio-container>`
- :ref:`Deploy Buckit onto MacOS <deploy-minio-macos>`
- :ref:`Deploy Buckit onto Windows <deploy-minio-windows>`

.. important::

   Buckit strongly recommends :minio-docs:`Linux (RHEL, Ubuntu) <minio/linux/index.html>` for long-term development and production environments.

   Buckit provides no guarantee of support for :abbr:`SNMD (Single-Node Multi-Drive)` or :abbr:`MNMD (Multi-Node Multi-Drive)` topologies on MacOS, Windows, or Containerized deployments.
