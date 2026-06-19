=======================
``bm support callhome``
=======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

.. mc:: bm support logs disable
.. mc:: bm support logs enable
.. mc:: bm support logs status
   
.. mc:: bm support callhome

Description
-----------

.. start-mc-support-callhome-desc

The :mc-cmd:`bm support callhome` command allows the enabling or disabling of diagnostic information from a deployment to |SUBNET|.

.. end-mc-support-callhome-desc

All ``bm support`` commands require an active SUBNET subscription.

When enabled, Buckit sends diagnostic information to SUBNET.

Buckit disables this functionality by default, regardless of registration status.
You must explicitly enable the ``callhome`` function to begin information upload.

.. include:: /includes/common-mc-support.rst
   :start-after: start-minio-only
   :end-before: end-minio-only

Syntax
------

.. mc-cmd:: enable
   :fullpath:

   Begin sending a deployment's diagnostics, logs, or both to SUBNET.

   .. code-block:: shell
               
      bm support callhome enable    \
                          ALIAS     \
                          [--logs]  \
                          [--diag]

   .. note::

      The ``--logs`` and ``--diag`` flags are no longer supported in SUBNET and will be removed in a future release.

.. mc-cmd:: disable
   :fullpath:

   Stop sending a deployment's diagnostics, logs, or both to SUBNET.

   .. code-block:: shell
               
      bm support callhome disable  \
                          ALIAS    \
                          [--logs] \
                          [--diag]

   .. note::

      The ``--logs`` and ``--diag`` flags are no longer supported in SUBNET and will be removed in a future release.

.. mc-cmd:: status
   :fullpath:

   Output whether a deployment currently sends diagnostics, logs, or both to SUBNET.

   .. code-block:: shell
               
      bm support callhome status   \
                          ALIAS    \
                          [--diag]

   .. note::

      The ``--diag`` flag is no longer supported in SUBNET and will be removed in a future release.
            
Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The :ref:`alias <alias>` of the Buckit deployment.

.. mc-cmd:: --diag
   :optional:

   .. note::

      This option is no longer supported in SUBNET and will be removed in a future release.

   Send or stop sending deployment diagnostic information to SUBNET every 24 hours.

Examples
--------

Enable ``callhome`` reporting
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Enable sending diagnostic information to SUBNET for a deployment registered to SUBNET with an :ref:`alias <alias>` of ``minio1``.

.. code-block:: shell
   :class: copyable
 
   bm support callhome enable minio1

Disable ``callhome`` reporting
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Disable sending diagnostic information to SUBNET for a deployment registered to SUBNET with an :ref:`alias <alias>` of ``minio1``.

.. code-block:: shell
   :class: copyable

   bm support callhome disable minio1


Display Current ``callhome`` settings
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Display whether a deployment with the alias ``minio1`` sends information to SUBNET.

.. code-block:: shell
   :class: copyable
 
   bm support callhome status minio1

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

