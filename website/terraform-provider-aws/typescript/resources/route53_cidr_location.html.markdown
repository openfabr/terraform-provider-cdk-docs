---
subcategory: "Route 53"
layout: "aws"
page_title: "AWS: aws_route53_cidr_location"
description: |-
  Provides a Route53 CIDR location resource.
---

# Resource: awsRoute53CidrLocation

Provides a Route53 CIDR location resource.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsRoute53CidrCollectionExample =
  new aws.route53CidrCollection.Route53CidrCollection(this, "example", {
    name: "collection-1",
  });
const awsRoute53CidrLocationExample =
  new aws.route53CidrLocation.Route53CidrLocation(this, "example_1", {
    cidrBlocks: ["200.5.3.0/24", "200.6.3.0/24"],
    cidrCollectionId: awsRoute53CidrCollectionExample.id,
    name: "office",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsRoute53CidrLocationExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `cidrBlocks` - (Required) CIDR blocks for the location.
* `cidrCollectionId` - (Required) The ID of the CIDR collection to update.
* `name` - (Required) Name for the CIDR location.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The CIDR location ID.

## Import

CIDR locations can be imported using their the CIDR collection ID and location name, e.g.,

```console
$ terraform import aws_route53_cidr_location.example 9ac32814-3e67-0932-6048-8d779cc6f511,office
```
