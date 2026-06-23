.. _minio-bucket-notifications-publish-kafka:

=======================
Publish Events to Kafka
=======================

.. default-domain:: minio

.. |ARN| replace:: ``arn:minio:sqs::primary:kafka``

.. contents:: Table of Contents
   :local:
   :depth: 1

Buckit supports publishing :ref:`bucket notification
<minio-bucket-notifications>` events to a `Kafka <https://kafka.apache.org/>`__
service endpoint. 

Buckit relies on the :github:`Shopify/sarama` project for Kafka connectivity
and shares that project's Kafka support. See the 
``sarama`` :github:`Compatibility and API stability 
<Shopify/sarama/#compatibility-and-api-stability>` section for more details.

Add a Kafka Endpoint to a Buckit Deployment
-------------------------------------------

The following procedure adds a new Kafka service endpoint for supporting
:ref:`bucket notifications <minio-bucket-notifications>` in a Buckit
deployment.

Prerequisites
~~~~~~~~~~~~~

Kafka Minimum Versions and Supported Versions
+++++++++++++++++++++++++++++++++++++++++++++

Buckit relies on the :github:`Shopify/sarama` project for Kafka connectivity
and shares that project's Kafka support. See the 
``sarama`` :github:`Compatibility and API stability 
<Shopify/sarama/#compatibility-and-api-stability>` section for more details.

Buckit ``bm`` Command Line Tool
+++++++++++++++++++++++++++++++

This procedure uses the :mc:`bm` command line tool for certain actions. 
See the ``bm`` :ref:`Quickstart <mc-install>` for installation instructions.

1) Add the Kafka Endpoint to Buckit
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can configure a new Kafka service endpoint using either environment variables
*or* by setting runtime configuration settings.

