.. _minio-mc-ilm-import:

=================
``mc ilm import``
=================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: mc ilm import



Syntax
------

.. start-mc-ilm-import-desc

The :mc:`bm ilm import` command imports an object lifecycle management
configuration and applies it to a Buckit bucket.

.. end-mc-ilm-import-desc

The :mc:`bm ilm import` command imports from ``STDIN`` by default. You can
input the contents from a ``.json`` file, such as one produced by
:mc:`bm ilm export`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command imports the lifecycle management configuration from
      ``mydata-lifecycle-config.json`` and applies it to the ``mydata`` bucket
      on the ``mybuckit`` deployment:

      .. code-block:: shell
         :class: copyable

         mc ilm import mybuckit/mydata < mydata-lifecycle-config.json

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         mc [GLOBALFLAGS] ilm import ALIAS < STDIN

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   
   *Required* The :ref:`alias <alias>` and full path to the bucket on the Buckit
   deployment into which to import object lifecycle management rules. For
   example:

   .. code-block:: none

      mc ilm import mybuckit/mydata < bucket-lifecycle.json



Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Import the Bucket Lifecycle Management Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. tab-set::

   .. tab-item:: Example

      The following command imports the bucket lifecycle management
      configuration from the ``bucket-lifecycle.json`` file:

      .. code-block:: shell
         :class: copyable

         mc ilm import mybuckit/mybucket < bucket-lifecycle.json

   .. tab-item:: Syntax

      .. code-block:: shell
         :class: copyable

         mc ilm import ALIAS < file.json

      - Replace ``ALIAS`` with the :ref:`alias <alias>` of the Buckit 
        deployment and the bucket into which to import object lifecycle
        management rules:

        ``mybuckit/mydata``

      - Replace ``file.json`` with the name of the file from which to import the
        lifecycle management rules.


Behavior
--------

Importing Configuration Overrides Existing Rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:mc:`bm ilm import` replaces the current bucket lifecycle management
rules with those defined in the imported JSON configuration.

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
