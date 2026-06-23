.. _minio-batch-framework:

===============
Batch Framework
===============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2



Overview
--------

The Buckit Batch Framework allows you to create, manage, monitor, and execute jobs using a YAML-formatted job definition file (a "batch file").
The batch jobs run directly on the Buckit deployment to take advantage of the server-side processing power without constraints of the local machine where you run the :ref:`Buckit Client <minio-client>`.

A batch file defines one job task.

Once started, Buckit starts processing the job.
Time to completion depends on the resources available to the deployment.

If any portion of the job fails, Buckit retries the job up to the number of times defined in the job definition.

The Buckit Batch Framework supports the following job types:

.. list-table:: 
   :header-rows: 1
   :widths: 30 70
   :width: 100%   

   * - Job Type
     - Description

   * - :ref:`replicate <minio-batch-framework-replicate-job>`
     - Perform a one-time replication procedure from one Buckit location to another Buckit location.

   * - :ref:`keyrotate <minio-batch-framework-keyrotate-job>`
     - Perform a one-time process to cycle the :ref:`sse-s3 or sse-kms <minio-sse-data-encryption>` cryptographic keys on objects.

   * - :ref:`expire <minio-batch-framework-expire-job>`
     - Perform a one-time immediate expiration of objects in a bucket.

Buckit Batch CLI
----------------

- Install the :ref:`Buckit Client <minio-client>`
- Define an :mc:`alias <bm alias set>` for the Buckit deployment

The :mc:`bm batch` commands include

.. list-table::
   :widths: 30 70
   :width: 90%

   * - :mc:`bm batch generate`
     - .. include:: /reference/bm-cli/bm-batch-generate.rst
          :start-after: start-mc-batch-generate-desc
          :end-before: end-mc-batch-generate-desc
   * - :mc:`bm batch start`
     - .. include:: /reference/bm-cli/bm-batch-start.rst
          :start-after: start-mc-batch-start-desc
          :end-before: end-mc-batch-start-desc
   * - :mc:`bm batch list`
     - .. include:: /reference/bm-cli/bm-batch-list.rst
          :start-after: start-mc-batch-list-desc
          :end-before: end-mc-batch-list-desc
   * - :mc:`bm batch status`
     - .. include:: /reference/bm-cli/bm-batch-status.rst
          :start-after: start-mc-batch-status-desc
          :end-before: end-mc-batch-status-desc
   * - :mc:`bm batch describe`
     - .. include:: /reference/bm-cli/bm-batch-describe.rst
          :start-after: start-mc-batch-describe-desc
          :end-before: end-mc-batch-describe-desc
   * - :mc:`bm batch cancel`
     - .. include:: /reference/bm-cli/bm-batch-cancel.rst
          :start-after: start-mc-batch-cancel-desc
          :end-before: end-mc-batch-cancel-desc

.. _minio-batch-framework-access:

Access to ``mc batch``
----------------------

Each batch job executes using the credentials specified in the batch definition.
The success of a given batch job depends on those credentials having the appropriate :ref:`permissions <minio-policy>` to perform all requested actions.

The user executing the batch job must have the following permissions. 
You can alternatively restrict users from accessing these functions by blocking or limiting access to these actions:

``admin:ListBatchJobs``
  Grants the user the ability to see batch jobs currently in process.

``admin:DescribeBatchJobs``
  Grants the user the ability to see the definition details of batch job currently in process.

``admin:StartBatchJob``
  Grants the user the ability to start a batch job.
  The job may be further restricted by the credentials the job uses to access either the source or target deployments.

``admin:CancelBatchJob``
  Allows the user to stop a batch job currently in progress.

You can assign any of these actions to users independently or in any combination.

The built-in ``ConsoleAdmin`` policy includes sufficient access to perform all of these types of batch job actions.

.. _minio-batch-local:

``Local`` Deployment
--------------------

You run a batch job against a particular deployment by passing an ``alias`` to the :mc:`bm batch` command.
The deployment you specify in the command becomes the ``local`` deployment within the context of that batch job.

.. toctree::
   :titlesonly:
   :hidden:
   
   /administration/batch-framework-job-replicate
   /administration/batch-framework-job-keyrotate
   /administration/batch-framework-job-expire
