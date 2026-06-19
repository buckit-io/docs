.. _minio-client:

==================
Buckit Manager CLI
==================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

.. mc:: bm

The Buckit Manager CLI uses the :program:`bm` command for object storage and
administration commands. It provides a modern alternative to UNIX commands
like ``ls``, ``cat``, ``cp``, ``mirror``, and ``diff`` with support for both
filesystems and Amazon S3-compatible cloud storage services.

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: minio-mc-s3-compatibility

:mc-cmd:`bm` has the following syntax:

.. code-block:: shell

   bm [GLOBALFLAGS] COMMAND --help

See :ref:`minio-mc-commands` for a list of supported commands.

.. _mc-client-versioning:

Version Alignment with Buckit Server
-----------------------------------

Buckit Manager releases separately from the Buckit Server.

For best functionality and compatibility, use a Buckit Manager version
released closely to your Buckit Server version. For example, a Buckit Manager
version released the same day or later than your Buckit Server version.

You can install a version of Buckit Manager that is more recent than the
Buckit Server version. However, if the version skews too far from the Buckit
Server version, you may see increased warnings or errors as a result of the
differences.
For example, while core S3 APIs around copying (:mc:`bm cp`) may remain unchanged, some features or flags may only be available or stable if the client and server versions are aligned.

.. _mc-install:

Quickstart
----------

1) Install ``bm``
~~~~~~~~~~~~~~~~~

Install the :program:`bm` command line tool onto the host machine. Click
the tab that corresponds to the host machine operating system or environment:

.. include:: /includes/minio-mc-installation.rst

2) Create an Alias for the S3-Compatible Service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. important::

   The following example temporarily disables the bash history to mitigate the
   risk of authentication credentials leaking in plain text. This is a basic
   security measure and does not mitigate all possible attack vectors. Defer to
   security best practices for your operating system for inputting sensitive
   information on the command line.

Use the :mc:`bm alias set` command to add an Amazon S3-compatible service
to the :mc-cmd:`bm` :ref:`configuration <mc-configuration>`.

.. code-block:: shell
   :class: copyable

   bash +o history
   bm alias set ALIAS HOSTNAME ACCESS_KEY SECRET_KEY
   bash -o history

- Replace ``ALIAS`` with a name to associate to the S3 service. 
  :mc-cmd:`bm` commands typically require ``ALIAS`` as an argument for
  identifying which S3 service to execute against.

- Replace ``HOSTNAME`` with the URL endpoint or IP address of the S3 service.

- Replace ``ACCESS_KEY`` and ``SECRET_KEY`` with the access and secret 
  keys for a user on the S3 service. 

Replace each argument with the required values.
If you omit the ``ACCESS_KEY`` and ``SECRET_KEY``, the command prompts you to enter those values in the CLI.

Each of the following tabs contains a provider-specific example:

.. tab-set::

   .. tab-item:: Buckit Server

      .. code-block:: shell
         :class: copyable

         bm alias set myminio https://minioserver.example.net ACCESS_KEY SECRET_KEY

   .. tab-item:: AWS S3 Storage

      .. code-block:: shell
         :class: copyable

         bm alias set myS3 https://s3.{your-region-code}.amazonaws.com/endpoint ACCESS_KEY SECRET_KEY

   .. tab-item:: Google Cloud Storage

      .. code-block:: shell
         :class: copyable

         bm alias set myGCS https://storage.googleapis.com/endpoint ACCESS_KEY SECRET_KEY

3) Test the Connection
~~~~~~~~~~~~~~~~~~~~~~

Use the :mc-cmd:`bm admin info` command to test the connection to
the newly added Buckit deployment:

.. code-block:: shell
   :class: copyable

   bm admin info myminio

The command returns information on the S3 service if successful. If
unsuccessful, check each of the following:

- The host machine has connectivity to the S3 service URL (i.e. using ``ping``
  or ``traceroute``).

- The specified ``ACCESSKEY`` and ``SECRETKEY`` correspond to a user on the
  S3 service. The user must have permission to perform actions on the
  service. 
  
  For Buckit deployments, see :ref:`minio-access-management`
  for more information on user access permissions. For other S3-compatible
  services, defer to the documentation for that service.

.. _minio-mc-commands:

Command Quick Reference
-----------------------

The following table lists :mc-cmd:`bm` commands:

