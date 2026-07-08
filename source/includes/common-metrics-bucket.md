# Bucket Metrics

MinIO collects the following metrics at the bucket level.
Each metric includes the ``bucket`` label to identify the corresponding bucket.
Metrics may include one or more additional labels, such as the server that calculated that metric.

These metrics can be obtained from any MinIO server once per collection by using the following URL:

```shell
https://HOSTNAME:PORT/minio/v2/metrics/bucket
```

Replace ``HOSTNAME:PORT`` with the hostname of your MinIO deployment.
For deployments behind a load balancer, use the load balancer hostname instead of a single node hostname.

## Distribution Metrics

| Name                                        | Description                                                                     |
|:--------------------------------------------|:--------------------------------------------------------------------------------|
| `minio_bucket_objects_size_distribution`    | Distribution of object sizes in the bucket, includes label for the bucket name. |
| `minio_bucket_objects_version_distribution` | Distribution of object sizes in a bucket, by number of versions                 |

## Replication Metrics

These metrics only populate on deployments with [Bucket Replication](https://docs.min.io/community/minio-object-store/administration/bucket-replication.html) or [Batch Replication](https://docs.min.io/community/minio-object-store/administration/batch-framework.html) configurations.
For deployments with [Site Replication](https://docs.min.io/community/minio-object-store/operations/install-deploy-manage/multi-site-replication.html) configured, select metrics populate under the [Cluster Metrics](#cluster-metrics) endpoint.

| Name                                                | Description                                                                      |
|:----------------------------------------------------|:---------------------------------------------------------------------------------|
| `minio_bucket_replication_last_minute_failed_bytes` | Total number of bytes failed at least once to replicate in the last full minute. |
| `minio_bucket_replication_last_minute_failed_count` | Total number of objects which failed replication in the last full minute.        |
| `minio_bucket_replication_last_hour_failed_bytes`   | Total number of bytes failed at least once to replicate in the last full hour.   |
| `minio_bucket_replication_last_hour_failed_count`   | Total number of objects which failed replication in the last full hour.          |
| `minio_bucket_replication_total_failed_bytes`       | Total number of bytes failed at least once to replicate since server start.      |
| `minio_bucket_replication_total_failed_count`       | Total number of objects which failed replication since server start.             |
| `minio_bucket_replication_latency_ms`               | Replication latency in milliseconds.                                             |
| `minio_bucket_replication_received_bytes`           | Total number of bytes replicated to this bucket from another source bucket.      |
| `minio_bucket_replication_received_count`           | Total number of objects received by this bucket from another source bucket.      |
| `minio_bucket_replication_sent_bytes`               | Total number of bytes replicated to the target bucket.                           |
| `minio_bucket_replication_sent_count`               | Total number of objects replicated to the target bucket.                         |
| `minio_bucket_replication_credential_errors`        | Total number of replication credential errors since server start                 |
| `minio_bucket_replication_proxied_get_requests_total` | Number of GET requests proxied to replication target                          |
| `minio_bucket_replication_proxied_head_requests_total` | Number of HEAD requests proxied to replication target                          |
| `minio_bucket_replication_proxied_delete_tagging_requests_total` | Number of DELETE tagging requests proxied to replication target                          |
| `minio_bucket_replication_proxied_get_tagging_requests_total` | Number of GET tagging requests proxied to replication target                          |
| `minio_bucket_replication_proxied_put_tagging_requests_total` | Number of PUT tagging requests proxied to replication target                          |
| `minio_bucket_replication_proxied_get_requests_failures` | Number of failures in GET requests proxied to replication target                          |
| `minio_bucket_replication_proxied_head_requests_failures` | Number of failures in HEAD requests proxied to replication target                          |
| `minio_bucket_replication_proxied_delete_tagging_requests_failures` | Number of failures in DELETE tagging proxy requests to replication target                          |
| `minio_bucket_replication_proxied_get_tagging_requests_failures` |Number of failures in GET tagging proxy requests to replication target                          |
| `minio_bucket_replication_proxied_put_tagging_requests_failures` | Number of failures in PUT tagging proxy requests to replication target                          |

## Traffic Metrics

| Name                                  | Description                                        |
|:--------------------------------------|:---------------------------------------------------|
| `minio_bucket_traffic_received_bytes` | Total number of S3 bytes received for this bucket. |
| `minio_bucket_traffic_sent_bytes`     | Total number of S3 bytes sent for this bucket.     |
	
## Usage Metrics

| Name                                    | Description                                       |
|:----------------------------------------|:--------------------------------------------------|
| `minio_bucket_usage_object_total`       | Total number of objects.                          |
| `minio_bucket_usage_version_total`      | Total number of versions (includes delete marker) |
| `minio_bucket_usage_deletemarker_total` | Total number of delete markers.                   |
| `minio_bucket_usage_total_bytes`        | Total bucket size in bytes.                       |
| `minio_bucket_quota_total_bytes`        | Total bucket quota size in bytes.                 |

## Requests Metrics

| Name                                              | Description                                                     |
|:--------------------------------------------------|:----------------------------------------------------------------|
| `minio_bucket_requests_4xx_errors_total`          | Total number of S3 requests with (4xx) errors on a bucket.      |
| `minio_bucket_requests_5xx_errors_total`          | Total number of S3 requests with (5xx) errors on a bucket.      |
| `minio_bucket_requests_inflight_total`            | Total number of S3 requests currently in flight on a bucket.    |
| `minio_bucket_requests_total`                     | Total number of S3 requests on a bucket.                        |
| `minio_bucket_requests_canceled_total`            | Total number S3 requests canceled by the client.                |
| `minio_bucket_requests_ttfb_seconds_distribution` | Distribution of time to first byte across API calls per bucket. |

