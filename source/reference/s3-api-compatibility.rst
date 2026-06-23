=========================
Access Buckit with AWS SDK
=========================

.. default-domain:: minio

.. toctree::
   :titlesonly:
   :hidden:

   self
   /integrations/aws-cli-with-minio.md
   /integrations/setup-nginx-proxy-with-minio
   /integrations/presigned-put-upload-via-browser.md
   /developers/file-transfer-protocol
   /developers/security-token-service
   /developers/transforms-with-object-lambda

.. contents:: Table of Contents
   :local:
   :depth: 2

This page shows how to access Buckit using the AWS SDK and documents the
S3 APIs supported by Buckit Object Storage.
For reference documentation on any given API, see the corresponding
documentation for Amazon S3.

Use AWS SDK
-----------

The following examples connect to a Buckit deployment using an S3-compatible
endpoint and perform basic ``PUT`` and ``GET`` object operations.

Replace the following placeholders before running the examples:

- ``https://buckit.example.net``
- ``ACCESS_KEY``
- ``SECRET_KEY``
- ``my-bucket``
- ``hello.txt``

For local or non-TLS test environments, you can use an ``http://`` endpoint.
For TLS-enabled deployments, use ``https://``.

AWS SDK for Java
~~~~~~~~~~~~~~~~

.. code-block:: java

   import java.net.URI;
   import java.nio.file.Path;
   import java.nio.charset.StandardCharsets;

   import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
   import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
   import software.amazon.awssdk.core.ResponseBytes;
   import software.amazon.awssdk.core.sync.RequestBody;
   import software.amazon.awssdk.regions.Region;
   import software.amazon.awssdk.services.s3.S3Client;
   import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
   import software.amazon.awssdk.services.s3.model.GetObjectRequest;
   import software.amazon.awssdk.services.s3.model.GetObjectResponse;
   import software.amazon.awssdk.services.s3.model.PutObjectRequest;

   public class BuckitAwsJavaExample {
       public static void main(String[] args) {
           S3Client s3 = S3Client.builder()
               // Point the AWS SDK to the Buckit S3 endpoint.
               .endpointOverride(URI.create("https://buckit.example.net"))
               // Required by the AWS SDK for SigV4 request signing.
               // If Buckit has a server region configured, this value must match it.
               // If no server region is configured, us-east-1 is a common default.
               .region(Region.US_EAST_1)
               // Use path-style requests for broad S3-compatible compatibility.
               .forcePathStyle(true)
               .credentialsProvider(
                   StaticCredentialsProvider.create(
                       AwsBasicCredentials.create("ACCESS_KEY", "SECRET_KEY")
                   )
               )
               .build();

           PutObjectRequest putRequest = PutObjectRequest.builder()
               .bucket("my-bucket")
               .key("hello.txt")
               .build();

           // Upload a local file to Buckit.
           s3.putObject(
               putRequest,
               RequestBody.fromFile(Path.of("/path/to/hello.txt"))
           );

           GetObjectRequest getRequest = GetObjectRequest.builder()
               .bucket("my-bucket")
               .key("hello.txt")
               .build();

           // Read the same object back from Buckit.
           ResponseBytes<GetObjectResponse> object = s3.getObjectAsBytes(getRequest);

           System.out.println(object.asString(StandardCharsets.UTF_8));

           DeleteObjectRequest deleteRequest = DeleteObjectRequest.builder()
               .bucket("my-bucket")
               .key("hello.txt")
               .build();

           // Delete the object from Buckit.
           s3.deleteObject(deleteRequest);
           s3.close();
       }
   }

AWS SDK for JavaScript
~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: javascript

   import { readFile } from "node:fs/promises";
   import {
     S3Client,
     PutObjectCommand,
     GetObjectCommand,
     DeleteObjectCommand,
   } from "@aws-sdk/client-s3";

   const client = new S3Client({
     // Required by the AWS SDK for SigV4 request signing.
     // If Buckit has a server region configured, this value must match it.
     // If no server region is configured, us-east-1 is a common default.
     region: "us-east-1",
     // Point the AWS SDK to the Buckit S3 endpoint.
     endpoint: "https://buckit.example.net",
     // Use path-style requests for broad S3-compatible compatibility.
     forcePathStyle: true,
     credentials: {
       accessKeyId: "ACCESS_KEY",
       secretAccessKey: "SECRET_KEY",
     },
   });

   const fileBody = await readFile("/path/to/hello.txt");

   // Upload a local file to Buckit.
   await client.send(
     new PutObjectCommand({
       Bucket: "my-bucket",
       Key: "hello.txt",
       Body: fileBody,
     })
   );

   // Read the same object back from Buckit.
   const response = await client.send(
     new GetObjectCommand({
       Bucket: "my-bucket",
       Key: "hello.txt",
     })
   );

   const body = await response.Body.transformToString();
   console.log(body);

   // Delete the object from Buckit.
   await client.send(
     new DeleteObjectCommand({
       Bucket: "my-bucket",
       Key: "hello.txt",
     })
   );

