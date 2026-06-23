.. _minio-server-envvar-ilm:

============
ILM Settings
============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

This page covers settings that control Information Lifecycle Management (ILM) for the Buckit process. 

.. include:: /includes/common-mc-admin-config.rst
   :start-after: start-minio-settings-defined
   :end-before: end-minio-settings-defined

.. include:: /includes/common-mc-admin-config.rst
   :start-after: start-minio-settings-test-before-prod
   :end-before: end-minio-settings-test-before-prod

Expiration Workers
------------------

.. tab-set::

   .. tab-item:: Environment Variable
      :sync: envvar

      .. envvar:: MINIO_ILM_EXPIRATION_WORKERS

   .. tab-item:: Configuration Setting
      :sync: config
  
      .. mc-conf:: ilm expiration_workers
         :delimiter: " "

Set the number of workers to use for :ref:`expiring objects <minio-lifecycle-management-expiration>`.
Valid values are ``1`` to ``500``.

The default value is ``100``.
