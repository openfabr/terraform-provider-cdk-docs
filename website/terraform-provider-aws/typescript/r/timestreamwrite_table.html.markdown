---
subcategory: "Timestream Write"
layout: "aws"
page_title: "AWS: aws_timestreamwrite_table"
description: |-
  Provides a Timestream table resource.
---

# Resource: aws\_timestreamwrite\_table

Provides a Timestream table resource.

## Example Usage

### Basic usage

```hcl
resource "aws_timestreamwrite_table" "example" {
  database_name = aws_timestreamwrite_database.example.database_name
  table_name    = "example"
}
```

### Full usage

```hcl
resource "aws_timestreamwrite_table" "example" {
  database_name = aws_timestreamwrite_database.example.database_name
  table_name    = "example"

  retention_properties {
    magnetic_store_retention_period_in_days = 30
    memory_store_retention_period_in_hours  = 8
  }

  tags = {
    Name = "example-timestream-table"
  }
}
```

## Argument Reference

The following arguments are supported:

* `databaseName` – (Required) The name of the Timestream database.
* `magneticStoreWriteProperties` - (Optional) Contains properties to set on the table when enabling magnetic store writes. See [Magnetic Store Write Properties](#magnetic-store-write-properties) below for more details.
* `retentionProperties` - (Optional) The retention duration for the memory store and magnetic store. See [Retention Properties](#retention-properties) below for more details. If not provided, `magneticStoreRetentionPeriodInDays` default to 73000 and `memoryStoreRetentionPeriodInHours` defaults to 6.
* `tableName` - (Required) The name of the Timestream table.
* `tags` - (Optional) Map of tags to assign to this resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### Magnetic Store Write Properties

The `magneticStoreWriteProperties` block supports the following arguments:

* `enableMagneticStoreWrites` - (Required) A flag to enable magnetic store writes.
* `magneticStoreRejectedDataLocation` - (Optional) The location to write error reports for records rejected asynchronously during magnetic store writes. See [Magnetic Store Rejected Data Location](#magnetic-store-rejected-data-location) below for more details.

#### Magnetic Store Rejected Data Location

The `magneticStoreRejectedDataLocation` block supports the following arguments:

* `s3Configuration` - (Optional) Configuration of an S3 location to write error reports for records rejected, asynchronously, during magnetic store writes. See [S3 Configuration](#s3-configuration) below for more details.

##### S3 Configuration

The `s3Configuration` block supports the following arguments:

* `bucketName` - (Optional) Bucket name of the customer S3 bucket.
* `encryptionOption` - (Optional) Encryption option for the customer s3 location. Options are S3 server side encryption with an S3-managed key or KMS managed key. Valid values are `sseKms` and `sseS3`.
* `kmsKeyId` - (Optional) KMS key arn for the customer s3 location when encrypting with a KMS managed key.
* `objectKeyPrefix` - (Optional) Object key prefix for the customer S3 location.

### Retention Properties

The `retentionProperties` block supports the following arguments:

* `magneticStoreRetentionPeriodInDays` - (Required) The duration for which data must be stored in the magnetic store. Minimum value of 1. Maximum value of 73000.
* `memoryStoreRetentionPeriodInHours` - (Required) The duration for which data must be stored in the memory store. Minimum value of 1. Maximum value of 8766.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The `tableName` and `databaseName` separated by a colon (`:`).
* `arn` - The ARN that uniquely identifies this table.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Timestream tables can be imported using the `tableName` and `databaseName` separate by a colon (`:`), e.g.,

```console
$ terraform import aws_timestreamwrite_table.example ExampleTable:ExampleDatabase
```
