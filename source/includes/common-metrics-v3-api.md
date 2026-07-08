### API metrics

Metrics about requests served by the current node.

| Path            | Description                                   |
|-----------------|-----------------------------------------------|
| `/api/requests` | Metrics over all requests.                    |
| `/bucket/api`   | Metrics over all requests for a given bucket. |

#### `/api/requests`

| Name                                           | Description                                                                    | Labels                                       |
|------------------------------------------------|--------------------------------------------------------------------------------|----------------------------------------------|
| `minio_api_requests_rejected_auth_total`       | Total number of requests rejected for auth failure. <br><br>Type: counter      | `type`, `pool_index`, `server`               |
| `minio_api_requests_rejected_header_total`     | Total number of requests rejected for invalid header. <br><br>Type: counter    | `type`, `pool_index`, `server`               |
| `minio_api_requests_rejected_timestamp_total`  | Total number of requests rejected for invalid timestamp. <br><br>Type: counter | `type`, `pool_index`, `server`               |
| `minio_api_requests_rejected_invalid_total`    | Total number of invalid requests. <br><br>Type: counter                        | `type`, `pool_index`, `server`               |
| `minio_api_requests_waiting_total`             | Total number of requests in the waiting queue. <br><br>Type: gauge             | `type`, `pool_index`, `server`               |
| `minio_api_requests_incoming_total`            | Total number of incoming requests. <br><br>Type: gauge                         | `type`, `pool_index`, `server`               |
| `minio_api_requests_inflight_total`            | Total number of requests currently in flight. <br><br>Type: gauge              | `name`, `type`, `pool_index`, `server`       |
| `minio_api_requests_total`                     | Total number of requests. <br><br>Type: counter                                | `name`, `type`, `pool_index`, `server`       |
| `minio_api_requests_errors_total`              | Total number of requests with 4xx or 5xx errors. <br><br>Type: counter         | `name`, `type`, `pool_index`, `server`       |
| `minio_api_requests_5xx_errors_total`          | Total number of requests with 5xx errors. <br><br>Type: counter                | `name`, `type`, `pool_index`, `server`       |
| `minio_api_requests_4xx_errors_total`          | Total number of requests with 4xx errors. <br><br>Type: counter                | `name`, `type`, `pool_index`, `server`       |
| `minio_api_requests_canceled_total`            | Total number of requests canceled by the client. <br><br>Type: counter         | `name`, `type`, `pool_index`, `server`       |
| `minio_api_requests_ttfb_seconds_distribution` | Distribution of time to first byte across API calls. <br><br>Type: counter     | `name`, `type`, `le`, `pool_index`, `server` |
| `minio_api_requests_traffic_sent_bytes`        | Total number of bytes sent. <br><br>Type: counter                              | `type`, `pool_index`, `server`               |
| `minio_api_requests_traffic_received_bytes`    | Total number of bytes received. <br><br>Type: counter                          | `type`, `pool_index`, `server`               |

#### `/bucket/api`

| Name                                         | Description                                                                             | Labels                                                 |
|----------------------------------------------|-----------------------------------------------------------------------------------------|--------------------------------------------------------|
| `minio_bucket_api_traffic_received_bytes`    | Total number of bytes sent for a bucket. <br><br>Type: counter                          | `bucket`, `type`, `server`, `pool_index`               |
| `minio_bucket_api_traffic_sent_bytes`        | Total number of bytes received for a bucket. <br><br>Type: counter                      | `bucket`, `type`, `server`, `pool_index`               |
| `minio_bucket_api_inflight_total`            | Total number of requests currently in flight for a bucket. <br><br>Type: gauge          | `bucket`, `name`, `type`, `server`, `pool_index`       |
| `minio_bucket_api_total`                     | Total number of requests for a bucket. <br><br>Type: counter                            | `bucket`, `name`, `type`, `server`, `pool_index`       |
| `minio_bucket_api_canceled_total`            | Total number of requests canceled by the client for a bucket. <br><br>Type: counter     | `bucket`, `name`, `type`, `server`, `pool_index`       |
| `minio_bucket_api_4xx_errors_total`          | Total number of requests with 4xx errors for a bucket. <br><br>Type: counter            | `bucket`, `name`, `type`, `server`, `pool_index`       |
| `minio_bucket_api_5xx_errors_total`          | Total number of requests with 5xx errors for a bucket. <br><br>Type: counter            | `bucket`, `name`, `type`, `server`, `pool_index`       |
| `minio_bucket_api_ttfb_seconds_distribution` | Distribution of time to first byte across API calls for a bucket. <br><br>Type: counter | `bucket`, `name`, `le`, `type`, `server`, `pool_index` |

