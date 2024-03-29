---
subcategory: "VPC (Virtual Private Cloud)"
layout: "aws"
page_title: "AWS: aws_route"
description: |-
    Provides details about a specific Route
---

# Data Source: awsRoute

`awsRoute` provides details about a specific Route.

This resource can prove useful when finding the resource associated with a CIDR. For example, finding the peering connection associated with a CIDR value.

## Example Usage

The following example shows how one might use a CIDR value to find a network interface id and use this to create a data source of that network interface.

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
/*Terraform Variables are not always the best fit for getting inputs in the context of Terraform CDK.
You can read more about this at https://cdk.tf/variables*/
const subnetId = new cdktf.TerraformVariable(this, "subnet_id", {});
const dataAwsRouteRoute = new aws.dataAwsRoute.DataAwsRoute(this, "route", {
  destinationCidrBlock: "10.0.1.0/24",
  routeTableId: "${aws_route_table.selected.id}",
});
new aws.dataAwsRouteTable.DataAwsRouteTable(this, "selected", {
  subnetId: subnetId.value,
});
new aws.dataAwsNetworkInterface.DataAwsNetworkInterface(this, "interface", {
  id: dataAwsRouteRoute.networkInterfaceId,
});

```

## Argument Reference

The arguments of this data source act as filters for querying the available Route in the current region. The given filters must match exactly oneRoute whose data will be exported as attributes.

The following arguments are required:

* `routeTableId` - (Required) ID of the specific Route Table containing the Route entry.

The following arguments are optional:

* `carrierGatewayId` - (Optional) EC2 Carrier Gateway ID of the Route belonging to the Route Table.
* `coreNetworkArn` - (Optional) Core network ARN of the Route belonging to the Route Table.
* `destinationCidrBlock` - (Optional) CIDR block of the Route belonging to the Route Table.
* `destinationIpv6CidrBlock` - (Optional) IPv6 CIDR block of the Route belonging to the Route Table.
* `destinationPrefixListId` - (Optional) ID of a [managed prefix list](ec2_managed_prefix_list.html) destination of the Route belonging to the Route Table.
* `egressOnlyGatewayId` - (Optional) Egress Only Gateway ID of the Route belonging to the Route Table.
* `gatewayId` - (Optional) Gateway ID of the Route belonging to the Route Table.
* `instanceId` - (Optional) Instance ID of the Route belonging to the Route Table.
* `localGatewayId` - (Optional) Local Gateway ID of the Route belonging to the Route Table.
* `natGatewayId` - (Optional) NAT Gateway ID of the Route belonging to the Route Table.
* `networkInterfaceId` - (Optional) Network Interface ID of the Route belonging to the Route Table.
* `transitGatewayId` - (Optional) EC2 Transit Gateway ID of the Route belonging to the Route Table.
* `vpcPeeringConnectionId` - (Optional) VPC Peering Connection ID of the Route belonging to the Route Table.

## Attributes Reference

All of the argument attributes are also exported as result attributes when there is data available. For example, the `vpcPeeringConnectionId` field will be empty when the route is attached to a Network Interface.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `read` - (Default `20M`)
