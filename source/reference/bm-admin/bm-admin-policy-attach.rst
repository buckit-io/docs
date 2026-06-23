==========================
``bm admin policy attach``
==========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin policy attach

Syntax
------

.. start-mc-admin-policy-attach-desc

Attaches one or more IAM policies to either a :ref:`Buckit-managed user or a group <minio-users>`. 

.. end-mc-admin-policy-attach-desc


Exactly one :mc-cmd:`~bm admin policy attach --user` or one :mc-cmd:`~bm admin policy attach --group` is required.


.. tab-set::

   .. tab-item:: EXAMPLE

      The following command attaches the ``readonly`` policy to the user ``james`` on the deployment at :term:`alias` ``mybuckit``.

      .. code-block:: shell
         :class: copyable

         bm admin policy attach mybuckit readonly --user james  

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm admin policy attach                       \
                         TARGET                       \
                         POLICY                       \
                         [POLICY...]                  \
                         [--user USER | --group GROUP] 


      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

.. important::

   This command is intended for managing policy associations for :ref:`Buckit-managed <minio-users>` users only.

   For attaching policies to OpenID-managed users, see :ref:`minio-external-identity-management-openid`.

   For attaching policies to Active Directory/LDAP users or groups, use :mc-cmd:`bm idp ldap policy attach`.

Parameters
~~~~~~~~~~

The :mc-cmd:`bm admin policy attach` command accepts the following arguments:

.. mc-cmd:: TARGET
   :required:

   The :mc-cmd:`alias <bm alias>` of a configured Buckit deployment with the user or group for which you want to attach one or more policies.

.. mc-cmd:: POLICY
   :required:

   The name of the policy to attach to either the user or the group. 
      
   You may attach multiple policies at once by separating each policy name with a space.

   Buckit deployments include the following :ref:`built-in policies <minio-policy-built-in>` by default:

   - :userpolicy:`readonly` 
   - :userpolicy:`readwrite`
   - :userpolicy:`diagnostics`
   - :userpolicy:`writeonly`

.. mc-cmd:: --user
   :optional:

   The username of the identity you want to attach the policy or policies to.
   You may only list one user.

   You must include either the ``--user`` flag or the ``--group`` flag.
   You may not use the ``--user`` flag at the same time as the ``--group`` flag.

.. mc-cmd:: --group
   :optional:

   The name of the group identity you want to attach the policy or policies to.
   You may only list one group.

   All users with membership in the group inherit the policies associated to the group.

   You must include either the ``--group`` flag or the ``--user`` flag.
   You may not use the ``--group`` flag at the same time as the ``--user`` flag.

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Attach the ``readonly`` policy to user ``james`` on the deployment at alias ``mybuckit``.

.. code-block:: shell
   :class: copyable

   bm admin policy attach mybuckit readonly --user james

Attach the ``audit-policy`` and ``acct-policy`` policies to group ``legal`` on the deployment at alias ``mybuckit``.

.. code-block:: shell
   :class: copyable

   bm admin policy attach mybuckit audit-policy acct-policy --group legal
