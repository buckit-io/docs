.. _minio-mc-admin-accesskey-list:

=========================
``bm admin accesskey ls``
=========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin accesskey list
.. mc:: bm admin accesskey ls


Syntax
------

.. start-mc-admin-accesskey-list-desc

The :mc:`bm admin accesskey ls` command lists users, access keys, or temporary :ref:`security token service <minio-security-token-service>` keys managed by the Buckit deployment.

.. end-mc-admin-accesskey-list-desc

The alias :mc:`bm admin accesskey list` has equivalent functionality to :mc:`bm admin accesskey ls`.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command lists all access keys associated to the user with username ``admin1`` on the deployment at alias ``mybuckit``:

      .. code-block:: shell  
         :class: copyable 

         bm admin accesskey ls mybuckit admin1

      The output resembles the following:
   
      .. code-block:: shell

            Access Key        | Expiry
         5XF3ZHNZK6FBDWH9JMLX | 2023-06-24 07:00:00 +0000 UTC
         F4V2BBUZSWY7UG96ED70 | 2023-12-24 18:00:00 +0000 UTC
         FZVSEZ8NM9JRBEQZ7B8Q | no-expiry
         HOXGL8ON3RG0IKYCHCUD | no-expiry

	 
   .. tab-item:: SYNTAX

      The command has the following syntax: 
  
      .. code-block:: shell  
         :class: copyable 
  
         bm [GLOBALFLAGS] admin accesskey ls             \  
                                          ALIAS          \ 
                                          [USER]         \
                                          [--all]        \
                                          [--self]       \
                                          [--temp-only]  \
                                          [--users-only]

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax


Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :mc-cmd:`alias <bm alias>` of the Buckit deployment.

.. mc-cmd:: USER
   :optional:

   The username of the user(s) to display access keys for.
   Separate multiple usernames with a space.

.. mc-cmd:: --all
   :optional:

   List all users and any access keys or temporary STS keys associated with them.
   Requires admin privileges for the deployment.

   This flag is mutually exclusive with the other flags available for this command.

.. mc-cmd:: --svcacc-only
   :optional:

   List temporary :ref:`Security Token Service (STS) keys <minio-security-token-service>` on the deployment.

   This flag is mutually exclusive with the other flags available for this command.

.. mc-cmd:: --self
   :optional:

   List access keys and STS keys for the currently authenticated user.

   This flag is mutually exclusive with the other flags available for this command.

.. mc-cmd:: --temp-only
   :optional:

   List users with their access keys.
   This returns only users that have associated access keys.

   This flag requires admin privileges for the user running the command.

   This flag is mutually exclusive with the other flags available for this command.

.. mc-cmd:: --users-only
   :optional:

   List the Buckit users managed by the deployment.
   Use in conjunction with the :mc-cmd:`~bm admin accesskey ls --all` flag to list all users on the deployment.

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

List all built-in users and associated access keys
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following command lists all users managed by the Buckit deployment at alias ``mybuckit`` and any associated access keys or temporary STS tokens.

.. code-block:: shell
   :class: copyable

   bm admin accesskey list mybuckit/ --all

Return a list of access keys for the current authenticated user
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following command lists the access keys or temporary STS tokens associated with the currently authenticated user for the ``mybuckit`` deployment.

.. code-block:: shell
   :class: copyable

   bm admin accesskey list mybuckit/ --self

List all users created and managed by the deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following command returns a list of all of the users on the current deployment.
The list only includes Buckit IDP managed users, not users managed by a third party tool on a protocol like OpenID or Active Directory/LDAP.

.. code-block:: shell
   :class: copyable

   bm admin accesskey ls mybuckit/ --all --users-only

Return a list of access keys associated with the users ``miniouser1`` and ``miniouser2``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following command returns a list of access keys for two users on the ``mybuckit`` deployment.

.. code-block:: shell
   :class: copyable

   bm admin accesskey ls mybuckit/ miniouser1 miniouser2

Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
