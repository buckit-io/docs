.. _minio-mc-admin-user-disable:

=========================
``bm admin user disable``
=========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin user disable


Syntax
------

.. start-mc-admin-user-disable-desc

The :mc:`bm admin user disable` command disables a :ref:`Buckit user <minio-internal-idp>` on the target Buckit deployment.

.. end-mc-admin-user-disable-desc

Clients cannot use the user credentials to authenticate to the Buckit deployment.
Disabling a user does *not* remove that user from the deployment.
Use :mc-cmd:`bm admin user enable` to enable a disabled user on a Buckit deployment.

To manage external Identity Provider users, see :mc:`OIDC <bm idp openid>` or :mc:`AD/LDAP <bm idp ldap>`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command disables user ``myuser`` on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm admin user disable mybuckit myuser

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] admin user disable   \
                                     ALIAS     \
				     USERNAME

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :mc:`alias <bm alias>` of the Buckit deployment with the user to disable.

.. mc-cmd:: USERNAME
   :required:

   The username of the user to disable.


Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Example
-------

Disable a User
~~~~~~~~~~~~~~

Use :mc-cmd:`bm admin user disable` to disable a user on a Buckit deployment.

.. code-block:: shell
   :class: copyable

   bm admin user disable ALIAS USERNAME

- Replace :mc-cmd:`ALIAS <bm admin user disable ALIAS>` with the :mc-cmd:`alias <bm alias>` of the Buckit deployment.

- Replace :mc-cmd:`USERNAME <bm admin user disable USERNAME>` with the username of the user to disable.


Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
