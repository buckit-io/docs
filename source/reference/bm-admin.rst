==================
Buckit Admin CLI
==================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

.. mc:: bm admin

The Buckit Manager CLI provides the :mc:`bm admin`
command for performing administrative tasks on your Buckit deployments.

While :mc-cmd:`bm` supports any S3-compatible service,
:mc:`bm admin` *only* supports Buckit deployments.

:mc:`bm admin` has the following syntax:

.. code-block:: shell

   bm admin [FLAGS] COMMAND [ARGUMENTS]

Command Quick reference
-----------------------

The following table lists :mc:`bm admin` commands:

.. list-table::
   :header-rows: 1
   :widths: 40 60
   :width: 100%

   * - Command
     - Description

   * - :mc:`bm admin accesskey`
     - .. include:: /reference/bm-admin/bm-admin-accesskey.rst
          :start-after: start-mc-admin-accesskey-desc
          :end-before: end-mc-admin-accesskey-desc

   * - :mc:`bm admin cluster bucket`
     - .. include:: /reference/bm-admin/bm-admin-cluster-bucket.rst
          :start-after: start-mc-admin-cluster-bucket-desc
          :end-before: end-mc-admin-cluster-bucket-desc

   * - :mc:`bm admin cluster iam`
     - .. include:: /reference/bm-admin/bm-admin-cluster-iam.rst
          :start-after: start-mc-admin-cluster-iam-desc
          :end-before: end-mc-admin-cluster-iam-desc

   * - :mc-cmd:`bm admin decommission`
     - .. include:: /reference/bm-admin/bm-admin-decommission.rst
          :start-after: start-mc-admin-decommission-desc
          :end-before: end-mc-admin-decommission-desc

   * - :mc:`bm admin group`
     - .. include:: /reference/bm-admin/bm-admin-group.rst
          :start-after: start-mc-admin-group-desc
          :end-before: end-mc-admin-group-desc

   * - :mc-cmd:`bm admin heal`
     - .. include:: /reference/bm-admin/bm-admin-heal.rst
          :start-after: start-mc-admin-heal-desc
          :end-before: end-mc-admin-heal-desc
  
   * - :mc-cmd:`bm admin info`
     - .. include:: /reference/bm-admin/bm-admin-info.rst
          :start-after: start-mc-admin-info-desc
          :end-before: end-mc-admin-info-desc

   * - :mc-cmd:`bm admin kms key`
     - .. include:: /reference/bm-admin/bm-admin-kms-key.rst
          :start-after: start-mc-admin-kms-key-desc
          :end-before: end-mc-admin-kms-key-desc

   * - :mc-cmd:`bm admin logs`
     - .. include:: /reference/bm-admin/bm-admin-logs.rst
          :start-after: start-mc-admin-logs-desc
          :end-before: end-mc-admin-logs-desc

   * - :mc:`bm admin policy`
     - .. include:: /reference/bm-admin/bm-admin-policy.rst
          :start-after: start-mc-admin-policy-desc
          :end-before: end-mc-admin-policy-desc

   * - :mc-cmd:`bm admin prometheus`
     - .. include:: /reference/bm-admin/bm-admin-prometheus.rst
          :start-after: start-mc-admin-prometheus-desc
          :end-before: end-mc-admin-prometheus-desc

   * - :mc-cmd:`bm admin rebalance`
     - .. include:: /reference/bm-admin/bm-admin-rebalance.rst
          :start-after: start-mc-admin-rebalance-desc
          :end-before: end-mc-admin-rebalance-desc

   * - :mc-cmd:`bm admin replicate`
     - .. include:: /reference/bm-admin/bm-admin-replicate.rst
          :start-after: start-mc-admin-replicate-desc
          :end-before: end-mc-admin-replicate-desc

   * - :mc-cmd:`bm admin scanner`
     - .. include:: /reference/bm-admin/bm-admin-scanner.rst
          :start-after: start-mc-admin-scanner-desc
          :end-before: end-mc-admin-scanner-desc

   * - :mc-cmd:`bm admin service`
     - .. include:: /reference/bm-admin/bm-admin-service.rst
          :start-after: start-mc-admin-service-desc
          :end-before: end-mc-admin-service-desc

   * - :mc-cmd:`bm admin trace`
     - .. include:: /reference/bm-admin/bm-admin-trace.rst
          :start-after: start-mc-admin-trace-desc
          :end-before: end-mc-admin-trace-desc

   * - :mc-cmd:`bm admin update`
     - .. include:: /reference/bm-admin/bm-admin-update.rst
          :start-after: start-mc-admin-update-desc
          :end-before: end-mc-admin-update-desc

   * - :mc:`bm admin user`
     - .. include:: /reference/bm-admin/bm-admin-user.rst
          :start-after: start-mc-admin-user-desc
          :end-before: end-mc-admin-user-desc

.. _mc-admin-install:

Installation
------------

.. include:: /includes/minio-mc-installation.rst

Quickstart
----------

Ensure that the host machine has :mc:`bm`
:ref:`installed <mc-admin-install>` prior to starting this procedure.

.. important::

   The following example temporarily disables the bash history to mitigate the
   risk of authentication credentials leaking in plain text. This is a basic
   security measure and does not mitigate all possible attack vectors. Defer to
   security best practices for your operating system for inputting sensitive
   information on the command line.

Use the :mc:`bm alias set` command to add the
deployment to the :program:`bm` configuration.

.. code-block:: shell
   :class: copyable

   bash +o history
   bm alias set <ALIAS> <ENDPOINT> ACCESS_KEY SECRET_KEY
   bash -o history

Replace each argument with the required values.

Use the :mc-cmd:`bm admin info` command to test the connection to
the newly added Buckit deployment:

.. code-block:: shell
   :class: copyable

   bm admin info <ALIAS>

Global Options
--------------

:mc:`bm admin` supports the same global options as :mc-cmd:`bm`.
See :ref:`minio-mc-global-options`.

.. toctree::
   :titlesonly:
   :hidden:
   :glob:

   /reference/bm-admin/bm-admin-accesskey
   /reference/bm-admin/bm-admin-cluster-bucket
   /reference/bm-admin/bm-admin-cluster-iam
   /reference/bm-admin/bm-admin-config
   /reference/bm-admin/bm-admin-decommission
   /reference/bm-admin/bm-admin-group
   /reference/bm-admin/bm-admin-heal
   /reference/bm-admin/bm-admin-info
   /reference/bm-admin/bm-admin-kms-key
   /reference/bm-admin/bm-admin-logs
   /reference/bm-admin/bm-admin-policy
   /reference/bm-admin/bm-admin-prometheus
   /reference/bm-admin/bm-admin-rebalance
   /reference/bm-admin/bm-admin-replicate
   /reference/bm-admin/bm-admin-scanner
   /reference/bm-admin/bm-admin-service
   /reference/bm-admin/bm-admin-trace
   /reference/bm-admin/bm-admin-update
   /reference/bm-admin/bm-admin-user
   /reference/deprecated/mc-admin-bucket-remote
 
