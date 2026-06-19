.. _minio-hardware-checklist:

==================
Hardware Checklist
==================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

Use the following checklist when planning the hardware configuration for a production, distributed Buckit deployment.

Considerations
--------------

When selecting hardware for your Buckit implementation, take into account the following factors:

- Expected amount of data in tebibytes to store at launch
- Expected growth in size of data for at least the next two years
- Number of objects by average object size
- Average retention time of data in years
- Number of sites to be deployed
- Number of expected buckets

.. _deploy-minio-distributed-recommendations:

Production Hardware Recommendations
-----------------------------------

Buckit, like any distributed system, benefits from selecting identical configurations for all nodes in a given :term:`server pool`. 
Ensure a consistent selection of hardware (CPU, memory, motherboard, storage adapters) and software (operating system, kernel settings, system services) across pool nodes. 

Deployments may exhibit unpredictable performance if nodes have varying hardware or software configurations. 
Workloads that benefit from storing aged data on lower-cost hardware should instead deploy a dedicated "warm" or "cold" Buckit deployment and :ref:`transition <minio-lifecycle-management-tiering>` data to that tier.

.. include:: /includes/common/common-checklist.rst
   :start-after: start-linux-hardware-checklist
   :end-before: end-linux-hardware-checklist

.. important:: 

   The following areas have the greatest impact on Buckit performance, listed in order of importance:

   .. list-table:: 
      :stub-columns: 1
      :widths: auto
      :width: 100%

      * - Network Infrastructure
        - Insufficient or limited throughput constrains performance
      
      * - Storage Controller
        - Old firmware, limited throughput, or failing hardware constrains performance and affects reliability

      * - Storage (Drive)
        - Old firmware, or slow/aging/failing hardware constrains performance and affects reliability

   Prioritize securing the necessary components for each of these areas before focusing on other hardware resources, such as compute-related constraints.

The minimum recommendations above reflect Buckit's experience with assisting enterprise customers in deploying on a variety of IT infrastructures while maintaining the desired SLA/SLO. 
While Buckit may run on less than the minimum recommended topology, any potential cost savings come at the risk of decreased reliability, performance, or overall functionality.

.. _minio-hardware-checklist-network:

Networking
~~~~~~~~~~

Buckit recommends high speed networking to support the maximum possible throughput of the attached storage (aggregated drives, storage controllers, and PCIe busses). The following table provides a general guideline for the maximum storage throughput supported by a given physical or virtual network interface.
This table assumes all network infrastructure components, such as routers, switches, and physical cabling, also supports the NIC bandwidth.

.. list-table::
   :widths: auto
   :width: 100%

   * - NIC Bandwidth (Gbps)
     - Estimated Aggregated Storage Throughput (GBps)

   * - 10Gbps
     - 1.25GBps

   * - 25Gbps
     - 3.125GBps

   * - 50Gbps
     - 6.25GBps

   * - 100Gbps
     - 12.5GBps

Networking has the greatest impact on Buckit performance, where low per-host bandwidth artificially constrains the potential performance of the storage.
The following examples of network throughput constraints assume spinning disks with ~100MB/S sustained I/O

- 1GbE network link can support up to 125MB/s, or one spinning disk
- 10GbE network can support approximately 1.25GB/s, potentially supporting 10-12 spinning disks
- 25GbE network can support approximately 3.125GB/s, potentially supporting ~30 spinning disks

.. _minio-hardware-checklist-memory:

Memory
~~~~~~

Memory primarily constrains the number of concurrent simultaneous connections per node.

You can calculate the maximum number of concurrent requests per node with this formula:

   :math:`totalRam / ramPerRequest`

To calculate the amount of RAM used for each request, use this formula:

   :math:`((2MiB + 128KiB) * driveCount) + (2 * 10MiB) + (2 * 1 MiB)`

   10MiB is the default erasure block size v1.
   1 MiB is the default erasure block size v2.

The following table lists the maximum concurrent requests on a node based on the number of host drives and the *free* system RAM:

