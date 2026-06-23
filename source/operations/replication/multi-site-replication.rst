.. _minio-site-replication-overview:

=========================
Site Replication Overview
=========================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 1

Site replication configures multiple independent Buckit deployments as a cluster of replicas called peer sites.

   .. figure:: /images/architecture/architecture-load-balancer-multi-site.svg
      :figwidth: 100%
      :alt: Diagram of a site replication deployment with two sites

      A site replication deployment with two peer sites.
      A load balancer manages routing operations to either of the two sites.
      Data written to one site automatically replicates to the other peer site.

Site replication assumes the use of either the included Buckit identity provider (IDP) *or* an external IDP.
All configured deployments must use the same IDP.
Deployments using an external IDP must use the same configuration across sites.

For more information on site replication architecture and deployment concepts, see :ref:`Deployment Architecture: Replicated Buckit Deployments <minio-deployment-architecture-replicated>`.

Buckit does not recommend using MacOS, Windows, or non-orchestrated Containerized deployments for site replication outside of early development, evaluation, or general experimentation.
For production, use :minio-docs:`Linux <minio/linux/operations/install-deploy-manage/multi-site-replication.html>` or :minio-docs:`Kubernetes <minio/kubernetes/upstream/operations/install-deploy-manage/multi-site-replication.html>`

Overview
--------

.. _minio-site-replication-what-replicates:

What Replicates Across All Sites
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /includes/common-replication.rst
   :start-after: start-mc-admin-replicate-what-replicates
   :end-before: end-mc-admin-replicate-what-replicates

What Does Not Replicate Across Sites
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /includes/common-replication.rst
   :start-after: start-mc-admin-replicate-what-does-not-replicate
   :end-before: end-mc-admin-replicate-what-does-not-replicate


Initial Site Replication Process
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After enabling site replication, identity and access management (IAM) settings sync in the following order:

.. tab-set::

   .. tab-item:: Buckit IDP

      #. Policies
      #. User accounts (for local users)
      #. Groups
      #. Access Keys
         
         Access Keys for ``root`` do not sync.

      #. Policy mapping for synced user accounts
      #. Policy mapping for :ref:`Security Token Service (STS) users <minio-security-token-service>`

   .. tab-item:: OIDC

      #. Policies
      #. Access Keys associated to OIDC accounts with a valid :ref:`Buckit Policy <minio-policy>`. ``root`` access keys do not sync.
      #. Policy mapping for synced user accounts
      #. Policy mapping for :ref:`Security Token Service (STS) users <minio-security-token-service>`

   .. tab-item:: LDAP

      #. Policies
      #. Groups
      #. Access Keys associated to LDAP accounts with a valid :ref:`Buckit Policy <minio-policy>`. ``root`` access keys do not sync.
      #. Policy mapping for synced user accounts
      #. Policy mapping for :ref:`Security Token Service (STS) users <minio-security-token-service>`

After the initial synchronization of data across peer sites, Buckit continually replicates and synchronizes :ref:`replicable data <minio-site-replication-what-replicates>` among all sites as they occur on any site.

Site Healing
~~~~~~~~~~~~

Any Buckit deployment in the site replication configuration can resynchronize damaged :ref:`replica-eligible data <minio-site-replication-what-replicates>` from the peer with the most updated ("latest") version of that data.




.. include:: /includes/common/scanner.rst
   :start-after: start-scanner-speed-config
   :end-before: end-scanner-speed-config

Synchronous vs Asynchronous Replication
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /includes/common-replication.rst
   :start-after: start-replication-sync-vs-async
   :end-before: end-replication-sync-vs-async

Buckit strongly recommends using the default asynchronous site replication.
Synchronous site replication performance depends strongly on latency between sites, where higher latency can result in lower PUT performance and replication lag.
To configure synchronous site replication use :mc-cmd:`bm admin replicate update` with the :mc-cmd:`~bm admin replicate update --mode` option.

Proxy to Other Sites
~~~~~~~~~~~~~~~~~~~~

Buckit peer sites can proxy ``GET/HEAD`` requests for an object to other peers to check if it exists.
This allows a site that is healing or lagging behind other peers to still return an object persisted to other sites.

For example:

1. A client issues ``GET("data/invoices/january.xls")`` to ``Site1``
2. ``Site1`` cannot locate the object
3. ``Site1`` proxies the request to ``Site2``
4. ``Site2`` returns the latest version of the requested object
5. ``Site1`` returns the proxied object to the client

For ``GET/HEAD`` requests that do *not* include a unique version ID, the proxy request returns the *latest* version of that object on the peer site.
This may result in retrieval of a non-current version of an object, such as if the responding peer site is also experiencing replication lag.

Buckit does not proxy ``LIST``, ``DELETE``, and ``PUT`` operations.

Prerequisites
-------------