.. tab-set::

   .. tab-item:: Environment Variables

      Buckit supports specifying the Kafka service endpoint and associated
      configuration settings using 
      :ref:`environment variables 
      <minio-server-envvar-bucket-notification-kafka>`. The 
      :mc:`buckit server <buckit server>` process applies the specified settings on its 
      next startup.
      
      The following example code sets *all*  environment variables
      related to configuring a Kafka service endpoint. The minimum
      *required* variables are
      :envvar:`MINIO_NOTIFY_KAFKA_ENABLE` and 
      :envvar:`MINIO_NOTIFY_KAFKA_BROKERS`:

      .. cond:: windows
      
         .. code-block:: shell
            :class: copyable
         
               set MINIO_NOTIFY_KAFKA_ENABLE_<IDENTIFIER>="on"
               set MINIO_NOTIFY_KAFKA_BROKERS_<IDENTIFIER>="<ENDPOINT>"
               set MINIO_NOTIFY_KAFKA_TOPIC_<IDENTIFIER>="<string>"
               set MINIO_NOTIFY_KAFKA_SASL_USERNAME_<IDENTIFIER>="<string>"
               set MINIO_NOTIFY_KAFKA_SASL_PASSWORD_<IDENTIFIER>="<string>"
               set MINIO_NOTIFY_KAFKA_SASL_MECHANISM_<IDENTIFIER>="<string>"
               set MINIO_NOTIFY_KAFKA_TLS_CLIENT_AUTH_<IDENTIFIER>="<string>"
               set MINIO_NOTIFY_KAFKA_SASL_<IDENTIFIER>="<string>"
               set MINIO_NOTIFY_KAFKA_TLS_<IDENTIFIER>="<string>"
               set MINIO_NOTIFY_KAFKA_TLS_SKIP_VERIFY_<IDENTIFIER>="<string>"
               set MINIO_NOTIFY_KAFKA_CLIENT_TLS_CERT_<IDENTIFIER>="<string>"
               set MINIO_NOTIFY_KAFKA_CLIENT_TLS_KEY_<IDENTIFIER>="<string>"
               set MINIO_NOTIFY_KAFKA_QUEUE_DIR_<IDENTIFIER>="<string>"
               set MINIO_NOTIFY_KAFKA_QUEUE_LIMIT_<IDENTIFIER>="<string>"
               set MINIO_NOTIFY_KAFKA_VERSION_<IDENTIFIER>="<string>"
               set MINIO_NOTIFY_KAFKA_COMMENT_<IDENTIFIER>="<string>"

      .. cond:: not windows

         .. code-block:: shell
            :class: copyable

               export MINIO_NOTIFY_KAFKA_ENABLE_<IDENTIFIER>="on"
               export MINIO_NOTIFY_KAFKA_BROKERS_<IDENTIFIER>="<ENDPOINT>"
               export MINIO_NOTIFY_KAFKA_TOPIC_<IDENTIFIER>="<string>"
               export MINIO_NOTIFY_KAFKA_SASL_USERNAME_<IDENTIFIER>="<string>"
               export MINIO_NOTIFY_KAFKA_SASL_PASSWORD_<IDENTIFIER>="<string>"
               export MINIO_NOTIFY_KAFKA_SASL_MECHANISM_<IDENTIFIER>="<string>"
               export MINIO_NOTIFY_KAFKA_TLS_CLIENT_AUTH_<IDENTIFIER>="<string>"
               export MINIO_NOTIFY_KAFKA_SASL_<IDENTIFIER>="<string>"
               export MINIO_NOTIFY_KAFKA_TLS_<IDENTIFIER>="<string>"
               export MINIO_NOTIFY_KAFKA_TLS_SKIP_VERIFY_<IDENTIFIER>="<string>"
               export MINIO_NOTIFY_KAFKA_CLIENT_TLS_CERT_<IDENTIFIER>="<string>"
               export MINIO_NOTIFY_KAFKA_CLIENT_TLS_KEY_<IDENTIFIER>="<string>"
               export MINIO_NOTIFY_KAFKA_QUEUE_DIR_<IDENTIFIER>="<string>"
               export MINIO_NOTIFY_KAFKA_QUEUE_LIMIT_<IDENTIFIER>="<string>"
               export MINIO_NOTIFY_KAFKA_VERSION_<IDENTIFIER>="<string>"
               export MINIO_NOTIFY_KAFKA_COMMENT_<IDENTIFIER>="<string>"

      - Replace ``<IDENTIFIER>`` with a unique descriptive string for the
        Kafka service endpoint. Use the same ``<IDENTIFIER>`` value for all 
        environment variables related to the new target service endpoint.
        The following examples assume an identifier of ``PRIMARY``.

        If the specified ``<IDENTIFIER>`` matches an existing Kafka service
        endpoint on the Buckit deployment, the new settings *override* 
        any existing settings for that endpoint. Use 
        :mc-cmd:`bm admin config get notify_kafka <bm admin config get>` to
        review the currently configured Kafka endpoints on the Buckit deployment.

      - Replace ``<ENDPOINT>`` with a comma-separated list of Kafka brokers.
        For example:

        ``"kafka1.example.com:2021,kafka2.example.com:2021"``

      See :ref:`Kafka Service for Bucket Notifications
      <minio-server-envvar-bucket-notification-kafka>` for complete documentation
      on each environment variable.

   .. tab-item:: Configuration Settings

      Buckit supports adding or updating Kafka endpoints on a running 
      :mc:`buckit server <buckit server>` process using the :mc-cmd:`bm admin config set` command 
      and the :mc-conf:`notify_kafka` configuration key. You must restart the 
      :mc:`buckit server <buckit server>` process to apply any new or updated configuration
      settings.

      The following example code sets *all*  settings related to configuring an
      Kafka service endpoint. The minimum *required* setting is 
      :mc-conf:`notify_kafka brokers <notify_kafka.brokers>`:

      .. code-block:: shell
         :class: copyable

         bm admin config set ALIAS/ notify_kafka:IDENTIFIER \
            brokers="<ENDPOINT>" \
            topic="<string>" \
            sasl_username="<string>" \
            sasl_password="<string>" \
            sasl_mechanism="<string>" \
            tls_client_auth="<string>" \
            tls="<string>" \
            tls_skip_verify="<string>" \
            client_tls_cert="<string>" \
            client_tls_key="<string>" \
            version="<string>" \
            queue_dir="<string>" \
            queue_limit="<string>" \
            comment="<string>"

      - Replace ``IDENTIFIER`` with a unique descriptive string for the
        Kafka service endpoint. The following examples in this procedure
        assume an identifier of ``PRIMARY``.

        If the specified ``IDENTIFIER`` matches an existing Kafka service
        endpoint on the Buckit deployment, the new settings *override* 
        any existing settings for that endpoint. Use 
        :mc-cmd:`bm admin config get notify_kafka <bm admin config get>` to
        review the currently configured Kafka endpoints on the Buckit deployment.

      - Replace ``ENDPOINT`` with a comma separated list of Kafka brokers.
        For example:

        ``"kafka1.example.com:2021,kafka2.example.com:2021"``

      See :ref:`Kafka Bucket Notification Configuration Settings
      <minio-server-config-bucket-notification-kafka>` for complete 
      documentation on each setting.

