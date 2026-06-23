.. _quickstart-linux:

.. |OS| replace:: Linux

This procedure deploys a :ref:`Standalone <minio-installation-comparison>` Buckit server onto |OS| for early development and evaluation of Buckit Object Storage and its S3-compatible API layer. 

For instructions on deploying to production environments, see :ref:`deploy-minio-distributed`.

Prerequisites
-------------

- Read, Write and Execute permissions on your local user folder (e.g. ``~/minio``).
- Permission to install binaries to the system ``PATH`` (e.g. access to ``/usr/local/bin``).
- Familiarity with the Linux terminal or shell (Bash, ZSH, etc.).
- A 64-bit Linux OS (e.g. RHEL 8, Ubuntu LTS releases).

Procedure
---------

#. **Install the Buckit Server**

   .. include:: /includes/linux/common-installation.rst
      :start-after: start-install-minio-binary-desc
      :end-before: end-install-minio-binary-desc

#. **Launch the Buckit Server**

   Run the following command from the system terminal or shell to start a local Buckit instance using the ``~/minio`` folder. You can replace this path with another folder path on the local machine:

   .. code-block:: shell
      :class: copyable

      mkdir ~/minio
      buckit server ~/minio --console-address :9001

   The ``mkdir`` command creates the folder explicitly at the specified path.

   The ``minio server`` command starts the Buckit server. The path argument
   ``~/minio`` identifies the folder in which the server operates.

   The :mc:`buckit server <buckit server>` process prints its output to the system console, similar to the following:

   .. code-block:: shell

      API: http://192.0.2.10:9000  http://127.0.0.1:9000
      RootUser: buckitadmin
      RootPass: buckitadmin

      Console: http://192.0.2.10:9001 http://127.0.0.1:9001
      RootUser: buckitadmin
      RootPass: buckitadmin

      Command-line: https://docs.min.io/community/minio-object-store/reference/bm-cli.html
         $ bm alias set mybuckit http://192.0.2.10:9000 buckitadmin buckitadmin

      Documentation: https://docs.min.io/community/minio-object-store/index.html

      WARNING: Detected default credentials 'buckitadmin:buckitadmin', we recommend that you change these values with 'MINIO_ROOT_USER' and 'MINIO_ROOT_PASSWORD' environment variables.

#. **Connect Your Browser to the Buckit Server**

   Open http://127.0.0.1:9000 in a web browser to access the :ref:`Buckit Console <minio-console>`. 
   You can alternatively enter any of the network addresses specified as part of the server command output.
   For example, :guilabel:`Console: http://192.0.2.10:9001 http://127.0.0.1:9001` in the example output indicates two possible addresses to use for connecting to the Console.

   While the port ``9000`` is used for connecting to the API, Buckit automatically redirects browser access to the Buckit Console.

   Log in to the Console with the ``RootUser`` and ``RootPass`` user credentials displayed in the output.
   These default to ``buckitadmin | buckitadmin``.

#. `(Optional)` **Install the Buckit Client**

   The :ref:`Buckit Client <minio-client>` allows you to work with your Buckit server from the commandline.

   Download the :mc:`bm` client and install it to a location on your system ``PATH`` such as 
   ``/usr/local/bin``. You can alternatively run the binary from the download location.

   .. code-block:: shell
      :class: copyable

      wget https://dl.min.io/client/mc/release/linux-amd64/mc
      chmod +x mc
      sudo mv mc /usr/local/bin/mc

   Use :mc:`bm alias set` to create a new alias associated to your local deployment.
   You can run :mc-cmd:`bm` commands against this alias:

   .. code-block:: shell
      :class: copyable

      bm alias set local http://127.0.0.1:9000 buckitadmin buckitadmin
      bm admin info local

   The :mc:`bm alias set` takes four arguments:

   - The name of the alias
   - The hostname or IP address and port of the Buckit server
   - The Access Key for a Buckit :ref:`user <minio-users>`
   - The Secret Key for a Buckit :ref:`user <minio-users>`

   The example above uses the :ref:`root user <minio-users-root>`.

.. rst-class:: section-next-steps

Next Steps
----------

- :ref:`Connect your applications to Buckit <minio-drivers>`
- :ref:`Configure Object Retention <minio-object-retention>`
- :ref:`Configure Security <minio-authentication-and-identity-management>`
- :ref:`Deploy Buckit for Production Environments <deploy-minio-distributed>`
