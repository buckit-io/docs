.. _minio-mc-admin-user-list:

====================
``bm admin user ls``
====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin user list
.. mc:: bm admin user ls


Syntax
------

.. start-mc-admin-user-list-desc

The :mc:`bm admin user ls` command lists all :ref:`Buckit users <minio-internal-idp>` on the target Buckit deployment.

.. end-mc-admin-user-list-desc

The :mc:`bm admin user list` command has equivalent functionality to :mc:`bm admin user ls`.

:mc-cmd:`bm admin user ls` does *not* return the access key or secret key associated to a user.
Use :mc-cmd:`bm admin user info` to retrieve detailed user information, including the user access key.

To manage external Identity Provider users, see :mc:`OIDC <bm idp openid>` or :mc:`AD/LDAP <bm idp ldap>`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command lists all users on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm admin user ls mybuckit

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] admin user list   \
                                     ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :mc-cmd:`alias <bm alias>` of a configured Buckit deployment from which the command lists users.


Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals


Example
-------

List Available Users
~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm admin user ls` to list all users on a Buckit deployment:

.. code-block:: shell
   :class: copyable

   bm admin user ls ALIAS

- Replace :mc-cmd:`ALIAS <bm admin user ls ALIAS>` with the :mc-cmd:`alias <bm alias>` of the Buckit deployment.

The output resembles the following:

.. code-block:: shell

   enabled    devadmin              readwrite
   enabled    devtest               readonly
   enabled    newuser


Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
