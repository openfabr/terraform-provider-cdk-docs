---
subcategory: "Network Manager"
layout: "aws"
page_title: "AWS: aws_networkmanager_vpc_attachment"
description: |-
  Terraform resource for managing an AWS NetworkManager VpcAttachment.
---

# Resource: awsNetworkmanagerVpcAttachment

Terraform resource for managing an AWS NetworkManager VpcAttachment.

## Example Usage

### Basic Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.networkmanagerVpcAttachment.NetworkmanagerVpcAttachment(
  this,
  "example",
  {
    coreNetworkId: "${awscc_networkmanager_core_network.example.id}",
    subnetArns: ["${aws_subnet.example.arn}"],
    vpcArn: "${aws_vpc.example.arn}",
  }
);

```

## Argument Reference

The following arguments are required:

* `coreNetworkId` - (Required) The ID of a core network for the VPC attachment.
* `subnetArns` - (Required) The subnet ARN of the VPC attachment.
* `vpcArn` - (Required) The ARN of the VPC.

The following arguments are optional:

* `options` - (Optional) Options for the VPC attachment.
* `tags` - (Optional) Key-value tags for the attachment. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### options

* `applianceModeSupport` - (Optional) Indicates whether appliance mode is supported. If enabled, traffic flow between a source and destination use the same Availability Zone for the VPC attachment for the lifetime of that flow.
* `ipv6Support` - (Optional) Indicates whether IPv6 is supported.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The ARN of the attachment.
* `attachmentPolicyRuleNumber` - The policy rule number associated with the attachment.
* `attachmentType` - The type of attachment.
* `coreNetworkArn` - The ARN of a core network.
* `edgeLocation` - The Region where the edge is located.
* `id` - The ID of the attachment.
* `ownerAccountId` - The ID of the attachment account owner.
* `resourceArn` - The attachment resource ARN.
* `segmentName` - The name of the segment attachment.
* `state` - The state of the attachment.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsNetworkmanagerVpcAttachment` can be imported using the attachment ID, e.g.

```console
$ terraform import aws_networkmanager_vpc_attachment.example attachment-0f8fa60d2238d1bd8
```
