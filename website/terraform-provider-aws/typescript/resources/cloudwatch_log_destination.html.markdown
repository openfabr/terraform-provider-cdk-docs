---
subcategory: "CloudWatch Logs"
layout: "aws"
page_title: "AWS: aws_cloudwatch_log_destination"
description: |-
  Provides a CloudWatch Logs destination.
---

# Resource: awsCloudwatchLogDestination

Provides a CloudWatch Logs destination resource.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.cloudwatchLogDestination.CloudwatchLogDestination(
  this,
  "test_destination",
  {
    name: "test_destination",
    roleArn: "${aws_iam_role.iam_for_cloudwatch.arn}",
    targetArn: "${aws_kinesis_stream.kinesis_for_cloudwatch.arn}",
  }
);

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) A name for the log destination.
* `roleArn` - (Required) The ARN of an IAM role that grants Amazon CloudWatch Logs permissions to put data into the target.
* `targetArn` - (Required) The ARN of the target Amazon Kinesis stream resource for the destination.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The Amazon Resource Name (ARN) specifying the log destination.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

CloudWatch Logs destinations can be imported using the `name`, e.g.,

```console
$ terraform import aws_cloudwatch_log_destination.test_destination test_destination
```
