---
subcategory: "Network Manager"
layout: "aws"
page_title: "AWS: aws_networkmanager_connect_attachment"
description: |-
  Terraform resource for managing an AWS NetworkManager ConnectAttachment.
---

# Resource: awsNetworkmanagerConnectAttachment

Terraform resource for managing an AWS NetworkManager ConnectAttachment.

## Example Usage

### Basic Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsNetworkmanagerVpcAttachmentExample =
  new aws.networkmanagerVpcAttachment.NetworkmanagerVpcAttachment(
    this,
    "example",
    {
      coreNetworkId: "${awscc_networkmanager_core_network.example.id}",
      subnetArns: "${aws_subnet.example[*].arn}",
      vpcArn: "${aws_vpc.example.arn}",
    }
  );
const awsNetworkmanagerConnectAttachmentExample =
  new aws.networkmanagerConnectAttachment.NetworkmanagerConnectAttachment(
    this,
    "example_1",
    {
      coreNetworkId: "${awscc_networkmanager_core_network.example.id}",
      edgeLocation: awsNetworkmanagerVpcAttachmentExample.edgeLocation,
      options: {
        protocol: "GRE",
      },
      transportAttachmentId: awsNetworkmanagerVpcAttachmentExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsNetworkmanagerConnectAttachmentExample.overrideLogicalId("example");

```

### Usage with attachment accepter

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsNetworkmanagerVpcAttachmentExample =
  new aws.networkmanagerVpcAttachment.NetworkmanagerVpcAttachment(
    this,
    "example",
    {
      coreNetworkId: "${awscc_networkmanager_core_network.example.id}",
      subnetArns: "${aws_subnet.example[*].arn}",
      vpcArn: "${aws_vpc.example.arn}",
    }
  );
const awsNetworkmanagerAttachmentAccepterExample =
  new aws.networkmanagerAttachmentAccepter.NetworkmanagerAttachmentAccepter(
    this,
    "example_1",
    {
      attachmentId: awsNetworkmanagerVpcAttachmentExample.id,
      attachmentType: awsNetworkmanagerVpcAttachmentExample.attachmentType,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsNetworkmanagerAttachmentAccepterExample.overrideLogicalId("example");
const awsNetworkmanagerConnectAttachmentExample =
  new aws.networkmanagerConnectAttachment.NetworkmanagerConnectAttachment(
    this,
    "example_2",
    {
      coreNetworkId: "${awscc_networkmanager_core_network.example.id}",
      depends_on: ["aws_networkmanager_attachment_accepter.test"],
      edgeLocation: awsNetworkmanagerVpcAttachmentExample.edgeLocation,
      options: {
        protocol: "GRE",
      },
      transportAttachmentId: awsNetworkmanagerVpcAttachmentExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsNetworkmanagerConnectAttachmentExample.overrideLogicalId("example");
new aws.networkmanagerAttachmentAccepter.NetworkmanagerAttachmentAccepter(
  this,
  "example2",
  {
    attachmentId: awsNetworkmanagerConnectAttachmentExample.id,
    attachmentType: awsNetworkmanagerConnectAttachmentExample.attachmentType,
  }
);

```

## Argument Reference

The following arguments are required:

* `coreNetworkId` - (Required) The ID of a core network where you want to create the attachment.
* `transportAttachmentId` - (Required) The ID of the attachment between the two connections.
* `edgeLocation` - (Required) The Region where the edge is located.
* `options` - (Required) Options for creating an attachment.

The following arguments are optional:

* `tags` - (Optional) Key-value tags for the attachment. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The ARN of the attachment.
* `attachmentPolicyRuleNumber` - The policy rule number associated with the attachment.
* `attachmentType` - The type of attachment.
* `coreNetworkArn` - The ARN of a core network.
* `coreNetworkId` - The ID of a core network
* `edgeLocation` - The Region where the edge is located.
* `id` - The ID of the attachment.
* `ownerAccountId` - The ID of the attachment account owner.
* `resourceArn` - The attachment resource ARN.
* `segmentName` - The name of the segment attachment.
* `state` - The state of the attachment.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsNetworkmanagerConnectAttachment` can be imported using the attachment ID, e.g.

```console
$ terraform import aws_networkmanager_connect_attachment.example attachment-0f8fa60d2238d1bd8
```