AWS SDK for Python
~~~~~~~~~~~~~~~~~~

.. code-block:: python

   from pathlib import Path

   import boto3

   client = boto3.client(
       "s3",
       endpoint_url="https://buckit.example.net",
       aws_access_key_id="ACCESS_KEY",
       aws_secret_access_key="SECRET_KEY",
       # Required by the AWS SDK for SigV4 request signing.
       # If Buckit has a server region configured, this value must match it.
       # If no server region is configured, us-east-1 is a common default.
       region_name="us-east-1",
       # Use path-style requests for broad S3-compatible compatibility.
       config=boto3.session.Config(s3={"addressing_style": "path"}),
   )

   # Upload a local file to Buckit.
   client.put_object(
       Bucket="my-bucket",
       Key="hello.txt",
       Body=Path("/path/to/hello.txt").read_bytes(),
   )

   # Read the same object back from Buckit.
   response = client.get_object(Bucket="my-bucket", Key="hello.txt")
   body = response["Body"].read().decode("utf-8")
   print(body)

   # Delete the object from Buckit.
   client.delete_object(Bucket="my-bucket", Key="hello.txt")

Supported S3 APIs
-----------------

Object APIs
~~~~~~~~~~~

- :s3-api:`CopyObject <API_CopyObject.html>`
- :s3-api:`DeleteObject <API_DeleteObject.html>`
- :s3-api:`DeleteObjects <API_DeleteObjects.html>`
- :s3-api:`DeleteObjectTagging <API_DeleteObjectTagging.html>`
- :s3-api:`GetObject <API_GetObject.html>`
- :s3-api:`GetObjectAttributes <API_GetObjectAttributes.html>`
- :s3-api:`GetObjectTagging <API_GetObjectTagging.html>`
- :s3-api:`HeadObject <API_HeadObject.html>`
- :s3-api:`ListObjects <API_ListObjects.html>`
- :s3-api:`ListObjectsV2 <API_ListObjectsV2.html>`
- :s3-api:`ListObjectVersions <API_ListObjectVersions.html>`
- :s3-api:`PutObject <API_PutObject.html>`
- :s3-api:`PutObjectTagging <API_PutObjectTagging.html>`
- :s3-api:`RestoreObject <API_RestoreObject.html>`
- :s3-api:`SelectObjectContent <API_SelectObjectContent.html>`

Object Locking
~~~~~~~~~~~~~~

- :s3-api:`GetObjectRetention <API_GetObjectRetention.html>`
- :s3-api:`PutObjectRetention <API_PutObjectRetention.html>`
- :s3-api:`GetObjectLegalHold <API_GetObjectLegalHold.html>`
- :s3-api:`PutObjectLegalHold <API_PutObjectLegalHold.html>`
- :s3-api:`GetObjectLockConfiguration <API_GetObjectLockConfiguration.html>`
- :s3-api:`PutObjectLockConfiguration <API_PutObjectLockConfiguration.html>`

Unsupported API Object Endpoints
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: text

   GetObjectAcl
   PutObjectAcl

Multipart Uploads
~~~~~~~~~~~~~~~~~

- :s3-api:`AbortMultipartUpload <API_AbortMultipartUpload.html>`
- :s3-api:`CompleteMultipartUpload <API_CompleteMultipartUpload.html>`
- :s3-api:`CreateMultipartUpload <API_CreateMultipartUpload.html>`
- :s3-api:`ListMultipartUploads <API_ListMultipartUploads.html>`
- :s3-api:`ListParts <API_ListParts.html>`
- :s3-api:`UploadPart <API_UploadPart.html>`
- :s3-api:`UploadPartCopy <API_UploadPartCopy.html>`

Differences from S3 APIs for Multipart Uploads
++++++++++++++++++++++++++++++++++++++++++++++

- ``ListMultipartUploads`` requires the exact object name as a prefix.
- The ``AbortIncompleteMultipartUpload`` lifecycle action is not supported with ``PutBucketLifecycle``.

Bucket APIs
~~~~~~~~~~~