.. note:: 

   Buckit Manager also includes an administration extension for managing Buckit deployments.
   See :mc:`bm admin` for more complete documentation.

   The below table does not include those commands.

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Command
     - Description

   * - | :mc:`bm alias list`
       | :mc:`bm alias remove`
       | :mc:`bm alias set`
       | :mc:`bm alias import`
       | :mc:`bm alias export`
     - .. include:: /reference/bm-cli/bm-alias.rst
          :start-after: start-mc-alias-desc
          :end-before: end-mc-alias-desc
     
   * - | :mc:`bm anonymous get`
       | :mc:`bm anonymous get-json`
       | :mc:`bm anonymous links`
       | :mc:`bm anonymous list`
       | :mc:`bm anonymous set`
       | :mc:`bm anonymous set-json`
     - .. include:: /reference/bm-cli/bm-anonymous.rst
          :start-after: start-mc-anonymous-desc
          :end-before: end-mc-anonymous-desc
     
   * - | :mc:`bm batch describe`
       | :mc:`bm batch generate`
       | :mc:`bm batch list`
       | :mc:`bm batch start`
       | :mc:`bm batch status`
     - .. include:: /reference/bm-cli/bm-batch.rst
          :start-after: start-mc-batch-desc
          :end-before: end-mc-batch-desc

   * - :mc:`bm cat`
     - .. include:: /reference/bm-cli/bm-cat.rst
          :start-after: start-mc-cat-desc
          :end-before: end-mc-cat-desc
     
   * - :mc:`bm cp`
     - .. include:: /reference/bm-cli/bm-cp.rst
          :start-after: start-mc-cp-desc
          :end-before: end-mc-cp-desc
     
   * - :mc:`bm diff`
     - .. include:: /reference/bm-cli/bm-diff.rst
          :start-after: start-mc-diff-desc
          :end-before: end-mc-diff-desc

   * - :mc:`bm du`
     - .. include:: /reference/bm-cli/bm-du.rst
          :start-after: start-mc-du-desc
          :end-before: end-mc-du-desc
     
   * - | :mc:`bm encrypt clear`
       | :mc:`bm encrypt info`
       | :mc:`bm encrypt set`
     - .. include:: /reference/bm-cli/bm-encrypt.rst
          :start-after: start-mc-encrypt-desc
          :end-before: end-mc-encrypt-desc
     
   * - | :mc:`bm event add`
       | :mc:`bm event ls`
       | :mc:`bm event rm`
     - .. include:: /reference/bm-cli/bm-event.rst
          :start-after: start-mc-event-desc
          :end-before: end-mc-event-desc
     
   * - :mc:`bm find`
     - .. include:: /reference/bm-cli/bm-find.rst
          :start-after: start-mc-find-desc
          :end-before: end-mc-find-desc

   * - :mc:`bm get`
     - .. include:: /reference/bm-cli/bm-get.rst
          :start-after: start-mc-get-desc
          :end-before: end-mc-get-desc  

   * - :mc:`bm head`
     - .. include:: /reference/bm-cli/bm-head.rst
          :start-after: start-mc-head-desc
          :end-before: end-mc-head-desc
     
   * - | :mc:`bm idp ldap accesskey`
       | :mc:`bm idp ldap accesskey create-with-login`
       | :mc:`bm idp ldap add`
       | :mc:`bm idp ldap disable`
       | :mc:`bm idp ldap enable`
       | :mc:`bm idp ldap info`
       | :mc:`bm idp ldap ls`
       | :mc:`bm idp ldap policy`
       | :mc:`bm idp ldap rm`
       | :mc:`bm idp ldap update`
     - .. include:: /reference/bm-cli/bm-idp-ldap.rst
          :start-after: start-mc-idp-ldap-desc
          :end-before: end-mc-idp-ldap-desc

   * - | :mc:`bm idp openid add`
       | :mc:`bm idp openid disable`
       | :mc:`bm idp openid enable`
       | :mc:`bm idp openid info`
       | :mc:`bm idp openid ls`
       | :mc:`bm idp openid rm`
       | :mc:`bm idp openid update`
     - .. include:: /reference/bm-cli/bm-idp-openid.rst
          :start-after: start-mc-idp-openid-desc
          :end-before: end-mc-idp-openid-desc

   * - | :mc:`bm idp ldap policy attach`
       | :mc:`bm idp ldap policy detach`
       | :mc:`bm idp ldap policy entities`
     - .. include:: /reference/bm-cli/bm-idp-ldap-policy.rst
          :start-after: start-mc-idp-ldap-policy-desc
          :end-before: end-mc-idp-ldap-policy-desc

   * - | :mc:`bm ilm restore`
       | :mc:`bm ilm rule add`
       | :mc:`bm ilm rule edit`
       | :mc:`bm ilm rule export`
       | :mc:`bm ilm rule import`
       | :mc:`bm ilm rule ls`
       | :mc:`bm ilm rule rm`
       | :mc:`bm ilm tier add`
       | :mc:`bm ilm tier check`
       | :mc:`bm ilm tier info`
       | :mc:`bm ilm tier ls`
       | :mc:`bm ilm tier rm`
       | :mc:`bm ilm tier update`
     - .. include:: /reference/bm-cli/bm-ilm.rst
          :start-after: start-mc-ilm-desc
          :end-before: end-mc-ilm-desc
     
   * - | :mc:`bm legalhold clear`
       | :mc:`bm legalhold info`
       | :mc:`bm legalhold set`
     - .. include:: /reference/bm-cli/bm-legalhold.rst
          :start-after: start-mc-legalhold-desc
          :end-before: end-mc-legalhold-desc

   * - | :mc:`bm license info`
       | :mc:`bm license register`
       | :mc:`bm license update`
     - .. include:: /reference/bm-cli/bm-license.rst
          :start-after: start-mc-license-desc
          :end-before: end-mc-license-desc

   * - :mc:`bm ls`
     - .. include:: /reference/bm-cli/bm-ls.rst
          :start-after: start-mc-ls-desc
          :end-before: end-mc-ls-desc
     
   * - :mc:`bm mb`
     - .. include:: /reference/bm-cli/bm-mb.rst
          :start-after: start-mc-mb-desc
          :end-before: end-mc-mb-desc
     
   * - :mc:`bm mirror`
     - .. include:: /reference/bm-cli/bm-mirror.rst
          :start-after: start-mc-mirror-desc
          :end-before: end-mc-mirror-desc
     
   * - :mc:`bm mv`
     - .. include:: /reference/bm-cli/bm-mv.rst
          :start-after: start-mc-mv-desc
          :end-before: end-mc-mv-desc

   * - :mc:`bm od`
     - .. include:: /reference/bm-cli/bm-od.rst
          :start-after: start-mc-od-desc
          :end-before: end-mc-od-desc

   * - :mc:`bm ping`
     - .. include:: /reference/bm-cli/bm-ping.rst
          :start-after: start-mc-ping-desc
          :end-before: end-mc-ping-desc  

   * - :mc:`bm pipe`
     - .. include:: /reference/bm-cli/bm-pipe.rst
          :start-after: start-mc-pipe-desc
          :end-before: end-mc-pipe-desc  

   * - :mc:`bm put`
     - .. include:: /reference/bm-cli/bm-put.rst
          :start-after: start-mc-put-desc
          :end-before: end-mc-put-desc  

   * - :mc:`bm rb`
     - .. include:: /reference/bm-cli/bm-rb.rst
          :start-after: start-mc-rb-desc
          :end-before: end-mc-rb-desc
     
   * - :mc:`bm ready`
     - .. include:: /reference/bm-cli/bm-ready.rst
          :start-after: start-mc-ready-desc
          :end-before: end-mc-ready-desc

   * - | :mc:`bm replicate add`
       | :mc:`bm replicate backlog`
       | :mc:`bm replicate export`
       | :mc:`bm replicate import`
       | :mc:`bm replicate ls`
       | :mc:`bm replicate resync`
       | :mc:`bm replicate rm`
       | :mc:`bm replicate status`
       | :mc:`bm replicate update`
     - .. include:: /reference/bm-cli/bm-replicate.rst
          :start-after: start-mc-replicate-desc
          :end-before: end-mc-replicate-desc
     
   * - | :mc:`bm retention clear`
       | :mc:`bm retention info`
       | :mc:`bm retention set`
     - .. include:: /reference/bm-cli/bm-retention.rst
          :start-after: start-mc-retention-desc
          :end-before: end-mc-retention-desc

   * - :mc:`bm rm`
     - .. include:: /reference/bm-cli/bm-rm.rst
          :start-after: start-mc-rm-desc
          :end-before: end-mc-rm-desc
     
   * - | :mc:`bm share download`
       | :mc:`bm share ls`
       | :mc:`bm share upload`
     - .. include:: /reference/bm-cli/bm-share.rst
          :start-after: start-mc-share-desc
          :end-before: end-mc-share-desc
     
   * - :mc:`bm sql`
     - .. include:: /reference/bm-cli/bm-sql.rst
          :start-after: start-mc-sql-desc
          :end-before: end-mc-sql-desc
     
   * - :mc:`bm stat`
     - .. include:: /reference/bm-cli/bm-stat.rst
          :start-after: start-mc-stat-desc
          :end-before: end-mc-stat-desc

   * - | :mc:`bm support callhome`
       | :mc:`bm support diag`
       | :mc:`bm support inspect`
       | :mc:`bm support perf`
       | :mc:`bm support profile`
       | :mc:`bm support proxy`
       | :mc:`bm support top api`
       | :mc:`bm support top disk`
       | :mc:`bm support top locks`
       | :mc:`bm support upload`
     - .. include:: /reference/bm-cli/bm-support.rst
          :start-after: start-mc-support-desc
          :end-before: end-mc-support-desc

   * - | :mc:`bm tag list`
       | :mc:`bm tag remove`
       | :mc:`bm tag set`
     - .. include:: /reference/bm-cli/bm-tag.rst
          :start-after: start-mc-tag-desc
          :end-before: end-mc-tag-desc
     
   * - :mc:`bm tree`
     - .. include:: /reference/bm-cli/bm-tree.rst
          :start-after: start-mc-tree-desc
          :end-before: end-mc-tree-desc
     
   * - :mc:`bm undo`
     - .. include:: /reference/bm-cli/bm-undo.rst
          :start-after: start-mc-undo-desc
          :end-before: end-mc-undo-desc

   * - :mc:`bm update`
     - .. include:: /reference/bm-cli/bm-update.rst
          :start-after: start-mc-update-desc
          :end-before: end-mc-update-desc
     
   * - | :mc:`bm version enable`
       | :mc:`bm version info`
       | :mc:`bm version suspend`
     - .. include:: /reference/bm-cli/bm-version.rst
          :start-after: start-mc-version-desc
          :end-before: end-mc-version-desc
     
   * - :mc:`bm watch`
     - .. include:: /reference/bm-cli/bm-watch.rst
          :start-after: start-mc-watch-desc
          :end-before: end-mc-watch-desc

