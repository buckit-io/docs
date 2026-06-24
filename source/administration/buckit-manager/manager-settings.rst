:orphan:

.. _bm-web-settings:

====================================
Connection and Application Settings
====================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

You can use the :ref:`Buckit Manager web interface <buckit-manager-web>` to
configure the credentials Buckit Manager uses to reach each cluster, review the
history of actions you have run, and manage application settings such as
updates. This page describes those settings.

.. _bm-web-ssh-credentials:

SSH Credentials
---------------

Buckit Manager uses SSH to install upgrades, swap systemd units, run rolling
restarts, reboot hosts, and provision replacement nodes. Operations that run
over SSH are unavailable until you configure SSH credentials for the cluster.

Reach the SSH credentials page from the :guilabel:`Configure SSH credentials`
item in the cluster gear menu, or from the prompt shown when you start an
SSH-based operation without credentials configured.

Configure a default credential set for the cluster:

- :guilabel:`Authentication` — choose how Buckit Manager authenticates:

  - :guilabel:`Use SSH agent` — authenticate through keys loaded into your
    ``ssh-agent`` (run ``ssh-add`` first).
  - :guilabel:`Use key file` — point Buckit Manager at a private key file on
    disk, with an optional passphrase.
  - :guilabel:`Password` — authenticate with an SSH password. Most production
    servers disable this; use it only for legacy hosts.

- :guilabel:`SSH user` and :guilabel:`SSH port` — the login user and port.
- :guilabel:`Use sudo (passwordless)` — required when the SSH user is not
  ``root``. The user must be able to install packages, write configuration
  under ``/etc``, prepare storage directories, and manage the systemd service.

The :guilabel:`Hosts` table lists every node in the cluster. You can set a
per-host SSH port, enable custom credentials for individual hosts that differ
from the default, and select :guilabel:`Test SSH connection` to probe every
host and confirm reachability before saving.

Select :guilabel:`Save SSH credentials on this computer for future operations`
to persist the credentials so later operations can reuse them without
re-prompting. When saved, credentials and passphrases are encrypted at rest.

.. _bm-web-admin-credentials:

Admin Credentials
-----------------

Buckit Manager uses admin API credentials to fetch detailed cluster and
hardware facts and to run admin-API operations. Reach the admin credentials
page from the :guilabel:`Set admin credentials` item in the cluster gear menu.

Provide:

- :guilabel:`Admin API URL` — the S3 endpoint Buckit Manager uses for admin
  calls.
- :guilabel:`Root username` and :guilabel:`Current root password` — the
  cluster root credentials.
- :guilabel:`Skip TLS certificate verification` — enable for deployments using
  a self-signed or otherwise untrusted certificate.

The stored password is encrypted and is never displayed back to you.

This page also includes a :guilabel:`Danger zone` for removing the cluster
definition from the manager. Removing a cluster stops tracking it; the hosts
and data are not changed.

.. _bm-web-history:

History
-------

The :guilabel:`History` section lists every action you have run from this
manager, with the time, operation, cluster, scope (cluster-wide, a single host,
or a set of hosts), status, and duration.

Read-only fetches and background polling are not recorded, and command-line
invocations of ``bm`` are out of scope.

You can:

- Filter by status (:guilabel:`Succeeded`, :guilabel:`Failed`,
  :guilabel:`Running`, :guilabel:`Canceled`) and by cluster, and search by
  operation, cluster, or hostname.
- Select :guilabel:`View` on a finished entry to see its detailed result.
- Select :guilabel:`Clear history` to remove all entries from this machine.
  Clearing history does not affect any cluster.

.. _bm-web-app-settings:

Application Settings
--------------------

The :guilabel:`Settings` section manages the Buckit Manager application itself.

About
~~~~~

The :guilabel:`About` group shows the installed Buckit Manager version. Select
:guilabel:`Check for updates` to query for a newer stable release. When an
update is available and can be applied, Buckit Manager can download and install
it; the running ``bm web`` process keeps running until you restart it.

Remote Access
~~~~~~~~~~~~~

By default, ``bm web`` listens only on ``127.0.0.1`` and is reachable only from
the machine where it runs. See :ref:`bm-web-loopback`.

.. tip::

   An optional remote-access mode that allows access from other devices on your
   network — requiring a passcode and using TLS — is planned for a future
   release.
