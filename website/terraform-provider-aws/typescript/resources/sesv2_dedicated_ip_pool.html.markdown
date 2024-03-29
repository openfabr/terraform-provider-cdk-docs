---
subcategory: "SESv2 (Simple Email V2)"
layout: "aws"
page_title: "AWS: aws_sesv2_dedicated_ip_pool"
description: |-
  Terraform resource for managing an AWS SESv2 (Simple Email V2) Dedicated IP Pool.
---

# Resource: awsSesv2DedicatedIpPool

Terraform resource for managing an AWS SESv2 (Simple Email V2) Dedicated IP Pool.

## Example Usage

### Basic Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.sesv2DedicatedIpPool.Sesv2DedicatedIpPool(this, "example", {
  poolName: "my-pool",
});

```

### Managed Pool

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.sesv2DedicatedIpPool.Sesv2DedicatedIpPool(this, "example", {
  poolName: "my-managed-pool",
  scalingMode: "MANAGED",
});

```

## Argument Reference

The following arguments are required:

* `poolName` - (Required) Name of the dedicated IP pool.

The following arguments are optional:

* `scalingMode` - (Optional) IP pool scaling mode. Valid values: `standard`, `managed`. If omitted, the AWS API will default to a standard pool.
* `tags` - (Optional) A map of tags to assign to the pool. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the Dedicated IP Pool.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `30M`)
* `update` - (Default `30M`)
* `delete` - (Default `30M`)

## Import

SESv2 (Simple Email V2) Dedicated IP Pool can be imported using the `poolName`, e.g.,

```console
$ terraform import aws_sesv2_dedicated_ip_pool.example my-pool
```