1) Restart the Buckit Deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You must restart the Buckit deployment to apply the configuration changes. 
Use the :mc-cmd:`bm admin service restart` command to restart the deployment.

.. code-block:: shell
   :class: copyable

   bm admin service restart ALIAS

Replace ``ALIAS`` with the :ref:`alias <alias>` of the deployment to 
restart.

The :mc:`buckit server <buckit server>` process prints a line on startup for each configured
Kafka target similar to the following:

.. code-block:: shell

   SQS ARNs: arn:minio:sqs::primary:kafka

You must specify the ARN resource when configuring bucket notifications with
the associated Kafka deployment as a target.

.. include:: /includes/common-bucket-notifications.rst
   :start-after: start-bucket-notification-find-arn
   :end-before: end-bucket-notification-find-arn


3) Configure Bucket Notifications using the Kafka Endpoint as a Target
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :mc:`bm event add` command to add a new bucket notification 
event with the configured Kafka service as a target:

.. code-block:: shell
   :class: copyable

   bm event add ALIAS/BUCKET arn:minio:sqs::primary:kafka \
     --event EVENTS

- Replace ``ALIAS`` with the :ref:`alias <alias>` of a Buckit deployment.
- Replace ``BUCKET`` with the name of the bucket in which to configure the 
  event.
- Replace ``EVENTS`` with a comma-separated list of :ref:`events 
  <mc-event-supported-events>` for which Buckit triggers notifications.

Use :mc:`bm event ls` to view all configured bucket events for 
a given notification target:

.. code-block:: shell
   :class: copyable

   bm event ls ALIAS/BUCKET arn:minio:sqs::primary:kafka

4) Validate the Configured Events
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Perform an action on the bucket for which you configured the new event and 
check the Kafka service for the notification data. The action required
depends on which :mc-cmd:`events <bm event add --event>` were specified
when configuring the bucket notification.

For example, if the bucket notification configuration includes the 
``s3:ObjectCreated:Put`` event, you can use the 
:mc:`bm cp` command to create a new object in the bucket and trigger 
a notification.

.. code-block:: shell
   :class: copyable

   bm cp ~/data/new-object.txt ALIAS/BUCKET

Update a Kafka Endpoint in a Buckit Deployment
----------------------------------------------

The following procedure updates an existing Kafka service endpoint for supporting
:ref:`bucket notifications <minio-bucket-notifications>` in a Buckit
deployment.

Prerequisites
~~~~~~~~~~~~~~

Kafka Minimum Versions and Supported Versions
+++++++++++++++++++++++++++++++++++++++++++++

Buckit relies on the :github:`Shopify/sarama` project for Kafka connectivity
and shares that project's Kafka support. See the 
``sarama`` :github:`Compatibility and API stability 
<Shopify/sarama/#compatibility-and-api-stability>` section for more details.

