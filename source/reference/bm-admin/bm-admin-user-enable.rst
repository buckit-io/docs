.. _minio-mc-admin-user-enable:

========================
``bm admin user enable``
========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin user enable


Syntax
------

.. start-mc-admin-user-enable-desc

The :mc:`bm admin user enable` command enables a :ref:`Buckit user <minio-internal-idp>` on the target Buckit deployment.

.. end-mc-admin-user-enable-desc

Clients can only use enabled users to authenticate to the Buckit deployment.
Users created using :mc-cmd:`bm admin user add` are enabled by default.

To manage external Identity Provider users, see :mc:`OIDC <mc idp openid>` or :mc:`AD/LDAP <mc idp ldap>`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command enables user ``myuser`` on the ``myminio`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm admin user enable myminio myuser

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] admin user enable    \
                                     ALIAS     \
	                             USERNAME

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :mc:`alias <bm alias>` of the Buckit deployment with the user to enable.

.. mc-cmd:: USERNAME
   :required:

   The username of the user to enable.


Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals


Example
-------

Enable a User
~~~~~~~~~~~~~

Use :mc-cmd:`bm admin user enable` to enable a user on a Buckit deployment.

.. code-block:: shell
   :class: copyable

   bm admin user enable ALIAS USERNAME

- Replace :mc-cmd:`ALIAS <bm admin user enable ALIAS>` with the :mc-cmd:`alias <bm alias>` of the Buckit deployment.

- Replace :mc-cmd:`USERNAME <bm admin user enable USERNAME>` with the username of the user to enable.


Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
