.. _minio-mc-ilm-rm:

=============
``mc ilm rm``
=============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: mc ilm remove
.. mc:: mc ilm rm



Syntax
------

.. start-mc-ilm-rm-desc

The :mc:`bm ilm rm` command removes an object lifecycle management rule from a 
Buckit Bucket.

.. end-mc-ilm-rm-desc

The :mc:`bm ilm remove` command has equivalent functionality to :mc:`bm ilm rm`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command removes a single lifecycle management rule from
      the ``mydata`` bucket on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         mc ilm rm --id "bgrt1ghju" mybuckit/mydata

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         mc [GLOBALFLAGS] ilm rm                          \
                          --id "string" | (--all --force) \
                          ALIAS                           \

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   
   *Required* The :ref:`alias <alias>` and full path to the bucket on the Buckit
   deployment to which to remove the object lifecycle management rule. For
   example:

   .. code-block:: none

      mc ilm rm mybuckit/mydata

.. mc-cmd:: all

   *Required* Removes all rules in the bucket. Mutually exclusive with
   :mc:`bm ilm rm id`.

   Mutually exclusive with :mc:`bm ilm rm id`

   Requires including :mc-cmd:`~bm ilm rm force`.

.. mc-cmd:: force

   Required if specifying :mc-cmd:`~bm ilm rm all`.

.. mc-cmd:: id

   *Required* The unique ID of the rule. Use :mc:`bm ilm rule ls` to list bucket
   rules and retrieve the ``id`` for the rule you want to remove.

   Mutually exclusive with :mc:`bm ilm rm all`

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Remove a Bucket Lifecycle Management Rule
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm ilm rm` to remove a bucket lifecycle management rule:

.. code-block:: shell
   :class: copyable

   mc ilm rm --id "RULE" ALIAS/PATH

- Replace :mc-cmd:`RULE <bm ilm rm id>` with the unique name of the lifecycle
  management rule.

- Replace :mc-cmd:`ALIAS <bm ilm rm ALIAS>` with the 
  :mc:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm ilm rm ALIAS>` with the path to the bucket on the
  S3-compatible host.

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
