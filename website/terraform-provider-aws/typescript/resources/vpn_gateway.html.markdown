---
subcategory: "VPN (Site-to-Site)"
layout: "aws"
page_title: "AWS: aws_vpn_gateway"
description: |-
  Provides a resource to create a VPC VPN Gateway.
---

# Resource: awsVpnGateway

Provides a resource to create a VPC VPN Gateway.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.vpnGateway.VpnGateway(this, "vpn_gw", {
  tags: {
    Name: "main",
  },
  vpcId: "${aws_vpc.main.id}",
});

```

## Argument Reference

The following arguments are supported:

* `vpcId` - (Optional) The VPC ID to create in.
* `availabilityZone` - (Optional) The Availability Zone for the virtual private gateway.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `amazonSideAsn` - (Optional) The Autonomous System Number (ASN) for the Amazon side of the gateway. If you don't specify an ASN, the virtual private gateway is created with the default ASN.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the VPN Gateway.
* `id` - The ID of the VPN Gateway.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

VPN Gateways can be imported using the `vpnGatewayId`, e.g.,

```console
$ terraform import aws_vpn_gateway.testvpngateway vgw-9a4cacf3
```
