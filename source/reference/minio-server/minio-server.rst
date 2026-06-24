=============
Buckit Server
=============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: minio

Buckit Server
-------------

The :mc:`buckit server <buckit server>` command starts the :mc:`buckit server <buckit server>` process:

.. code-block:: shell
   :class: copyable

   buckit server /mnt/disk{1...4}

For examples of deploying :mc:`buckit server <buckit server>` on a bare metal environment, see :ref:`minio-installation`.

Buckit does not support Kubernetes deployment guidance in this documentation set.


.. _minio-server-parameters:

Syntax
~~~~~~

.. mc:: buckit server

Starts the ``minio`` server process.

The command has the following syntax:

.. code-block:: shell
   :class: copyable

   buckit server [FLAGS] HOSTNAME/DIRECTORIES [HOSTNAME/DIRECTORIES..]

The command accepts the following arguments:

.. mc-cmd:: HOSTNAME

   The hostname of a :mc:`buckit server <buckit server>` process.

   For standalone deployments, this field is *optional*. 
   You can start a standalone :mc:`buckit server <buckit server>` process with only the :mc-cmd:`~buckit server DIRECTORIES` argument.

   For distributed deployments, specify the hostname of each Buckit server in the deployment. 
   The group of :mc:`buckit server <buckit server>` processes represent a single :ref:`Server Pool <minio-intro-server-pool>`.

   :mc-cmd:`~buckit server HOSTNAME` supports Buckit expansion notation ``{x...y}`` to denote a sequential series of hostnames. 
   Buckit *requires* sequential hostnames to identify each :mc:`buckit server <buckit server>` process in the set.

   For example, ``https://buckit{1...4}.example.net`` expands to:

   - ``https://buckit1.example.net``
   - ``https://buckit2.example.net``
   - ``https://buckit3.example.net``
   - ``https://buckit4.example.net``

   You must run the :mc:`buckit server <buckit server>` command with the *same* combination of :mc-cmd:`~buckit server HOSTNAME` and :mc-cmd:`~buckit server DIRECTORIES` on   each host in the Server Pool.

   Each additional ``HOSTNAME/DIRECTORIES`` pair denotes an additional Server Set for the purpose of horizontal expansion of the Buckit deployment. 
   For more information on Server Pools, see :ref:`Server Pool <minio-intro-server-pool>`.

.. mc-cmd:: DIRECTORIES
   :required:

   The directories or drives the :mc:`buckit server <buckit server>` process uses as the storage backend.

   :mc-cmd:`~buckit server DIRECTORIES` supports Buckit expansion notation ``{x...y}`` to denote a sequential series of folders or drives. 
   For example, ``/mnt/disk{1...4}`` expands to:

   - ``/mnt/disk1``
   - ``/mnt/disk2``
   - ``/mnt/disk3``
   - ``/mnt/disk4``

   The :mc-cmd:`~buckit server DIRECTORIES` path(s) *must* be empty when first starting the :mc:`buckit server <buckit server>` process.

   The :mc:`buckit server <buckit server>` process requires *at least* 4 drives or directories to enable :ref:`erasure coding <minio-erasure-coding>`.

   .. important::

      Buckit recommends locally-attached drives, where the :mc-cmd:`~buckit server DIRECTORIES` path points to each drive on the host machine. 
      Buckit recommends *against* using network-attached storage, as network latency reduces performance of those drives compared to locally-attached storage.

      For development or evaluation, you can specify multiple logical directories or partitions on a single physical volume to enable erasure coding on the deployment.

      For production environments, Buckit does **not recommend** using multiple logical directories or partitions on a single physical disk. 
      While Buckit supports those configurations, the potential cost savings come at the risk of decreased reliability.