.. _mc-configuration:

Configuration File
------------------

:mc-cmd:`bm` stores aliases and other CLI settings in a ``JSON`` configuration
file.

By default, :mc-cmd:`bm` uses the following paths:

- Linux and macOS: ``~/.config/bm/config.json``
- Windows: ``%APPDATA%\bm\config.json``

You can override the configuration directory with the global
``--config-dir`` option or the :envvar:`MC_CONFIG_DIR` environment variable.

.. _minio-mc-certificates:

Certificates
------------

The Buckit Manager CLI stores certificates and CAs for deployments to the following paths:

Linux, macOS, and other Unix-like systems:

.. code-block:: shell

   ~/.config/bm/certs/ # certificates
   ~/.config/bm/certs/CAs/ # Certificate Authorities

Windows systems:

.. code-block:: shell

   %APPDATA%\bm\certs\ # certificates
   %APPDATA%\bm\certs\CAs\ # Certificate Authorities

When creating a new :ref:`alias <minio-mc-alias>`, the Buckit Manager CLI fetches the peer certificate, computes the public key fingerprint, and asks the user whether to accept the deployment's certificate.
If you decide to trust the certificate, the Buckit Manager CLI adds the certificate to the certificate authority path listed above.

.. note::

   In testing environments, you can bypass the certificate check for selected Buckit Manager CLI commands by passing the ``--insecure`` flag.

