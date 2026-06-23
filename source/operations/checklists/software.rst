.. _minio-software-checklists:

==================
Software Checklist
==================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

Use the following checklist when planning the software configuration for a production, distributed Buckit deployment.

Buckit Pre-requisites
---------------------

.. list-table::
   :widths: auto
   :width: 100%

   * - :octicon:`circle`
     - Servers running a Linux operating system with a 6.6+ kernel. Red Hat Enterprise Linux (RHEL) 10 or Ubuntu LTS 22.04.01+ ship with these Kernel's by default.
       Ensure the chosen OS uses LTS and in-support releases of a 6.6+ Linux kernel.

   * - :octicon:`circle`
     - A method to synchronize time servers across nodes, such as with ``ntp``, ``timedatectl`` or ``timesyncd``.
       The method to use varies by operating system.
       Check with your operating system's documentation for how to synchronize time with a time server.

   * - :octicon:`circle`
     - Disable system services that index, scan, or audit the filesystem, system-level calls, or kernel-level calls.
       These services can reduce performance due to resource contention or interception of Buckit operations.

       Buckit strongly recommends uninstalling or disabling the following services on hosts running Buckit:

       - ``mlocate`` or ``plocate``
       - ``updatedb``
       - ``auditd``
       - Crowdstrike Falcon
       - Antivirus software (``clamav``)
      
       The above list represents the most common services or softwares known to cause performance or behavioral issues with high performance systems like Buckit.
       Consider removing or disabling any other service or software which functions similarly to those listed above on Buckit hosts.

       Alternatively, configure these services to ignore or exclude the Buckit Server process and *all* drives or drive paths accessed by Buckit.

   * - :octicon:`circle` 
     - System administrator access to the remote servers

   * - :octicon:`circle`
     - (optional) Load balancer to handle routing of requests (for example, `NGINX <https://www.nginx.com/>`__)

   * - :octicon:`circle`
     - (optional) :ref:`Prometheus <minio-metrics-collect-using-prometheus>` or a Prometheus-compatible setup for monitoring and metrics

   * - :octicon:`circle`
     - (optional) :ref:`Grafana configured <minio-grafana>` for dashboards 


.. include:: /includes/common-admonitions.rst
   :start-after: start-exclusive-drive-access
   :end-before: end-exclusive-drive-access
