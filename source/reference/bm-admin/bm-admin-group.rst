===================
``bm admin group``
===================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin group

Description
-----------

.. start-mc-admin-group-desc

The :mc:`bm admin group` command manages groups on a Buckit deployment.

.. end-mc-admin-group-desc

A :ref:`group <minio-groups>` is a collection of :ref:`users
<minio-users>`. Each group can have one or more assigned
:ref:`policies <minio-policy>` that explicitly list the
actions and resources to which group members are allowed or denied access.
Groups provide a simplified method for managing shared permissions among users
with common access patterns and workloads. 

.. admonition:: Use ``bm admin`` on Buckit Deployments Only
   :class: note

   .. include:: /includes/facts-mc-admin.rst
      :start-after: start-minio-only
      :end-before: end-minio-only

Groups and Policy-Based Access Control
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit uses Policy-Based Access Control (PBAC) to support *authorization* of
users who have successfully *authenticated* to the deployment. Each policy
includes rules that dictate the allowed or denied actions/resources on the
deployment. You can assign one or more :ref:`policies
<minio-policy>` to a group. Users with membership in the
group inherit the group's assigned policies. A user's total set of permissions
includes their explicitly assigned policies *and* any policies inherited
via group membership.

Newly created groups have *no* policies by default. To configure a group's
assigned policies, use the :mc-cmd:`bm admin policy attach` command.

For more information on Buckit users and groups, see
:ref:`minio-users` and :ref:`minio-groups`. For 
more information on Buckit policies, see :ref:`Buckit Policy Based Access Control <minio-policy>`.

.. admonition:: ``Deny`` overrides ``Allow``
   :class: note

   Buckit follows the IAM standard where a ``Deny`` rule overrides ``Allow`` rule
   on the same action or resource. For example, if a user has an explicitly
   assigned policy with an ``Allow`` rule for an action/resource while one of
   its groups has an assigned policy with a ``Deny`` rule for that
   action/resource, Buckit would apply only the ``Deny`` rule. 

   For more information on IAM policy evaluation logic, see the IAM
   documentation on 
   :iam-docs:`Determining Whether a Request is Allowed or Denied Within an Account 
   <reference_policies_evaluation-logic.html#policy-eval-denyallow>`.

Examples
--------

Create a New Group
~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm admin group add` to create a new group to an S3-compatible host:

.. code-block:: shell
   :class: copyable

   bm admin group add ALIAS GROUPNAME MEMBER [MEMBER...]

- Replace :mc-cmd:`ALIAS <bm admin group add TARGET>` with the 
  :mc-cmd:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`GROUPNAME <bm admin group add GROUPNAME>` with the name
  of the group to create.

- Replace :mc-cmd:`MEMBER <bm admin group add MEMBERS>` with *at least* one
  :mc-cmd:`user <bm admin user>` on the S3 host. Specify multiple members 
  as a list: ``MEMBER1 MEMBER2 MEMBER3``

List Available Groups
~~~~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm admin group ls` to list list all groups on an S3-compatible
host:

.. code-block:: shell
   :class: copyable

   bm admin group ls ALIAS

- Replace :mc-cmd:`ALIAS <bm admin group ls TARGET>` with the 
  :mc-cmd:`alias <bm alias>` of the S3-compatible host.


View Group Details
~~~~~~~~~~~~~~~~~~

Use :mc-cmd:`bm admin group info` to view detailed group information on an 
S3-compatible host:

.. code-block:: shell
   :class: copyable

   bm admin group info ALIAS GROUPNAME

- Replace :mc-cmd:`ALIAS <bm admin group info TARGET>` with the 
  :mc-cmd:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`GROUPNAME <bm admin group info GROUPNAME>` with the name of
  the group.

Remove a Group
~~~~~~~~~~~~~~

Use :mc-cmd:`bm admin group rm` to remove a group from an S3-compatible
host:

.. code-block:: shell
   :class: copyable

   bm admin group rm ALIAS GROUPNAME

- Replace :mc-cmd:`ALIAS <bm admin group rm TARGET>` with the 
  :mc-cmd:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`GROUPNAME <bm admin group rm GROUPNAME>` with the
  name of the group.

Disable a Group
~~~~~~~~~~~~~~~

Use :mc-cmd:`bm admin group disable` to disable a group on an S3-compatible
host:

.. code-block:: shell
   :class: copyable

   bm admin group disable ALIAS GROUPNAME

- Replace :mc-cmd:`ALIAS <bm admin group disable TARGET>` with the 
  :mc-cmd:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`GROUPNAME <bm admin group disable GROUPNAME>` with the name
  of the group.

Enable a Group
~~~~~~~~~~~~~~

Use :mc-cmd:`bm admin group enable` to enable a group on an S3-compatible
host:

.. code-block:: shell
   :class: copyable

   bm admin group enable ALIAS GROUPNAME

- Replace :mc-cmd:`ALIAS <bm admin group enable TARGET>` with the 
  :mc-cmd:`alias <bm alias>` of the S3-compatible host.

