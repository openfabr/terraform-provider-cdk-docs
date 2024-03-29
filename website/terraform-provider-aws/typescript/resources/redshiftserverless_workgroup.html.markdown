---
subcategory: "Redshift Serverless"
layout: "aws"
page_title: "AWS: aws_redshiftserverless_workgroup"
description: |-
  Provides a Redshift Serverless Workgroup resource.
---

# Resource: awsRedshiftserverlessWorkgroup

Creates a new Amazon Redshift Serverless Workgroup.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.redshiftserverlessWorkgroup.RedshiftserverlessWorkgroup(
  this,
  "example",
  {
    namespaceName: "concurrency-scaling",
    workgroupName: "concurrency-scaling",
  }
);

```

## Argument Reference

The following arguments are required:

* `namespaceName` - (Required) The name of the namespace.
* `workgroupName` - (Required) The name of the workgroup.

The following arguments are optional:

* `baseCapacity` - (Optional) The base data warehouse capacity of the workgroup in Redshift Processing Units (RPUs).
* `configParameter` - (Optional) An array of parameters to set for more control over a serverless database. See `configParameter` below.
* `enhancedVpcRouting` - (Optional) The value that specifies whether to turn on enhanced virtual private cloud (VPC) routing, which forces Amazon Redshift Serverless to route traffic through your VPC instead of over the internet.
* `publiclyAccessible` - (Optional) A value that specifies whether the workgroup can be accessed from a public network.
* `securityGroupIds` - (Optional) An array of security group IDs to associate with the workgroup.
* `subnetIds` - (Optional) An array of VPC subnet IDs to associate with the workgroup. When set, must contain at least three subnets spanning three Availability Zones. A minimum number of IP addresses is required and scales with the Base Capacity. For more information, see the following [AWS document](https://docs.aws.amazon.com/redshift/latest/mgmt/serverless-known-issues.html).
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### Config Parameter

* `parameterKey` - (Required) The key of the parameter. The options are `datestyle`, `enableUserActivityLogging`, `queryGroup`, `searchPath`, and `maxQueryExecutionTime`.
* `parameterValue` - (Required) The value of the parameter to set.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the Redshift Serverless Workgroup.
* `id` - The Redshift Workgroup Name.
* `workgroupId` - The Redshift Workgroup ID.
* `endpoint` - The endpoint that is created from the workgroup. See `endpoint` below.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

### Endpoint

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

Redshift Serverless Workgroups can be imported using the `workgroupName`, e.g.,

```console
$ terraform import aws_redshiftserverless_workgroup.example example
```
