.. _minio-mc-event-list:

===============
``bm event ls``
===============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm event list
.. mc:: bm event ls

Syntax
------

.. start-mc-event-list-desc

The :mc:`bm event ls` command lists all event notification triggers for a
bucket.

.. end-mc-event-list-desc

The alias :mc:`bm event list` has equivalent functionality to :mc:`bm event ls`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command lists all configured event notifications for the
      specified :ref:`bucket notification target <minio-bucket-notifications>`
      for the ``mydata`` bucket on the ``myminio`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm event ls myminio myminio/mydata arn:aws:sqs::primary:target

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS]

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


.. code-block:: shell

   bm [GLOBALFLAGS] event ls [FLAGS] ALIAS ARN

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The S3 service :ref:`alias <alias>` and bucket to which the command lists event notification. 
   For example:

   .. code-block:: shell

      bm event ls play/mybucket ARN...

.. mc-cmd:: ARN
   :required:

   The :aws-docs:`Amazon Resource Name (ARN) <IAM/latest/UserGuide/reference-arns>` of the bucket resource.

   The Buckit server outputs an ARN at startup for each configured notification target. 
   See :ref:`Bucket Notifications <minio-bucket-notifications>` for more information.


Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

List Event Notifications on a Bucket
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. tab-set::

   .. tab-item:: Example

      The following command lists all event notification triggers on a bucket.

      .. code-block:: shell
         :class: copyable

         bm event ls myminio/mydata

   .. tab-item:: Syntax

      .. code-block:: shell
         :class: copyable

         bm event ls ALIAS ARN

      - Replace ``ALIAS`` with the :ref:`alias <alias>` of the Buckit
        deployment on which to add the bucket notification event. For example:

        ``myminio/mydata``

      - Replace ``ARN`` with the notification target
        :mc-cmd:`ARN <bm event add ARN>`.

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
