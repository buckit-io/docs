.. _minio-metrics-collect-using-prometheus:

========================================
Monitoring and Alerting using Prometheus
========================================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

Buckit publishes cluster, node, bucket, and resource metrics using the :prometheus-docs:`Prometheus Data Model <concepts/data_model/#data-model>`.
The procedure on this page documents the following:

- Configuring a Prometheus service to scrape and display metrics from a Buckit deployment
- Configuring an Alert Rule on a Buckit Metric to trigger an AlertManager action

These instructions use :ref:`version 2 metrics. <minio-metrics-v2>`
For more about metrics API versions, see :ref:`Metrics and alerts. <minio-metrics-and-alerts>`

.. admonition:: Prerequisites
   :class: note

   This procedure requires the following:

   - An existing :prometheus-docs:`Prometheus deployment <prometheus/latest/installation/>` with backing :prometheus-docs:`Alert Manager <alerting/latest/overview/>`

   - An existing Buckit deployment with network access to the Prometheus deployment

   - An :mc:`bm` installation on your local host configured to :ref:`access <alias>` the Buckit deployment


Configure Prometheus to Collect and Alert using Buckit Metrics
--------------------------------------------------------------

1) Generate the Scrape Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :mc:`bm admin prometheus generate` command to generate the scrape configuration for use by Prometheus in making scraping requests:

.. tab-set::

   .. tab-item:: Buckit Server

      The following command scrapes metrics for the Buckit cluster.

      .. code-block:: shell
         :class: copyable
      
         bm admin prometheus generate ALIAS

      Replace :mc-cmd:`ALIAS <bm admin prometheus generate ALIAS>` with the :mc:`alias <bm alias>` of the Buckit deployment.
	 
      The command returns output similar to the following:

      .. code-block:: yaml
         :class: copyable
      
         global:
            scrape_interval: 60s
         
         scrape_configs:
            - job_name: minio-job
              bearer_token: TOKEN
              metrics_path: /minio/v2/metrics/cluster
              scheme: https
              static_configs:
              - targets: [buckit.example.net]
		      
   .. tab-item:: Nodes

      The following command scrapes metrics for a node on the Buckit Server.

      .. code-block:: shell
         :class: copyable
      
         bm admin prometheus generate ALIAS node

      Replace :mc-cmd:`ALIAS <bm admin prometheus generate ALIAS>` with the :mc:`alias <bm alias>` of the Buckit deployment.

      .. code-block:: yaml
         :class: copyable
      
         global:
            scrape_interval: 60s
         
         scrape_configs:
            - job_name: minio-job-node
              bearer_token: TOKEN
              metrics_path: /minio/v2/metrics/node
              scheme: https
              static_configs:
              - targets: [buckit-1.example.net, buckit-2.example.net, buckit-N.example.net]
		      
   .. tab-item:: Buckets

      The following command scrapes metrics for buckets on the Buckit Server.

      .. code-block:: shell
         :class: copyable
      
         bm admin prometheus generate ALIAS bucket

      Replace :mc-cmd:`ALIAS <bm admin prometheus generate ALIAS>` with the :mc:`alias <bm alias>` of the Buckit deployment.

      .. code-block:: yaml
         :class: copyable
      
         global:
            scrape_interval: 60s
         
         scrape_configs:
            - job_name: minio-job-bucket
              bearer_token: TOKEN
              metrics_path: /minio/v2/metrics/bucket
              scheme: https
              static_configs:
              - targets: [buckit.example.net]
      
   .. tab-item:: Resources

- Set an appropriate ``scrape_interval`` value to ensure each scraping operation completes before the next one begins.
  The recommended value is 60 seconds.

  Some deployments require a longer scrape interval due to the number of metrics being scraped.
  To reduce the load on your Buckit and Prometheus servers, choose the longest interval that meets your monitoring requirements.

- Set the ``job_name`` to a value associated to the Buckit deployment.

  Use a unique value to ensure isolation of the deployment metrics from any others collected by that Prometheus service.

- Buckit deployments started with :envvar:`MINIO_PROMETHEUS_AUTH_TYPE` set to ``"public"`` can omit the ``bearer_token`` field.

- Set the ``scheme`` to http for Buckit deployments not using TLS.

- Set the ``targets`` array with a hostname that resolves to the Buckit deployment.

  This can be any single node, or a load balancer/proxy which handles connections to the Buckit nodes.

  For Buckit Tenants on Kubernetes infrastructure, when using a Prometheus cluster in that same cluster you can specify the service DNS name for the ``minio`` service.
  You can otherwise specify the ingress or load balancer endpoint configured to route connections to and from the Buckit Tenant.

2) Restart Prometheus with the Updated Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Append the desired ``scrape_configs`` job generated in the previous step to the configuration file:

