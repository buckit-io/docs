### Cluster metrics

Metrics about an entire MinIO cluster.

| Path                     | Description                    |
|--------------------------|--------------------------------|
| `/cluster/config`        | Cluster configuration metrics. |
| `/cluster/erasure-set`   | Erasure set metrics.           |
| `/cluster/health`        | Cluster health metrics.        |
| `/cluster/iam`           | Cluster iam metrics.           |
| `/cluster/usage/buckets` | Object statistics by bucket.   |
| `/cluster/usage/objects` | Object statistics.             |

#### `/cluster/config`

| Name                                   | Description                                                  | Labels |
|----------------------------------------|--------------------------------------------------------------|--------|
| `minio_cluster_config_rrs_parity`      | Reduced redundancy storage class parity. <br><br>Type: gauge |        |
| `minio_cluster_config_standard_parity` | Standard storage class parity. <br><br>Type: gauge           |        |

#### `/cluster/erasure-set`

| Name                                             | Description                                                                                             | Labels              |
|--------------------------------------------------|---------------------------------------------------------------------------------------------------------|---------------------|
| `minio_cluster_erasure_set_overall_write_quorum` | Overall write quorum across pools and sets. <br><br>Type: gauge                                         |                     |
| `minio_cluster_erasure_set_overall_health`       | Overall health across pools and sets (1=healthy, 0=unhealthy). <br><br>Type: gauge                      |                     |
| `minio_cluster_erasure_set_read_quorum`          | Read quorum for the erasure set in a pool. <br><br>Type: gauge                                          | `pool_id`, `set_id` |
| `minio_cluster_erasure_set_write_quorum`         | Write quorum for the erasure set in a pool. <br><br>Type: gauge                                         | `pool_id`, `set_id` |
| `minio_cluster_erasure_set_online_drives_count`  | Count of online drives in the erasure set in a pool. <br><br>Type: gauge                                | `pool_id`, `set_id` |
| `minio_cluster_erasure_set_healing_drives_count` | Count of healing drives in the erasure set in a pool. <br><br>Type: gauge                               | `pool_id`, `set_id` |
| `minio_cluster_erasure_set_health`               | Health of the erasure set in a pool (1=healthy, 0=unhealthy). <br><br>Type: gauge                       | `pool_id`, `set_id` |
| `minio_cluster_erasure_set_read_tolerance`       | Number of drive failures that can be tolerated without disrupting read operations. <br><br>Type: gauge  | `pool_id`, `set_id` |
| `minio_cluster_erasure_set_write_tolerance`      | Number of drive failures that can be tolerated without disrupting write operations. <br><br>Type: gauge | `pool_id`, `set_id` |
| `minio_cluster_erasure_set_read_health`          | Health of the erasure set in a pool for read operations (1=healthy, 0=unhealthy). <br><br>Type: gauge   | `pool_id`, `set_id` |
| `minio_cluster_erasure_set_write_health`         | Health of the erasure set in a pool for write operations (1=healthy, 0=unhealthy). <br><br>Type: gauge  | `pool_id`, `set_id` |

#### `/cluster/health`

| Name                                               | Description                                                         | Labels |
|----------------------------------------------------|---------------------------------------------------------------------|--------|
| `minio_cluster_health_drives_offline_count`        | Count of offline drives in the cluster. <br><br>Type: gauge         |        |
| `minio_cluster_health_drives_online_count`         | Count of online drives in the cluster. <br><br>Type: gauge          |        |
| `minio_cluster_health_drives_count`                | Count of all drives in the cluster. <br><br>Type: gauge             |        |
| `minio_cluster_health_nodes_offline_count`         | Count of offline nodes in the cluster. <br><br>Type: gauge          |        |
| `minio_cluster_health_nodes_online_count`          | Count of online nodes in the cluster. <br><br>Type: gauge           |        |
| `minio_cluster_health_capacity_raw_total_bytes`    | Total cluster raw storage capacity in bytes. <br><br>Type: gauge    |        |
| `minio_cluster_health_capacity_raw_free_bytes`     | Total cluster raw storage free in bytes. <br><br>Type: gauge        |        |
| `minio_cluster_health_capacity_usable_total_bytes` | Total cluster usable storage capacity in bytes. <br><br>Type: gauge |        |
| `minio_cluster_health_capacity_usable_free_bytes`  | Total cluster usable storage free in bytes. <br><br>Type: gauge     |        |

#### `/cluster/iam`

