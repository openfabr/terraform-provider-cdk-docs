---
subcategory: "Route 53"
layout: "aws"
page_title: "AWS: aws_route53_delegation_set"
description: |-
  Provides a Route53 Delegation Set resource.
---

# Resource: awsRoute53DelegationSet

Provides a [Route53 Delegation Set](https://docs.aws.amazon.com/Route53/latest/APIReference/API-actions-by-function.html#actions-by-function-reusable-delegation-sets) resource.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsRoute53DelegationSetMain =
  new aws.route53DelegationSet.Route53DelegationSet(this, "main", {
    referenceName: "DynDNS",
  });
new aws.route53Zone.Route53Zone(this, "primary", {
  delegationSetId: awsRoute53DelegationSetMain.id,
  name: "hashicorp.com",
});
new aws.route53Zone.Route53Zone(this, "secondary", {
  delegationSetId: awsRoute53DelegationSetMain.id,
  name: "terraform.io",
});

```

## Argument Reference

The following arguments are supported:

* `referenceName` - (Optional) This is a reference name used in Caller Reference
  (helpful for identifying single delegation set amongst others)

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The Amazon Resource Name (ARN) of the Delegation Set.
* `id` - The delegation set ID
* `nameServers` - A list of authoritative name servers for the hosted zone
  (effectively a list of NS records).

## Import

Route53 Delegation Sets can be imported using the `delegationSetId`, e.g.,

```console
$ terraform import aws_route53_delegation_set.set1 N1PA6795SAMPLE
```
