---
subcategory: "DMS (Database Migration)"
layout: "aws"
page_title: "AWS: aws_dms_endpoint"
description: |-
  Provides a DMS (Data Migration Service) endpoint resource.
---

# Resource: awsDmsEndpoint

Provides a DMS (Data Migration Service) endpoint resource. DMS endpoints can be created, updated, deleted, and imported.

\~> **Note:** All arguments including the password will be stored in the raw state as plain-text. [Read more about sensitive data in state](https://www.terraform.io/docs/state/sensitive-data.html).

\~> **Note:** The `s3Settings` argument is deprecated, may not be maintained, and will be removed in a future version. Use the [`awsDmsS3Endpoint`](/docs/providers/aws/r/dms_s3_endpoint.html) resource instead.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dmsEndpoint.DmsEndpoint(this, "test", {
  certificateArn:
    "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012",
  databaseName: "test",
  endpointId: "test-dms-endpoint-tf",
  endpointType: "source",
  engineName: "aurora",
  extraConnectionAttributes: "",
  kmsKeyArn:
    "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012",
  password: "test",
  port: 3306,
  serverName: "test",
  sslMode: "none",
  tags: {
    Name: "test",
  },
  username: "test",
});

```

## Argument Reference

The following arguments are required:

* `endpointId` - (Required) Database endpoint identifier. Identifiers must contain from 1 to 255 alphanumeric characters or hyphens, begin with a letter, contain only ASCII letters, digits, and hyphens, not end with a hyphen, and not contain two consecutive hyphens.
* `endpointType` - (Required) Type of endpoint. Valid values are `source`, `target`.
* `engineName` - (Required) Type of engine for the endpoint. Valid values are `aurora`, `auroraPostgresql`, `azuredb`, `azureSqlManagedInstance`, `db2`, `docdb`, `dynamodb`, `elasticsearch`, `kafka`, `kinesis`, `mariadb`, `mongodb`, `mysql`, `opensearch`, `oracle`, `postgres`, `redshift`, `s3`, `sqlserver`, `sybase`. Please note that some of engine names are available only for `target` endpoint type (e.g. `redshift`).
* `kmsKeyArn` - (Required when `engineName` is `mongodb`, cannot be set when `engineName` is `s3`, optional otherwise) ARN for the KMS key that will be used to encrypt the connection parameters. If you do not specify a value for `kmsKeyArn`, then AWS DMS will use your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS region. To encrypt an S3 target with a KMS Key, use the parameter `s3SettingsServerSideEncryptionKmsKeyId`. When `engineName` is `redshift`, `kmsKeyArn` is the KMS Key for the Redshift target and the parameter `redshiftSettingsServerSideEncryptionKmsKeyId` encrypts the S3 intermediate storage.

The following arguments are optional:

* `certificateArn` - (Optional, Default: empty string) ARN for the certificate.
* `databaseName` - (Optional) Name of the endpoint database.
* `elasticsearchSettings` - (Optional) Configuration block for OpenSearch settings. See below.
* `extraConnectionAttributes` - (Optional) Additional attributes associated with the connection. For available attributes for a `source` Endpoint, see [Sources for data migration](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.html). For available attributes for a `target` Endpoint, see [Targets for data migration](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.html).
* `kafkaSettings` - (Optional) Configuration block for Kafka settings. See below.
* `kinesisSettings` - (Optional) Configuration block for Kinesis settings. See below.
* `mongodbSettings` - (Optional) Configuration block for MongoDB settings. See below.
* `password` - (Optional) Password to be used to login to the endpoint database.
* `port` - (Optional) Port used by the endpoint database.
* `redshiftSettings` - (Optional) Configuration block for Redshift settings. See below.
* `s3Settings` - (Optional) (**Deprecated**, use the [`awsDmsS3Endpoint`](/docs/providers/aws/r/dms_s3_endpoint.html) resource instead) Configuration block for S3 settings. See below.
* `secretsManagerAccessRoleArn` - (Optional) ARN of the IAM role that specifies AWS DMS as the trusted entity and has the required permissions to access the value in SecretsManagerSecret.
* `secretsManagerArn` - (Optional) Full ARN, partial ARN, or friendly name of the SecretsManagerSecret that contains the endpoint connection details. Supported only when `engineName` is `aurora`, `auroraPostgresql`, `mariadb`, `mongodb`, `mysql`, `oracle`, `postgres`, `redshift`, or `sqlserver`.
* `serverName` - (Optional) Host name of the server.
* `serviceAccessRole` - (Optional) ARN used by the service access IAM role for dynamodb endpoints.
* `sslMode` - (Optional, Default: `none`) SSL mode to use for the connection. Valid values are `none`, `require`, `verifyCa`, `verifyFull`
* `tags` - (Optional) Map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `username` - (Optional) User name to be used to login to the endpoint database.

### elasticsearchSettings

\-> Additional information can be found in the [Using Amazon OpenSearch Service as a Target for AWS Database Migration Service documentation](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.Elasticsearch.html).

* `endpointUri` - (Required) Endpoint for the OpenSearch cluster.
* `errorRetryDuration` - (Optional) Maximum number of seconds for which DMS retries failed API requests to the OpenSearch cluster. Default is `300`.
* `fullLoadErrorPercentage` - (Optional) Maximum percentage of records that can fail to be written before a full load operation stops. Default is `10`.
* `serviceAccessRoleArn` - (Required) ARN of the IAM Role with permissions to write to the OpenSearch cluster.

### kafkaSettings

\-> Additional information can be found in the [Using Apache Kafka as a Target for AWS Database Migration Service documentation](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.Kafka.html).

* `broker` - (Required) Kafka broker location. Specify in the form broker-hostname-or-ip:port.
* `includeControlDetails` - (Optional) Shows detailed control information for table definition, column definition, and table and column changes in the Kafka message output. Default is `false`.
* `includeNullAndEmpty` - (Optional) Include NULL and empty columns for records migrated to the endpoint. Default is `false`.
* `includePartitionValue` - (Optional) Shows the partition value within the Kafka message output unless the partition type is `schemaTableType`. Default is `false`.
* `includeTableAlterOperations` - (Optional) Includes any data definition language (DDL) operations that change the table in the control data, such as `renameTable`, `dropTable`, `addColumn`, `dropColumn`, and `renameColumn`. Default is `false`.
* `includeTransactionDetails` - (Optional) Provides detailed transaction information from the source database. This information includes a commit timestamp, a log position, and values for `transactionId`, previous `transactionId`, and `transactionRecordId` (the record offset within a transaction). Default is `false`.
* `messageFormat` - (Optional) Output format for the records created on the endpoint. Message format is `json` (default) or `JSON_UNFORMATTED` (a single line with no tab).
* `messageMaxBytes` - (Optional) Maximum size in bytes for records created on the endpoint Default is `1,000,000`.
* `noHexPrefix` - (Optional) Set this optional parameter to true to avoid adding a '0x' prefix to raw data in hexadecimal format. For example, by default, AWS DMS adds a '0x' prefix to the LOB column type in hexadecimal format moving from an Oracle source to a Kafka target. Use the `noHexPrefix` endpoint setting to enable migration of RAW data type columns without adding the `'0X'` prefix.
* `partitionIncludeSchemaTable` - (Optional) Prefixes schema and table names to partition values, when the partition type is `primaryKeyType`. Doing this increases data distribution among Kafka partitions. For example, suppose that a SysBench schema has thousands of tables and each table has only limited range for a primary key. In this case, the same primary key is sent from thousands of tables to the same partition, which causes throttling. Default is `false`.
* `saslPassword` - (Optional) Secure password you created when you first set up your MSK cluster to validate a client identity and make an encrypted connection between server and client using SASL-SSL authentication.
* `saslUsername` - (Optional) Secure user name you created when you first set up your MSK cluster to validate a client identity and make an encrypted connection between server and client using SASL-SSL authentication.
* `securityProtocol` - (Optional) Set secure connection to a Kafka target endpoint using Transport Layer Security (TLS). Options include `sslEncryption`, `sslAuthentication`, and `saslSsl`. `saslSsl` requires `saslUsername` and `saslPassword`.
* `sslCaCertificateArn` - (Optional) ARN for the private certificate authority (CA) cert that AWS DMS uses to securely connect to your Kafka target endpoint.
* `sslClientCertificateArn` - (Optional) ARN of the client certificate used to securely connect to a Kafka target endpoint.
* `sslClientKeyArn` - (Optional) ARN for the client private key used to securely connect to a Kafka target endpoint.
* `sslClientKeyPassword` - (Optional) Password for the client private key used to securely connect to a Kafka target endpoint.
* `topic` - (Optional) Kafka topic for migration. Default is `kafkaDefaultTopic`.

### kinesisSettings

\-> Additional information can be found in the [Using Amazon Kinesis Data Streams as a Target for AWS Database Migration Service documentation](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.Kinesis.html).

* `includeControlDetails` - (Optional) Shows detailed control information for table definition, column definition, and table and column changes in the Kinesis message output. Default is `false`.
* `includeNullAndEmpty` - (Optional) Include NULL and empty columns in the target. Default is `false`.
* `includePartitionValue` - (Optional) Shows the partition value within the Kinesis message output, unless the partition type is schema-table-type. Default is `false`.
* `includeTableAlterOperations` - (Optional) Includes any data definition language (DDL) operations that change the table in the control data. Default is `false`.
* `includeTransactionDetails` - (Optional) Provides detailed transaction information from the source database. Default is `false`.
* `messageFormat` - (Optional) Output format for the records created. Default is `json`. Valid values are `json` and `jsonUnformatted` (a single line with no tab).
* `partitionIncludeSchemaTable` - (Optional) Prefixes schema and table names to partition values, when the partition type is primary-key-type. Default is `false`.
* `serviceAccessRoleArn` - (Optional) ARN of the IAM Role with permissions to write to the Kinesis data stream.
* `streamArn` - (Optional) ARN of the Kinesis data stream.

### mongodbSettings

\-> Additional information can be found in the [Using MongoDB as a Source for AWS DMS documentation](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.MongoDB.html).

* `authMechanism` - (Optional) Authentication mechanism to access the MongoDB source endpoint. Default is `default`.
* `authSource` - (Optional) Authentication database name. Not used when `authType` is `no`. Default is `admin`.
* `authType` - (Optional) Authentication type to access the MongoDB source endpoint. Default is `password`.
* `docsToInvestigate` - (Optional) Number of documents to preview to determine the document organization. Use this setting when `nestingLevel` is set to `one`. Default is `1000`.
* `extractDocId` - (Optional) Document ID. Use this setting when `nestingLevel` is set to `none`. Default is `false`.
* `nestingLevel` - (Optional) Specifies either document or table mode. Default is `none`. Valid values are `one` (table mode) and `none` (document mode).

### redisSettings

\-> Additional information can be found in the [Using Redis as a target for AWS Database Migration Service](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.Redis.html).

* `authPassword` - (Optional) The password provided with the auth-role and auth-token options of the AuthType setting for a Redis target endpoint.
* `authType` - (Required) The type of authentication to perform when connecting to a Redis target. Options include `none`, `authToken`, and `authRole`. The `authToken` option requires an `authPassword` value to be provided. The `authRole` option requires `authUserName` and `authPassword` values to be provided.
* `authUserName` - (Optional) The username provided with the `authRole` option of the AuthType setting for a Redis target endpoint.
* `serverName` - (Required) Fully qualified domain name of the endpoint.
* `port` - (Required) Transmission Control Protocol (TCP) port for the endpoint.
* `sslCaCertificateArn` - (Optional) The Amazon Resource Name (ARN) for the certificate authority (CA) that DMS uses to connect to your Redis target endpoint.
* `sslSecurityProtocol`- (Optional) The plaintext option doesn't provide Transport Layer Security (TLS) encryption for traffic between endpoint and database. Options include `plaintext`, `sslEncryption`. The default is `sslEncryption`.

### redshiftSettings

\-> Additional information can be found in the [Using Amazon Redshift as a Target for AWS Database Migration Service documentation](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.Redshift.html).

* `bucketFolder` - (Optional) Custom S3 Bucket Object prefix for intermediate storage.
* `bucketName` - (Optional) Custom S3 Bucket name for intermediate storage.
* `encryptionMode` - (Optional) The server-side encryption mode that you want to encrypt your intermediate .csv object files copied to S3. Defaults to `SSE_S3`. Valid values are `SSE_S3` and `SSE_KMS`.
* `serverSideEncryptionKmsKeyId` - (Required when `encryptionMode` is  `SSE_KMS`, must not be set otherwise) ARN or Id of KMS Key to use when `encryptionMode` is `SSE_KMS`.
* `serviceAccessRoleArn` - (Optional) Amazon Resource Name (ARN) of the IAM Role with permissions to read from or write to the S3 Bucket for intermediate storage.

### s3Settings

\~> **Deprecated:** This argument is deprecated, may not be maintained, and will be removed in a future version. Use the [`awsDmsS3Endpoint`](/docs/providers/aws/r/dms_s3_endpoint.html) resource instead.

\-> Additional information can be found in the [Using Amazon S3 as a Source for AWS Database Migration Service documentation](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.S3.html) and [Using Amazon S3 as a Target for AWS Database Migration Service documentation](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.S3.html).

* `addColumnName` - (Optional) Whether to add column name information to the .csv output file. Default is `false`.
* `bucketFolder` - (Optional) S3 object prefix.
* `bucketName` - (Optional) S3 bucket name.
* `cannedAclForObjects` - (Optional) Predefined (canned) access control list for objects created in an S3 bucket. Valid values include `none`, `private`, `publicRead`, `publicReadWrite`, `authenticatedRead`, `awsExecRead`, `bucketOwnerRead`, and `bucketOwnerFullControl`. Default is `none`.
* `cdcInsertsAndUpdates` - (Optional) Whether to write insert and update operations to .csv or .parquet output files. Default is `false`.
* `cdcInsertsOnly` - (Optional) Whether to write insert operations to .csv or .parquet output files. Default is `false`.
* `cdcMaxBatchInterval` - (Optional) Maximum length of the interval, defined in seconds, after which to output a file to Amazon S3. Default is `60`.
* `cdcMinFileSize` - (Optional) Minimum file size condition as defined in kilobytes to output a file to Amazon S3. Default is `32000`. **NOTE:** Previously, this setting was measured in megabytes but now represents kilobytes. Update configurations accordingly.
* `cdcPath` - (Optional) Folder path of CDC files. For an S3 source, this setting is required if a task captures change data; otherwise, it's optional. If `cdcPath` is set, AWS DMS reads CDC files from this path and replicates the data changes to the target endpoint. Supported in AWS DMS versions 3.4.2 and later.
* `compressionType` - (Optional) Set to compress target files. Default is `none`. Valid values are `gzip` and `none`.
* `csvDelimiter` - (Optional) Delimiter used to separate columns in the source files. Default is `,`.
* `csvNoSupValue` - (Optional) String to use for all columns not included in the supplemental log.
* `csvNullValue` - (Optional) String to as null when writing to the target.
* `csvRowDelimiter` - (Optional) Delimiter used to separate rows in the source files. Default is `\n`.
* `dataFormat` - (Optional) Output format for the files that AWS DMS uses to create S3 objects. Valid values are `csv` and `parquet`. Default is `csv`.
* `dataPageSize` - (Optional) Size of one data page in bytes. Default is `1048576` (1 MiB).
* `datePartitionDelimiter` - (Optional) Date separating delimiter to use during folder partitioning. Valid values are `slash`, `underscore`, `dash`, and `none`. Default is `slash`.
* `datePartitionEnabled` - (Optional) Partition S3 bucket folders based on transaction commit dates. Default is `false`.
* `datePartitionSequence` - (Optional) Date format to use during folder partitioning. Use this parameter when `datePartitionEnabled` is set to true. Valid values are `yyyymmdd`, `yyyymmddhh`, `yyyymm`, `mmyyyydd`, and `ddmmyyyy`. Default is `yyyymmdd`.
* `dictPageSizeLimit` - (Optional) Maximum size in bytes of an encoded dictionary page of a column. Default is `1048576` (1 MiB).
* `enableStatistics` - (Optional) Whether to enable statistics for Parquet pages and row groups. Default is `true`.
* `encodingType` - (Optional) Type of encoding to use. Value values are `rleDictionary`, `plain`, and `plainDictionary`. Default is `rleDictionary`.
* `encryptionMode` - (Optional) Server-side encryption mode that you want to encrypt your .csv or .parquet object files copied to S3. Valid values are `SSE_S3` and `SSE_KMS`. Default is `SSE_S3`.
* `externalTableDefinition` - (Optional) JSON document that describes how AWS DMS should interpret the data.
* `ignoreHeaderRows` - (Optional) When this value is set to `1`, DMS ignores the first row header in a .csv file. Default is `0`.
* `ignoreHeadersRow` - (Optional) Deprecated. This setting has no effect. Will be removed in a future version.
* `includeOpForFullLoad` - (Optional) Whether to enable a full load to write INSERT operations to the .csv output files only to indicate how the rows were added to the source database. Default is `false`.
* `maxFileSize` - (Optional) Maximum size (in KB) of any .csv file to be created while migrating to an S3 target during full load. Valid values are from `1` to `1048576`. Default is `1048576` (1 GB).
* `parquetTimestampInMillisecond` - (Optional) - Specifies the precision of any TIMESTAMP column values written to an S3 object file in .parquet format. Default is `false`.
* `parquetVersion` - (Optional) Version of the .parquet file format. Default is `parquet10`. Valid values are `parquet10` and `parquet20`.
* `preserveTransactions` - (Optional) Whether DMS saves the transaction order for a CDC load on the S3 target specified by `cdcPath`. Default is `false`.
* `rfc4180` - (Optional) For an S3 source, whether each leading double quotation mark has to be followed by an ending double quotation mark. Default is `true`.
* `rowGroupLength` - (Optional) Number of rows in a row group. Default is `10000`.
* `serverSideEncryptionKmsKeyId` - (Required when `encryptionMode` is  `SSE_KMS`, must not be set otherwise) ARN or Id of KMS Key to use when `encryptionMode` is `SSE_KMS`.
* `serviceAccessRoleArn` - (Optional) ARN of the IAM Role with permissions to read from or write to the S3 Bucket.
* `timestampColumnName` - (Optional) Column to add with timestamp information to the endpoint data for an Amazon S3 target.
* `useCsvNoSupValue` - (Optional) Whether to use `csvNoSupValue` for columns not included in the supplemental log.
* `useTaskStartTimeForFullLoadTimestamp` - (Optional) When set to true, uses the task start time as the timestamp column value instead of the time data is written to target. For full load, when set to true, each row of the timestamp column contains the task start time. For CDC loads, each row of the timestamp column contains the transaction commit time. When set to false, the full load timestamp in the timestamp column increments with the time data arrives at the target. Default is `false`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `endpointArn` - ARN for the endpoint.
* `tagsAll` - Map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `5M`)
* `delete` - (Default `10M`)

## Import

Endpoints can be imported using the `endpointId`, e.g.,

```console
$ terraform import aws_dms_endpoint.test test-dms-endpoint-tf
```
