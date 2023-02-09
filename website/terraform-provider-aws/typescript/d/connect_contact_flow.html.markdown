---
subcategory: "Connect"
layout: "aws"
page_title: "AWS: aws_connect_contact_flow"
description: |-
  Provides details about a specific Amazon Connect Contact Flow.
---

# Data Source: aws\_connect\_contact\_flow

Provides details about a specific Amazon Connect Contact Flow.

## Example Usage

By name

```hcl
data "aws_connect_contact_flow" "test" {
  instance_id = "aaaaaaaa-bbbb-cccc-dddd-111111111111"
  name        = "Test"
}
```

By contact\_flow\_id

```hcl
data "aws_connect_contact_flow" "test" {
  instance_id     = "aaaaaaaa-bbbb-cccc-dddd-111111111111"
  contact_flow_id = "cccccccc-bbbb-cccc-dddd-111111111111"
}
```

## Argument Reference

\~> **NOTE:** `instanceId` and one of either `name` or `contactFlowId` is required.

The following arguments are supported:

* `contactFlowId` - (Optional) Returns information on a specific Contact Flow by contact flow id
* `instanceId` - (Required) Reference to the hosting Amazon Connect Instance
* `name` - (Optional) Returns information on a specific Contact Flow by name

## Attributes Reference

In addition to all of the arguments above, the following attributes are exported:

* `arn` - ARN of the Contact Flow.
* `content` - Logic of the Contact Flow.
* `description` - Description of the Contact Flow.
* `tags` - Tags to assign to the Contact Flow.
* `type` - Type of Contact Flow.
