---
subcategory: "ELB (Elastic Load Balancing)"
layout: "aws"
page_title: "AWS: aws_lb_listener"
description: |-
  Provides a Load Balancer Listener data source.
---

# Data Source: awsLbListener

\~> **Note:** `awsAlbListener` is known as `awsLbListener`. The functionality is identical.

Provides information about a Load Balancer Listener.

This data source can prove useful when a module accepts an LB Listener as an input variable and needs to know the LB it is attached to, or other information specific to the listener in question.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
/*Terraform Variables are not always the best fit for getting inputs in the context of Terraform CDK.
You can read more about this at https://cdk.tf/variables*/
const listenerArn = new cdktf.TerraformVariable(this, "listener_arn", {});
const dataAwsLbSelected = new aws.dataAwsLb.DataAwsLb(this, "selected", {
  name: "default-public",
});
new aws.dataAwsLbListener.DataAwsLbListener(this, "listener", {
  arn: listenerArn.value,
});
new aws.dataAwsLbListener.DataAwsLbListener(this, "selected443", {
  loadBalancerArn: dataAwsLbSelected.arn,
  port: 443,
});

```

## Argument Reference

The following arguments are supported:

* `arn` - (Optional) ARN of the listener. Required if `loadBalancerArn` and `port` is not set.
* `loadBalancerArn` - (Optional) ARN of the load balancer. Required if `arn` is not set.
* `port` - (Optional) Port of the listener. Required if `arn` is not set.

## Attributes Reference

See the [LB Listener Resource](/docs/providers/aws/r/lb_listener.html) for details on the returned attributes - they are identical.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `read` - (Default `20M`)
