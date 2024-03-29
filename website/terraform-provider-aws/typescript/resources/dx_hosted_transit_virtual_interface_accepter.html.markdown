---
subcategory: "Direct Connect"
layout: "aws"
page_title: "AWS: aws_dx_hosted_transit_virtual_interface_accepter"
description: |-
  Provides a resource to manage the accepter's side of a Direct Connect hosted transit virtual interface.
---

# Resource: awsDxHostedTransitVirtualInterfaceAccepter

Provides a resource to manage the accepter's side of a Direct Connect hosted transit virtual interface.
This resource accepts ownership of a transit virtual interface created by another AWS account.

\-> **NOTE:** AWS allows a Direct Connect hosted transit virtual interface to be deleted from either the allocator's or accepter's side. However, Terraform only allows the Direct Connect hosted transit virtual interface to be deleted from the allocator's side by removing the corresponding `awsDxHostedTransitVirtualInterface` resource from your configuration. Removing a `awsDxHostedTransitVirtualInterfaceAccepter` resource from your configuration will remove it from your statefile and management, **but will not delete the Direct Connect virtual interface.**

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.provider.AwsProvider(this, "aws", {});
const awsAccepter = new aws.provider.AwsProvider(this, "aws_1", {
  alias: "accepter",
});
const awsDxGatewayExample = new aws.dxGateway.DxGateway(this, "example", {
  amazonSideAsn: 64512,
  name: "tf-dxg-example",
  provider: `\${${awsAccepter.fqn}}`,
});
const dataAwsCallerIdentityAccepter =
  new aws.dataAwsCallerIdentity.DataAwsCallerIdentity(this, "accepter", {
    provider: `\${${awsAccepter.fqn}}`,
  });
const awsDxHostedTransitVirtualInterfaceCreator =
  new aws.dxHostedTransitVirtualInterface.DxHostedTransitVirtualInterface(
    this,
    "creator",
    {
      addressFamily: "ipv4",
      bgpAsn: 65352,
      connectionId: "dxcon-zzzzzzzz",
      depends_on: [`\${${awsDxGatewayExample.fqn}}`],
      name: "tf-transit-vif-example",
      ownerAccountId: dataAwsCallerIdentityAccepter.accountId,
      vlan: 4094,
    }
  );
const awsDxHostedTransitVirtualInterfaceAccepterAccepter =
  new aws.dxHostedTransitVirtualInterfaceAccepter.DxHostedTransitVirtualInterfaceAccepter(
    this,
    "accepter_5",
    {
      dxGatewayId: awsDxGatewayExample.id,
      provider: `\${${awsAccepter.fqn}}`,
      tags: {
        Side: "Accepter",
      },
      virtualInterfaceId: awsDxHostedTransitVirtualInterfaceCreator.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsDxHostedTransitVirtualInterfaceAccepterAccepter.overrideLogicalId(
  "accepter"
);

```

## Argument Reference

The following arguments are supported:

* `dxGatewayId` - (Required) The ID of the [Direct Connect gateway](dx_gateway.html) to which to connect the virtual interface.
* `virtualInterfaceId` - (Required) The ID of the Direct Connect virtual interface to accept.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ID of the virtual interface.
* `arn` - The ARN of the virtual interface.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `10M`)
* `delete` - (Default `10M`)

## Import

Direct Connect hosted transit virtual interfaces can be imported using the `vifId`, e.g.,

```console
$ terraform import aws_dx_hosted_transit_virtual_interface_accepter.test dxvif-33cc44dd
```
