==========
``bm sql``
==========

.. default-domain:: minio

.. contents:: Table of Contents
   :local:
   :depth: 2

.. mc:: bm sql

Syntax
------

.. start-mc-sql-desc

The :mc:`bm sql` command provides an S3 Select interface for performing sql queries on objects in the specified Buckit deployment.

.. end-mc-sql-desc

See :s3-docs:`Selecting content from objects <selecting-content-from-objects>` for more information on S3 Select behavior and limitations.

.. tab-set::

   .. tab-item:: EXAMPLE

      The following command queries all objects in the ``mydata`` bucket on the ``myminio`` Buckit deployment:

      .. code-block:: shell
         :class: copyable

         bm sql --recursive --query "select * from S3Object" myminio/mydata

   .. tab-item:: SYNTAX

      The command has the following syntax:

      .. code-block:: shell
         :class: copyable

         bm [GLOBALFLAGS] bm sql                          \
                          --query "string"                \
                          [--csv-input "string"]          \
                          [--compression "string"]        \
                          [--csv-output "string"]         \
                          [--csv-output-header "string"]  \
                          [--enc-c "string"]              \
                          [--json-input "string"]         \
                          [--json-output "string"]        \
                          [--recursive]                   \
                          ALIAS

      .. include:: /includes/common-minio-mc.rst
         :start-after: start-minio-syntax
         :end-before: end-minio-syntax

Parameters
~~~~~~~~~~

.. mc-cmd:: ALIAS
   :required:

   The full path to the bucket or object to run the SQL query against.
   Specify the :ref:`alias <alias>` of a configured S3 service as the prefix to the ``ALIAS`` path.
   For example:

   .. code-block:: shell

      bm sql [FLAGS] play/mybucket

.. mc-cmd:: --query, e
   :required:

   The SQL statement to execute on the specified :mc-cmd:`~bm sql ALIAS` directory or object.
   Wrap the entire SQL query in double quotes ``"``.

   Defaults to ``"select * from S3Object"``.

.. mc-cmd:: --csv-input
   :optional:

   The data format for ``.csv`` input objects.
   Specify a string of comma-seperated ``key=value,...`` pairs.
   See :ref:`mc-sql-csv-format` for more information on valid keys.

.. mc-cmd:: --compression
   :optional:

   The compression type of the input object.
   Specify one of the following supported values:

   - ``GZIP``
   - ``BZIP2``
   - ``NONE`` (default)

   Compression schemes supported by Buckit backend only:

   - ``ZSTD`` `Zstandard <https://facebook.github.io/zstd/>`__
   - ``LZ4`` `LZ4 <https://lz4.github.io/lz4/>`__ stream
   - ``S2`` `S2 <https://github.com/klauspost/compress/tree/master/s2#s2-compression>`__ framed stream
   - ``SNAPPY`` `Snappy <http://google.github.io/snappy/>`__ framed stream

.. mc-cmd:: --csv-output
   :optional:

   The data format for ``.csv`` output.
   Specify a string of comma-seperated ``key=value,...`` pairs.
   See :ref:`mc-sql-csv-format` for more information on valid keys.

   See the S3 API :s3-api:`CSVOutput <API_CSVOutput.html>` for more information.

.. mc-cmd:: --csv-output-header
   :optional:

   The header row of the ``.csv`` output file.
   Specify a string of comma-separated fields as ``field1,field2,...``.

   Omit to output a ``.csv`` with no header row.

.. block include of enc-c

.. include:: /includes/common-minio-sse.rst
   :start-after: start-minio-mc-sse-c-only
   :end-before: end-minio-mc-sse-options

.. mc-cmd:: --json-input
   :optional:

   The data format for ``.json`` or ``.ndjson`` input objects.
   Specify the type of the JSON contents as ``type=<VALUE>``.
   The value can be either:

   - ``DOCUMENT`` - JSON `document <https://www.json.org/json-en.html>`__.
   - ``LINES`` - JSON `lines <http://jsonlines.org/>`__.

   See the S3 API :s3-api:`JSONInput <API_JSONInput.html>` for more information.

.. mc-cmd:: --json-output
   :optional:

   The data format for the ``.json`` output.
   Supports the ``rd=value`` key, where ``rd`` is the ``RecordDelimiter`` for the JSON document.

   Omit to use the default newline character ``\n``.

   See the S3 API :s3-api:`JSONOutput <API_JSONOutput.html>` for more information.

.. mc-cmd:: --recursive, r
   :optional:

   Recursively searches the specified :mc-cmd:`~bm sql ALIAS` directory using the :mc-cmd:`~bm sql --query` SQL statement.

Global Flags
~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-globals
   :end-before: end-minio-mc-globals

Examples
--------

