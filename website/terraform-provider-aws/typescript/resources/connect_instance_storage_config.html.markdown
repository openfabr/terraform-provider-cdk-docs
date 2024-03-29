---
subcategory: "Connect"
layout: "aws"
page_title: "AWS: aws_connect_instance_storage_config"
description: |-
  Provides details about a specific Amazon Connect Instance Storage Config.
---

# Resource: awsConnectInstanceStorageConfig

Provides an Amazon Connect Instance Storage Config resource. For more information see
[Amazon Connect: Getting Started](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-get-started.html)

## Example Usage

### Storage Config Kinesis Firehose Config

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.connectInstanceStorageConfig.ConnectInstanceStorageConfig(
  this,
  "example",
  {
    instanceId: "${aws_connect_instance.example.id}",
    resourceType: "CONTACT_TRACE_RECORDS",
    storageConfig: {
      kinesisFirehoseConfig: {
        firehoseArn: "${aws_kinesis_firehose_delivery_stream.example.arn}",
      },
      storageType: "KINESIS_FIREHOSE",
    },
  }
);

```

### Storage Config Kinesis Stream Config

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.connectInstanceStorageConfig.ConnectInstanceStorageConfig(
  this,
  "example",
  {
    instanceId: "${aws_connect_instance.example.id}",
    resourceType: "CONTACT_TRACE_RECORDS",
    storageConfig: {
      kinesisStreamConfig: {
        streamArn: "${aws_kinesis_stream.example.arn}",
      },
      storageType: "KINESIS_STREAM",
    },
  }
);

```

### Storage Config Kinesis Video Stream Config

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.connectInstanceStorageConfig.ConnectInstanceStorageConfig(
  this,
  "example",
  {
    instanceId: "${aws_connect_instance.example.id}",
    resourceType: "MEDIA_STREAMS",
    storageConfig: {
      kinesisVideoStreamConfig: {
        encryptionConfig: {
          encryptionType: "KMS",
          keyId: "${aws_kms_key.example.arn}",
        },
        prefix: "example",
        retentionPeriodHours: 3,
      },
      storageType: "KINESIS_VIDEO_STREAM",
    },
  }
);

```

### Storage Config S3 Config

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.connectInstanceStorageConfig.ConnectInstanceStorageConfig(
  this,
  "example",
  {
    instanceId: "${aws_connect_instance.example.id}",
    resourceType: "CHAT_TRANSCRIPTS",
    storageConfig: {
      s3Config: {
        bucketName: "${aws_s3_bucket.example.id}",
        bucketPrefix: "example",
      },
      storageType: "S3",
    },
  }
);

```

### Storage Config S3 Config with Encryption Config

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.connectInstanceStorageConfig.ConnectInstanceStorageConfig(
  this,
  "example",
  {
    instanceId: "${aws_connect_instance.example.id}",
    resourceType: "CHAT_TRANSCRIPTS",
    storageConfig: {
      s3Config: {
        bucketName: "${aws_s3_bucket.example.id}",
        bucketPrefix: "example",
        encryptionConfig: {
          encryptionType: "KMS",
          keyId: "${aws_kms_key.example.arn}",
        },
      },
      storageType: "S3",
    },
  }
);

```

## Argument Reference

The following arguments are supported:

* `instanceId` - (Required) Specifies the identifier of the hosting Amazon Connect Instance.
* `resourceType` - (Required) A valid resource type. Valid Values: `CHAT_TRANSCRIPTS` | `CALL_RECORDINGS` | `SCHEDULED_REPORTS` | `MEDIA_STREAMS` | `CONTACT_TRACE_RECORDS` | `AGENT_EVENTS` | `REAL_TIME_CONTACT_ANALYSIS_SEGMENTS`.
* `storageConfig` - (Required) Specifies the storage configuration options for the Connect Instance. [Documented below](#storage_config).

### `storageConfig`

The `storageConfig` configuration block supports the following arguments:

* `kinesisFirehoseConfig` - (Required if `type` is set to `KINESIS_FIREHOSE`) A block that specifies the configuration of the Kinesis Firehose delivery stream. [Documented below](#kinesis_firehose_config).
* `kinesisStreamConfig` - (Required if `type` is set to `KINESIS_STREAM`) A block that specifies the configuration of the Kinesis data stream. [Documented below](#kinesis_stream_config).
* `kinesisVideoStreamConfig` - (Required if `type` is set to `KINESIS_VIDEO_STREAM`) A block that specifies the configuration of the Kinesis video stream. [Documented below](#kinesis_video_stream_config).
* `s3Config` - (Required if `type` is set to `s3`) A block that specifies the configuration of S3 Bucket. [Documented below](#s3_config).
* `storageType` - (Required) A valid storage type. Valid Values: `s3` | `KINESIS_VIDEO_STREAM` | `KINESIS_STREAM` | `KINESIS_FIREHOSE`.

#### `kinesisFirehoseConfig`

The `kinesisFirehoseConfig` configuration block supports the following arguments:

* `firehoseArn` - (Required) The Amazon Resource Name (ARN) of the delivery stream.

#### `kinesisStreamConfig`

The `kinesisStreamConfig` configuration block supports the following arguments:

* `streamArn` - (Required) The Amazon Resource Name (ARN) of the data stream.

#### `kinesisVideoStreamConfig`

The `kinesisVideoStreamConfig` configuration block supports the following arguments:

* `encryptionConfig` - (Required) The encryption configuration. [Documented below](#encryption_config).
* `prefix` - (Required) The prefix of the video stream. Minimum length of `1`. Maximum length of `128`. When read from the state, the value returned is `<prefix>Connect-<connectInstanceAlias>Contact` since the API appends additional details to the `prefix`.
* `retentionPeriodHours` - (Required) The number of hours data is retained in the stream. Kinesis Video Streams retains the data in a data store that is associated with the stream. Minimum value of `0`. Maximum value of `87600`. A value of `0`, indicates that the stream does not persist data.

#### `s3Config`

The `s3Config` configuration block supports the following arguments:

* `bucketName` - (Required) The S3 bucket name.
* `bucketPrefix` - (Required) The S3 bucket prefix.
* `encryptionConfig` - (Optional) The encryption configuration. [Documented below](#encryption_config).

#### `encryptionConfig`

The `encryptionConfig` configuration block supports the following arguments:

* `encryptionType` - (Required) The type of encryption. Valid Values: `kms`.
* `keyId` - (Required) The full ARN of the encryption key. Be sure to provide the full ARN of the encryption key, not just the ID.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `associationId` - The existing association identifier that uniquely identifies the resource type and storage config for the given instance ID.
* `id` - The identifier of the hosting Amazon Connect Instance, `associationId`, and `resourceType` separated by a colon (`:`).

## Import

Amazon Connect Instance Storage Configs can be imported using the `instanceId`, `associationId`, and `resourceType` separated by a colon (`:`), e.g.,

```console
$ terraform import aws_connect_instance_storage_config.example f1288a1f-6193-445a-b47e-af739b2:c1d4e5f6-1b3c-1b3c-1b3c-c1d4e5f6c1d4e5:CHAT_TRANSCRIPTS
```
