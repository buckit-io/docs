### Replication metrics

Metrics about MinIO site and bucket replication.

| Path                  | Description                            |
|-----------------------|----------------------------------------|
| `/bucket/replication` | Metrics related to bucket replication. |
| `/replication`        | Metrics related to site replication.   |

#### `/replication`

| Name                                              | Description                                                                                 | Labels   |
|---------------------------------------------------|---------------------------------------------------------------------------------------------|----------|
| `minio_replication_average_active_workers`        | Average number of active replication workers. <br><br>Type: gauge                           | `server` |
| `minio_replication_average_queued_bytes`          | Average number of bytes queued for replication since server start. <br><br>Type: gauge      | `server` |
| `minio_replication_average_queued_count`          | Average number of objects queued for replication since server start. <br><br>Type: gauge    | `server` |
| `minio_replication_average_data_transfer_rate`    | Average replication data transfer rate in bytes/sec. <br><br>Type: gauge                    | `server` |
| `minio_replication_current_active_workers`        | Total number of active replication workers. <br><br>Type: gauge                             | `server` |
| `minio_replication_current_data_transfer_rate`    | Current replication data transfer rate in bytes/sec. <br><br>Type: gauge                    | `server` |
| `minio_replication_last_minute_queued_bytes`      | Number of bytes queued for replication in the last full minute. <br><br>Type: gauge         | `server` |
| `minio_replication_last_minute_queued_count`      | Number of objects queued for replication in the last full minute. <br><br>Type: gauge       | `server` |
| `minio_replication_max_active_workers`            | Maximum number of active replication workers seen since server start. <br><br>Type: gauge   | `server` |
| `minio_replication_max_queued_bytes`              | Maximum number of bytes queued for replication since server start. <br><br>Type: gauge      | `server` |
| `minio_replication_max_queued_count`              | Maximum number of objects queued for replication since server start. <br><br>Type: gauge    | `server` |
| `minio_replication_max_data_transfer_rate`        | Maximum replication data transfer rate in bytes/sec since server start. <br><br>Type: gauge | `server` |
| `minio_replication_recent_backlog_count`          | Total number of objects seen in replication backlog in the last 5 minutes <br><br>Type: gauge | `server` |
#### `/bucket/replication`

| Name                                                                | Description                                                                                                     | Labels                                                |
|---------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|
| `minio_bucket_replication_last_hour_failed_bytes`                   | Total number of bytes on a bucket which failed to replicate at least once in the last hour. <br><br>Type: gauge | `bucket`, `server`                                    |
| `minio_bucket_replication_last_hour_failed_count`                   | Total number of objects on a bucket which failed to replicate in the last hour. <br><br>Type: gauge             | `bucket`, `server`                                    |
| `minio_bucket_replication_last_minute_failed_bytes`                 | Total number of bytes on a bucket which failed at least once in the last full minute. <br><br>Type: gauge       | `bucket`, `server`                                    |
| `minio_bucket_replication_last_minute_failed_count`                 | Total number of objects on a bucket which failed to replicate in the last full minute. <br><br>Type: gauge      | `bucket`, `server`                                    |
| `minio_bucket_replication_latency_ms`                               | Replication latency on a bucket in milliseconds. <br><br>Type: gauge                                            | `bucket`, `operation`, `range`, `targetArn`, `server` |
| `minio_bucket_replication_proxied_delete_tagging_requests_total`    | Number of DELETE tagging requests proxied to replication target. <br><br>Type: counter                          | `bucket`, `server`                                    |
| `minio_bucket_replication_proxied_get_requests_failures`            | Number of failures in GET requests proxied to replication target. <br><br>Type: counter                         | `bucket`, `server`                                    |
| `minio_bucket_replication_proxied_get_requests_total`               | Number of GET requests proxied to replication target. <br><br>Type: counter                                     | `bucket`, `server`                                    |
| `minio_bucket_replication_proxied_get_tagging_requests_failures`    | Number of failures in GET tagging requests proxied to replication target. <br><br>Type: counter                 | `bucket`, `server`                                    |
| `minio_bucket_replication_proxied_get_tagging_requests_total`       | Number of GET tagging requests proxied to replication target. <br><br>Type: counter                             | `bucket`, `server`                                    |
| `minio_bucket_replication_proxied_head_requests_failures`           | Number of failures in HEAD requests proxied to replication target. <br><br>Type: counter                        | `bucket`, `server`                                    |
| `minio_bucket_replication_proxied_head_requests_total`              | Number of HEAD requests proxied to replication target. <br><br>Type: counter                                    | `bucket`, `server`                                    |
| `minio_bucket_replication_proxied_put_tagging_requests_failures`    | Number of failures in PUT tagging requests proxied to replication target. <br><br>Type: counter                 | `bucket`, `server`                                    |
| `minio_bucket_replication_proxied_put_tagging_requests_total`       | Number of PUT tagging requests proxied to replication target. <br><br>Type: counter                             | `bucket`, `server`                                    |
| `minio_bucket_replication_sent_bytes`                               | Total number of bytes replicated to the target. <br><br>Type: counter                                           | `bucket`, `server`                                    |
| `minio_bucket_replication_sent_count`                               | Total number of objects replicated to the target. <br><br>Type: counter                                         | `bucket`, `server`                                    |
| `minio_bucket_replication_total_failed_bytes`                       | Total number of bytes failed to replicate at least once since server start. <br><br>Type: counter               | `bucket`, `server`                                    |
| `minio_bucket_replication_total_failed_count`                       | Total number of objects that failed to replicate since server start. <br><br>Type: counter                      | `bucket`, `server`                                    |
| `minio_bucket_replication_proxied_delete_tagging_requests_failures` | Number of failures in DELETE tagging requests proxied to replication target. <br><br>Type: counter              | `bucket`, `server`                                    |

