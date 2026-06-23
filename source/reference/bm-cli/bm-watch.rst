============
``bm watch``
============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm watch

Syntax
------

.. start-mc-watch-desc

The :mc:`bm watch` command watches for events on the specified Buckit bucket or
local filesystem path. For S3 services, use :mc:`bm event add` to configure
bucket event notifications on S3-compatible services.

.. end-mc-watch-desc

You can also use :mc:`bm watch` against a local filesystem directory to
produce similar results to running
the ``inotify -e modify,create,delete,move`` command.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command watches for 
      :ref:`events <mc-event-supported-events>` on any object or prefix in the 
      ``mydata`` bucket on the ``mybuckit`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm watch --recursive mybuckit/mydata

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] watch                \
                          [--event "string"]   \
                          [--prefix "string"]  \
                          [--recursive]        \
                          [--suffix "string"]  \
                          ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS

   *Required* The :ref:`alias <alias>` of a Buckit deployment and the
   full path to the bucket to watch for configured events. For example:

   .. code-block:: shell

      bm watch mybuckit/mybucket

.. mc-cmd:: --event
   

   The event(s) to watch for. Specify multiple events using a comma ``,``
   delimiter. See :ref:`mc-event-supported-events` for supported events.

   Defaults to ``put,delete, get``.
      
.. mc-cmd:: --prefix
   

   The bucket prefix in which to watch for the specified 
   :mc-cmd:`~bm watch --event`.

   For example, given a :mc-cmd:`~bm watch ALIAS` of ``play/mybucket`` and a 
   :mc-cmd:`~bm watch --prefix` of ``photos``, only events in 
   ``play/mybucket/photos`` trigger bucket notifications.

.. mc-cmd:: --recursive, r
   

   Recursively watch for events in the specified 
   :mc-cmd:`~bm watch ALIAS` bucket path or local directory.

.. mc-cmd:: --suffix
   

   The bucket suffix in which to watch for the specified 
   :mc-cmd:`~bm watch --event`.

   For example, given a :mc-cmd:`~bm watch ALIAS` of ``play/mybucket`` and a 
   :mc-cmd:`~bm watch --suffix` of ``.jpg``, only events in 
   ``play/mybucket/*.jpg`` trigger bucket notifications.

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-json-globals
   :end-before: end-minio-mc-json-globals

Examples
--------

Watch for Events in a Bucket
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: shell
   :class: copyable

   bm watch --recursive ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm watch ALIAS>` with the :mc:`alias <bm alias>`
  of the S3-compatible host.

- Replace :mc-cmd:`PATH <bm watch ALIAS>` with the path to the bucket.


Behavior
--------

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility

