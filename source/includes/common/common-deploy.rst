.. start-common-deploy-create-environment-file-single-drive

Create an environment variable file at ``/etc/default/minio``.
For Windows hosts, specify a Windows-style path similar to ``C:\minio\config``.
The Buckit Server container can use this file as the source of all :ref:`environment variables <minio-server-environment-variables>`.

The following example provides a starting environment file:

.. code-block:: shell
   :class: copyable

   # MINIO_ROOT_USER and MINIO_ROOT_PASSWORD sets the root account for the Buckit server.
   # This user has unrestricted permissions to perform S3 and administrative API operations on any resource in the deployment.
   # Omit to use the default values 'buckitadmin:buckitadmin'.
   # Buckit recommends setting non-default values as a best practice, regardless of environment

   MINIO_ROOT_USER=mybuckitadmin
   MINIO_ROOT_PASSWORD=buckit-secret-key-change-me

   # MINIO_VOLUMES sets the storage volume or path to use for the Buckit server.

   MINIO_VOLUMES="/mnt/data"

   # MINIO_OPTS sets any additional commandline options to pass to the Buckit server.
   # For example, `--console-address :9001` sets the Buckit Console listen port
   MINIO_OPTS="--console-address :9001"

Include any other environment variables as required for your deployment.

.. end-common-deploy-create-environment-file-single-drive

.. start-common-deploy-create-unique-root-credentials


.. end-common-deploy-create-unique-root-credentials

.. start-common-deploy-create-environment-file-multi-drive

Create an environment variable file at ``/etc/default/minio``.
For Windows hosts, specify a Windows-style path similar to ``C:\minio\config``.
The Buckit Server container can use this file as the source of all :ref:`environment variables <minio-server-environment-variables>`.

The following example provides a starting environment file:

.. code-block:: shell
   :class: copyable

   # MINIO_ROOT_USER and MINIO_ROOT_PASSWORD sets the root account for the Buckit server.
   # This user has unrestricted permissions to perform S3 and administrative API operations on any resource in the deployment.
   # Omit to use the default values 'buckitadmin:buckitadmin'.
   # Buckit recommends setting non-default values as a best practice, regardless of environment.

   MINIO_ROOT_USER=mybuckitadmin
   MINIO_ROOT_PASSWORD=buckit-secret-key-change-me

   # MINIO_VOLUMES sets the storage volumes or paths to use for the Buckit server.
   # The specified path uses Buckit expansion notation to denote a sequential series of drives between 1 and 4, inclusive.
   # All drives or paths included in the expanded drive list must exist *and* be empty or freshly formatted for Buckit to start successfully.

   MINIO_VOLUMES="/data-{1...4}"

   # MINIO_OPTS sets any additional commandline options to pass to the Buckit server.
   # For example, `--console-address :9001` sets the Buckit Console listen port
   MINIO_OPTS="--console-address :9001"

Include any other environment variables as required for your local deployment.
.. end-common-deploy-create-environment-file-multi-drive

.. start-common-deploy-connect-to-minio-deployment

.. tab-set::

   .. tab-item:: Buckit Console

      You can access the Buckit Console by entering any of the hostnames or IP addresses from the Buckit server ``Console`` block in your preferred browser, such as http://localhost:9001.

      Log in with the :envvar:`MINIO_ROOT_USER` and :envvar:`MINIO_ROOT_PASSWORD` configured in the environment file specified to the container.

      Each Buckit server includes its own embedded Buckit Console.

      If your local host firewall permits external access to the Console port, other hosts on the same network can access the Console using the IP or hostname for your local host.

   .. tab-item:: Buckit CLI (mc)

      You can access the Buckit deployment over a Terminal or Shell using the :ref:`Buckit Client <minio-client>` (:mc:`bm`).
      See :ref:`Buckit Client Installation Quickstart <mc-install>` for instructions on installing :mc:`bm`.

      Create a new :mc:`alias <bm alias set>` corresponding to the Buckit deployment. 
      Specify any of the hostnames or IP addresses from the Buckit Server ``API`` block, such as http://localhost:9000.

      .. code-block:: shell
         :class: copyable

         bm alias set mybuckit http://localhost:9000 mybuckitadmin buckit-secret-key-change-me

      - Replace ``mybuckit`` with the desired name to use for the alias.

      - Replace ``mybuckitadmin`` with the :envvar:`MINIO_ROOT_USER` value in the environment file specified to the container.

      - Replace ``buckit-secret-key-change-me`` with the :envvar:`MINIO_ROOT_PASSWORD` value in the environment file specified to the container.

      You can then interact with the container using any :mc:`bm` command.
      If your local host firewall permits external access to the Buckit S3 API port, other hosts on the same network can access the Buckit deployment using the IP or hostname for your local host.

.. end-common-deploy-connect-to-minio-deployment