.. list-table::
   :header-rows: 1
   :width: 100%

   * - Number of Drives
     - 32 GiB of RAM
     - 64 GiB of RAM
     - 128 GiB of RAM
     - 256 GiB of RAM
     - 512 GiB of RAM

   * - 4 Drives
     - 1,074 
     - 2,149 
     - 4,297 
     - 8,595 
     - 17,190 

   * - 8 Drives
     - 840 
     - 1,680 
     - 3,361 
     - 6,722 
     - 13,443 

   * - 16 Drives
     - 585 
     - 1,170 
     - 2.341 
     - 4,681 
     - 9,362 

The following table provides general guidelines for allocating memory for use by Buckit based on the total amount of local storage on the node:

.. list-table::
   :header-rows: 1
   :width: 100%
   :widths: 40 60

   * - Total Host Storage
     - Recommended Host Memory

   * - Up to 1 Tebibyte (Ti)
     - 8GiB

   * - Up to 10 Tebibyte (Ti)
     - 16GiB

   * - Up to 100 Tebibyte (Ti)
     - 32GiB
   
   * - Up to 1 Pebibyte (Pi)
     - 64GiB

   * - More than 1 Pebibyte (Pi)
     - 128GiB

.. _minio-hardware-checklist-storage:

Storage
~~~~~~~

.. include:: /includes/common-admonitions.rst
   :start-after: start-exclusive-drive-access
   :end-before: end-exclusive-drive-access

Storage Mediums
+++++++++++++++

HDD and flash-based (NVMe or SSD) storage devices are all supported, but their performance varies.
Workloads with higher throughput or latency requirements should account for the performance characteristics of the selected storage medium.

Prefer Direct-Attached "Local" Storage (DAS)
++++++++++++++++++++++++++++++++++++++++++++

:abbr:`DAS (Direct-Attached Storage)`, such as locally-attached JBOD (Just a Bunch of Disks) arrays, provide significant performance and consistency advantages over networked (NAS, SAN, NFS) storage.

Configure the JBOD arrays without any RAID, pooling, or similar software-level layers, such that the storage is presented directly to Buckit.

For virtual machines or systems that require provising storage as a virtual volume, Buckit recommends using thick LUNs only.

.. dropdown:: Network File System Volumes Break Consistency Guarantees
   :class-title: note

   Buckit's strict **read-after-write** and **list-after-write** consistency model requires local drive filesystems.
   Buckit cannot provide consistency guarantees if the underlying storage volumes are NFS or a similar network-attached storage volume. 


Use XFS-Formatted Drives with Consistent Mounting
+++++++++++++++++++++++++++++++++++++++++++++++++

Format drives as XFS and present them to Buckit as a :abbr:`JBOD (Just a Bunch of Disks)` array with no RAID or other pooling configurations.
Using any other type of backing storage (SAN/NAS, ext4, RAID, LVM) typically results in a reduction in performance, reliability, predictability, and consistency.

When formatting XFS drives, apply a unique label per drive.
For example, the following command formats four drives as XFS and applies a corresponding drive label.

.. code-block:: shell

   mkfs.xfs /dev/sdb -L BUCKITDRIVE1
   mkfs.xfs /dev/sdc -L BUCKITDRIVE2
   mkfs.xfs /dev/sdd -L BUCKITDRIVE3
   mkfs.xfs /dev/sde -L BUCKITDRIVE4

Buckit **requires** that drives maintain their ordering at the mounted position across restarts.
Buckit **does not** support arbitrary migration of a drive with existing Buckit data to a new mount position, whether intentional or as the result of OS-level behavior.

You **must** use ``/etc/fstab`` or a similar mount control system to mount drives at a consistent path.
For example:

.. code-block:: shell
   :class: copyable

   $ nano /etc/fstab

   # <file system>        <mount point>    <type>  <options>         <dump>  <pass>
   LABEL=BUCKITDRIVE1     /mnt/drive-1     xfs     defaults,noatime  0       2
   LABEL=BUCKITDRIVE2     /mnt/drive-2     xfs     defaults,noatime  0       2
   LABEL=BUCKITDRIVE3     /mnt/drive-3     xfs     defaults,noatime  0       2
   LABEL=BUCKITDRIVE4     /mnt/drive-4     xfs     defaults,noatime  0       2

You can use ``mount -a`` to mount those drives at those paths during initial setup.
The Operating System should otherwise mount these drives as part of the node startup process.