.. mc-cmd:: --address
   :optional:

   Binds the :mc:`minio <buckit server>` server process to a specific network address and port number. 
   Specify the address and port as ``ADDRESS:PORT``, where ``ADDRESS`` is an IP address or hostname and ``PORT`` is a valid and open port on the host system.
   Buckit supports both IPv4 and IPv6 addressing, provided that the specified addresses are routable and resolveable. 

   To change the port number for all IP addresses or hostnames configured on the host machine, specify only ``:PORT`` where ``PORT`` is a valid and open port on the host.

   .. versionchanged:: RELEASE.2023-01-02T09-40-09Z
   
      You can configure your hosts file to have Buckit only listen on specific IPs.
      For example, if the machine's `/etc/hosts` file contains the following:

      .. code-block:: shell

         127.0.1.1       minioip
         127.0.1.2       minioip

      A command like the following would listen for API calls on port ``9000`` on both configured IP addresses.

      .. code-block:: shell

         buckit server --address "minioip:9000" ~/miniodirectory

   If omitted, :mc:`minio <buckit server>` binds to port ``9000`` on all configured IPv4 addresses, IPv6 addresses, and hostnames on the host machine.

.. mc-cmd:: --console-address
   :optional:

   Specifies a static port for the embedded Buckit Console.

   Omit to direct Buckit to generate a dynamic port at server startup. 
   The Buckit server outputs the port to the system log.

.. mc-cmd:: --ftp
   :optional:
   
   Enable and configure a File Transfer Protocol (``FTP``) or File Transfer Protocol over SSL/TLS (``FTPS``) server.
   Use this flag multiple times to specify an address port, a passive port range of addresses, or a TLS certificate and key as key-value pairs.

   Valid keys:

   - ``address``, which takes a single port to use for the server, typically ``8021``
   
   - *(Optional)* ``passive-port-range``, which restricts the range of potential ports the server can use to transfer data, such as when tight firewall rules limit the port the FTP server can request for the connection
   
   - *(Optional)* ``tls-private-key``, which takes the path to the user's private key for accessing the Buckit deployment by TLS
     
     Use with ``tls-public-cert``.
   
   - *(Optional)* ``tls-public-cert``, which takes the path to the certificate for accessing the Buckit deployment by TLS
     
     Use with ``tls-private-key``.

   For Buckit deployments with TLS enabled, omit ``tls-private-key`` and ``tls-public-key`` to direct Buckit to use the default TLS keys for the Buckit deployment. 
   See :ref:`minio-tls` for more information.
   You only need to specify a certificate and private key to a different set of TLS certificate and key than the Buckit default (for example, to use a different domain).

   For example:

   .. code-block:: shell
      :class: copyable

      buckit server http://server{1...4}/disk{1...4} \
      --ftp="address=:8021"                         \
      --ftp="passive-port-range=30000-40000"        \
      --ftp="tls-private-key=path/to/private.key"   \
      --ftp="tls-public-cert=path/to/public.crt"    \
      ...

