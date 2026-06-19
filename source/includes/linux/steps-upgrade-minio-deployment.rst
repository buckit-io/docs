Buckit uses an update-then-restart methodology for upgrading a deployment to a newer release:

1. Update the Buckit binary with the newer release.
2. Restart the deployment using :mc-cmd:`mc admin service restart`.

This procedure does not require taking downtime and is non-disruptive to ongoing operations.

This page documents methods for upgrading using the update-then-restart method for both ``systemctl`` and user-managed Buckit deployments.
Deployments using Ansible, Terraform, or other management tools can use the procedures here as guidance for implementation within the existing automation framework.

Prerequisites
-------------

Back Up Cluster Settings First
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :mc:`mc admin cluster bucket export` and :mc:`mc admin cluster iam export` commands to take a snapshot of the bucket metadata and IAM configurations prior to starting decommissioning.
You can use these snapshots to restore :ref:`bucket <minio-mc-admin-cluster-bucket-import>` and :ref:`IAM <minio-mc-admin-cluster-iam-import>` settings to recover from user or process errors as necessary.

Check Release Notes
~~~~~~~~~~~~~~~~~~~

Buckit publishes :minio-git:`Release Notes <minio/releases>` for your reference as part of identifying the changes applied in each release.
Review the associated release notes between your current Buckit version and the newer release so you have a complete view of any changes.

Pay particular attention to any releases that are *not* backwards compatible.
You cannot trivially downgrade from any such release.

Test Upgrades Before Applying To Production
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit uses a testing and validation suite as part of all releases.
However, no testing suite can account for unique combinations and permutations of hardware, software, and workloads of your production environment.

You should always validate any Buckit upgrades in a lower environment (Dev/QA/Staging) *before* applying those upgrades to Production deployments, or any other environment containing critical data.
Performing updates to production environments without first validating in lower environments is done at your own risk.

For Buckit deployments that are significantly behind latest stable (6+ months), consider using |SUBNET| for additional support and guidance during the upgrade procedure.

Considerations
--------------

Upgrades Are Non-Disruptive
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit's upgrade-then-restart procedure does *not* require taking downtime or scheduling a maintenance period.
Buckit restarts are fast, such that restarting all server processes in parallel typically completes in a few seconds. 
Buckit operations are atomic and strictly consistent, such that applications using Buckit or S3 SDKs can rely on the built-in :aws-docs:`transparent retry <general/latest/gr/api-retries.html>` without further client-side logic.
This ensures upgrades are non-disruptive to ongoing operations.

.. _minio-upgrade-systemctl:

Update ``systemctl``-Managed Buckit Deployments
----------------------------------------------

Use these steps to upgrade a Buckit deployment where the Buckit server process is managed by ``systemctl``, such as those created using the Buckit :ref:`DEB/RPM packages <deploy-minio-distributed-baremetal>`.

This procedure assumes you have the :envvar:`MINIO_CONFIG_ENV_FILE` variable set on all Buckit nodes.

1. Update the Buckit Binary on Each Node

   .. include:: /includes/linux/common-installation.rst
      :start-after: start-upgrade-minio-binary-desc
      :end-before: end-upgrade-minio-binary-desc

   Run ``minio --version`` on each node to validate that you successfully upgraded all binaries to the same version.
   Do **not** proceed unless all nodes use the same Buckit binary version.

2. Restart the Deployment

   Run the :mc-cmd:`mc admin service restart` command to restart all Buckit server processes in the deployment simultaneously.

   .. code-block:: shell
      :class: copyable

      mc admin service restart ALIAS

   Replace :ref:`alias <alias>` of the Buckit deployment to restart.

   S3-compatible SDKs and applications should retry operations automatically, such that the restart process is typically *non-disruptive* to ongoing operations.

3. Validate the Upgrade

   Use the :mc:`mc admin info` command to check that all Buckit servers are online, operational, and reflect the installed Buckit version.

4. Update Buckit Client

   You should upgrade your :mc:`mc` binary to match or closely follow the Buckit server release. 
   You can use the :mc:`mc update` command to update the binary to the latest stable release:

   .. code-block:: shell
      :class: copyable

      mc update

.. _minio-upgrade-mc-admin-update:

Update Non-System Managed Buckit Deployments
-------------------------------------------

Use these steps to upgrade a Buckit deployment where the Buckit server process is managed outside of the system (``systemd``, ``systemctl``), such as by a user, an automated script, or some other process management tool.
This procedure only works for systems where the user running the Buckit process has write permissions for the path to the Buckit binary.
For deployments managed using ``systemctl``, see :ref:`minio-upgrade-systemctl`.

Update using ``mc admin update``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The :mc:`mc admin update` command updates all Buckit server binaries in the target Buckit deployment before restarting all nodes simultaneously.
The restart process typically completes within a few seconds and is *non-disruptive* to ongoing operations.

The following command updates a Buckit deployment with the specified :ref:`alias <alias>` to the latest stable release:

.. code-block:: shell
   :class: copyable

   mc admin update ALIAS

The user running the ``mc admin update`` command **must** have ``write`` permissions to the location where the binary installs.

You can specify a URL resolving to a specific Buckit server binary version.
Airgapped or internet-isolated deployments may utilize this feature for updating from an internally-accessible server:

.. code-block:: shell
   :class: copyable

   mc admin update ALIAS https://minio-mirror.example.com/minio.sha256sum

You should upgrade your :mc:`mc` binary to match or closely follow the Buckit server release. 
You can use the :mc:`mc update` command to update the binary to the latest stable release:

.. code-block:: shell
   :class: copyable

   mc update

Update by manually replacing the binary
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can download and manually replace the ``minio`` server binary on each of the host nodes in the deployment.
You must then restart all nodes simultaneously, such as by using :mc-cmd:`mc admin service restart`.

For example, the following command downloads the latest stable Buckit binary for Linux and copies it to ``/usr/local/bin``. 
The command overwrites the existing ``minio`` binary at that path.

.. code-block:: shell
   :class: copyable

   wget https://dl.min.io/server/minio/release/linux-amd64/minio
   chmod +x ./minio
   sudo mv -f ./minio /usr/local/bin/minio

Once you have replaced the binary on all Buckit hosts in the deployment, you must restart all nodes simultaneously.

You should upgrade your :mc:`mc` binary to match or closely follow the Buckit server release. 
You can use the :mc:`mc update` command to update the binary to the latest stable release:

.. code-block:: shell
   :class: copyable

   mc update