Buckit **strongly recommends** using label-based mounting rules over UUID-based rules.
Label-based rules allow swapping an unhealthy or non-working drive with a replacement that has matching format and label.
UUID-based rules require editing the ``/etc/fstab`` file to replace mappings with the new drive UUID.

.. note:: 

   Cloud environment instances which depend on mounted external storage may encounter boot failure if one or more of the remote file mounts return errors or failure.
   For example, an AWS ECS instance with mounted persistent EBS volumes may not boot with the standard ``/etc/fstab`` configuration if one or more EBS volumes fail to mount.

   You can set the ``nofail`` option to silence error reporting at boot and allow the instance to boot with one or more mount issues.
   
   You should not use this option on systems with locally attached disks, as silencing drive errors prevents both Buckit and the OS from responding to those errors in a normal fashion.

Disable XFS Retry On Error
++++++++++++++++++++++++++

Buckit **strongly recommends** disabling `retry-on-error <https://docs.kernel.org/admin-guide/xfs.html?highlight=xfs#error-handling>`__ behavior using the ``max_retries`` configuration for the following error classes:

- ``EIO`` Error when reading or writing
- ``ENOSPC`` Error no space left on device
- ``default`` All other errors

The default ``max_retries`` setting typically directs the filesystem to retry-on-error indefinitely instead of propagating the error.
Buckit can handle XFS errors appropriately, such that the retry-on-error behavior introduces at most unnecessary latency or performance degradation. 


The following script iterates through all drives at the specified mount path and sets the XFS ``max_retries`` setting to ``0`` or "fail immediately on error" for the recommended error classes.
The script ignores any drives not mounted, either manually or through ``/etc/fstab``.
Modify the ``/mnt/drive`` line to match the pattern used for your Buckit drives.

.. code-block:: bash
   :class: copyable

   #!/bin/bash

   for i in $(df -h | grep /mnt/drive | awk '{ print $1 }'); do
         mountPath="$(df -h | grep $i | awk '{ print $6 }')"
         deviceName="$(basename $i)"
         echo "Modifying xfs max_retries and retry_timeout_seconds for drive $i mounted at $mountPath"
         echo 0 > /sys/fs/xfs/$deviceName/error/metadata/EIO/max_retries
         echo 0 > /sys/fs/xfs/$deviceName/error/metadata/ENOSPC/max_retries
         echo 0 > /sys/fs/xfs/$deviceName/error/metadata/default/max_retries
   done
   exit 0

You must run this script on all Buckit nodes and configure the script to re-run on reboot, as Linux Operating Systems do not typically persist these changes.
You can use a ``cron`` job with the ``@reboot`` timing to run the above script whenever the node restarts and ensure all drives have retry-on-error disabled.
Use ``crontab -e`` to create the following job, modifying the script path to match that on each node:

.. code-block:: shell
   :class: copyable

   @reboot /opt/minio/xfs-retry-settings.sh

Use Consistent Drive Type and Capacity
++++++++++++++++++++++++++++++++++++++

Ensure a consistent drive type (NVMe, SSD, HDD) for the underlying storage in a Buckit deployment.
Buckit does not distinguish between storage types and does not support configuring "hot" or "warm" drives within a single deployment.
Mixing drive types typically results in performance degradation, as the slowest drives in the deployment become a bottleneck regardless of the capabilities of the faster drives.

Use the same capacity and type of drive across all nodes in each Buckit :ref:`server pool <minio-intro-server-pool>`. 
Buckit limits the maximum usable size per drive to the smallest size in the deployment.
For example, if a deployment has 15 10TB drives and 1 1TB drive, Buckit limits the per-drive capacity to 1TB.

Recommended Hardware Tests
--------------------------

Operating System Diagnostic Tools
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Test each drive independently on all servers to ensure they are identical in performance.
Use the results of these OS-level tools to verify the capabilities of your storage hardware.
Record the results for later reference.

