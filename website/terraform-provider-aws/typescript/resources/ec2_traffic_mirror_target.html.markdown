---
subcategory: "VPC (Virtual Private Cloud)"
layout: "aws"
page_title: "AWS: aws_ec2_traffic_mirror_target"
description: |-
  Provides a Traffic mirror target
---

# Resource: awsEc2TrafficMirrorTarget

Provides a Traffic mirror target.\
Read [limits and considerations](https://docs.aws.amazon.com/vpc/latest/mirroring/traffic-mirroring-considerations.html) for traffic mirroring

## Example Usage

To create a basic traffic mirror session

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.ec2TrafficMirrorTarget.Ec2TrafficMirrorTarget(this, "eni", {
  description: "ENI target",
  networkInterfaceId: "${aws_instance.test.primary_network_interface_id}",
});
new aws.ec2TrafficMirrorTarget.Ec2TrafficMirrorTarget(this, "gwlb", {
  description: "GWLB target",
  gatewayLoadBalancerEndpointId: "${aws_vpc_endpoint.example.id}",
});
new aws.ec2TrafficMirrorTarget.Ec2TrafficMirrorTarget(this, "nlb", {
  description: "NLB target",
  networkLoadBalancerArn: "${aws_lb.lb.arn}",
});

```

## Argument Reference

The following arguments are supported:

* `description` - (Optional, Forces new) A description of the traffic mirror session.
* `networkInterfaceId` - (Optional, Forces new) The network interface ID that is associated with the target.
* `networkLoadBalancerArn` - (Optional, Forces new) The Amazon Resource Name (ARN) of the Network Load Balancer that is associated with the target.
* `gatewayLoadBalancerEndpointId` - (Optional, Forces new) The VPC Endpoint Id of the Gateway Load Balancer that is associated with the target.
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

**NOTE:** Either `networkInterfaceId` or `networkLoadBalancerArn` should be specified and both should not be specified together

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ID of the Traffic Mirror target.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).
* `arn` - The ARN of the traffic mirror target.
* `ownerId` - The ID of the AWS account that owns the traffic mirror target.

## Import

Traffic mirror targets can be imported using the `id`, e.g.,

```console
$ terraform import aws_ec2_traffic_mirror_target.target tmt-0c13a005422b86606
```
