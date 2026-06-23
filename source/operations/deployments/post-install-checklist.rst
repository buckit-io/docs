.. _minio-post-install-checklist:

======================
Post Install Checklist
======================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

Use the following checklist after installing a Buckit deployment.

Security
--------

.. list-table::
   :widths: auto
   :width: 100%

   * - :octicon:`circle`
     - Allow firewall access to the Buckit S3 API and Console ports (``9000`` and ``9001`` by default).

   * - :octicon:`circle`
     - Create :ref:`users <minio-users>` and :ref:`groups <minio-groups>`

   * - :octicon:`circle`
     - Define :ref:`access policies for users and groups <minio-policy>`

   * - :octicon:`circle`
     - (optional) :ref:`Secure Buckit traffic with TLS <minio-tls>`

   * - :octicon:`circle`
     - (optional) Configure a 3rd party Identity Provider, if used: :ref:`OpenID Connect (OIDC) <minio-external-identity-management-openid-configure>` or :ref:`Active Directory / LDAP <minio-external-identity-management-ad-ldap-configure>`

Advanced
--------

.. list-table::
   :widths: auto
   :width: 100%

   * - :octicon:`circle`
     - (optional) Configure :ref:`Object retention rules with lifecycle management <minio-lifecycle-management>` to manage when objects should expire

   * - :octicon:`circle`
     - (optional) Configure :ref:`Object storage level rules with tiering <minio-lifecycle-management-tiering>` to move objects between hot, warm, and cold storage and maximize storage cost efficiencies

   * - :octicon:`circle`
     - (optional) Configure :ref:`Bucket replication <minio-bucket-replication-requirements>` to duplicate contents of a bucket to another bucket location

   * - :octicon:`circle`
     - (optional) Configure :ref:`Site replication <minio-site-replication-overview>` to synchronize contents of multiple dispersed data center locations
