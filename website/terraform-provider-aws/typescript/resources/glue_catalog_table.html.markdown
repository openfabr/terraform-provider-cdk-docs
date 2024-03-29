---
subcategory: "Glue"
layout: "aws"
page_title: "AWS: aws_glue_catalog_table"
description: |-
  Provides a Glue Catalog Table.
---

# Resource: awsGlueCatalogTable

Provides a Glue Catalog Table Resource. You can refer to the [Glue Developer Guide](http://docs.aws.amazon.com/glue/latest/dg/populate-data-catalog.html) for a full explanation of the Glue Data Catalog functionality.

## Example Usage

### Basic Table

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.glueCatalogTable.GlueCatalogTable(this, "aws_glue_catalog_table", {
  databaseName: "MyCatalogDatabase",
  name: "MyCatalogTable",
});

```

### Parquet Table for Athena

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.glueCatalogTable.GlueCatalogTable(this, "aws_glue_catalog_table", {
  databaseName: "MyCatalogDatabase",
  name: "MyCatalogTable",
  parameters: {
    EXTERNAL: "TRUE",
    "parquet.compression": "SNAPPY",
  },
  storageDescriptor: {
    columns: [
      {
        name: "my_string",
        type: "string",
      },
      {
        name: "my_double",
        type: "double",
      },
      {
        comment: "",
        name: "my_date",
        type: "date",
      },
      {
        comment: "",
        name: "my_bigint",
        type: "bigint",
      },
      {
        comment: "",
        name: "my_struct",
        type: "struct<my_nested_string:string>",
      },
    ],
    inputFormat:
      "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat",
    location: "s3://my-bucket/event-streams/my-stream",
    outputFormat:
      "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat",
    serDeInfo: {
      name: "my-stream",
      parameters: {
        serializationFormat: 1,
      },
      serializationLibrary:
        "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe",
    },
  },
  tableType: "EXTERNAL_TABLE",
});

```

## Argument Reference

The following arguments are required:

* `name` - (Required) Name of the table. For Hive compatibility, this must be entirely lowercase.
* `databaseName` - (Required) Name of the metadata database where the table metadata resides. For Hive compatibility, this must be all lowercase.

The follow arguments are optional:

* `catalogId` - (Optional) ID of the Glue Catalog and database to create the table in. If omitted, this defaults to the AWS Account ID plus the database name.
* `description` - (Optional) Description of the table.
* `owner` - (Optional) Owner of the table.
* `parameters` - (Optional) Properties associated with this table, as a list of key-value pairs.
* `partitionIndex` - (Optional) Configuration block for a maximum of 3 partition indexes. See [`partitionIndex`](#partition_index) below.
* `partitionKeys` - (Optional) Configuration block of columns by which the table is partitioned. Only primitive types are supported as partition keys. See [`partitionKeys`](#partition_keys) below.
* `retention` - (Optional) Retention time for this table.
* `storageDescriptor` - (Optional) Configuration block for information about the physical storage of this table. For more information, refer to the [Glue Developer Guide](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-api-catalog-tables.html#aws-glue-api-catalog-tables-StorageDescriptor). See [`storageDescriptor`](#storage_descriptor) below.
* `tableType` - (Optional) Type of this table (EXTERNAL\_TABLE, VIRTUAL\_VIEW, etc.). While optional, some Athena DDL queries such as `alterTable` and `showCreateTable` will fail if this argument is empty.
* `targetTable` - (Optional) Configuration block of a target table for resource linking. See [`targetTable`](#target_table) below.
* `viewExpandedText` - (Optional) If the table is a view, the expanded text of the view; otherwise null.
* `viewOriginalText` - (Optional) If the table is a view, the original text of the view; otherwise null.

### partitionIndex

\~> **NOTE:** A `partitionIndex` cannot be added to an existing `glueCatalogTable`.
This will destroy and recreate the table, possibly resulting in data loss.
To add an index to an existing table, see the [`gluePartitionIndex` resource](/docs/providers/aws/r/glue_partition_index.html) for configuration details.

* `indexName` - (Required) Name of the partition index.
* `keys` - (Required) Keys for the partition index.

### partitionKeys

* `comment` - (Optional) Free-form text comment.
* `name` - (Required) Name of the Partition Key.
* `type` - (Optional) Datatype of data in the Partition Key.

### storageDescriptor

* `bucketColumns` - (Optional) List of reducer grouping columns, clustering columns, and bucketing columns in the table.
* `columns` - (Optional) Configuration block for columns in the table. See [`columns`](#columns) below.
* `compressed` - (Optional) Whether the data in the table is compressed.
* `inputFormat` - (Optional) Input format: SequenceFileInputFormat (binary), or TextInputFormat, or a custom format.
* `location` - (Optional) Physical location of the table. By default this takes the form of the warehouse location, followed by the database location in the warehouse, followed by the table name.
* `numberOfBuckets` - (Optional) Must be specified if the table contains any dimension columns.
* `outputFormat` - (Optional) Output format: SequenceFileOutputFormat (binary), or IgnoreKeyTextOutputFormat, or a custom format.
* `parameters` - (Optional) User-supplied properties in key-value form.
* `schemaReference` - (Optional) Object that references a schema stored in the AWS Glue Schema Registry. When creating a table, you can pass an empty list of columns for the schema, and instead use a schema reference. See [Schema Reference](#schema_reference) below.
* `serDeInfo` - (Optional) Configuration block for serialization and deserialization ("SerDe") information. See [`serDeInfo`](#ser_de_info) below.
* `skewedInfo` - (Optional) Configuration block with information about values that appear very frequently in a column (skewed values). See [`skewedInfo`](#skewed_info) below.
* `sortColumns` - (Optional) Configuration block for the sort order of each bucket in the table. See [`sortColumns`](#sort_columns) below.
* `storedAsSubDirectories` - (Optional) Whether the table data is stored in subdirectories.

#### columns

* `comment` - (Optional) Free-form text comment.
* `name` - (Required) Name of the Column.
* `parameters` - (Optional) Key-value pairs defining properties associated with the column.
* `type` - (Optional) Datatype of data in the Column.

#### schemaReference

* `schemaId` - (Optional) Configuration block that contains schema identity fields. Either this or the `schemaVersionId` has to be provided. See [`schemaId`](#schema_id) below.
* `schemaVersionId` - (Optional) Unique ID assigned to a version of the schema. Either this or the `schemaId` has to be provided.
* `schemaVersionNumber` - (Required) Version number of the schema.

##### schemaId

* `registryName` - (Optional) Name of the schema registry that contains the schema. Must be provided when `schemaName` is specified and conflicts with `schemaArn`.
* `schemaArn` - (Optional) ARN of the schema. One of `schemaArn` or `schemaName` has to be provided.
* `schemaName` - (Optional) Name of the schema. One of `schemaArn` or `schemaName` has to be provided.

#### serDeInfo

* `name` - (Optional) Name of the SerDe.
* `parameters` - (Optional) Map of initialization parameters for the SerDe, in key-value form.
* `serializationLibrary` - (Optional) Usually the class that implements the SerDe. An example is `orgApacheHadoopHiveSerde2ColumnarColumnarSerDe`.

#### sortColumns

* `column` - (Required) Name of the column.
* `sortOrder` - (Required) Whether the column is sorted in ascending (`1`) or descending order (`0`).

#### skewedInfo

* `skewedColumnNames` - (Optional) List of names of columns that contain skewed values.
* `skewedColumnValueLocationMaps` - (Optional) List of values that appear so frequently as to be considered skewed.
* `skewedColumnValues` - (Optional) Map of skewed values to the columns that contain them.

### targetTable

* `catalogId` - (Required) ID of the Data Catalog in which the table resides.
* `databaseName` - (Required) Name of the catalog database that contains the target table.
* `name` - (Required) Name of the target table.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The ARN of the Glue Table.
* `id` - Catalog ID, Database name and of the name table.

## Import

Glue Tables can be imported with their catalog ID (usually AWS account ID), database name, and table name, e.g.,

```console
$ terraform import aws_glue_catalog_table.MyTable 123456789012:MyDatabase:MyTable
```
