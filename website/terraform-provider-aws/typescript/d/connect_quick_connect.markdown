---
subcategory: "Connect"
layout: "aws"
page_title: "AWS: aws_connect_quick_connect"
description: |-
  Provides details about a specific Amazon Connect Quick Connect.
---

# Data Source: aws\_connect\_quick\_connect

Provides details about a specific Amazon Connect Quick Connect.

## Example Usage

By `name`

```hcl
data "aws_connect_quick_connect" "example" {
  instance_id = "aaaaaaaa-bbbb-cccc-dddd-111111111111"
  name        = "Example"
}
```

By `quickConnectId`

```hcl
data "aws_connect_quick_connect" "example" {
  instance_id      = "aaaaaaaa-bbbb-cccc-dddd-111111111111"
  quick_connect_id = "cccccccc-bbbb-cccc-dddd-111111111111"
}
```

## Argument Reference

\~> **NOTE:** `instanceId` and one of either `name` or `quickConnectId` is required.

The following arguments are supported:

* `quickConnectId` - (Optional) Returns information on a specific Quick Connect by Quick Connect id
* `instanceId` - (Required) Reference to the hosting Amazon Connect Instance
* `name` - (Optional) Returns information on a specific Quick Connect by name

## Attributes Reference

In addition to all of the arguments above, the following attributes are exported:

* `arn` - ARN of the Quick Connect.
* `description` - Description of the Quick Connect.
* `id` - Identifier of the hosting Amazon Connect Instance and identifier of the Quick Connect separated by a colon (`:`).
* `quickConnectConfig` - A block that defines the configuration information for the Quick Connect: `quickConnectType` and one of `phoneConfig`, `queueConfig`, `userConfig` . The Quick Connect Config block is documented below.
* `quickConnectId` - Identifier for the Quick Connect.
* `tags` - Map of tags to assign to the Quick Connect.

A `quickConnectConfig` block contains the following arguments:

* `quickConnectType` - Configuration type of the Quick Connect. Valid values are `phoneNumber`, `queue`, `user`.
* `phoneConfig` - Phone configuration of the Quick Connect. This is returned only if `quickConnectType` is `phoneNumber`. The `phoneConfig` block is documented below.
* `queueConfig` - Queue configuration of the Quick Connect. This is returned only if `quickConnectType` is `queue`. The `queueConfig` block is documented below.
* `userConfig` - User configuration of the Quick Connect. This is returned only if `quickConnectType` is `user`. The `userConfig` block is documented below.

A `phoneConfig` block contains the following arguments:

* `phoneNumber` - Phone number in in E.164 format.

A `queueConfig` block contains the following arguments:

* `contactFlowId` - Identifier of the contact flow.
* `queueId` - Identifier for the queue.

A `userConfig` block contains the following arguments:

* `contactFlowId` - Identifier of the contact flow.
* `userId` - Identifier for the user.
