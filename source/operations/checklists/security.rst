.. _minio-security-checklist:

==================
Security Checklist
==================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

Use the following checklist when planning the security configuration for a production, distributed Buckit deployment.

Required Steps
--------------

.. list-table::
   :widths: auto
   :width: 100%

   * - :octicon:`circle`
     - Define group policies either on Buckit or the selected 3rd party Identity Provider (LDAP/Active Directory or OpenID)

   * - :octicon:`circle`
     - Define individual access policies on Buckit or the selected 3rd party Identity Provider

   * - :octicon:`circle`
     - Grant firewall access for TCP traffic to the Buckit Server S3 API Listen Port (Default: ``9000``).

   * - :octicon:`circle`
     - Grant firewall access for TCP traffic to the :ref:`Buckit Server Console Listen Port <minio-console-port-assignment>` (Recommended Default: ``9090``).

:ref:`Encryption-in-Transit ("In flight") <minio-tls>`
------------------------------------------------------

.. list-table::
   :widths: auto
   :width: 100%

   * - :octicon:`circle`
     - :ref:`Enable TLS <minio-tls>`

   * - :octicon:`circle`
     - Add separate certificates and keys for each internal and external domain that accesses Buckit

   * - :octicon:`circle`
     - Generate public and private TLS keys using a supported cipher for TLS 1.3 or TLS 1.2

   * - :octicon:`circle`
     - Configure trusted Certificate Authority (CA) store(s)

   * - :octicon:`circle`
     - (Optional) Validate certificates, such as with https://www.sslchecker.com/certdecoder
