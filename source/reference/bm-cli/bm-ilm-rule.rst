===============
``bm ilm rule``
===============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm ilm rule

.. versionchanged:: RELEASE.2022-12-24T15-21-38Z

   The following commands have moved to subcommands under :mc-cmd:`bm ilm rule`:

   - :mc-cmd:`bm ilm add`
   - :mc-cmd:`bm ilm edit`
   - :mc-cmd:`bm ilm export`
   - :mc-cmd:`bm ilm import`
   - :mc-cmd:`bm ilm ls`
   - :mc-cmd:`bm ilm rm`


Description
-----------

.. start-mc-ilm-rule-desc

The :mc:`bm ilm rule` command and its subcommands configure the rules used to transition objects between storage tiers in Buckit's Lifecycle Management. 

.. end-mc-ilm-rule-desc

Before creating rules with this command, use :mc-cmd:`bm ilm tier` and its subcommands to create the tier or tiers of other object storage locations where objects move.

For more information, see the overview of :ref:`lifecycle management <minio-lifecycle-management>`.


Subcommands
-----------

:mc-cmd:`bm ilm rule` includes the following subcommands:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Subcommand
     - Description

   * - :mc:`~bm ilm rule add`
     - .. include:: /reference/bm-cli/bm-ilm-rule-add.rst
          :start-after: start-mc-ilm-rule-add-desc
          :end-before: end-mc-ilm-rule-add-desc

   * - :mc:`~bm ilm rule edit`
     - .. include:: /reference/bm-cli/bm-ilm-rule-edit.rst
          :start-after: start-mc-ilm-rule-edit-desc
          :end-before: end-mc-ilm-rule-edit-desc

   * - :mc:`~bm ilm rule export`
     - .. include:: /reference/bm-cli/bm-ilm-rule-export.rst
          :start-after: start-mc-ilm-rule-export-desc
          :end-before: end-mc-ilm-rule-export-desc

   * - :mc:`~bm ilm rule import`
     - .. include:: /reference/bm-cli/bm-ilm-rule-import.rst
          :start-after: start-mc-ilm-rule-import-desc
          :end-before: end-mc-ilm-rule-import-desc

   * - :mc:`~bm ilm rule ls`
     - .. include:: /reference/bm-cli/bm-ilm-rule-ls.rst
          :start-after: start-mc-ilm-rule-ls-desc
          :end-before: end-mc-ilm-rule-ls-desc

   * - :mc:`~bm ilm rule rm`
     - .. include:: /reference/bm-cli/bm-ilm-rule-rm.rst
          :start-after: start-mc-ilm-rule-rm-desc
          :end-before: end-mc-ilm-rule-rm-desc

.. _minio-mc-ilm-rule-permissions:

Permissions
-----------

Buckit requires the following permissions scoped to to the bucket or buckets for which you create lifecycle management rules.

- :policy-action:`s3:PutLifecycleConfiguration`
- :policy-action:`s3:GetLifecycleConfiguration`

For example, the following policy provides permission for configuring object
transition lifecycle management rules on any bucket in the cluster:.

.. literalinclude:: /extra/examples/LifecycleManagementAdmin.json
   :language: json
   :class: copyable

Transition Permissions
~~~~~~~~~~~~~~~~~~~~~~

Object transition lifecycle management rules require additional permissions
on the remote storage tier. Specifically, Buckit requires the remote
tier credentials provide read, write, list, and delete permissions.

For example, if the remote storage tier implements AWS IAM policy-based
access control, the following policy provides the necessary permission
for transitioning objects into and out of the remote tier:

.. literalinclude:: /extra/examples/LifecycleManagementUser.json
   :language: json
   :class: copyable

Modify the ``Resource`` for the bucket into which Buckit tiers objects.

Defer to the documentation for the supported tiering targets for more complete
information on configuring users and permissions to support Buckit tiering:

- :aws-docs:`Amazon S3 Permissions <service-authorization/latest/reference/list_amazons3.html#amazons3-actions-as-permissions>`
- `Google Cloud Storage Access Control <https://cloud.google.com/storage/docs/access-control>`__
- `Authorizing access to data in Azure storage <https://docs.microsoft.com/en-us/azure/storage/common/storage-auth?toc=/azure/storage/blobs/toc.json>`__

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-ilm-rule-add
   /reference/bm-cli/bm-ilm-rule-edit
   /reference/bm-cli/bm-ilm-rule-export
   /reference/bm-cli/bm-ilm-rule-import
   /reference/bm-cli/bm-ilm-rule-ls
   /reference/bm-cli/bm-ilm-rule-rm