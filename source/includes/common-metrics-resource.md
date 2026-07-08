# Resource Metrics

MinIO collects the following resource metrics at the node level.
Each metric includes the `server` label to identify the corresponding node.
Metrics may include one or more additional labels, such as the drive path, interface name, etc.

These metrics can be obtained from any MinIO server once per collection by using the following URL:

```shell
https://HOSTNAME:PORT/minio/v2/metrics/resource
```

Replace `HOSTNAME:PORT` with the hostname of your MinIO deployment.
For deployments behind a load balancer, use the load balancer hostname instead of a single node hostname.

## Drive Resource Metrics

| Name                                 | Description                                              |
|:-------------------------------------|:---------------------------------------------------------|
| `minio_node_drive_total_bytes`       | Total bytes on a drive.                                  |
| `minio_node_drive_used_bytes`        | Used bytes on a drive.                                   |
| `minio_node_drive_total_inodes`      | Total inodes on a drive.                                 |
| `minio_node_drive_used_inodes`       | Total inodes used on a drive.                            |
| `minio_node_drive_reads_per_sec`     | Reads per second on a drive.                             |
| `minio_node_drive_reads_kb_per_sec`  | Kilobytes read per second on a drive.                    |
| `minio_node_drive_reads_await`       | Average time for read requests to be served on a drive.  |
| `minio_node_drive_writes_per_sec`    | Writes per second on a drive.                            |
| `minio_node_drive_writes_kb_per_sec` | Kilobytes written per second on a drive.                 |
| `minio_node_drive_writes_await`      | Average time for write requests to be served on a drive. |
| `minio_node_drive_perc_util`         | Percentage of time the disk was busy since uptime.       |

## Network Interface Metrics

| Name                          | Description                                                |
|:------------------------------|:-----------------------------------------------------------|
| `minio_node_if_rx_bytes`      | Bytes received on the interface in 60s.                    |
| `minio_node_if_rx_bytes_avg`  | Bytes received on the interface in 60s (avg) since uptime. |
| `minio_node_if_rx_bytes_max`  | Bytes received on the interface in 60s (max) since uptime. |
| `minio_node_if_rx_errors`     | Receive errors in 60s.                                     |
| `minio_node_if_rx_errors_avg` | Receive errors in 60s (avg).                               |
| `minio_node_if_rx_errors_max` | Receive errors in 60s (max).                               |
| `minio_node_if_tx_bytes`      | Bytes transmitted in 60s.                                  |
| `minio_node_if_tx_bytes_avg`  | Bytes transmitted in 60s (avg).                            |
| `minio_node_if_tx_bytes_max`  | Bytes transmitted in 60s (max).                            |
| `minio_node_if_tx_errors`     | Transmit errors in 60s.                                    |
| `minio_node_if_tx_errors_avg` | Transmit errors in 60s (avg).                              |
| `minio_node_if_tx_errors_max` | Transmit errors in 60s (max).                              |

## CPU Metrics

