============
``bm event``
============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm event


Description
-----------

.. start-mc-event-desc

The :mc:`bm event` command supports adding, removing, and listing bucket event notifications.

.. end-mc-event-desc

Buckit automatically sends triggered events to the configured notification targets. 
Buckit supports notification targets like AMQP (RabbitMQ), Redis, ElasticSearch, NATS and PostgreSQL. 
See :ref:`Buckit Bucket Notifications <minio-bucket-notifications>` for more information.


Subcommands
-----------

:mc:`bm event` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm event add`
     - .. include:: /reference/bm-cli/bm-event-add.rst
          :start-after: start-mc-event-add-desc
          :end-before: end-mc-event-add-desc

   * - :mc:`~bm event ls`
     - .. include:: /reference/bm-cli/bm-event-list.rst
          :start-after: start-mc-event-list-desc
          :end-before: end-mc-event-list-desc

   * - :mc:`~bm event rm`
     - .. include:: /reference/bm-cli/bm-event-remove.rst
          :start-after: start-mc-event-remove-desc
          :end-before: end-mc-event-remove-desc

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-event-add
   /reference/bm-cli/bm-event-list
   /reference/bm-cli/bm-event-remove
