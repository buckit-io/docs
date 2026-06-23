.. _minio-mc-ilm-rule-export:

======================
``bm ilm rule export``
======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm ilm rule export


Syntax
------

.. start-mc-ilm-rule-export-desc

The :mc:`bm ilm rule export` command exports the object lifecycle management configuration for a Buckit bucket.

.. end-mc-ilm-rule-export-desc

The :mc:`bm ilm rule export` command outputs to ``STDOUT`` by default. 
You can output the contents to a ``.json`` file for archival or ingestion using :mc:`bm ilm rule import`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command exports the lifecycle management configuration
      of the ``mydata`` bucket on the ``mybuckit`` deployment to the
      ``mydata-lifecycle-config.json`` file:

      .. code-block:: shell
         :class: copyable

         bm ilm rule export mybuckit/mydata > mydata-lifecycle-config.json

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] ilm rule export ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:
   
   The :ref:`alias <alias>` and full path to the bucket on the Buckit deployment for which to export object lifecycle management rules. 
   For example:

   .. code-block:: none

      bm ilm rule export mybuckit/mydata > bucket-lifecycle.json

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Export the Bucket Lifecycle Management Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. tab-set::

   .. tab-item:: Example

      The following command exports the bucket lifecycle management
      configuration to the ``bucket-lifecycle.json`` file:

      .. code-block:: shell
         :class: copyable

         bm ilm rule export mybuckit/mybucket > bucket-lifecycle.json

   .. tab-item:: Syntax

      .. code-block:: shell
         :class: copyable

         bm ilm rule export ALIAS > file.json

      - Replace ``ALIAS`` with the :ref:`alias <alias>` of the Buckit 
        deployment and the bucket for which to export object lifecycle
        management rules:

        ``mybuckit/mydata``

      - Replace ``file.json`` with the name of the file to which to export the
        lifecycle management rules.

Required Permissions
--------------------

For permissions required to export a rule, refer to the :ref:`required permissions <minio-mc-ilm-rule-permissions>` on the parent command.


Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