Buckit ``bm`` Command Line Tool
+++++++++++++++++++++++++++++++

This procedure uses the :mc:`bm` command line tool for certain actions. 
See the ``bm`` :ref:`Quickstart <mc-install>` for installation instructions.


1) List Configured Kafka Endpoints In The Deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :mc-cmd:`bm admin config get` command to list the currently
configured Kafka service endpoints in the deployment:

.. code-block:: shell
   :class: copyable

   bm admin config get ALIAS/ notify_kafka

Replace ``ALIAS`` with the :ref:`alias <alias>` of the Buckit deployment.

The command output resembles the following:

.. code-block:: shell

   notify_kafka:primary tls_skip_verify="off"  queue_dir="" queue_limit="0" sasl="off" sasl_password="" sasl_username="" tls_client_auth="0" tls="off" brokers="" topic="" client_tls_cert="" client_tls_key="" version=""
   notify_kafka:secondary tls_skip_verify="off"  queue_dir="" queue_limit="0" sasl="off" sasl_password="" sasl_username="" tls_client_auth="0" tls="off" brokers="" topic="" client_tls_cert="" client_tls_key="" version=""

The :mc-conf:`notify_kafka` key is the top-level configuration key for an
:ref:`minio-server-config-bucket-notification-kafka`. The 
:mc-conf:`brokers <notify_kafka.brokers>` key specifies the Kafka service
endpoint for the given `notify_kafka` key. The ``notify_kafka:<IDENTIFIER>``
suffix describes the unique identifier for that Kafka service endpoint.

Note the identifier for the Kafka service endpoint you want to update for
the next step. 

2) Update the Kafka Endpoint
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :mc-cmd:`bm admin config set` command to set the new configuration
for the Kafka service endpoint:

.. code-block:: shell
   :class: copyable

   bm admin config set ALIAS/ notify_kafka:<IDENTIFIER> \
      brokers="https://kafka1.example.net:9200, https://kafka2.example.net:9200" \
      topic="<string>" \
      sasl_username="<string>" \
      sasl_password="<string>" \
      sasl_mechanism="<string>" \
      tls_client_auth="<string>" \
      tls="<string>" \
      tls_skip_verify="<string>" \
      client_tls_cert="<string>" \
      client_tls_key="<string>" \
      version="<string>" \
      queue_dir="<string>" \
      queue_limit="<string>" \
      comment="<string>"

The :mc-conf:`notify_kafka brokers <notify_kafka.brokers>` configuration setting
is the *minimum* required for a Kafka service endpoint. All other configuration
settings are *optional*. See
:ref:`minio-server-config-bucket-notification-kafka` for a complete list of
Kafka configuration settings.

3) Restart the Buckit Deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You must restart the Buckit deployment to apply the configuration changes. 
Use the :mc-cmd:`bm admin service restart` command to restart the deployment.

.. code-block:: shell
   :class: copyable

   bm admin service restart ALIAS

Replace ``ALIAS`` with the :ref:`alias <alias>` of the deployment to 
restart.

The :mc:`buckit server <buckit server>` process prints a line on startup for each configured
Kafka target similar to the following:

.. code-block:: shell

   SQS ARNs: arn:minio:sqs::primary:kafka

4) Validate the Changes
~~~~~~~~~~~~~~~~~~~~~~~

Perform an action on a bucket which has an event configuration using the updated
Kafka service endpoint and check the Kafka service for the notification data.
The action required depends on which :mc-cmd:`events <bm event add --event>` were
specified when configuring the bucket notification.

For example, if the bucket notification configuration includes the 
``s3:ObjectCreated:Put`` event, you can use the 
:mc:`bm cp` command to create a new object in the bucket and trigger 
a notification.

.. code-block:: shell
   :class: copyable

   bm cp ~/data/new-object.txt ALIAS/BUCKET
