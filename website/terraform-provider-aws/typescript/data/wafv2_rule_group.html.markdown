---
subcategory: "WAF"
layout: "aws"
page_title: "AWS: aws_wafv2_rule_group"
description: |-
  Retrieves the summary of a WAFv2 Rule Group.
---

# Data Source: awsWafv2RuleGroup

Retrieves the summary of a WAFv2 Rule Group.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsWafv2RuleGroup.DataAwsWafv2RuleGroup(this, "example", {
  name: "some-rule-group",
  scope: "REGIONAL",
});

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) Name of the WAFv2 Rule Group.
* `scope` - (Required) Specifies whether this is for an AWS CloudFront distribution or for a regional application. Valid values are `cloudfront` or `regional`. To work with CloudFront, you must also specify the region `usEast1` (N. Virginia) on the AWS provider.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the entity.
* `description` - Description of the rule group that helps with identification.
* `id` - Unique identifier of the rule group.
