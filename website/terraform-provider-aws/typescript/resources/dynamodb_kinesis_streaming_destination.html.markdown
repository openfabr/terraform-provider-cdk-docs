---
subcategory: "DynamoDB"
layout: "aws"
page_title: "AWS: aws_dynamodb_kinesis_streaming_destination"
description: |-
  Enables a Kinesis streaming destination for a DynamoDB table
---

# Resource: awsDynamodbKinesisStreamingDestination

Enables a [Kinesis streaming destination](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/kds.html) for data replication of a DynamoDB table.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsDynamodbTableExample = new aws.dynamodbTable.DynamodbTable(
  this,
  "example",
  {
    attribute: [
      {
        name: "id",
        type: "S",
      },
    ],
    hashKey: "id",
    name: "orders",
  }
);
const awsKinesisStreamExample = new aws.kinesisStream.KinesisStream(
  this,
  "example_1",
  {
    name: "order_item_changes",
    shardCount: 1,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsKinesisStreamExample.overrideLogicalId("example");
const awsDynamodbKinesisStreamingDestinationExample =
  new aws.dynamodbKinesisStreamingDestination.DynamodbKinesisStreamingDestination(
    this,
    "example_2",
    {
      streamArn: awsKinesisStreamExample.arn,
      tableName: awsDynamodbTableExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsDynamodbKinesisStreamingDestinationExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `streamArn` - (Required) The ARN for a Kinesis data stream. This must exist in the same account and region as the DynamoDB table.

*   `tableName` - (Required) The name of the DynamoDB table. There
    can only be one Kinesis streaming destination for a given DynamoDB table.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The `tableName` and `streamArn` separated by a comma (`,`).

## Import

DynamoDB Kinesis Streaming Destinations can be imported using the `tableName` and `streamArn` separated by `,`, e.g.,

```console
$ terraform import aws_dynamodb_kinesis_streaming_destination.example example,arn:aws:kinesis:us-east-1:111122223333:exampleStreamName
```