| Name                                 | Description                                |
|:-------------------------------------|:-------------------------------------------|
| `minio_node_cpu_avg_user`            | CPU user time.                             |
| `minio_node_cpu_avg_user_avg`        | CPU user time (avg).                       |
| `minio_node_cpu_avg_user_max`        | CPU user time (max).                       |
| `minio_node_cpu_avg_system`          | CPU system time.                           |
| `minio_node_cpu_avg_system_avg`      | CPU system time (avg).                     |
| `minio_node_cpu_avg_system_max`      | CPU system time (max).                     |
| `minio_node_cpu_avg_idle`            | CPU idle time.                             |
| `minio_node_cpu_avg_idle_avg`        | CPU idle time (avg).                       |
| `minio_node_cpu_avg_idle_max`        | CPU idle time (max).                       |
| `minio_node_cpu_avg_iowait`          | CPU ioWait time.                           |
| `minio_node_cpu_avg_iowait_avg`      | CPU ioWait time (avg).                     |
| `minio_node_cpu_avg_iowait_max`      | CPU ioWait time (max).                     |
| `minio_node_cpu_avg_nice`            | CPU nice time.                             |
| `minio_node_cpu_avg_nice_avg`        | CPU nice time (avg).                       |
| `minio_node_cpu_avg_nice_max`        | CPU nice time (max).                       |
| `minio_node_cpu_avg_steal`           | CPU steam time.                            |
| `minio_node_cpu_avg_steal_avg`       | CPU steam time (avg).                      |
| `minio_node_cpu_avg_steal_max`       | CPU steam time (max).                      |
| `minio_node_cpu_avg_load1`           | CPU load average 1min.                     |
| `minio_node_cpu_avg_load1_avg`       | CPU load average 1min (avg).               |
| `minio_node_cpu_avg_load1_max`       | CPU load average 1min (max).               |
| `minio_node_cpu_avg_load1_perc`      | CPU load average 1min (percentage).        |
| `minio_node_cpu_avg_load1_perc_avg`  | CPU load average 1min (percentage) (avg).  |
| `minio_node_cpu_avg_load1_perc_max`  | CPU load average 1min (percentage) (max).  |
| `minio_node_cpu_avg_load5`           | CPU load average 5min.                     |
| `minio_node_cpu_avg_load5_avg`       | CPU load average 5min (avg).               |
| `minio_node_cpu_avg_load5_max`       | CPU load average 5min (max).               |
| `minio_node_cpu_avg_load5_perc`      | CPU load average 5min (percentage).        |
| `minio_node_cpu_avg_load5_perc_avg`  | CPU load average 5min (percentage) (avg).  |
| `minio_node_cpu_avg_load5_perc_max`  | CPU load average 5min (percentage) (max).  |
| `minio_node_cpu_avg_load15`          | CPU load average 15min.                    |
| `minio_node_cpu_avg_load15_avg`      | CPU load average 15min (avg).              |
| `minio_node_cpu_avg_load15_max`      | CPU load average 15min (max).              |
| `minio_node_cpu_avg_load15_perc`     | CPU load average 15min (percentage).       |
| `minio_node_cpu_avg_load15_perc_avg` | CPU load average 15min (percentage) (avg). |
| `minio_node_cpu_avg_load15_perc_max` | CPU load average 15min (percentage) (max). |

## Memory Metrics

| Name                           | Description                               |
|:-------------------------------|:------------------------------------------|
| `minio_node_mem_available`     | Available memory on the node.             |
| `minio_node_mem_available_avg` | Available memory on the node (avg).       |
| `minio_node_mem_available_max` | Available memory on the node (max).       |
| `minio_node_mem_buffers`       | Buffers memory on the node.               |
| `minio_node_mem_buffers_avg`   | Buffers memory on the node (avg).         |
| `minio_node_mem_buffers_max`   | Buffers memory on the node (max).         |
| `minio_node_mem_cache`         | Cache memory on the node.                 |
| `minio_node_mem_cache_avg`     | Cache memory on the node (avg).           |
| `minio_node_mem_cache_max`     | Cache memory on the node (max).           |
| `minio_node_mem_free`          | Free memory on the node.                  |
| `minio_node_mem_free_avg`      | Free memory on the node (avg).            |
| `minio_node_mem_free_max`      | Free memory on the node (max).            |
| `minio_node_mem_shared`        | Shared memory on the node.                |
| `minio_node_mem_shared_avg`    | Shared memory on the node (avg).          |
| `minio_node_mem_shared_max`    | Shared memory on the node (max).          |
| `minio_node_mem_total`         | Total memory on the node.                 |
| `minio_node_mem_total_avg`     | Total memory on the node (avg).           |
| `minio_node_mem_total_max`     | Total memory on the node (max).           |
| `minio_node_mem_used`          | Used memory on the node.                  |
| `minio_node_mem_used_avg`      | Used memory on the node (avg).            |
| `minio_node_mem_used_max`      | Used memory on the node (max).            |
| `minio_node_mem_used_perc`     | Used memory percentage on the node.       |
| `minio_node_mem_used_perc_avg` | Used memory percentage on the node (avg). |
| `minio_node_mem_used_perc_max` | Used memory percentage on the node (max). |
