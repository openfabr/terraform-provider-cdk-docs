---
subcategory: "ElastiCache"
layout: "aws"
page_title: "AWS: aws_elasticache_user"
description: |-
  Get information on an ElastiCache User resource.
---

# Data Source: aws\_elasticache\_user

Use this data source to get information about an ElastiCache User.

## Example Usage

```hcl
data "aws_elasticache_user" "bar" {
  user_id = "example"
}
```

## Argument Reference

The following arguments are supported:

* `userId` – (Required) Identifier for the user.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `userId` - Identifier for the user.
* `userName` - User name of the user.
* `accessString` - String for what access a user possesses within the associated ElastiCache replication groups or clusters.
