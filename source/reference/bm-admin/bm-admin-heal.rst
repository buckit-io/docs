=================
``bm admin heal``
=================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin heal

Description
-----------

.. start-mc-admin-heal-desc

The :mc-cmd:`bm admin heal` command scans for objects that are damaged or corrupted and heals those objects.  

.. end-mc-admin-heal-desc

:mc-cmd:`bm admin heal` is resource intensive and typically not required as a manual process, even after drive failures or corruption events. 

As a part of normal operations, Buckit:

- automatically heals objects damaged by silent bit rot corruption, drive failure, or other issues on each ``POST`` or ``GET`` operation. 
- performs periodic background object healing using the :ref:`scanner <minio-concepts-scanner>`.
- aggressively heals objects after drive replacement.

Refer to :ref:`minio-concepts-healing` for more details on how Buckit heals objects.

.. admonition:: Use ``bm admin`` on Buckit Deployments Only
   :class: note

   .. include:: /includes/facts-mc-admin.rst
      :start-after: start-minio-only
      :end-before: end-minio-only

Syntax
------

:mc-cmd:`bm admin heal` has the following syntax:

.. code-block:: shell
   :class: copyable

   bm admin heal [FLAGS] TARGET             \
                         [--all-drives, -a] \
                         [--force]          \
                         [--verbose, -v]

:mc-cmd:`bm admin heal` supports the following arguments:

.. mc-cmd:: TARGET
   :required:

   The full path to the bucket or bucket prefix on which the command should perform object healing. 
   Specify the :mc-cmd:`alias <bm alias>` of a configured Buckit deployment as the prefix for the path. 
   For example:

   .. code-block:: shell
      :class: copyable

      bm admin heal play/mybucket/myprefix

   If the ``TARGET`` bucket or bucket prefix has an active healing scan, the command returns the status of that scan.

.. mc-cmd:: --all-drives, -a
   :optional:

   Select all drives and show verbose information.

.. mc-cmd:: --force
   :optional:

   Disables warning prompts.

.. mc-cmd:: --verbose, -v
   :optional:

   Show information about offline and faulty healing drives.


.. _minio-concepts-healing-colors:

Healing Colors
--------------

Some versions of Buckit used a color key as a way to differentiate objects with different healing statuses.

.. versionchanged:: mc RELEASE.2024-11-17T19-35-25Z

The color meaning has been updated.

- Green indicates the bucket is healthy.
- Yellow indicates the bucket requires healing on one or more drives.
- Red indicates one or more drives are unhealthy.
- Grey indicates an indeterminate healing state.