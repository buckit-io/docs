.. _minio-mc-alias-remove:

===================
``bm alias remove``
===================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm alias remove

Syntax
------

.. start-mc-alias-remove-desc

The :mc:`bm alias remove` removes an existing alias from the local
:program:`bm` configuration.

.. end-mc-alias-remove-desc

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command removes the ``mybuckit`` :ref:`alias <alias>` for a
      Buckit deployment from the host machine:

      .. code-block:: shell
         :class: copyable

         bm alias remove mybuckit

   .. tab-item:: SYNTAX

      The :mc:`bm alias remove` command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] alias remove ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS

   *Required* The alias to remove from the local :program:`bm` configuration.

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Remove an Alias from the ``bm`` Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm alias remove` to remove an existing alias from the
:program:`bm` configuration:

.. tab-set::

   .. tab-item:: Example

      The following command removes the ``mybuckit`` alias.

      .. code-block:: shell
         :class: copyable

         bm alias remove mybuckit

   .. tab-item:: Syntax

      .. code-block:: shell
         :class: copyable

         bm alias remove ALIAS

      Replace ``ALIAS`` with the the name of the alias to remove.

Behavior
~~~~~~~~

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility