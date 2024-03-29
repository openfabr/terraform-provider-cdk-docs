---
subcategory: "WAF Classic Regional"
layout: "aws"
page_title: "AWS: aws_wafregional_web_acl"
description: |-
  Retrieves a WAF Regional Web ACL id.
---

# Data Source: awsWafregionalWebAcl

`awsWafregionalWebAcl` Retrieves a WAF Regional Web ACL Resource Id.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsWafregionalWebAcl.DataAwsWafregionalWebAcl(this, "example", {
  name: "tfWAFRegionalWebACL",
});

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) Name of the WAF Regional Web ACL.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - ID of the WAF Regional Web ACL.