#. Test the drive's performance during write operations

   This tests checks a drive's ability to write new data (uncached) to the drive by creating a specified number of blocks at up to a certain number of bytes at a time to mimic how a drive would function with writing uncached data. 
   This allows you to see the actual drive performance with consistent file I/O.
   
   .. code-block::
      :class: copyable

      dd if=/dev/zero of=/mnt/driveN/testfile bs=128k count=80000 oflag=direct conv=fdatasync > dd-write-drive1.txt

   Replace ``driveN`` with the path for the drive you are testing.

   .. list-table::
      :widths: auto
      :width: 100%

      * - ``dd``
        - The command to copy and paste data.
      * - ``if=/dev/zero``
        - Read from ``/dev/zero``, an system-generated endless stream of 0 bytes used to create a file of a specified size
      * - ``of=/mnt/driveN/testfile``
        - Write to ``/mnt/driveN/testfile``
      * - ``bs=128k``
        - Write up to 128,000 bytes at a time
      * - ``count=80000``
        - Write up to 80000 blocks of data
      * - ``oflag=direct``
        - Use direct I/O to write to avoid data from caching
      * - ``conv=fdatasync``
        - Physically write output file data before finishing
      * - ``> dd-write-drive1.txt``
        - Write the contents of the operation's output to ``dd-write-drive1.txt`` in the current working directory

   The operation returns the number of files written, total size written in bytes, the total length of time for the operation (in seconds), and the speed of the writing in some order of bytes per second.

#. Test the drive's performance during read operations

   .. code-block::
      :class: copyable

      dd if=/mnt/driveN/testfile of=/dev/null bs=128k iflag=direct > dd-read-drive1.txt

   Replace ``driveN`` with the path for the drive you are testing.

   .. list-table::
      :widths: auto
      :width: 100%

      * - ``dd``
        - The command to copy and paste data
      * - ``if=/mnt/driveN/testfile``
        - Read from ``/mnt/driveN/testfile``; replace with the path to the file to use for testing the drive's read performance
      * - ``of=/dev/null``
        - Write to ``/dev/null``, a virtual file that does not persist after the operation completes
      * - ``bs=128k``
        - Write up to 128,000 bytes at a time
      * - ``count=80000``
        - Write up to 80000 blocks of data
      * - ``iflag=direct``
        - Use direct I/O to read and avoid data from caching
      * - ``> dd-read-drive1.txt``
        - Write the contents of the operation's output to ``dd-read-drive1.txt`` in the current working directory

   Use a sufficiently sized file that mimics the primary use case for your deployment to get accurate read test results.
   
   The following guidelines may help during performance testing:

   - Small files: < 128KB
   - Normal files: 128KB – 1GB
   - Large files: > 1GB

   You can use the ``head`` command to create a file to use.
   The following command example creates a 10 Gigabyte file called ``testfile``.

   .. code-block:: shell
      :class: copyable

      head -c 10G </dev/urandom > testfile

   The operation returns the number of files read, total size read in bytes, the total length of time for the operation (in seconds), and the speed of the reading in bytes per second.

Third Party Diagnostic Tools
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

IO Controller test
   
Use `IOzone <http://iozone.org/>`__ to test the input/output controller and all drives in combination.
Document the performance numbers for each server in your deployment.

.. code-block:: shell
   :class: copyable

   iozone -s 1g -r 4m -i 0 -i 1 -i 2 -I -t 160 -F /mnt/sdb1/tmpfile.{1..16} /mnt/sdc1/tmpfile.{1..16} /mnt/sdd1/tmpfile.{1..16} /mnt/sde1/tmpfile.{1..16} /mnt/sdf1/tmpfile.{1..16} /mnt/sdg1/tmpfile.{1..16} /mnt/sdh1/tmpfile.{1..16} /mnt/sdi1/tmpfile.{1..16} /mnt/sdj1/tmpfile.{1..16} /mnt/sdk1/tmpfile.{1..16} > iozone.txt

.. list-table::
   :widths: auto
   :width: 100%

   * - ``-s 1g``
     - Size of 1G per file
   * - ``-r`` 
     - 4m  4MB block size
   * - ``-i #``   
     - 0=write/rewrite, 1=read/re-read, 2=random-read/write
   * - ``-I``     
     - Direct-IO modern
   * - ``-t N``   
     - Number of threads (:math:`numberOfDrives * 16`)
   * - ``-F <>``  
     - list of files (the above command tests with 16 files per drive)  