.. tab-set::

   .. tab-item:: Cluster

      Cluster metrics aggregate node-level metrics and, where appropriate, attach labels to metrics for the originating node.

      .. code-block:: yaml
         :class: copyable
      
         global:
            scrape_interval: 60s
         
         scrape_configs:
            - job_name: minio-job
              bearer_token: TOKEN
              metrics_path: /minio/v2/metrics/cluster
              scheme: https
              static_configs:
              - targets: [buckit.example.net]


   .. tab-item:: Nodes

      Node metrics are specific for node-level monitoring. You need to list all Buckit nodes for this configuration.

      .. code-block:: yaml
         :class: copyable
      
         global:
            scrape_interval: 60s
         
         scrape_configs:
            - job_name: minio-job-node
              bearer_token: TOKEN
              metrics_path: /minio/v2/metrics/node
              scheme: https
              static_configs:
              - targets: [buckit-1.example.net, buckit-2.example.net, buckit-N.example.net]

	      
   .. tab-item:: Bucket

      .. code-block:: yaml
         :class: copyable
      
         global:
            scrape_interval: 60s
         
         scrape_configs:
            - job_name: minio-job-bucket
              bearer_token: TOKEN
              metrics_path: /minio/v2/metrics/bucket
              scheme: https
              static_configs:
              - targets: [buckit.example.net]

   .. tab-item:: Resource

      .. code-block:: yaml
         :class: copyable

         global:
            scrape_interval: 60s

         scrape_configs:
            - job_name: minio-job-resource
              bearer_token: TOKEN
              metrics_path: /minio/v2/metrics/resource
              scheme: https
              static_configs:
              - targets: [buckit.example.net]

Start the Prometheus cluster using the configuration file:

.. code-block:: shell
   :class: copyable

   prometheus --config.file=prometheus.yaml

3) Analyze Collected Metrics
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Prometheus includes an :prometheus-docs:`expression browser <prometheus/latest/getting_started/#using-the-expression-browser>`. 
You can execute queries here to analyze the collected metrics.

.. tab-set::

   .. tab-item:: Examples

      The following query examples return metrics collected by Prometheus every five minutes for a scrape job named ``minio-job``:

      .. code-block:: shell
         :class: copyable

         minio_node_drive_free_bytes{job="minio-job"}[5m]
         minio_node_drive_free_inodes{job="minio-job"}[5m]

         minio_node_drive_latency_us{job="minio-job"}[5m]

         minio_node_drive_offline_total{job="minio-job"}[5m]
         minio_node_drive_online_total{job="minio-job"}[5m]

         minio_node_drive_total{job="minio-job"}[5m]

         minio_node_drive_total_bytes{job="minio-job"}[5m]
         minio_node_drive_used_bytes{job="minio-job"}[5m]

         minio_node_drive_errors_timeout{job="minio-job"}[5m]
         minio_node_drive_errors_availability{job="minio-job"}[5m]

         minio_node_drive_io_waiting{job="minio-job"}[5m]

   .. tab-item:: Recommended Metrics

      Buckit recommends the following as a basic set of metrics to monitor.

      See :ref:`minio-metrics-and-alerts` for information about all available metrics.

      .. list-table::
         :header-rows: 1
         :widths: 40 60
         :width: 100%

         * - Metric
           - Description
     
         * - ``minio_node_drive_free_bytes``
           - Total storage available on a drive.

         * - ``minio_node_drive_free_inodes``
           - Total free inodes.

         * - ``minio_node_drive_latency_us``
           - Average last minute latency in µs for drive API storage operations.

         * - ``minio_node_drive_offline_total``
           - Total drives offline in this node.

         * - ``minio_node_drive_online_total``
           - Total drives online in this node.

         * - ``minio_node_drive_total``
           - Total drives in this node.

         * - ``minio_node_drive_total_bytes``
           - Total storage on a drive.

         * - ``minio_node_drive_used_bytes``
           - Total storage used on a drive.

         * - ``minio_node_drive_errors_timeout``
           - Total number of drive timeout errors since server start.

         * - ``minio_node_drive_errors_availability``
           - Total number of drive I/O errors, permission denied and timeouts since server start.

         * - ``minio_node_drive_io_waiting``
           - Total number of I/O operations waiting on drive.

4) Configure an Alert Rule using Buckit Metrics
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You must configure :prometheus-docs:`Alert Rules <prometheus/latest/configuration/alerting_rules/>` on the Prometheus deployment to trigger alerts based on collected Buckit metrics.

The following example alert rule files provide a baseline of alerts for a Buckit deployment.
You can modify or otherwise use these examples as guidance in building your own alerts.

.. code-block:: yaml
   :class: copyable

   groups:
   - name: minio-alerts
     rules:
     - alert: NodesOffline
       expr: avg_over_time(minio_cluster_nodes_offline_total{job="minio-job"}[5m]) > 0
       for: 10m
       labels:
         severity: warn
       annotations:
         summary: "Node down in Buckit deployment"
         description: "Node(s) in cluster {{ $labels.instance }} offline for more than 5 minutes"

     - alert: DisksOffline
       expr: avg_over_time(minio_cluster_drive_offline_total{job="minio-job"}[5m]) > 0
       for: 10m
       labels:
         severity: warn
       annotations:
         summary: "Disks down in Buckit deployment"
         description: "Disks(s) in cluster {{ $labels.instance }} offline for more than 5 minutes"

In the Prometheus configuration, specify the path to the alert file in the ``rule_files`` key:

.. code-block:: yaml

   rule_files:
   - minio-alerting.yml

Once triggered, Prometheus sends the alert to the configured AlertManager service.

Dashboards
----------

Buckit provides Grafana Dashboards to display metrics collected by Prometheus.
For more information, see :ref:`minio-grafana`
