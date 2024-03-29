---
subcategory: "Kinesis"
layout: "aws"
page_title: "AWS: aws_kinesis_stream"
description: |-
  Provides a AWS Kinesis Stream
---

# Resource: awsKinesisStream

Provides a Kinesis Stream resource. Amazon Kinesis is a managed service that
scales elastically for real-time processing of streaming big data.

For more details, see the [Amazon Kinesis Documentation][1].

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.kinesisStream.KinesisStream(this, "test_stream", {
  name: "terraform-kinesis-test",
  retentionPeriod: 48,
  shardCount: 1,
  shardLevelMetrics: ["IncomingBytes", "OutgoingBytes"],
  streamModeDetails: {
    streamMode: "PROVISIONED",
  },
  tags: {
    Environment: "test",
  },
});

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) A name to identify the stream. This is unique to the AWS account and region the Stream is created in.
* `shardCount` – (Optional) The number of shards that the stream will use. If the `streamMode` is `provisioned`, this field is required.
  Amazon has guidelines for specifying the Stream size that should be referenced when creating a Kinesis stream. See [Amazon Kinesis Streams][2] for more.
* `retentionPeriod` - (Optional) Length of time data records are accessible after they are added to the stream. The maximum value of a stream's retention period is 8760 hours. Minimum value is 24. Default is 24.
* `shardLevelMetrics` - (Optional) A list of shard-level CloudWatch metrics which can be enabled for the stream. See [Monitoring with CloudWatch][3] for more. Note that the value ALL should not be used; instead you should provide an explicit list of metrics you wish to enable.
* `enforceConsumerDeletion` - (Optional) A boolean that indicates all registered consumers should be deregistered from the stream so that the stream can be destroyed without error. The default value is `false`.
* `encryptionType` - (Optional) The encryption type to use. The only acceptable values are `none` or `kms`. The default value is `none`.
* `kmsKeyId` - (Optional) The GUID for the customer-managed KMS key to use for encryption. You can also use a Kinesis-owned master key by specifying the alias `alias/aws/kinesis`.
* `streamModeDetails` - (Optional) Indicates the [capacity mode](https://docs.aws.amazon.com/streams/latest/dev/how-do-i-size-a-stream.html) of the data stream. Detailed below.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### stream\_mode\_details Configuration Block

* `streamMode` - (Required) Specifies the capacity mode of the stream. Must be either `provisioned` or `ON_DEMAND`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The unique Stream id
* `name` - The unique Stream name
* `shardCount` - The count of Shards for this Stream
* `arn` - The Amazon Resource Name (ARN) specifying the Stream (same as `id`)
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `5M`)
* `update` - (Default `120M`)
* `delete` - (Default `120M`)

## Import

Kinesis Streams can be imported using the `name`, e.g.,

```console
$ terraform import aws_kinesis_stream.test_stream terraform-kinesis-test
```

[1]: https://aws.amazon.com/documentation/kinesis/

[2]: https://docs.aws.amazon.com/kinesis/latest/dev/amazon-kinesis-streams.html

[3]: https://docs.aws.amazon.com/streams/latest/dev/monitoring-with-cloudwatch.html