.. mc-cmd:: --sftp
   :optional:

   Enable and configure a SSH File Transfer Protocol (``SFTP``) server.
   Use multiple times to specify each desired key-value pair.

   The following table lists valid keys.

   .. list-table::
      :header-rows: 1
      :widths: 30 30 40
      :width: 100%
   
      * - Key
        - Description
        - Valid values
   
      * - ``address``
        - Port to use for connecting to SFTP.
        - Any valid port number, typically ``8022``.
   
      * - ``ssh-private-key``
        - Path to the user's private key file.
        - Absolute path or relative path from current location to the key file to use.
 
      * - ``trusted-user-ca-key``
        - Specifies a file containing public key of a certificate authority that is trusted to sign user certificates for authentication.
          The file must contain a `user principals list <https://man.openbsd.org/ssh-keygen#CERTIFICATES>`__, and the list must include the user(s) that can authenticate with the key. 
        - Absolute path or relative path from current location to the user's trusted certificate authority public key file.

      * - ``pub-key-algos``
        - Comma-separated list of the public key algorithms to support.
        - ``ssh-ed25519``, ``sk-ssh-ed25519@openssh.com``, ``sk-ecdsa-sha2-nistp256@openssh.com``, ``ecdsa-sha2-nistp256``, ``ecdsa-sha2-nistp384``, ``ecdsa-sha2-nistp521``, ``rsa-sha2-256``, ``rsa-sha2-512``, ``ssh-rsa``, ``ssh-dss``

      * - ``kex-algos``
        - Comma-separated list in priority order of the key-exchange algorithms to support.
        - ``curve25519-sha256``, ``curve25519-sha256@libssh.org``, ``ecdh-sha2-nistp256``, ``ecdh-sha2-nistp384``, ``ecdh-sha2-nistp521``, ``diffie-hellman-group14-sha256``, ``diffie-hellman-group16-sha512``, ``diffie-hellman-group14-sha1``, ``diffie-hellman-group1-sha1``

      * - ``cipher-algos``
        - Comma-separated list of cipher algorithms to support
        - ``aes128-ctr``, ``aes192-ctr``, ``aes256-ctr``, ``aes128-gcm@openssh.com``, ``aes256-gcm@openssh.com``, ``chacha20-poly1305@openssh.com``, ``arcfour256``, ``arcfour128``, ``arcfour``, ``aes128-cbc``, ``3des-cbc``

      * - ``mac-algos``
        - Comma-separated list in preference order of MAC algorithms to support.
          Based on `RFC 4253 section 6.4 <https://www.rfc-editor.org/rfc/rfc4253>`__ with the exception of ``hmac-md5`` variants, which are end of life.
        - ``hmac-sha2-256-etm@openssh.com``, ``hmac-sha2-512-etm@openssh.com``, ``hmac-sha2-256``, ``hmac-sha2-512``, ``hmac-sha1``, ``hmac-sha1-96``

      * - ``disable-password-auth``
        - Disable password authentication.
        - ``true``

   For example:

   .. code-block:: shell
      :class: copyable

      buckit server http://server{1...4}/disk{1...4}                                 \
      --sftp="address=:8022" --sftp="ssh-private-key=/home/miniouser/.ssh/id_rsa"   \
      --sftp="kex-algos=diffie-hellman-group14-sha256,curve25519-sha256@libssh.org" \
      ...

.. mc-cmd:: --certs-dir, -S
   :optional:

   Specifies the path to the folder containing certificates the :mc:`minio` process uses for configuring TLS/SSL connectivity.
   
   The contents of the specified folder must follow that of the :ref:`default path structure <minio-tls-user-generated>`.
   For example, the path contents of ``--certs-dir /etc/minio`` should resemble the following:

   .. code-block:: shell

      /etc/minio
        private.key
        public.crt
        domain.tld/
          private.key
          public.crt
        CAs/
          full-chain-ca.crt

   Specify ``--certs-dir`` to use a custom certificate directory.

   See :ref:`minio-TLS` for more information on TLS/SSL connectivity.

.. mc-cmd:: --quiet
   :optional:

   Disables startup information.

.. mc-cmd:: --anonymous
   :optional:

   Hides sensitive information from logging.

.. mc-cmd:: --json
   :optional:

   Outputs server logs and startup information in ``JSON`` format.

.. note::

   You can define any of the ``buckit`` parameters above by setting them in the :envvar:`MINIO_OPTS` environment variable.
   This variable takes as its value a single string that contains any of the above parameters and their values that you want to set when starting the Buckit Server.

Settings
--------

You can perform other customizations to the Buckit Server process by defining additional :ref:`Configuration Values <minio-server-configuration-options>` or :ref:`Environment Variables <minio-server-environment-variables>`.

Many configuration values and environment variables define the same value.
If you set both a configuration value and the matching environment variable, Buckit uses the value from the environment variable.

   
.. toctree::
   :titlesonly:
   :hidden:
   
   /reference/minio-server/settings
   /reference/minio-server/settings/core
   /reference/minio-server/settings/root-credentials 
   /reference/minio-server/settings/storage-class
   /reference/minio-server/settings/console 
   /reference/minio-server/settings/metrics-and-logging 
   /reference/minio-server/settings/notifications 
   /reference/minio-server/settings/iam 
   /reference/minio-server/settings/ilm 
   /reference/minio-server/settings/kes 
   /reference/minio-server/settings/object-lambda
   /reference/minio-server/settings/deprecated
