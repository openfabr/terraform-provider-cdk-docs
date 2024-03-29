---
subcategory: "Auto Scaling"
layout: "aws"
page_title: "AWS: aws_autoscaling_group"
description: |-
  Get information on an Amazon EC2 Autoscaling Group.
---

# Data Source: awsAutoscalingGroup

Use this data source to get information on an existing autoscaling group.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsAutoscalingGroup.DataAwsAutoscalingGroup(this, "foo", {
  name: "foo",
});

```

## Argument Reference

* `name` - Specify the exact name of the desired autoscaling group.

## Attributes Reference

\~> **NOTE:** Some values are not always set and may not be available for
interpolation.

* `arn` - ARN of the Auto Scaling group.
* `availabilityZones` - One or more Availability Zones for the group.
* `defaultCoolDown` - Amount of time, in seconds, after a scaling activity completes before another scaling activity can start.
* `desiredCapacity` - Desired size of the group.
* `desiredCapacityType` - The unit of measurement for the value returned for `desiredCapacity`.
* `enabledMetrics` - List of metrics enabled for collection.
* `healthCheckGracePeriod` - The amount of time, in seconds, that Amazon EC2 Auto Scaling waits before checking the health status of an EC2 instance that has come into service.
* `healthCheckType` - Service to use for the health checks. The valid values are EC2 and ELB.
* `id` - Name of the Auto Scaling Group.
* `launchConfiguration` - The name of the associated launch configuration.
* `loadBalancers` - One or more load balancers associated with the group.
* `maxSize` - Maximum size of the group.
* `minSize` - Minimum size of the group.
* `name` - Name of the Auto Scaling Group.
* `placementGroup` - Name of the placement group into which to launch your instances, if any. For more information, see Placement Groups (http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html) in the Amazon Elastic Compute Cloud User Guide.
* `serviceLinkedRoleArn` - ARN of the service-linked role that the Auto Scaling group uses to call other AWS services on your behalf.
* `status` - Current state of the group when DeleteAutoScalingGroup is in progress.
* `targetGroupArns` - ARNs of the target groups for your load balancer.
* `terminationPolicies` - The termination policies for the group.
* `vpcZoneIdentifier` - VPC ID for the group.
