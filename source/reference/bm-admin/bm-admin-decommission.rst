.. _minio-mc-admin-decommission:

=========================
``bm admin decommission``
=========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm admin decommission

Syntax
------

.. start-mc-admin-decommission-desc

The :mc-cmd:`bm admin decommission` command starts the decommissioning process for a
Buckit :ref:`server pools <minio-intro-server-pool>`. Decommissioning is designed
for removing an older server pool whose hardware is no longer sufficient or
performant compared to the pools in the deployment. Buckit automatically migrates
data from the decommissioned pool to the remaining pools in the deployment based
on the ratio of free space available in each pool.

.. end-mc-admin-decommission-desc

See :ref:`minio-decommissioning` for a complete procedure on
decommissioning a server pool.

.. admonition:: Decommissioning is Permanent
   :class: important

   Once Buckit begins decommissioning a pool, it marks that pool as *permanently*
   inactive ("draining"). Cancelling or otherwise interrupting the 
   decommissioning procedure does **not** restore the pool to an active
   state.

   Decommissioning is a major administrative operation that requires care
   in planning and execution, and is not a trivial or 'daily' task. 


.. code-block:: shell

   bm admin [GLOBALFLAGS] decommission start|status|cancel ALIAS TARGET

Parameters
~~~~~~~~~~

.. mc-cmd:: start

   *Required* Starts the decommissioning process for the server pool specified
   to :mc-cmd:`~bm admin decommission TARGET`.

   Requires specifying :mc-cmd:`~bm admin decommission TARGET`

.. mc-cmd:: status

   *Required* Returns the decommissioning status of all server pools on the
   specified :mc-cmd:`~bm admin decommission ALIAS`:

   - :guilabel:`Active` - The pool is active and not scheduled for
     decommissioning.

   - :guilabel:`Draining` - The pool is currently decommissioning.

   - :guilabel:`Draining (Failed)` - The decommissioning process failed and
     requires manually restart.

   - :guilabel:`Draining (Cancelled)` - The decommissioning process was
     manually cancelled.

   If the command includes a :mc-cmd:`~bm admin decommission TARGET`, 
   the command output includes the rate of data migration *if*
   decommissioning is in progress.

.. mc-cmd:: cancel

   *Required* Cancels an ongoing decommissioning process on the pool specified
   to :mc-cmd:`~bm admin decommission TARGET`.

   Requires specifying :mc-cmd:`~bm admin decommission TARGET`.

   Cancelling a decommissioning process does not return the pool to an active
   state. You must eventually complete the decommissioning process and remove
   the pool from the deployment. You can resume the process by
   running :mc-cmd:`bm admin decommission start` again against the pool.

.. mc-cmd:: ALIAS

   *Required* The :ref:`alias <alias>` of the Buckit deployment on which to start
   the decommissioning process.

.. mc-cmd:: TARGET

   The full description of the server pool on which the command operates. For
   example:

   .. code-block:: shell

      https://buckit-{01...04}.example.net:9000/mnt/disk{1...4}



Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

See :ref:`minio-decommissioning` for a complete procedure on
decommissioning a server pool.
