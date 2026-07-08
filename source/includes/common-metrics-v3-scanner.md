### Scanner metrics

Metrics about the MinIO scanner.

| Path       | Description                           |
|------------|---------------------------------------|
| `/scanner` | Metrics related to the MinIO scanner. |

#### `/scanner`

| Name                                       | Description                                                                       | Labels   |
|--------------------------------------------|-----------------------------------------------------------------------------------|----------|
| `minio_scanner_bucket_scans_finished`      | Total number of bucket scans completed since server start. <br><br>Type: counter  | `server` |
| `minio_scanner_bucket_scans_started`       | Total number of bucket scans started since server start. <br><br>Type: counter    | `server` |
| `minio_scanner_directories_scanned`        | Total number of directories scanned since server start. <br><br>Type: counter     | `server` |
| `minio_scanner_last_activity_seconds`      | Time elapsed (in seconds) since last scan activity. <br><br>Type: gauge           | `server` |
| `minio_scanner_objects_scanned`            | Total number of unique objects scanned since server start. <br><br>Type: counter  | `server` |
| `minio_scanner_versions_scanned`           | Total number of object versions scanned since server start. <br><br>Type: counter | `server` |

