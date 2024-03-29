---
subcategory: "Kinesis"
layout: "aws"
page_title: "AWS: aws_kinesis_stream_consumer"
description: |-
  Provides details about a Kinesis Stream Consumer.
---

# Data Source: awsKinesisStreamConsumer

Provides details about a Kinesis Stream Consumer.

For more details, see the [Amazon Kinesis Stream Consumer Documentation][1].

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsKinesisStreamConsumer.DataAwsKinesisStreamConsumer(
  this,
  "example",
  {
    name: "example-consumer",
    streamArn: "${aws_kinesis_stream.example.arn}",
  }
);

```

## Argument Reference

* `arn` - (Optional) ARN of the stream consumer.
* `name` - (Optional) Name of the stream consumer.
* `streamArn` - (Required) ARN of the data stream the consumer is registered with.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `creationTimestamp` - Approximate timestamp in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8) of when the stream consumer was created.
* `id` - ARN of the stream consumer.
* `status` - Current status of the stream consumer.

[1]: https://docs.aws.amazon.com/streams/latest/dev/amazon-kinesis-consumers.html
