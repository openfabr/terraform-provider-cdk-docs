---
subcategory: "VPC (Virtual Private Cloud)"
layout: "aws"
page_title: "AWS: aws_vpc_peering_connection"
description: |-
  Provides a resource to manage a VPC peering connection.
---

# Resource: awsVpcPeeringConnection

Provides a resource to manage a VPC peering connection.

\~> **NOTE on VPC Peering Connections and VPC Peering Connection Options:** Terraform provides
both a standalone [VPC Peering Connection Options](vpc_peering_connection_options.html) and a VPC Peering Connection
resource with `accepter` and `requester` attributes. Do not manage options for the same VPC peering
connection in both a VPC Peering Connection resource and a VPC Peering Connection Options resource.
Doing so will cause a conflict of options and will overwrite the options.
Using a VPC Peering Connection Options resource decouples management of the connection options from
management of the VPC Peering Connection and allows options to be set correctly in cross-account scenarios.

\-> **Note:** For cross-account (requester's AWS account differs from the accepter's AWS account) or inter-region
VPC Peering Connections use the `awsVpcPeeringConnection` resource to manage the requester's side of the
connection and use the `awsVpcPeeringConnectionAccepter` resource to manage the accepter's side of the connection.

\-> **Note:** Creating multiple `awsVpcPeeringConnection` resources with the same `peerVpcId` and `vpcId` will not produce an error. Instead, AWS will return the connection `id` that already exists, resulting in multiple `awsVpcPeeringConnection` resources with the same `id`.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.vpcPeeringConnection.VpcPeeringConnection(this, "foo", {
  peerOwnerId: "${var.peer_owner_id}",
  peerVpcId: "${aws_vpc.bar.id}",
  vpcId: "${aws_vpc.foo.id}",
});

```

Basic usage with connection options:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.vpcPeeringConnection.VpcPeeringConnection(this, "foo", {
  accepter: {
    allowRemoteVpcDnsResolution: true,
  },
  peerOwnerId: "${var.peer_owner_id}",
  peerVpcId: "${aws_vpc.bar.id}",
  requester: {
    allowRemoteVpcDnsResolution: true,
  },
  vpcId: "${aws_vpc.foo.id}",
});

```

Basic usage with tags:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsVpcBar = new aws.vpc.Vpc(this, "bar", {
  cidrBlock: "10.2.0.0/16",
});
const awsVpcFoo = new aws.vpc.Vpc(this, "foo", {
  cidrBlock: "10.1.0.0/16",
});
const awsVpcPeeringConnectionFoo =
  new aws.vpcPeeringConnection.VpcPeeringConnection(this, "foo_2", {
    autoAccept: true,
    peerOwnerId: "${var.peer_owner_id}",
    peerVpcId: awsVpcBar.id,
    tags: {
      Name: "VPC Peering between foo and bar",
    },
    vpcId: awsVpcFoo.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsVpcPeeringConnectionFoo.overrideLogicalId("foo");

```

Basic usage with region:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsVpcBar = new aws.vpc.Vpc(this, "bar", {
  cidrBlock: "10.2.0.0/16",
  provider: "${aws.us-east-1}",
});
const awsVpcFoo = new aws.vpc.Vpc(this, "foo", {
  cidrBlock: "10.1.0.0/16",
  provider: "${aws.us-west-2}",
});
const awsVpcPeeringConnectionFoo =
  new aws.vpcPeeringConnection.VpcPeeringConnection(this, "foo_2", {
    peerOwnerId: "${var.peer_owner_id}",
    peerRegion: "us-east-1",
    peerVpcId: awsVpcBar.id,
    vpcId: awsVpcFoo.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsVpcPeeringConnectionFoo.overrideLogicalId("foo");

```

## Argument Reference

\-> **Note:** Modifying the VPC Peering Connection options requires peering to be active. An automatic activation
can be done using the [`autoAccept`](vpc_peering_connection.html#auto_accept) attribute. Alternatively, the VPC Peering
Connection has to be made active manually using other means. See [notes](vpc_peering_connection.html#notes) below for
more information.

The following arguments are supported:

* `peerOwnerId` - (Optional) The AWS account ID of the owner of the peer VPC.
  Defaults to the account ID the [AWS provider][1] is currently connected to.
* `peerVpcId` - (Required) The ID of the VPC with which you are creating the VPC Peering Connection.
* `vpcId` - (Required) The ID of the requester VPC.
* `autoAccept` - (Optional) Accept the peering (both VPCs need to be in the same AWS account and region).
* `peerRegion` - (Optional) The region of the accepter VPC of the VPC Peering Connection. `autoAccept` must be `false`,
  and use the `awsVpcPeeringConnectionAccepter` to manage the accepter side.
* `accepter` (Optional) - An optional configuration block that allows for [VPC Peering Connection](https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html) options to be set for the VPC that accepts
  the peering connection (a maximum of one).
* `requester` (Optional) - A optional configuration block that allows for [VPC Peering Connection](https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html) options to be set for the VPC that requests
  the peering connection (a maximum of one).
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

#### Accepter and Requester Arguments

\-> **Note:** When enabled, the DNS resolution feature requires that VPCs participating in the peering
must have support for the DNS hostnames enabled. This can be done using the [`enableDnsHostnames`](vpc.html#enable_dns_hostnames) attribute in the [`awsVpc`](vpc.html) resource. See [Using DNS with Your VPC](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-dns.html) user guide for more information.

* `allowRemoteVpcDnsResolution` - (Optional) Allow a local VPC to resolve public DNS hostnames to
  private IP addresses when queried from instances in the peer VPC.
* `allowClassicLinkToRemoteVpc` - (Optional) Allow a local linked EC2-Classic instance to communicate
  with instances in a peer VPC. This enables an outbound communication from the local ClassicLink connection
  to the remote VPC.
* `allowVpcToRemoteClassicLink` - (Optional) Allow a local VPC to communicate with a linked EC2-Classic
  instance in a peer VPC. This enables an outbound communication from the local VPC to the remote ClassicLink
  connection.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ID of the VPC Peering Connection.
* `acceptStatus` - The status of the VPC Peering Connection request.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Notes

If both VPCs are not in the same AWS account and region do not enable the `autoAccept` attribute.
The accepter can manage its side of the connection using the `awsVpcPeeringConnectionAccepter` resource
or accept the connection manually using the AWS Management Console, AWS CLI, through SDKs, etc.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `1M`)
* `update` - (Default `1M`)
* `delete` - (Default `1M`)

## Import

VPC Peering resources can be imported using the `vpcPeeringId`, e.g.,

```sh
$ terraform import aws_vpc_peering_connection.test_connection pcx-111aaa111
```

[1]: /docs/providers/aws/index.html
