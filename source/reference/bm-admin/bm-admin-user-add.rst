.. _minio-mc-admin-user-add:

=====================
``bm admin user add``
=====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin user add


Syntax
------

.. start-mc-admin-user-add-desc

The :mc:`bm admin user add` command adds a new :ref:`Buckit user <minio-internal-idp>` to the target Buckit deployment.

.. end-mc-admin-user-add-desc

To manage external Identity Provider users, see :mc:`OIDC <bm idp openid>` or :mc:`AD/LDAP <bm idp ldap>`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command creates a new user ``newuser`` on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm admin user add mybuckit newuser newusersecret

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] admin user add        \
                                     ALIAS      \
                                     ACCESSKEY  \
                                     SECRETKEY

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ACCESSKEY
   :required:

   The access key that uniquely identifies the new user, similar to a username.

.. mc-cmd:: ALIAS
   :required:

   The :mc-cmd:`alias <bm alias>` of a configured Buckit deployment on which to create the new user.

.. mc-cmd:: SECRETKEY
   :required:

   The secret key for the new user. Consider the following guidance when creating a secret key:
   
   - The key should be *unique*
   - The key should be *long* (Greater than 12 characters)
   - The key should be *complex* (A mixture of characters, numerals, and symbols)


Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals


Example
-------

Create a New User
~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm admin user add` to create a user on a Buckit deployment:

.. code-block:: shell
   :class: copyable

      bm admin user add ALIAS ACCESSKEY SECRETKEY

- Replace :mc-cmd:`ALIAS <bm admin user add ALIAS>` with the :mc-cmd:`alias <bm alias>` of the Buckit deployment.

- Replace :mc-cmd:`ACCESSKEY <bm admin user add ACCESSKEY>` with the access key for the user.

- Replace :mc-cmd:`SECRETKEY <bm admin user add SECRETKEY>` with the secret key for the user.
  Buckit *does not* provide any method for retrieving the secret key once set.

Specify a unique, random, and long string for both the ``ACCESSKEY`` and ``SECRETKEY``.
Your organization may have specific internal or regulatory requirements around generating values for use with access or secret keys.


Behavior
--------

New Users Have No Default Policies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Newly created users have *no* policies by default and therefore cannot perform any operations on the Buckit deployment.
To configure a user's assigned policies, you can do either or both of the following:

- Use :mc-cmd:`bm admin policy attach` to associate one or more policies to the user.

- Use :mc-cmd:`bm admin group add` to associate the user to the group.
  Users inherit any policies assigned to the group.

For more information on Buckit users and groups, see :ref:`minio-users` and :ref:`minio-groups`.
For more information on Buckit policies, see :ref:`Buckit Policy Based Access Control <minio-policy>`.

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
