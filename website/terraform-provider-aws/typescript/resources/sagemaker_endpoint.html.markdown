---
subcategory: "SageMaker"
layout: "aws"
page_title: "AWS: aws_sagemaker_endpoint"
description: |-
  Provides a SageMaker Endpoint resource.
---

# Resource: awsSagemakerEndpoint

Provides a SageMaker Endpoint resource.

## Example Usage

Basic usage:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.sagemakerEndpoint.SagemakerEndpoint(this, "e", {
  endpointConfigName: "${aws_sagemaker_endpoint_configuration.ec.name}",
  name: "my-endpoint",
  tags: {
    Name: "foo",
  },
});

```

## Argument Reference

The following arguments are supported:

* `endpointConfigName` - (Required) The name of the endpoint configuration to use.
* `deploymentConfig` - (Optional) The deployment configuration for an endpoint, which contains the desired deployment strategy and rollback configurations. See [Deployment Config](#deployment-config).
* `name` - (Optional) The name of the endpoint. If omitted, Terraform will assign a random, unique name.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### Deployment Config

* `blueGreenUpdatePolicy` - (Required) Update policy for a blue/green deployment. If this update policy is specified, SageMaker creates a new fleet during the deployment while maintaining the old fleet. See [Blue Green Update Config](#blue-green-update-config).
* `autoRollbackConfiguration` - (Optional) Automatic rollback configuration for handling endpoint deployment failures and recovery. See [Auto Rollback Configuration](#auto-rollback-configuration).

#### Blue Green Update Config

* `trafficRoutingConfiguration` - (Required) Defines the traffic routing strategy to shift traffic from the old fleet to the new fleet during an endpoint deployment. See [Traffic Routing Configuration](#traffic-routing-configuration).
* `maximumExecutionTimeoutInSeconds` - (Optional) Maximum execution timeout for the deployment. Note that the timeout value should be larger than the total waiting time specified in `terminationWaitInSeconds` and `waitIntervalInSeconds`. Valid values are between `600` and `14400`.
* `terminationWaitInSeconds` - (Optional) Additional waiting time in seconds after the completion of an endpoint deployment before terminating the old endpoint fleet. Default is `0`. Valid values are between `0` and `3600`.

##### Traffic Routing Configuration

* `type` - (Required) Traffic routing strategy type. Valid values are: `ALL_AT_ONCE`, `canary`, and `linear`.
* `waitIntervalInSeconds` - (Required) The waiting time (in seconds) between incremental steps to turn on traffic on the new endpoint fleet. Valid values are between `0` and `3600`.
* `canarySize` - (Optional) Batch size for the first step to turn on traffic on the new endpoint fleet. Value must be less than or equal to 50% of the variant's total instance count. See [Canary Size](#canary-size).
* `linearStepSize` - (Optional) Batch size for each step to turn on traffic on the new endpoint fleet. Value must be 10-50% of the variant's total instance count. See [Linear Step Size](#linear-step-size).

###### Canary Size

* `type` - (Required) Specifies the endpoint capacity type. Valid values are: `INSTANCE_COUNT`, or `CAPACITY_PERCENT`.
* `value` - (Required) Defines the capacity size, either as a number of instances or a capacity percentage.

###### Linear Step Size

* `type` - (Required) Specifies the endpoint capacity type. Valid values are: `INSTANCE_COUNT`, or `CAPACITY_PERCENT`.
* `value` - (Required) Defines the capacity size, either as a number of instances or a capacity percentage.

#### Auto Rollback Configuration

* `alarms` - (Required) List of CloudWatch alarms in your account that are configured to monitor metrics on an endpoint. If any alarms are tripped during a deployment, SageMaker rolls back the deployment. See [Alarms](#alarms).

##### Alarms

* `alarmName` - (Required) The name of a CloudWatch alarm in your account.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The Amazon Resource Name (ARN) assigned by AWS to this endpoint.
* `name` - The name of the endpoint.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Endpoints can be imported using the `name`, e.g.,

```console
$ terraform import aws_sagemaker_endpoint.test_endpoint my-endpoint
```
