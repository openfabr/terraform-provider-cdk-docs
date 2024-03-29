---
subcategory: "DataSync"
layout: "aws"
page_title: "AWS: aws_datasync_agent"
description: |-
  Manages an AWS DataSync Agent in the provider region
---

# Resource: awsDatasyncAgent

Manages an AWS DataSync Agent deployed on premises.

\~> **NOTE:** One of `activationKey` or `ipAddress` must be provided for resource creation (agent activation). Neither is required for resource import. If using `ipAddress`, Terraform must be able to make an HTTP (port 80) GET request to the specified IP address from where it is running. The agent will turn off that HTTP server after activation.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.datasyncAgent.DatasyncAgent(this, "example", {
  ipAddress: "1.2.3.4",
  name: "example",
});

```

## Example Usage with VPC Endpoints

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsRegionCurrent = new aws.dataAwsRegion.DataAwsRegion(
  this,
  "current",
  {}
);
const awsVpcEndpointExample = new aws.vpcEndpoint.VpcEndpoint(this, "example", {
  securityGroupIds: ["${aws_security_group.example.id}"],
  serviceName: `com.amazonaws.\${${dataAwsRegionCurrent.name}}.datasync`,
  subnetIds: ["${aws_subnet.example.id}"],
  vpcEndpointType: "Interface",
  vpcId: "${aws_vpc.example.id}",
});
const dataAwsNetworkInterfaceExample =
  new aws.dataAwsNetworkInterface.DataAwsNetworkInterface(this, "example_2", {
    id: `\${tolist(${awsVpcEndpointExample.networkInterfaceIds})[0]}`,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAwsNetworkInterfaceExample.overrideLogicalId("example");
const awsDatasyncAgentExample = new aws.datasyncAgent.DatasyncAgent(
  this,
  "example_3",
  {
    ipAddress: "1.2.3.4",
    name: "example",
    privateLinkEndpoint: dataAwsNetworkInterfaceExample.privateIp,
    securityGroupArns: ["${aws_security_group.example.arn}"],
    subnetArns: ["${aws_subnet.example.arn}"],
    vpcEndpointId: awsVpcEndpointExample.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsDatasyncAgentExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) Name of the DataSync Agent.
* `activationKey` - (Optional) DataSync Agent activation key during resource creation. Conflicts with `ipAddress`. If an `ipAddress` is provided instead, Terraform will retrieve the `activationKey` as part of the resource creation.
* `ipAddress` - (Optional) DataSync Agent IP address to retrieve activation key during resource creation. Conflicts with `activationKey`. DataSync Agent must be accessible on port 80 from where Terraform is running.
* `privateLinkEndpoint` - (Optional) The IP address of the VPC endpoint the agent should connect to when retrieving an activation key during resource creation. Conflicts with `activationKey`.
* `securityGroupArns` - (Optional) The ARNs of the security groups used to protect your data transfer task subnets.
* `subnetArns` - (Optional) The Amazon Resource Names (ARNs) of the subnets in which DataSync will create elastic network interfaces for each data transfer task.
* `tags` - (Optional) Key-value pairs of resource tags to assign to the DataSync Agent. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `vpcEndpointId` - (Optional) The ID of the VPC (virtual private cloud) endpoint that the agent has access to.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Amazon Resource Name (ARN) of the DataSync Agent.
* `arn` - Amazon Resource Name (ARN) of the DataSync Agent.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `10M`)

## Import

`awsDatasyncAgent` can be imported by using the DataSync Agent Amazon Resource Name (ARN), e.g.,

```console
$ terraform import aws_datasync_agent.example arn:aws:datasync:us-east-1:123456789012:agent/agent-12345678901234567
```