Select all Columns in all Objects in a Bucket
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm sql` with the :mc-cmd:`~bm sql --recursive` and :mc-cmd:`~bm sql --query` options to apply the query to all objects  in a bucket:

.. code-block:: shell
   :class: copyable

   bm sql --recursive --query "select * from S3Object" ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm sql ALIAS>` with the :ref:`alias <alias>` of the Buckit deployment.

- Replace :mc-cmd:`PATH <bm sql ALIAS>` with the path to the bucket on the Buckit deployment.

Run an Aggregation Query on an Object
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :mc:`bm sql` with the :mc-cmd:`~bm sql --query` option to query an object on an Buckit deployment:

.. code-block:: shell

   bm sql --query "select count(s.power) from S3Object" ALIAS/PATH

- Replace :mc-cmd:`ALIAS <bm sql ALIAS>` with the :ref:`alias <alias>` of the Buckit deployment.

- Replace :mc-cmd:`PATH <bm sql ALIAS>` with the path to the object on the Buckit deployment.

Behavior
--------

Input Formats
~~~~~~~~~~~~~

:mc:`bm sql` supports the following input formats:

.. list-table:: Input Format Types
   :header-rows: 1
		 
   * - Type
     - ``content-type`` Value

   * - ``.csv``
     - ``text/csv``

   * - ``.json``
     - ``application/json``

   * - ``.parquet``
     - none

For ``.csv`` file types, use :mc-cmd:`bm sql --csv-input` to specify the CSV data format.
See :ref:`mc-sql-csv-format` for more information on CSV formatting fields.

For ``.json`` file types, use :mc-cmd:`bm sql --json-input` to specify the JSON data format.

For ``.parquet`` file types, :mc:`bm sql` automatically interprets the data format.

:mc:`bm sql` determines the type by the file extension of the target object.
For example, an object named ``data.json`` is interpreted as a JSON file.

You can query data of a supported type but a different extension if the object has the appropriate ``content-type``.
For more information, see :mc-cmd:`bm cp --attr`.

.. _mc-sql-csv-format:

CSV Formatting Fields
~~~~~~~~~~~~~~~~~~~~~

The following table lists valid key-value pairs for use with :mc-cmd:`bm sql --csv-input` and :mc-cmd:`bm sql --csv-output`.
Certain key pairs are only valid for :mc-cmd:`~bm sql --csv-input`.
See the documentation for S3 API :s3-api:`CSVInput <API_CSVInput.html>` for more information on S3 CSV formatting.

.. list-table::
   :header-rows: 1
   :widths: 20 20 60
   :width: 100%

   * - Key
     - ``--csv-input`` Only
     - Description

   * - ``rd``
     -
     - The character that seperates each record (row) in the input ``.csv`` file.

       Corresponds to ``RecordDelimiter`` in the S3 API ``CSVInput``.

   * - ``fd``
     -
     - The character that seperates each field in a record. Defaults to ``,``.

       Corresponds to ``FieldDelimeter`` in the S3 API ``CSVInput``.

   * - ``qc``
     -
     - The character used for escaping when the ``fd`` character is part of a value. Defaults to ``"``.

       Corresponds to ``QuoteCharacter`` in the S3 API ``CSVInput``.

   * - ``qec``
     -
     - The character used for escaping a quotation mark ``"`` character inside an already escaped value. 

       Corresponds to ``QuoteEscapeCharacter`` in the S3 API ``CSVInput``.

   * - ``fh``
     - Yes
     - The content of the first line in the ``.csv`` file.

       Specify one of the following supported values:

       - ``NONE`` - The first line is not a header.
       - ``IGNORE`` - Ignore the first line.
       - ``USE`` - The first line is a header.

       For ``NONE`` or ``IGNORE``, you must specify column positions ``_#`` to identify a column in the :mc-cmd:`~bm sql --query` statement.

       For ``USE``, you can specify header values to identify a column in the :mc-cmd:`~bm sql --query` statement.

       Corresponds to ``FieldHeaderInfo`` in the S3 API ``CSVInput``.

   * - ``cc``
     - Yes
     - The character used to indicate a record should be ignored.
       The character *must* appear at the beginning of the record.

       Corresponds to ``Comment`` in the S3 API ``CSVInput``.

   * - ``qrd``
     - Yes
     - Specify ``TRUE`` to indicate that fields may contain record delimiter values (``rd``).

       Defaults to ``FALSE``.

       Corresponds to ``AllowQuotedRecordDelimiter`` in the S3 API ``CSVInput``.

S3 Compatibility
~~~~~~~~~~~~~~~~

.. include:: /includes/common-minio-mc.rst
   :start-after: start-minio-mc-s3-compatibility
   :end-before: end-minio-mc-s3-compatibility
