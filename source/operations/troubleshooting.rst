===============
Troubleshooting
===============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

Overview
--------

Buckit users can seek support through the following channel.

#. Community support from the `public Slack channel <https://slack.min.io>`_.
   
   Community support is best-effort only and has no :abbr:`SLA (Service Level Agreement)` or :abbr:`SLO (Service Level Objective)`.
Tools
-----

The :ref:`Buckit Client <minio-client>` provides several functions to display information about your Buckit deployment or monitor its activity.

- For basic information about your Buckit deployment, use :mc-cmd:`bm admin info`.

- For deeper investigation of S3 calls and responses, use :mc-cmd:`bm admin trace`.

- Use :mc:`bm admin logs` to display logs from the command line.
  The command supports type and quantity filters for further limiting logs output.

Upgrades and version support
----------------------------

Buckit regularly releases updates to introduce features, improve performance, address security concerns, or fix bugs. 
These releases can occur very frequently, and vary by product.

Always test software releases in a development environment before upgrading on a production deployment.

Recommended upgrade schedule
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit recommends always installing the most recent release to obtain security enhancements and improvements.
We recognize that such a frequent release schedule may make this impractical for some organizations.
In such cases, we recommend using Buckit and our related product releases that are no older than six months.

Version Alignment
~~~~~~~~~~~~~~~~~

As the various Buckit products release separately on their own schedules, we recommend the following version alignment practices:

Buckit
   Update to the latest release or a release no older than six months.

Buckit Client
   Update to the `bm` release that occurs immediately after the Buckit release, within one or two weeks.

Buckit Operator
   Use a Buckit version no earlier than the latest at the time of the Operator release.
   The Buckit version latest at time of release can be found in the quay.io link in the example tenant kustomization yaml file for the Operator release.

   - 4.5.5: Buckit RELEASE.2022-12-07T00-56-37Z or later
   - 4.5.6: Buckit RELEASE.2023-01-02T09-40-09Z or later
   - 4.5.7: Buckit RELEASE.2023-01-12T02-06-16Z or later
   - 4.5.8: Buckit RELEASE.2023-01-12T02-06-16Z or later

   When creating a new tenant, the Operator uses either the latest available Buckit release image or the image you specify when creating the tenant.
   
   :ref:`Upgrading the Operator <minio-k8s-upgrade-minio-operator>` does **not** automatically upgrade existing tenants.
   :ref:`Upgrade existing tenant <minio-k8s-upgrade-minio-tenant>` Buckit versions separately.

.. toctree::
   :titlesonly:
   :hidden:

   /operations/troubleshooting/encrypting-files
