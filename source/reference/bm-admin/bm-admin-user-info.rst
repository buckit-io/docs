.. _minio-mc-admin-user-info:

======================
``bm admin user info``
======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin user info

Syntax
------

.. start-mc-admin-user-info-desc

The :mc:`bm admin user info` command returns detailed information of a :ref:`Buckit user <minio-internal-idp>` on the target Buckit deployment.

.. end-mc-admin-user-info-desc

To manage external Identity Provider users, see :mc:`OIDC <bm idp openid>` or :mc:`AD/LDAP <bm idp ldap>`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command returns details of user ``myuser`` on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm admin user info mybuckit myuser

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] admin user info      \
                                     ALIAS     \
	                             USERNAME

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :mc-cmd:`alias <bm alias>` of a configured Buckit deployment to retrieve user information from.

.. mc-cmd:: USERNAME

   The username to retrieve information for.


Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals


Examples
--------

View User Details
~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm admin user info` to view detailed user information for a user on a Buckit deployment:

.. code-block:: shell
   :class: copyable

   bm admin user info ALIAS USERNAME

- Replace :mc-cmd:`ALIAS <bm admin user info ALIAS>` with the :mc-cmd:`alias <bm alias>` of the Buckit deployment.

- Replace :mc-cmd:`USERNAME <bm admin user info USERNAME>` with the username of the user to display information for.

For the :ref:`Buckit internal IDentity Provider (IDP) <minio-internal-idp>`, the output resembles the following:

.. code-block:: shell

   AccessKey: miniouser
   Status: enabled
   PolicyName: 
   MemberOf: []
   Authentication: builtin (miniouser)

For a :ref:`third-party <minio-external-identity-management>` identity service such as LDAP, the output resembles the following:

.. code-block:: shell

   AccessKey: uid=dillon,ou=people,ou=swengg,dc=min,dc=io
   Status: 
   PolicyName: consoleAdmin
   MemberOf: []
   Authentication: ldap/localhost:1389 (uid=dillon,ou=people,ou=swengg,dc=min,dc=io)

View Policies from Group Membership
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm admin user info` with ``--json`` to view the policies inherited from a user's :ref:`group memberships <minio-groups>`:

.. code-block:: shell
   :class: copyable

   bm admin user info ALIAS USERNAME --json

- Replace :mc-cmd:`ALIAS <bm admin user info ALIAS>` with the :mc-cmd:`alias <bm alias>` of the Buckit deployment.

- Replace :mc-cmd:`USERNAME <bm admin user info USERNAME>` with the username of the user to display information for.

The ``memberOf`` property in the output contains a list of groups the user is a member of, with the policies attached to each group.
The output resembles the following:

.. code-block:: shell

   {
    "status": "success",
    "accessKey": "myuser",
    "userStatus": "enabled",
    "memberOf": [
     {
      "name": "testingGroup",
      "policies": [
       "testingGroupPolicy"
      ]
    "authentication": builtin (myuser)
     }
    ]
   }


Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
