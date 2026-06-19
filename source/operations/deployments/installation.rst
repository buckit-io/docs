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

This section documents steps for installing and managing the AGPLv3-licensed Community Buckit Object Storage on :ref:`Kubernetes <minio-kubernetes>` and :ref:`Baremetal <minio-baremetal>` infrastructures.

.. meta::
   :description: Buckit Deployment Topologies and Installation Instructions
   :keywords: Buckit, Deploy, Architecture, Topology, Distributed, Replication, Install

.. container:: extlinks-video

   - `Installing and Running Buckit on Linux <https://www.youtube.com/watch?v=74usXkZpNt8&list=PLFOIsHSSYIK1BnzVY66pCL-iJ30Ht9t1o>`__

   - `Object Storage Essentials <https://www.youtube.com/playlist?list=PLFOIsHSSYIK3WitnqhqfpeZ6fRFKHxIr7>`__
   
   - `How to Connect to Buckit with JavaScript <https://www.youtube.com/watch?v=yUR4Fvx0D3E&list=PLFOIsHSSYIK3Dd3Y_x7itJT1NUKT5SxDh&index=5>`__

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

Kubernetes
----------

Buckit provides a Kubernetes-native Operator framework for managing and deploying Tenants onto your managed infrastructure.

Buckit fully supports upstream Kubernetes and most flavors which inherit from the upstream as a base.
This includes, but is not limited to, RedHat Openshift, SUSE Rancher, VMWare Tanzu.
Buckit also fully supports cloud-based Kubernetes engines such as Elastic Kubernetes Engine, Google Kubernetes Service, and Azure Kubernetes Service.

Select the link most appropriate for your Kubernetes infrastructure.
If your provider is not listed, use the Kubernetes Upstream documentation as a baseline and modify as needed based on your provider's guidance or divergence from upstream semantics and behavior.

- :ref:`Deploy Buckit on Kubernetes (Upstream) <deploy-operator-kubernetes>`
- :ref:`Deploy Buckit on Openshift Kubernetes <deploy-operator-openshift>`
- :ref:`Deploy Buckit on SUSE Rancher Kubernetes <deploy-operator-rancher>`
- :ref:`Deploy Buckit on Elastic Kubernetes Service <deploy-operator-eks>`
- :ref:`Deploy Buckit on Google Kubernetes Engine <deploy-operator-gke>`
- :ref:`Deploy Buckit on Azure Kubernetes Service <deploy-operator-aks>`

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

   Buckit strongly recommends :minio-docs:`Linux (RHEL, Ubuntu) <minio/linux/index.html>` or :minio-docs:`Kubernetes (Upstream, OpenShift) <minio/kubernetes/upstream/index.html>` for long-term development and production environments.

   Buckit provides no guarantee of support for :abbr:`SNMD (Single-Node Multi-Drive)` or :abbr:`MNMD (Multi-Node Multi-Drive)` topologies on MacOS, Windows, or Containerized deployments.

