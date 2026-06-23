.. _minio-mc-batch-cancel:

===================
``bm batch cancel``
===================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm batch cancel

Syntax
------

.. start-mc-batch-cancel-desc

The :mc:`bm batch cancel` stops an ongoing batch job.

.. end-mc-batch-cancel-desc

You must specify the job ID.
To find the job ID, use :mc-cmd:`bm batch list`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command outputs the job definition for the job identified as ``KwSysDpxcBU9FNhGkn2dCf``.

      .. code-block:: shell
         :class: copyable

         bm batch cancel mybuckit KwSysDpxcBU9FNhGkn2dCf

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] batch cancel ALIAS JOBID

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:
   
   The :ref:`alias <alias>` for the Buckit deployment on which the job is currently running. 

.. mc-cmd:: JOBID
   :required:

   The unique identifier of the batch job to cancel.
   To find the ID of a job, use :mc:`bm batch list`.
   
Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Example
-------

Cancel an ongoing batch job
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following command cancels the job with ID ``KwSysDpxcBU9FNhGkn2dCf`` on the deployment at alias ``mybuckit``:

.. code-block:: shell
   :class: copyable

   bm batch cancel mybuckit KwSysDpxcBU9FNhGkn2dCf

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
