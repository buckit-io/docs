====================
``bm admin service``
====================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin service

Description
-----------

.. start-mc-admin-service-desc

The :mc-cmd:`bm admin service` command can restart or unfreeze Buckit servers.

.. end-mc-admin-service-desc

:mc-cmd:`bm admin service` affects *all* Buckit servers in the target deployment
at the same time. The command interrupts in-progress API operations on
the Buckit deployment. Use caution when issuing this command to a deployment.

.. admonition:: Use ``bm admin`` on Buckit Deployments Only
   :class: note

   .. include:: /includes/facts-mc-admin.rst
      :start-after: start-minio-only
      :end-before: end-minio-only

Examples
--------

Restart Buckit Servers in Target Deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /includes/play-alias-available.rst
   :start-after: myminio-alias
   :end-before: end-myminio-alias

.. code-block:: shell
   :class: copyable

   bm admin service restart myminio

Resume S3 Calls on a Target Deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /includes/play-alias-available.rst
   :start-after: myminio-alias
   :end-before: end-myminio-alias

.. code-block:: shell
   :class: copyable

   bm admin service unfreeze myminio

Syntax
------

:mc-cmd:`bm admin service` has the following syntax:

.. code-block:: shell
   :class: copyable

   bm admin service COMMAND [ARGUMENTS]

:mc-cmd:`bm admin service` supports the following commands:

.. mc-cmd:: restart

   Restarts Buckit servers.
   If needed, the command may suggest restarting the node based on the status.

   :mc-cmd:`bm admin service restart` has the following syntax:

   .. code-block:: shell
      :class: copyable

      bm admin service restart ALIAS

   Specify the :mc-cmd:`alias <bm alias>` of a configured Buckit deployment.
   :mc-cmd:`~bm admin service restart` restarts *all* Buckit servers in the
   deployment.

.. mc-cmd:: unfreeze

   Restart S3 API calls on a Buckit cluster.

   :mc-cmd:`bm admin service unfreeze` has the following syntax:

   .. code-block:: shell
      :class: copyable

      bm admin service unfreeze ALIAS

   Specify the :mc-cmd:`alias <bm alias>` of a configured Buckit deployment.