| Name                                                            | Description                                                                                                                                     | Labels |
|-----------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|--------|
| `minio_cluster_iam_last_sync_duration_millis`                   | Last successful IAM data sync duration in milliseconds. <br><br>Type: counter                                                                   |        |
| `minio_cluster_iam_plugin_authn_service_failed_requests_minute` | When plugin authentication is configured, returns failed requests count in the last full minute. <br><br>Type: counter                          |        |
| `minio_cluster_iam_plugin_authn_service_last_fail_seconds`      | When plugin authentication is configured, returns time (in seconds) since the last failed request to the service. <br><br>Type: counter         |        |
| `minio_cluster_iam_plugin_authn_service_last_succ_seconds`      | When plugin authentication is configured, returns time (in seconds) since the last successful request to the service. <br><br>Type: counter     |        |
| `minio_cluster_iam_plugin_authn_service_succ_avg_rtt_ms_minute` | When plugin authentication is configured, returns average round-trip time of successful requests in the last full minute. <br><br>Type: counter |        |
| `minio_cluster_iam_plugin_authn_service_succ_max_rtt_ms_minute` | When plugin authentication is configured, returns maximum round-trip time of successful requests in the last full minute. <br><br>Type: counter |        |
| `minio_cluster_iam_plugin_authn_service_total_requests_minute`  | When plugin authentication is configured, returns total requests count in the last full minute. <br><br>Type: counter                           |        |
| `minio_cluster_iam_since_last_sync_millis`                      | Time (in milliseconds) since last successful IAM data sync. <br><br>Type: counter                                                               |        |
| `minio_cluster_iam_sync_failures`                               | Number of failed IAM data syncs since server start. <br><br>Type: counter                                                                       |        |
| `minio_cluster_iam_sync_successes`                              | Number of successful IAM data syncs since server start. <br><br>Type: counter                                                                   |        |

#### `/cluster/usage/buckets` 

| Name                                                            | Description                                                                          | Labels            |
|-----------------------------------------------------------------|--------------------------------------------------------------------------------------|-------------------|
| `minio_cluster_usage_buckets_since_last_update_seconds`         | Time since last update of usage metrics in seconds. <br><br>Type: gauge              |                   |
| `minio_cluster_usage_buckets_total_bytes`                       | Total bucket size in bytes. <br><br>Type: gauge                                      | `bucket`          |
| `minio_cluster_usage_buckets_objects_count`                     | Total object count in bucket. <br><br>Type: gauge                                    | `bucket`          |
| `minio_cluster_usage_buckets_versions_count`                    | Total object versions count in bucket, including delete markers. <br><br>Type: gauge | `bucket`          |
| `minio_cluster_usage_buckets_delete_markers_count`              | Total delete markers count in bucket. <br><br>Type: gauge                            | `bucket`          |
| `minio_cluster_usage_buckets_quota_total_bytes`                 | Total bucket quota in bytes. <br><br>Type: gauge                                     | `bucket`          |
| `minio_cluster_usage_buckets_object_size_distribution`          | Bucket object size distribution. <br><br>Type: gauge                                 | `range`, `bucket` |
| `minio_cluster_usage_buckets_object_version_count_distribution` | Bucket object version count distribution. <br><br>Type: gauge                        | `range`, `bucket` |

#### `/cluster/usage/objects`

| Name                                                     | Description                                                                        | Labels  |
|----------------------------------------------------------|------------------------------------------------------------------------------------|---------|
| `minio_cluster_usage_objects_since_last_update_seconds`  | Time since last update of usage metrics in seconds. <br><br>Type: gauge            |         |
| `minio_cluster_usage_objects_total_bytes`                | Total cluster usage in bytes. <br><br>Type: gauge                                  |         |
| `minio_cluster_usage_objects_count`                      | Total cluster objects count. <br><br>Type: gauge                                   |         |
| `minio_cluster_usage_objects_versions_count`             | Total cluster object versions count, including delete markers. <br><br>Type: gauge |         |
| `minio_cluster_usage_objects_delete_markers_count`       | Total cluster delete markers count. <br><br>Type: gauge                            |         |
| `minio_cluster_usage_objects_buckets_count`              | Total cluster buckets count. <br><br>Type: gauge                                   |         |
| `minio_cluster_usage_objects_size_distribution`          | Cluster object size distribution. <br><br>Type: gauge                              | `range` |
| `minio_cluster_usage_objects_version_count_distribution` | Cluster object version count distribution. <br><br>Type: gauge                     | `range` |

