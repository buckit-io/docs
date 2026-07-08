### Logger webhook metrics

Metrics about MinIO logger webhooks.

| Path              | Description                         |
|-------------------|-------------------------------------|
| `/logger/webhook` | Metrics related to logger webhooks. |

#### `/logger/webhook`

| Name                                    | Description                                                         | Labels                       |
|-----------------------------------------|---------------------------------------------------------------------|------------------------------|
| `minio_logger_webhook_failed_messages`  | Number of messages that failed to send. <br><br>Type: counter       | `server`, `name`, `endpoint` |
| `minio_logger_webhook_queue_length`     | Webhook queue length. <br><br>Type: gauge                           | `server`, `name`, `endpoint` |
| `minio_logger_webhook_total_message`    | Total number of messages sent to this target. <br><br>Type: counter | `server`, `name`, `endpoint` |