Back Up Cluster Settings First
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :mc:`bm admin cluster bucket export` and :mc:`bm admin cluster iam export` commands to take a snapshot of the bucket metadata and IAM configurations respectively prior to configuring Site Replication.
You can use these snapshots to restore bucket/IAM settings in the event of misconfiguration during site replication configuration.

One Site with Data at Setup
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Only *one* site can have data at the time of setup.
The other sites must be empty of buckets and objects.

After configuring site replication, any data on the first deployment replicates to the other sites.

All Sites Must Use the Same IDP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All sites must use the same :ref:`Identity Provider <minio-authentication-and-identity-management>`.
Site replication supports the included Buckit IDP, OIDC, or LDAP.

All Sites Must use the Same Buckit Server Version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All sites must have a matching and consistent Buckit Server version. 
Configuring replication between sites with mismatched Buckit Server versions may result in unexpected or undesired replication behavior.

You should also ensure the :mc:`bm` version used to configure replication closely matches the server version.

Access to the Same Encryption Service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For :ref:`SSE-S3 <minio-encryption-sse-s3>` or :ref:`SSE-KMS <minio-encryption-sse-kms>` encryption via Key Management Service (KMS), all sites must have access to a central KMS deployment. 

You can achieve this with a central KES server or multiple KES servers (say one per site) connected via a central supported :ref:`key vault server <minio-sse>`.

Replication Requires Versioning
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Site replication *requires* :ref:`minio-bucket-versioning` and enables it for all created buckets automatically.
You cannot disable versioning in site replication deployments.

Buckit cannot replicate objects in prefixes in the bucket that you excluded from versioning.

Load Balancers Installed on Each Site
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /includes/common-replication.rst
   :start-after: start-mc-admin-replicate-load-balancing
   :end-before: end-mc-admin-replicate-load-balancing

Switch to Site Replication from Bucket Replication
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:ref:`Bucket replication <minio-bucket-replication>` and multi-site replication are mutually exclusive.
You cannot use both replication methods on the same deployments.

If you previously set up bucket replication and wish to now use site replication, you must first delete all of the bucket replication rules on the deployment that has data when initializing site replication.
Use :mc:`bm replicate rm` on the command line to remove bucket replication rules.

Only one site can have data when setting up site replication.
All other sites must be empty.

Tutorials
---------

.. _minio-configure-site-replication:

Configure Site Replication
~~~~~~~~~~~~~~~~~~~~~~~~~~

The following steps create a new site replication configuration for three :ref:`distributed deployments <deploy-minio-distributed>`.
One of the sites contains :ref:`replicable data <minio-site-replication-what-replicates>`.

The three sites use aliases, ``buckit1``, ``buckit2``, and ``buckit3``, and only ``buckit1`` contains any data.

#. :ref:`Deploy <deploy-minio-distributed>` three or more separate Buckit sites, using the same :ref:`IDP <minio-authentication-and-identity-management>`

   Start with empty sites *or* have no more than one site with any :ref:`replicable data <minio-site-replication-what-replicates>`.

#. Configure an alias for each site

   .. include:: /includes/common-replication.rst
      :start-after: start-mc-admin-replicate-load-balancing
      :end-before: end-mc-admin-replicate-load-balancing

   For example, for three Buckit sites, you might create aliases ``buckit1``, ``buckit2``, and ``buckit3``.
   
   Use :mc:`bm alias set` to define the hostname or IP of the load balancer managing connections to the site.

   .. code-block:: shell

      bm alias set buckit1 https://buckit1.example.com:9000 adminuser adminpassword
      bm alias set buckit2 https://buckit2.example.com:9000 adminuser adminpassword
      bm alias set buckit3 https://buckit3.example.com:9000 adminuser adminpassword

#. Add site replication configuration

   .. code-block:: shell
   
      bm admin replicate add buckit1 buckit2 buckit3

   If all sites are empty, the order of the aliases does not matter.
   If one of the sites contains any :ref:`replicable data <minio-site-replication-what-replicates>`, you must list it first.

   No more than one site can contain any replicable data.

#. Query the site replication configuration to verify

   .. code-block:: shell
   
      bm admin replicate info buckit1

   You can use the alias for any peer site in the site replication configuration.

#. Query the site replication status to confirm any initial data has replicated to all peer sites.

   .. code-block:: shell

      bm admin replicate status buckit1

   You can use the alias for any of the peer sites in the site replication configuration.
   The output should say that all :ref:`replicable data <minio-site-replication-what-replicates>` is in sync.

   The output could resemble the following:

   .. code-block:: shell

      Bucket replication status:
      ●  1/1 Buckets in sync

      Policy replication status:
      ●  5/5 Policies in sync

      User replication status:
      No Users present

      Group replication status:
      No Groups present

   For more on reviewing site replication, see the :ref:`Site Replication Status tutorial <minio-site-replication-status-tutorial>`.


