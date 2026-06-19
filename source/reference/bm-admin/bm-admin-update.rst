===================
``bm admin update``
===================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

.. mc:: bm admin update

Description
-----------

.. start-mc-admin-update-desc

The :mc-cmd:`bm admin update` command updates all Buckit servers in the deployment. 
The command also supports using a private mirror server for environments where the deployment does not have public internet access.

.. end-mc-admin-update-desc

After running the command, a prompt displays to confirm the update.
Type ``y`` and ``[ENTER]`` to confirm and proceed with the update.

The user **must** have ``write`` permissions for the target location where the binary installs.

.. admonition:: Use ``bm admin`` on Buckit Deployments Only
   :class: note

   .. include:: /includes/facts-mc-admin.rst
      :start-after: start-minio-only
      :end-before: end-minio-only


Considerations
--------------

Updates are Non-Disruptive
~~~~~~~~~~~~~~~~~~~~~~~~~~

:mc-cmd:`bm admin update` updates the binary and restarts all Buckit servers in the deployment simultaneously. 
Buckit operations are atomic and strictly consistent and as such the restart process is non-disruptive to applications.

Buckit strongly recommends only performing simultaneous upgrade-and-restart procedures. 
Do not perform "rolling" (that is, one node at a time) upgrade procedures.

Permissions
~~~~~~~~~~~

The user running the command **must** have ``write`` permissions to the target path where the Buckit Server binary installs.

Examples
--------

Use :mc-cmd:`bm admin update` to update each :mc:`minio` server process in the Buckit deployment:

.. code-block:: shell
   :class: copyable

   bm admin update ALIAS

Replace :mc-cmd:`ALIAS <bm admin update ALIAS>` with the :mc-cmd:`alias <bm alias>` of the Buckit deployment.

After running the command, answer yes to the prompt to confirm and process the update.

Syntax
------

:mc-cmd:`bm admin update` has the following syntax:

.. code-block:: shell
   :class: copyable

   bm admin update ALIAS         \
                   [MIRROR_URL]  \
                   [--yes]             

:mc-cmd:`bm admin update` supports the following arguments:

.. mc-cmd:: ALIAS

   The :mc-cmd:`alias <bm alias>` of the Buckit deployment to update. 

   If the specified ``ALIAS`` corresponds to a distributed Buckit deployment, :mc-cmd:`bm admin update` updates *all* Buckit servers in the deployment at the same time. 

   Use :mc:`bm alias list` to review the configured aliases and their corresponding Buckit deployment endpoints.

.. mc-cmd:: MIRROR_URL
   
   The mirror URL of the ``minio`` server binary to use for updating Buckit servers in the :mc-cmd:`~bm admin update ALIAS` deployment.

.. mc-cmd:: --yes, -y
   :optional:

   Pass this flag to confirm the update and bypass the confirmation prompt.

Behavior
--------

Binary Compression 
~~~~~~~~~~~~~~~~~~

.. versionchanged:: RELEASE.2024-01-28T22-35-53Z

   :mc-cmd:`bm admin update` compresses the binary before sending to all nodes in the deployment.

This feature does not apply to :ref:`systemctl managed deployments <minio-baremetal>`.