### System metrics

Metrics about the MinIO process and the node.

| Path                        | Description                                        |
|-----------------------------|----------------------------------------------------|
| `/system/cpu`               | Metrics about CPUs on the system.                  |
| `/system/drive`             | Metrics about drives on the system.                |
| `/system/network/internode` | Metrics about internode requests made by the node. |
| `/system/memory`            | Metrics about memory on the system.                |
| `/system/process`           | Standard process metrics.                          |

#### `/system/drive`

| Name                                           | Description                                                                             | Labels                                                             |
|------------------------------------------------|-----------------------------------------------------------------------------------------|--------------------------------------------------------------------|
| `minio_system_drive_used_bytes`                | Total storage used on a drive in bytes. <br><br>Type: gauge                             | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_free_bytes`                | Total storage free on a drive in bytes. <br><br>Type: gauge                             | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_total_bytes`               | Total storage available on a drive in bytes. <br><br>Type: gauge                        | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_used_inodes`               | Total used inodes on a drive. <br><br>Type: gauge                                       | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_free_inodes`               | Total free inodes on a drive. <br><br>Type: gauge                                       | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_total_inodes`              | Total inodes available on a drive. <br><br>Type: gauge                                  | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_timeout_errors_total`      | Total timeout errors on a drive. <br><br>Type: counter                                  | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_io_errors_total`           | Total I/O errors on a drive. <br><br>Type: counter                                      | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_availability_errors_total` | Total availability errors (I/O errors, timeouts) on a drive. <br><br>Type: counter      | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_waiting_io`                | Total waiting I/O operations on a drive. <br><br>Type: gauge                            | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_api_latency_micros`        | Average last minute latency in µs for drive API storage operations. <br><br>Type: gauge | `drive`, `api`, `set_index`, `drive_index`, `pool_index`, `server` |
| `minio_system_drive_offline_count`             | Count of offline drives. <br><br>Type: gauge                                            | `pool_index`, `server`                                             |
| `minio_system_drive_online_count`              | Count of online drives. <br><br>Type: gauge                                             | `pool_index`, `server`                                             |
| `minio_system_drive_count`                     | Count of all drives. <br><br>Type: gauge                                                | `pool_index`, `server`                                             |
| `minio_system_drive_health`                    | Drive health (0 = offline, 1 = healthy, 2 = healing). <br><br>Type: gauge               | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_reads_per_sec`             | Reads per second on a drive. <br><br>Type: gauge                                        | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_reads_kb_per_sec`          | Kilobytes read per second on a drive. <br><br>Type: gauge                               | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_reads_await`               | Average time for read requests served on a drive. <br><br>Type: gauge                   | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_writes_per_sec`            | Writes per second on a drive. <br><br>Type: gauge                                       | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_writes_kb_per_sec`         | Kilobytes written per second on a drive. <br><br>Type: gauge                            | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_writes_await`              | Average time for write requests served on a drive. <br><br>Type: gauge                  | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |
| `minio_system_drive_perc_util`                 | Percentage of time the disk was busy. <br><br>Type: gauge                               | `drive`, `set_index`, `drive_index`, `pool_index`, `server`        |

#### `/system/memory`

| Name                             | Description                                             | Labels   |
|----------------------------------|---------------------------------------------------------|----------|
| `minio_system_memory_used`       | Used memory on the node. <br><br>Type: gauge            | `server` |
| `minio_system_memory_used_perc`  | Used memory percentage on the node. <br><br>Type: gauge | `server` |
| `minio_system_memory_free`       | Free memory on the node. <br><br>Type: gauge            | `server` |
| `minio_system_memory_total`      | Total memory on the node. <br><br>Type: gauge           | `server` |
| `minio_system_memory_buffers`    | Buffers memory on the node. <br><br>Type: gauge         | `server` |
| `minio_system_memory_cache`      | Cache memory on the node. <br><br>Type: gauge           | `server` |
| `minio_system_memory_shared`     | Shared memory on the node. <br><br>Type: gauge          | `server` |
| `minio_system_memory_available`  | Available memory on the node. <br><br>Type: gauge       | `server` |

#### `/system/cpu`

