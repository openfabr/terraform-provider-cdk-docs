---
subcategory: "Config"
layout: "aws"
page_title: "AWS: aws_config_aggregate_authorization"
description: |-
  Manages an AWS Config Aggregate Authorization.
---

# Resource: awsConfigAggregateAuthorization

Manages an AWS Config Aggregate Authorization

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.configAggregateAuthorization.ConfigAggregateAuthorization(
  this,
  "example",
  {
    accountId: "123456789012",
    region: "eu-west-2",
  }
);

```

## Argument Reference

The following arguments are supported:

* `accountId` - (Required) Account ID
* `region` - (Required) Region
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The ARN of the authorization
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Config aggregate authorizations can be imported using `accountId:region`, e.g.,

```console
$ terraform import aws_config_aggregate_authorization.example 123456789012:us-east-1
```