.. _minio-wildcard-matching:

Pattern Matching
----------------

Some commands and flags allow for pattern matching.
When enabled, a pattern can include either of these wildcards for character replacement:
   
- ``*`` to represent a string of characters to match, either in the middle or end.
- ``?`` to represent a single character.

For example, refer to the following examples for wildcard uses and their results.

.. list-table::
   :header-rows: 1
   :widths: 40 30 30
   :width: 100%

   * - Pattern
     - Text
     - Match Result

   * - ``abc*``
     - ab
     - Match

   * - ``abc*``
     - abd
     - Not a match
  
   * - ``abc*c``
     - abcd
     - Match

   * - ``ab*??d``
     - abxxc
     - Match

   * - ``ab*??d``
     - abxc
     - Match

   * - ``ab??d``
     - abxc
     - Match

   * - ``ab??d``
     - abc
     - Match

   * - ``ab??d``
     - abcxdd
     - Not a match

.. _minio-mc-global-options:

Global Options
--------------

.. program:: bm

All :ref:`commands <minio-mc-commands>` support the following global options.
You can also define some of these options using :ref:`Environment Variables <minio-server-envvar-mc>`.

.. option:: --config-dir

   The path to a ``JSON`` formatted configuration file that
   :program:`bm` uses for storing data. See :ref:`mc-configuration` for
   more information on how :program:`bm` uses the configuration file.

   Alternatively, set the environment variable :envvar:`MC_CONFIG_DIR`.

