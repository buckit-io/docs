### ILM metrics

Metrics about the MinIO ILM functionality.

| Path   | Description                           |
|--------|---------------------------------------|
| `/ilm` | Metrics related to ILM functionality. |

#### `/ilm`

| Name                                                  | Description                                                                                       | Labels   |
|-------------------------------------------------------|---------------------------------------------------------------------------------------------------|----------|
| `minio_cluster_ilm_expiry_pending_tasks`              | Number of pending ILM expiry tasks in the queue. <br><br>Type: gauge                              | `server` |
| `minio_cluster_ilm_transition_active_tasks`           | Number of active ILM transition tasks. <br><br>Type: gauge                                        | `server` |
| `minio_cluster_ilm_transition_pending_tasks`          | Number of pending ILM transition tasks in the queue. <br><br>Type: gauge                          | `server` |
| `minio_cluster_ilm_transition_missed_immediate_tasks` | Number of missed immediate ILM transition tasks. <br><br>Type: counter                            | `server` |
| `minio_cluster_ilm_versions_scanned`                  | Total number of object versions checked for ILM actions since server start. <br><br>Type: counter | `server` |