| Name                          | Description                                             | Labels   |
|-------------------------------|---------------------------------------------------------|----------|
| `minio_system_cpu_avg_idle`   | Average CPU idle time. <br><br>Type: gauge              | `server` |
| `minio_system_cpu_avg_iowait` | Average CPU IOWait time. <br><br>Type: gauge            | `server` |
| `minio_system_cpu_load`       | CPU load average 1min. <br><br>Type: gauge              | `server` |
| `minio_system_cpu_load_perc`  | CPU load average 1min (percentage). <br><br>Type: gauge | `server` |
| `minio_system_cpu_nice`       | CPU nice time. <br><br>Type: gauge                      | `server` |
| `minio_system_cpu_steal`      | CPU steal time. <br><br>Type: gauge                     | `server` |
| `minio_system_cpu_system`     | CPU system time. <br><br>Type: gauge                    | `server` |
| `minio_system_cpu_user`       | CPU user time. <br><br>Type: gauge                      | `server` |

#### `/system/network/internode`

| Name                                                 | Description                                                                   | Labels                 |
|------------------------------------------------------|-------------------------------------------------------------------------------|------------------------|
| `minio_system_network_internode_errors_total`        | Total number of failed internode calls. <br><br>Type: counter                 | `server`, `pool_index` |
| `minio_system_network_internode_dial_errors_total`   | Total number of internode TCP dial timeouts and errors. <br><br>Type: counter | `server`, `pool_index` |
| `minio_system_network_internode_dial_avg_time_nanos` | Average dial time of internodes TCP calls in nanoseconds. <br><br>Type: gauge | `server`, `pool_index` |
| `minio_system_network_internode_sent_bytes_total`    | Total number of bytes sent to other peer nodes. <br><br>Type: counter         | `server`, `pool_index` |
| `minio_system_network_internode_recv_bytes_total`    | Total number of bytes received from other peer nodes. <br><br>Type: counter   | `server`, `pool_index` |

#### `/system/process`

| Name                                               | Description                                                                                                                           | Labels   |
|----------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------|----------|
| `minio_system_process_locks_read_total`            | Number of current READ locks on this peer. <br><br>Type: gauge                                                                        | `server` |
| `minio_system_process_locks_write_total`           | Number of current WRITE locks on this peer. <br><br>Type: gauge                                                                       | `server` |
| `minio_system_process_cpu_total_seconds`           | Total user and system CPU time spent in seconds. <br><br>Type: counter                                                                | `server` |
| `minio_system_process_go_routine_total`            | Total number of go routines running. <br><br>Type: gauge                                                                              | `server` |
| `minio_system_process_io_rchar_bytes`              | Total bytes read by the process from the underlying storage system including cache, /proc/[pid]/io rchar. <br><br>Type: counter       | `server` |
| `minio_system_process_io_read_bytes`               | Total bytes read by the process from the underlying storage system, /proc/[pid]/io read_bytes. <br><br>Type: counter                  | `server` |
| `minio_system_process_io_wchar_bytes`              | Total bytes written by the process to the underlying storage system including page cache, /proc/[pid]/io wchar. <br><br>Type: counter | `server` |
| `minio_system_process_io_write_bytes`              | Total bytes written by the process to the underlying storage system, /proc/[pid]/io write_bytes. <br><br>Type: counter                | `server` |
| `minio_system_process_start_time_seconds`          | Start time for MinIO process in seconds since Unix epoch. <br><br>Type: gauge                                                         | `server` |
| `minio_system_process_uptime_seconds`              | Uptime for MinIO process in seconds. <br><br>Type: gauge                                                                              | `server` |
| `minio_system_process_file_descriptor_limit_total` | Limit on total number of open file descriptors for the MinIO Server process. <br><br>Type: gauge                                      | `server` |
| `minio_system_process_file_descriptor_open_total`  | Total number of open file descriptors by the MinIO Server process. <br><br>Type: gauge                                                | `server` |
| `minio_system_process_syscall_read_total`          | Total read SysCalls to the kernel. /proc/[pid]/io syscr. <br><br>Type: counter                                                        | `server` |
| `minio_system_process_syscall_write_total`         | Total write SysCalls to the kernel. /proc/[pid]/io syscw. <br><br>Type: counter                                                       | `server` |
| `minio_system_process_resident_memory_bytes`       | Resident memory size in bytes. <br><br>Type: gauge                                                                                    | `server` |
| `minio_system_process_virtual_memory_bytes`        | Virtual memory size in bytes. <br><br>Type: gauge                                                                                     | `server` |
| `minio_system_process_virtual_memory_max_bytes`    | Maximum virtual memory size in bytes. <br><br>Type: gauge                                                                             | `server` |
