.. _minio-kubernetes:
.. _deploy-operator-kubernetes:
.. _deploy-operator-openshift:
.. _deploy-operator-rancher:
.. _deploy-operator-eks:
.. _deploy-operator-gke:
.. _deploy-operator-aks:
.. _minio-operator-installation:


==========================
Deploy Buckit on Kubernetes
==========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

Buckit is a Kubernetes-native high performance object store with an S3-compatible API. 
The Buckit Kubernetes Operator supports deploying Buckit Tenants onto private and public cloud infrastructures ("Hybrid" Cloud).

All documentation assumes familiarity with referenced Kubernetes concepts, utilities, and procedures. 
While Buckit documentation *may* provide guidance for configuring or deploying Kubernetes-related resources on a best-effort basis, it is not a replacement for the official :kube-docs:`Kubernetes Documentation <>`.

The Buckit Operator is a first-party Kubernetes-native operator that manages the deployment of Buckit Tenants onto Kubernetes infrastructure.

The Operator provides Buckit-centric functionality around Tenant management, including support for configuring all core Buckit features. 

You can interact with the Operator through the Buckit :kube-docs:`Custom Resource Definition (CRD) <concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions>`, or through the Operator Console UI.

The CRD provides a highly customizable entry point for using tools like Kustomize for deploying Tenants.
You can also use the Buckit Operator Console, a rich web-based UI that has complete support for deploying and configuring Buckit Tenants.

.. important:: 

   The Buckit Operator Console UI is deprecated and removed in Buckit Operator 6.0.0.

   You can continue to use standard Kubernetes approaches for Buckit Tenant management, such as Kustomize templates, Helm Charts, and ``kubectl`` commands for introspecting Tenant namespaces and resources.


.. toctree::
   :titlesonly:
   :hidden:
   
   /operations/deployments/k8s-minio-operator
   /operations/deployments/k8s-minio-tenants