- :s3-api:`CreateBucket <API_CreateBucket.html>`
- :s3-api:`DeleteBucket <API_DeleteBucket.html>`
- :s3-api:`DeleteBucketEncryption <API_DeleteBucketEncryption.html>`
- :s3-api:`DeleteBucketTagging <API_DeleteBucketTagging.html>`
- :s3-api:`GetBucketEncryption <API_GetBucketEncryption.html>`
- :s3-api:`GetBucketLocation <API_GetBucketLocation.html>`
- :s3-api:`GetBucketTagging <API_GetBucketTagging.html>`
- :s3-api:`GetBucketVersioning <API_GetBucketVersioning.html>`
- :s3-api:`HeadBucket <API_HeadBucket.html>`
- :s3-api:`ListBuckets <API_ListBuckets.html>`
- :s3-api:`ListDirectoryBuckets <API_ListDirectoryBuckets.html>`
- :s3-api:`PutBucketEncryption <API_PutBucketEncryption.html>`
- :s3-api:`PutBucketTagging <API_PutBucketTagging.html>`
- :s3-api:`PutBucketVersioning <API_PutBucketVersioning.html>`

Bucket Replication
~~~~~~~~~~~~~~~~~~

- :s3-api:`GetBucketReplication <API_GetBucketReplication.html>`
- :s3-api:`PutBucketReplication <API_PutBucketReplication.html>`
- :s3-api:`DeleteBucketReplication <API_DeleteBucketReplication.html>`

Bucket Lifecycle
~~~~~~~~~~~~~~~~

- :s3-api:`GetBucketLifecycle <API_GetBucketLifecycle.html>`
- :s3-api:`GetBucketLifecycleConfiguration <API_GetBucketLifecycleConfiguration.html>`
- :s3-api:`PutBucketLifecycle <API_PutBucketLifecycle.html>`
- :s3-api:`PutBucketLifecycleConfiguration <API_PutBucketLifecycleConfiguration.html>`
- :s3-api:`DeleteBucketLifecycle <API_DeleteBucketLifecycle.html>`

Bucket Notifications
~~~~~~~~~~~~~~~~~~~~

- :s3-api:`GetBucketNotification <API_GetBucketNotification.html>`
- :s3-api:`GetBucketNotificationConfiguration <API_GetBucketNotificationConfiguration.html>`
- :s3-api:`PutBucketNotification <API_PutBucketNotification.html>`
- :s3-api:`PutBucketNotificationConfiguration <API_PutBucketNotificationConfiguration.html>`

Bucket Policies
~~~~~~~~~~~~~~~

- :s3-api:`GetBucketPolicy <API_GetBucketPolicy.html>`
- :s3-api:`GetBucketPolicyStatus <API_GetBucketPolicyStatus.html>`
- :s3-api:`PutBucketPolicy <API_PutBucketPolicy.html>`
- :s3-api:`DeleteBucketPolicy <API_DeleteBucketPolicy.html>`

Unsupported API Bucket Operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: text

   GetBucketInventoryConfiguration
   PutBucketInventoryConfiguration
   DeleteBucketInventoryConfiguration
   PutBucketCors
   DeleteBucketCors
   GetBucketMetricsConfiguration
   PutBucketMetricsConfiguration
   DeleteBucketMetricsConfiguration
   PutBucketWebsite
   GetBucketLogging
   PutBucketLogging
   PutBucketAccelerateConfiguration
   DeleteBucketAccelerateConfiguration
   PutBucketRequestPayment
   DeleteBucketRequestPayment
   PutBucketAcl
   HeadBucketAcl
   GetPublicAccessBlock
   PutPublicAccessBlock
   DeletePublicAccessBlock
   GetBucketOwnershipControls
   PutBucketOwnershipControls
   DeleteBucketOwnershipControls
   GetBucketIntelligentTieringConfiguration
   PutBucketIntelligentTieringConfiguration
   ListBucketIntelligentTieringConfigurations
   DeleteBucketIntelligentTieringConfiguration
   GetBucketAnalyticsConfiguration
   PutBucketAnalyticsConfiguration
   ListBucketAnalyticsConfigurations
   DeleteBucketAnalyticsConfiguration
   CreateSession

Buckit alternatives for unsupported Bucket resources
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- For calls to ``BucketACL`` or ``ObjectACL`` operations, use :ref:`Policies <minio-policy>`.
- Calls to ``BucketCORS`` operations are not needed because CORS is enabled by default on all buckets for all HTTP verbs.
- For calls to ``BucketWebsite`` operations, use ``caddy`` or ``nginx``.
- For calls to ``BucketAnalytics``, ``BucketMetrics``, or ``BucketLogging`` operations, use :ref:`Bucket Notifications <minio-bucket-notifications>`.
