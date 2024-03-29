---
subcategory: "Route 53 Resolver"
layout: "aws"
page_title: "AWS: aws_route53_resolver_rules"
description: |-
    Provides details about a set of Route53 Resolver rules
---

# Data Source: awsRoute53ResolverRules

`awsRoute53ResolverRules` provides details about a set of Route53 Resolver rules.

## Example Usage

### Retrieving the default resolver rule

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsRoute53ResolverRules.DataAwsRoute53ResolverRules(
  this,
  "example",
  {
    ownerId: "Route 53 Resolver",
    ruleType: "RECURSIVE",
    shareStatus: "NOT_SHARED",
  }
);

```

### Retrieving forward rules shared with me

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsRoute53ResolverRules.DataAwsRoute53ResolverRules(
  this,
  "example",
  {
    ruleType: "FORWARD",
    shareStatus: "SHARED_WITH_ME",
  }
);

```

### Retrieving rules by name regex

Resolver rules whose name contains `abc`.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsRoute53ResolverRules.DataAwsRoute53ResolverRules(
  this,
  "example",
  {
    nameRegex: ".*abc.*",
  }
);

```

## Argument Reference

The arguments of this data source act as filters for querying the available resolver rules in the current region.

* `nameRegex` - (Optional) Regex string to filter resolver rule names.
  The filtering is done locally, so could have a performance impact if the result is large.
  This argument should be used along with other arguments to limit the number of results returned.
* `ownerId` (Optional) When the desired resolver rules are shared with another AWS account, the account ID of the account that the rules are shared with.
* `resolverEndpointId` (Optional) ID of the outbound resolver endpoint for the desired resolver rules.
* `ruleType` (Optional) Rule type of the desired resolver rules. Valid values are `forward`, `system` and `recursive`.
* `shareStatus` (Optional) Whether the desired resolver rules are shared and, if so, whether the current account is sharing the rules with another account, or another account is sharing the rules with the current account. Valid values are `NOT_SHARED`, `SHARED_BY_ME` or `SHARED_WITH_ME`

## Attributes Reference

The following attributes are exported:

* `id` - AWS Region.
* `resolverRuleIds` - IDs of the matched resolver rules.
