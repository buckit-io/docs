### Notification metrics

Metrics about the MinIO notification functionality.

| Path            | Description                                    |
|-----------------|------------------------------------------------|
| `/notification` | Metrics related to notification functionality. |

#### `/notification`

| Name                                          | Description                                                                                           | Labels   |
|-----------------------------------------------|-------------------------------------------------------------------------------------------------------|----------|
| `minio_notification_current_send_in_progress` | Number of concurrent async Send calls active to all targets. <br><br>Type: counter                    | `server` |
| `minio_notification_events_errors_total`      | Total number of events that failed to send to the targets. <br><br>Type: counter                      | `server` |
| `minio_notification_events_sent_total`        | Total number of events sent to the targets. <br><br>Type: counter                                     | `server` |
| `minio_notification_events_skipped_total`     | Number of events not sent to the targets due to the in-memory queue being full. <br><br>Type: counter | `server` |