.. option:: --debug

   Enables verbose output to the console.

   For example, the following operation adds verbose output to the 
   :mc:`bm ls` command:

   .. code-block:: shell
      :class: copyable

      bm --debug ls play

   Alternatively, set the environment variable :envvar:`MC_DEBUG`.

.. option:: --disable-pager, --dp

   .. versionadded:: mc RELEASE.2024-04-29T09-56-05Z

   Disable the pager functionality of the Buckit Manager CLI in the CLI.
   When used, output prints to raw ``STDOUT`` instead.

.. option:: --insecure

   Disables TLS/SSL certificate verification. Allows TLS connectivity to 
   servers with invalid certificates. Exercise caution when using this
   option against untrusted S3 hosts.

   Alternatively, set the environment variable :envvar:`MC_INSECURE`.

.. option:: --json

   Enables `JSON lines <http://jsonlines.org/>`_ formatted output to the
   console.

   For example, the following operation adds JSON Lines output to the 
   :mc:`bm ls` command:

   .. code-block:: shell
      :class: copyable

      bm --json ls play

   Alternatively, set the environment variable :envvar:`MC_JSON`.

.. option:: --no-color

   Disables the built-in color theme for console output. Useful for dumb
   terminals.

   Alternatively, set the environment variable :envvar:`MC_NO_COLOR`.

.. option:: --quiet

   Suppresses console output. 

   Alternatively, set the environment variable :envvar:`MC_QUIET`.

.. option:: --resolve

   .. versionadded:: mc RELEASE.2024-08-13T05-33-17Z

   Creates a custom DNS mapping to resolve a HOST to a specified IP address.

   Use the following syntax:

   .. code-block:: text

      --resolve HOST[:PORT]=IP 

   For example:

   .. code-block:: shell
      :class: copyable

      bm alias set --resolve myminio.example.com:9000=192.168.188.118 'myminio' 'https://myminio.example.com:9000' 'miniouser' 'miniosecret'

   Repeat the flag multiple times to add additional custom DNS mappings.

.. option:: --version

   Displays the current version of :mc-cmd:`bm`.

.. mc-cmd:: --help
   :optional:

   Displays a summary of command usage on the terminal.

.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/bm-cli/bm-cli-settings
   /reference/bm-cli/bm-alias
   /reference/bm-cli/bm-anonymous
   /reference/bm-cli/bm-batch
   /reference/bm-cli/bm-cat
   /reference/bm-cli/bm-cp
   /reference/bm-cli/bm-diff
   /reference/bm-cli/bm-du
   /reference/bm-cli/bm-encrypt
   /reference/bm-cli/bm-event
   /reference/bm-cli/bm-find
   /reference/bm-cli/bm-get
   /reference/bm-cli/bm-head
   /reference/bm-cli/bm-idp-ldap
   /reference/bm-cli/bm-idp-ldap-accesskey
   /reference/bm-cli/bm-idp-ldap-accesskey-create-with-login
   /reference/bm-cli/bm-idp-ldap-policy
   /reference/bm-cli/bm-idp-openid
   /reference/bm-cli/bm-ilm
   /reference/bm-cli/bm-legalhold
   /reference/bm-cli/bm-license
   /reference/bm-cli/bm-ls
   /reference/bm-cli/bm-mb
   /reference/bm-cli/bm-mirror
   /reference/bm-cli/bm-mv
   /reference/bm-cli/bm-od
   /reference/bm-cli/bm-ping
   /reference/bm-cli/bm-pipe
   /reference/bm-cli/bm-put
   /reference/bm-cli/bm-rb
   /reference/bm-cli/bm-ready
   /reference/bm-cli/bm-replicate
   /reference/bm-cli/bm-retention
   /reference/bm-cli/bm-rm
   /reference/bm-cli/bm-share
   /reference/bm-cli/bm-sql
   /reference/bm-cli/bm-stat
   /reference/bm-cli/bm-support
   /reference/bm-cli/bm-tag
   /reference/bm-cli/bm-tree
   /reference/bm-cli/bm-undo
   /reference/bm-cli/bm-update
   /reference/bm-cli/bm-version
   /reference/bm-cli/bm-watch
