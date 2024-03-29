---
subcategory: "Redshift Serverless"
layout: "aws"
page_title: "AWS: aws_redshiftserverless_endpoint_access"
description: |-
  Provides a Redshift Serverless Endpoint Access resource.
---

# Resource: awsRedshiftserverlessEndpointAccess

Creates a new Amazon Redshift Serverless Endpoint Access.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.redshiftserverlessEndpointAccess.RedshiftserverlessEndpointAccess(
  this,
  "example",
  {
    endpointName: "example",
    workgroupName: "example",
  }
);

```

## Argument Reference

The following arguments are supported:

* `endpointName` - (Required) The name of the endpoint.
* `subnetIds` - (Required) An array of VPC subnet IDs to associate with the endpoint.
* `vpcSecurityGroupIds` - (Optional) An array of security group IDs to associate with the workgroup.
* `workgroupName` - (Required) The name of the workgroup.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the Redshift Serverless Endpoint Access.
* `id` - The Redshift Endpoint Access Name.
* `address` - The DNS address of the VPC endpoint.
* `port` - The port that Amazon Redshift Serverless listens on.
* `vpcEndpoint` - The VPC endpoint or the Redshift Serverless workgroup. See `vpcEndpoint` below.

#### VPC Endpoint

* `vpcEndpointId` - The DNS address of the VPC endpoint.
* `vpcId` - The port that Amazon Redshift Serverless listens on.
* `networkInterface` - The network interfaces of the endpoint.. See `networkInterface` below.

##### Network Interface

* `availabilityZone` - The availability Zone.
* `networkInterfaceId` - The unique identifier of the network interface.
* `privateIpAddress` - The IPv4 address of the network interface within the subnet.
* `subnetId` - The unique identifier of the subnet.

## Import

Redshift Serverless Endpoint Access can be imported using the `endpointName`, e.g.,

```console
$ terraform import aws_redshiftserverless_endpoint_access.example example
```