- Replace :mc-cmd:`GROUPNAME <bm admin group enable GROUPNAME>` with the name
  of the group.


Quick Reference
---------------

:mc-cmd:`bm admin group add TARGET GROUPNAME MEMBERS <bm admin group add>`
   Adds a user to a group on the Buckit deployment. Creates the group if it
   does not exist.

:mc-cmd:`bm admin group info TARGET GROUPNAME <bm admin group info>`
   Returns detailed information for a group on the Buckit deployment.

:mc-cmd:`bm admin group ls TARGET <bm admin group ls>`
   Returns a list of all groups on the Buckit deployment.

:mc-cmd:`bm admin group rm TARGET GROUPNAME <bm admin group rm>`
   Removes a group on the Buckit deployment.

:mc-cmd:`bm admin group enable TARGET GROUPNAME <bm admin group enable>`
   Enables a group on the Buckit deployment. Users can only inherit
   :ref:`policies <minio-policy>` assigned to an enabled group.

:mc-cmd:`bm admin group disable TARGET GROUPNAME <bm admin group disable>`
   Disables a group on the Buckit deployment. Users cannot inherit :ref:`policies
   <minio-policy>` assigned to a disabled group.

Syntax
------

.. mc-cmd:: add
   :fullpath:

   Adds an existing user to the group. The command creates the group if it
   does not exist. The command has the following syntax:

   .. code-block:: shell
      :class: copyable

      bm admin group add TARGET GROUPNAME MEMBERS

   The command accepts the following arguments:

   .. mc-cmd:: TARGET

      The :mc-cmd:`alias <bm alias>` of a configured Buckit deployment on which
      the command adds users to the new or existing group

   .. mc-cmd:: GROUPNAME

      The name of the group. The command creates the group if it does not 
      already exist. Use :mc-cmd:`bm admin group ls` to review the existing
      groups on a deployment.

      A group name cannot contain the characters ``=`` (equal sign) or ``,`` (comma).

   .. mc-cmd:: MEMBERS

      The name of the user to add to the group.
      
      The user *must* exist on the :mc-cmd:`~bm admin group add TARGET` Buckit
      deployment. Use :mc-cmd:`bm admin user ls` to review the available
      users on the deployment. 

.. mc-cmd:: info
   :fullpath:

   Returns details for the group on the target deployment, such as all
   :ref:`users <minio-users>` with membership in the group and the
   assigned :ref:`policies <minio-policy>`. The command has
   the following syntax:

   .. code-block:: shell
      :class: copyable

      bm admin group info TARGET GROUPNAME

   The command accepts the following arguments:

   .. mc-cmd:: TARGET

      The :mc-cmd:`alias <bm alias>` of a configured Buckit deployment from which
      to retrieve the group information.

   .. mc-cmd:: GROUPNAME

      The name of the group.

.. mc-cmd:: ls, list
   :fullpath:

   List all groups on the target Buckit deployment. The command has the
   following syntax:

   .. code-block:: shell
      :class: copyable

      bm admin group ls TARGET

   The command accepts the following arguments:

   .. mc-cmd:: TARGET

      The :mc-cmd:`alias <bm alias>` of a configured Buckit deployment from
      which to retrieve groups.

.. mc-cmd:: rm, remove
   :fullpath:

   Removes a group on the target Buckit deployment. Removing a group does *not*
   remove any users with membership in the group. Use 
   :mc-cmd:`bm admin user rm` to remove users from a group. 
   
   The command has the following syntax:

   .. code-block:: shell
      :class: copyable

      bm admin group rm TARGET GROUPNAME

   The command accepts the following arguments:

   .. mc-cmd:: TARGET

      The :mc-cmd:`alias <bm alias>` of a configured Buckit deployment on which
      to remove the group.

   .. mc-cmd:: GROUPNAME

      The name of the group to remove.

.. mc-cmd:: enable
   :fullpath:

   Enables the group on the target Buckit deployment. Users can only inherit
   :ref:`policies <minio-policy>` from an enabled group.
   Groups are enabled on creation by default. The command has the following
   syntax:

   .. code-block:: shell
      :class: copyable

      bm admin group enable TARGET GROUPNAME

   The command accepts the following arguments:

   .. mc-cmd:: TARGET

      The :mc-cmd:`alias <bm alias>` of a configured Buckit deployment on
      which to enable the group.

   .. mc-cmd:: GROUPNAME

      The name of the group to enable. 

.. mc-cmd:: disable
   :fullpath:

   Disables the group on the target Buckit deployment. Users cannot inherit
   :ref:`policies <minio-policy>` from a disabled group. The
   command has the following syntax:

   .. code-block:: shell
      :class: copyable

      bm admin group disable TARGET GROUPNAME

   The command accepts the following arguments:

   .. mc-cmd:: TARGET

      The :mc-cmd:`alias <bm alias>` of a configured Buckit deployment on which
      to disable the group.

   .. mc-cmd:: GROUPNAME

      The name of the group to disable.

