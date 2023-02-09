---
subcategory: "Connect"
layout: "aws"
page_title: "AWS: aws_connect_user_hierarchy_structure"
description: |-
  Provides details about a specific Amazon Connect User Hierarchy Structure
---

# Data Source: aws\_connect\_user\_hierarchy\_structure

Provides details about a specific Amazon Connect User Hierarchy Structure

## Example Usage

```hcl
data "aws_connect_user_hierarchy_structure" "test" {
  instance_id = aws_connect_instance.test.id
}
```

## Argument Reference

The following arguments are supported:

* `instanceId` - (Required) Reference to the hosting Amazon Connect Instance

## Attributes Reference

In addition to all of the argument above, the following attributes are exported:

* `hierarchyStructure` - Block that defines the hierarchy structure's levels. The `hierarchyStructure` block is documented below.

A `hierarchyStructure` block supports the following attributes:

* `levelOne` - Details of level one. See below.
* `levelTwo` - Details of level two. See below.
* `levelThree` - Details of level three. See below.
* `levelFour` - Details of level four. See below.
* `levelFive` - Details of level five. See below.

Each level block supports the following attributes:

* `arn` -  ARN of the hierarchy level.
* `id` -  The identifier of the hierarchy level.
* `name` - Name of the user hierarchy level. Must not be more than 50 characters.
