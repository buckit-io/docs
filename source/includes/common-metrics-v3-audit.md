### Audit metrics

Metrics about the MinIO audit functionality.

| Path     | Description                             |
|----------|-----------------------------------------|
| `/audit` | Metrics related to audit functionality. |

#### `/audit`

| Name                              | Description                                                                     | Labels                |
|-----------------------------------|---------------------------------------------------------------------------------|-----------------------|
| `minio_audit_failed_messages`     | Total number of messages that failed to send since start. <br><br>Type: counter | `target_id`, `server` |
| `minio_audit_target_queue_length` | Number of unsent messages in queue for target. <br><br>Type: gauge              | `target_id`, `server` |
| `minio_audit_total_messages`      | Total number of messages sent since start. <br><br>Type: counter                | `target_id`, `server` |

