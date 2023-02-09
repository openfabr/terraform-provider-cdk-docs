---
subcategory: "Connect"
layout: "aws"
page_title: "AWS: aws_connect_hours_of_operation"
description: |-
  Provides details about a specific Amazon Connect Hours of Operation.
---

# Data Source: aws\_connect\_hours\_of\_operation

Provides details about a specific Amazon Connect Hours of Operation.

## Example Usage

By `name`

```hcl
data "aws_connect_hours_of_operation" "test" {
  instance_id = "aaaaaaaa-bbbb-cccc-dddd-111111111111"
  name        = "Test"
}
```

By `hoursOfOperationId`

```hcl
data "aws_connect_hours_of_operation" "test" {
  instance_id           = "aaaaaaaa-bbbb-cccc-dddd-111111111111"
  hours_of_operation_id = "cccccccc-bbbb-cccc-dddd-111111111111"
}
```

## Argument Reference

\~> **NOTE:** `instanceId` and one of either `name` or `hoursOfOperationId` is required.

The following arguments are supported:

* `hoursOfOperationId` - (Optional) Returns information on a specific Hours of Operation by hours of operation id
* `instanceId` - (Required) Reference to the hosting Amazon Connect Instance
* `name` - (Optional) Returns information on a specific Hours of Operation by name

## Attributes Reference

In addition to all of the arguments above, the following attributes are exported:

* `arn` - ARN of the Hours of Operation.
* `config` - Configuration information for the hours of operation: day, start time, and end time . Config blocks are documented below. Config blocks are documented below.
* `description` - Description of the Hours of Operation.
* `hoursOfOperationArn` - (**Deprecated**) ARN of the Hours of Operation.
* `hoursOfOperationId` - The identifier for the hours of operation.
* `instanceId` - Identifier of the hosting Amazon Connect Instance.
* `name` - Name of the Hours of Operation.
* `tags` - Map of tags to assign to the Hours of Operation.
* `timeZone` - Time zone of the Hours of Operation.

A `config` block supports the following arguments:

* `day` - Day that the hours of operation applies to.
* `endTime` - End time block specifies the time that your contact center closes. The `endTime` is documented below.
* `startTime` - Start time block specifies the time that your contact center opens. The `startTime` is documented below.

A `endTime` block supports the following arguments:

* `hours` - Hour of closing.
* `minutes` - Minute of closing.

A `startTime` block supports the following arguments:

* `hours` - Hour of opening.
* `minutes` - Minute of opening.
