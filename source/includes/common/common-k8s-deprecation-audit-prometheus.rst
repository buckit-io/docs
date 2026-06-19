.. start-deprecate-audit-logs

.. important::

   Buckit plans to deprecate the Tenant Console Audit Log feature and remove it in an upcoming release.
   Buckit recommends disabling this feature in preparation for this change.

   As an alternative, use any webhook-capable database or logging service to capture :ref:`audit logs <minio-logging-publish-audit-logs>` from the Tenant.

.. end-deprecate-audit-logs

.. start-deprecate-prometheus

.. important::

   Buckit plans to deprecate the Tenant Prometheus pod feature and remove it in an upcoming release.
   Buckit recommends setting this value to ``false`` in preparation for this change.

   As an alternative, use any Prometheus service deployed within the Kubernetes cluster or externally to :ref:`capture Tenant metrics <minio-metrics-collect-using-prometheus>`.

.. end-deprecate-prometheus