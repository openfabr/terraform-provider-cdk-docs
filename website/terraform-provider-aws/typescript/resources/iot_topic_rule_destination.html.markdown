---
subcategory: "IoT Core"
layout: "aws"
page_title: "AWS: aws_iot_topic_rule_destination"
description: |-
    Creates and manages an AWS IoT topic rule destination
---

# Resource: awsIotTopicRuleDestination

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.iotTopicRuleDestination.IotTopicRuleDestination(this, "example", {
  vpcConfiguration: {
    roleArn: "${aws_iam_role.example.arn}",
    securityGroups: ["${aws_security_group.example.id}"],
    subnetIds: "${aws_subnet.example[*].id}",
    vpcId: "${aws_vpc.example.id}",
  },
});

```

## Argument Reference

* `enabled` - (Optional) Whether or not to enable the destination. Default: `true`.
* `vpcConfiguration` - (Required) Configuration of the virtual private cloud (VPC) connection. For more info, see the [AWS documentation](https://docs.aws.amazon.com/iot/latest/developerguide/vpc-rule-action.html).

The `vpcConfiguration` object takes the following arguments:

* `roleArn` - (Required) The ARN of a role that has permission to create and attach to elastic network interfaces (ENIs).
* `securityGroups` - (Optional) The security groups of the VPC destination.
* `subnetIds` - (Required) The subnet IDs of the VPC destination.
* `vpcId` - (Required) The ID of the VPC.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The ARN of the topic rule destination

## Import

IoT topic rule destinations can be imported using the `arn`, e.g.,

```console
$ terraform import aws_iot_topic_rule_destination.example arn:aws:iot:us-west-2:123456789012:ruledestination/vpc/2ce781c8-68a6-4c52-9c62-63fe489ecc60
```
