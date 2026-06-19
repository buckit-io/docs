.. _minio-mc-admin-user-remove:

=====================
``bm admin user rm``
=====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin user remove
.. mc:: bm admin user rm

Syntax
------

.. start-mc-admin-user-remove-desc

The :mc:`bm admin user rm` command removes a :ref:`Buckit user <minio-internal-idp>` on the target Buckit deployment.

.. end-mc-admin-user-remove-desc

The :mc:`bm admin user remove` command has equivalent functionality to :mc:`bm admin user rm`.

To manage external Identity Provider users, see :mc:`OIDC <mc idp openid>` or :mc:`AD/LDAP <mc idp ldap>`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command removes user ``myuser`` on the ``myminio`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm admin user rm myminio myuser

   .. tab-item:: SYNTAX

      Removes a user on the target Buckit deployment.

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] admin user remove    \
                                     ALIAS     \
				     USERNAME

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :mc:`alias <bm alias>` of the configured Buckit deployment with the user to remove.

.. mc-cmd:: USERNAME
   :required:

   The username of the user to remove.

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Example
-------

Remove a User
~~~~~~~~~~~~~

Use :mc-cmd:`bm admin user rm` to remove a user from a Buckit deployment:

.. code-block:: shell
   :class: copyable

   bm admin user rm ALIAS USERNAME

- Replace :mc-cmd:`ALIAS <bm admin user rm ALIAS>` with the :mc-cmd:`alias <bm alias>` of the Buckit deployment.

- Replace :mc-cmd:`USERNAME <bm admin user rm USERNAME>` with the username of the user to remove.

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
