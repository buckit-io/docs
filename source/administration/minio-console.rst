.. _minio-console:

=============
Buckit Console
=============

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2


The Buckit Console is a rich graphical user interface that supports browsing buckets and objects on your deployment.

This page provides an overview of the Buckit Console and describes configuration options and instructions for logging in.

Overview
--------

.. versionchanged:: RELEASE.2025-05-24T17-08-30Z

   The Console now presents only object browser capabilities similar to those available through the :mc:`mc` tool.
   For administrative interactions, such as user management, use the :mc:`mc admin` command.

The Buckit Console is embedded as part of the Buckit Server. 
You can also deploy a standalone Buckit Console using the instructions in the :minio-git:`github repository <console>`.

Supported Browsers
~~~~~~~~~~~~~~~~~~

Buckit Console runs on a variety of current, stable release browsers.

For the best experience in the Buckit Console, use the latest stable release of your preferred browser.
Some browsers that are supported include:

- Chrome
- Edge
- Safari
- Firefox
- Opera

This list is *not* exhaustive and is subject to change.

For a full list of browsers and versions for running Buckit Console, see the `Browserslist <https://browsersl.ist/#q=%3E0.2%25%2Cnot+dead+and+not+op_mini+all>`__ website.

.. tip:: 
   
   Buckit Console does *not* support Opera Mini.

Configuration
-------------

The Buckit Console inherits the majority of its configuration settings from the
Buckit Server. The following environment variables enable specific behavior in
the Buckit Console:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :width: 100%

   * - Environment Variable
     - Description

   * - :envvar:`MINIO_PROMETHEUS_URL`
     - The URL for a Prometheus server configured to scrape metrics from the 
       Buckit deployment. The Buckit Console uses this server for populating the
       metrics dashboard.

       See :ref:`minio-metrics-collect-using-prometheus` for a tutorial on 
       configuring Prometheus to collect metrics from Buckit.

   * - :envvar:`MINIO_BROWSER_REDIRECT_URL`
     - The externally resolvable hostname for the Buckit Console used by the 
       configured :ref:`external identity manager 
       <minio-authentication-and-identity-management>` for returning the
       authentication response.

       This variable is typically necessary when using a reverse proxy, 
       load balancer, or similar system to expose the Buckit Console to the 
       public internet. Specify an externally reachable hostname that resolves
       to the Buckit Console.

.. _minio-console-port-assignment:

Static vs Dynamic Port Assignment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Buckit by default selects a random port for the Buckit Console on each server
startup. Browser clients accessing the Buckit Server are automatically 
redirected to the Buckit Console on its dynamically selected port. 
This behavior emulates the legacy web browser behavior while reducing the
the risk of a port collision on systems which were running Buckit *before* the 
embedded Console update.

You can select an explicit static port by passing the 
:mc-cmd:`minio server --console-address` commandline option when starting 
each Buckit Server in the deployment. 

For example, the following command starts a distributed Buckit deployment using
a static port assignment of ``9001`` for the Buckit Console. This deployment
would respond to S3 API operations on the default Buckit server port ``:9000``
and browser access on the Buckit Console port ``:9001``.

.. code-block:: shell
   :class: copyable

   minio server https://minio-{1...4}.example.net/mnt/drive-{1...4} \
         --console-address ":9001"

Deployments behind network routing components which require static ports for 
routing rules may require setting a static Buckit Console port. For example,
load balancers, reverse proxies, or Kubernetes ingress may by default block
or exhibit unexpected behavior with the the dynamic redirection behavior.

You must also ensure that the host system firewall grants access to the configured Console port.

.. _minio-console-play-login:

Logging In
----------

The Buckit Console displays a login screen for unauthenticated users.
The Console defaults to providing a username and password prompt for a :ref:`Buckit-managed user <minio-internal-idp>`.

.. admonition:: Try out the Console using Buckit's Play testing environment
   :class: note

   You can explore the Console using https://play.min.io:9443. 
   Log in with the following credentials:

   - Username: ``Q3AM3UQ867SPQQA43P2F``
   - Password: ``zuf+tfteSlswRu7BJ86wekitnifILbZam1KYY3TG``

   The Play Console connects to the Buckit Play deployment at https://play.min.io.
   You can also access this deployment using :mc:`mc` and using the ``play`` alias.

Documentation
-------------

The :guilabel:`Documentation` tab opens this documentation site in a separate browser window or tab.

Available Tasks
---------------

Once logged in to the Buckit Console, users can perform many kinds of tasks.

- :ref:`Manage objects <minio-console-managing-objects>` by browsing existing objects, uploading objects, or modifying bucket settings.
- :ref:`Review or modify identity and security <minio-console-security-access>` with access keys, policies, and Identity Provider settings.
- :ref:`Monitor the health and activities <minio-console-managing-deployment>` with metrics and notifications.

.. toctree::
   :titlesonly:
   :hidden:

   /administration/console/managing-deployment
   /administration/console/managing-objects
   /administration/console/security-and-access
