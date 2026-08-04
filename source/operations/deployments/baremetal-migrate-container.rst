.. _migrate-minio-container:

==============================
Migrate a Container Deployment
==============================

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

Overview
--------

Use this procedure when MinIO runs as a container under Docker, Docker Compose, or Kubernetes.
Migrating means replacing the image.
The volumes, ports, environment variables, and command arguments stay as they are.

Review the :ref:`shared considerations <migrate-minio-to-buckit>` before starting.

Buckit publishes the same image to two registries.
Use whichever one you prefer; the images are identical:

- ``docker.io/buckitio/buckit:latest`` (`Docker Hub <https://hub.docker.com/r/buckitio/buckit>`__)
- ``ghcr.io/buckit-io/buckit:latest`` (`GitHub Container Registry <https://github.com/buckit-io/buckit/pkgs/container/buckit>`__)

Pin a release tag instead of ``latest`` for production deployments.

Procedure
---------

Replacing the image is the whole migration.
Follow the one section below that matches how the containers are managed.

Docker Compose
~~~~~~~~~~~~~~

Change the image and leave the rest of the service definition unchanged:

.. code-block:: yaml
   :class: copyable

   services:
     storage:
       image: docker.io/buckitio/buckit:latest    # the only line that changes
       command: server /data --console-address ":9001"   # unchanged
       environment:
         MINIO_ROOT_USER: myadmin          # unchanged
         MINIO_ROOT_PASSWORD: mysecret     # unchanged
       volumes:
         - /mnt/data:/data                 # unchanged
       ports:                              # unchanged
         - "9000:9000"
         - "9001:9001"


Docker Run
~~~~~~~~~~

Stop and remove the MinIO container, then start Buckit with the same volume mounts, ports, and environment variables:

.. code-block:: shell
   :class: copyable

   docker stop minio && docker rm minio

   docker run -d --name buckit \
     -p 9000:9000 -p 9001:9001 \
     -v /mnt/data:/data \
     -e MINIO_ROOT_USER=myadmin \
     -e MINIO_ROOT_PASSWORD=mysecret \
     docker.io/buckitio/buckit:latest \
     server /data --console-address ":9001"

Removing the container does not remove the data volume.

Kubernetes
~~~~~~~~~~

Update the container image in the StatefulSet and allow the pods to roll:

.. code-block:: shell
   :class: copyable

   kubectl set image statefulset/STATEFULSET_NAME CONTAINER_NAME=docker.io/buckitio/buckit:latest

Replace ``STATEFULSET_NAME`` and ``CONTAINER_NAME`` with the names used by the deployment.

For distributed deployments, confirm the rollout does not leave MinIO and Buckit pods serving the same cluster at the same time.
Scale the StatefulSet to zero, change the image, then scale back up:

.. code-block:: shell
   :class: copyable

   kubectl scale statefulset/STATEFULSET_NAME --replicas=0
   kubectl set image statefulset/STATEFULSET_NAME CONTAINER_NAME=docker.io/buckitio/buckit:latest
   kubectl scale statefulset/STATEFULSET_NAME --replicas=DESIRED_COUNT

Validate
--------

Run the checks in :ref:`Validate the Migration <migrate-minio-validate>`.

Rollback
--------

Because no data was converted, rollback means restoring the previous image reference and reapplying.

.. code-block:: shell
   :class: copyable

   # Compose: restore the previous image line, then
   docker compose up -d

   # Kubernetes
   kubectl rollout undo statefulset/STATEFULSET_NAME
