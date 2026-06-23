.. _minio-mc-ilm-rule-import:

======================
``bm ilm rule import``
======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm ilm rule import


Syntax
------

.. start-mc-ilm-rule-import-desc

The :mc:`bm ilm rule import` command imports an object lifecycle management
configuration and applies it to a Buckit bucket.

.. end-mc-ilm-rule-import-desc

The :mc:`bm ilm rule import` command imports from ``STDIN`` by default. 
You can input the contents from a ``.json`` file, such as one produced by :mc:`bm ilm rule export`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command imports the lifecycle management configuration from
      ``mydata-lifecycle-config.json`` and applies it to the ``mydata`` bucket on the ``mybuckit`` deployment:

      .. code-block:: shell
         :class: copyable

         bm ilm rule import mybuckit/mydata < mydata-lifecycle-config.json

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] ilm rule import ALIAS < STDIN

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:
   
   The :ref:`alias <alias>` and full path to the bucket on the Buckit deployment into which to import object lifecycle management rules. 
   For example:

   .. code-block:: none

      bm ilm rule import mybuckit/mydata < bucket-lifecycle.json



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

         bm ilm rule import mybuckit/mybucket < bucket-lifecycle.json

   .. tab-item:: Syntax

      .. code-block:: shell
         :class: copyable

         bm ilm rule import ALIAS < file.json

      - Replace ``ALIAS`` with the :ref:`alias <alias>` of the Buckit 
        deployment and the bucket into which to import object lifecycle
        management rules:

        ``mybuckit/mydata``

      - Replace ``file.json`` with the name of the file from which to import the
        lifecycle management rules.


Required Permissions
--------------------

For permissions required to import rules, refer to the :ref:`required permissions <minio-mc-ilm-rule-permissions>` on the parent command.


Behavior
--------

Importing Configuration Overrides Existing Rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:mc:`bm ilm rule import` replaces the current bucket lifecycle management
rules with those defined in the imported JSON configuration.

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