.. _minio-expand-site-replication:

Expand Site Replication
~~~~~~~~~~~~~~~~~~~~~~~

You can add more sites to an existing site replication configuration.

The new site must meet the following requirements:

- Site is fully deployed and accessible by hostname or IP
- Shares the IDP configuration as all other sites in the configuration
- Uses the same root user credentials as other configured sites
- Contains no bucket or object data

#. Deploy the new Buckit peer site(s) following the stated requirements

#. Configure an alias for the new site

   .. include:: /includes/common-replication.rst
      :start-after: start-mc-admin-replicate-load-balancing
      :end-before: end-mc-admin-replicate-load-balancing

   To check the existing aliases, use :mc:`bm alias list`.

   Use :mc:`bm alias set` to define the hostname or IP of the load balancer managing connections to the new site(s).

   .. code-block:: shell

      bm alias set buckit4 https://buckit4.example.com:9000 adminuser adminpassword

#. Add site replication configuration

   Use the :mc-cmd:`bm admin replicate add` command to expand the site replication configuration with the new peer site.
   Specify the alias of *all* existing peer sites, then the alias of the new site to add.

   For example, the following command adds the new peer site ``buckit4`` to an existing site replication configuration that includes the existing sites ``buckit1``, ``buckit2``, and ``buckit3``.

   .. code-block:: shell
   
      bm admin replicate add buckit1 buckit2 buckit3 buckit4

   .. note::

      If any of the sites are unreachable or permanently lost, you **must** first remove the unreachable site(s) with :mc-cmd:`bm admin replicate rm` before expanding with the new site.

#. Query the site replication configuration to verify

   .. code-block:: shell
   
      bm admin replicate info buckit1

Modify a Site's Endpoint
~~~~~~~~~~~~~~~~~~~~~~~~

If a peer site changes its hostname, you can modify the replication configuration to reflect the new hostname.

#. Obtain the site's Deployment ID with :mc-cmd:`bm admin replicate info`

   .. code-block:: shell

      bm admin replicate info <ALIAS>
   

#. Update the site's endpoint with :mc-cmd:`bm admin replicate update`

   .. code-block:: shell

      bm admin replicate update ALIAS --deployment-id [DEPLOYMENT-ID] --endpoint [NEW-ENDPOINT]

   Replace [DEPLOYMENT-ID] with the deployment ID of the site to update.
   
   Replace [NEW-ENDPOINT] with the new endpoint for the site.

   .. include:: /includes/common-replication.rst
      :start-after: start-mc-admin-replicate-load-balancing
      :end-before: end-mc-admin-replicate-load-balancing

Remove a Site from Replication
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can remove a site from replication at any time.
You can re-add the site at a later date, but you must first completely wipe bucket and object data from the site.

Use :mc-cmd:`bm admin replicate rm`:

.. code-block:: shell

   bm admin replicate rm ALIAS PEER_TO_REMOVE --force

- Replace ``ALIAS`` with the :ref:`alias <alias>` of any peer site in the replication configuration.

- Replace ``PEER_TO_REMOVE`` with the alias of the peer site to remove.

All healthy peers in the site replication configuration update to remove the specified peer automatically.

Buckit requires the ``--force`` flag to remove the peer from the site replication configuration.

.. _minio-site-replication-status-tutorial:

Review Replication Status
~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit provides information on replication across the sites for users, groups, policies, or buckets.

The summary information includes the number of **Synced** and **Failed** items for each category.

Use :mc-cmd:`bm admin replicate status`:

.. code-block:: shell

   bm admin replicate status <ALIAS> --<flag> <value>

For example:

- ``bm admin replicate status buckit3 --bucket images``

  Displays the replication status for the ``images`` bucket on the ``buckit3`` site.
  
  The output resembles the following:

  .. code-block::
 
     ●  Bucket config replication summary for: images
 
     Bucket          | BUCKIT2         | BUCKIT3         | BUCKIT4        
     Tags            |                 |                 |                
     Policy          |                 |                 |                
     Quota           |                 |                 |                
     Retention       |                 |                 |                
     Encryption      |                 |                 |                
     Replication     | ✔               | ✔               | ✔        

- ``bm admin replicate status buckit3 --all``

  Displays the replication status summary for all replication sites of which ``buckit3`` is part. 

  The output resembles the following:

  .. code-block::

     Bucket replication status:
     ●  1/1 Buckets in sync
    
     Policy replication status:
     ●  5/5 Policies in sync
    
     User replication status:
     ●  1/1 Users in sync
    
     Group replication status:
     ●  0/2 Groups in sync
    
     Group           | BUCKIT2         | BUCKIT3         | BUCKIT4        
     ittechs         | ✗  in-sync      |                 | ✗  in-sync    
     managers        | ✗  in-sync      |                 | ✗  in-sync    
 
