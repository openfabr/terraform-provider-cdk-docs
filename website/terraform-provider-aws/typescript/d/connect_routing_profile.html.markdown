---
subcategory: "Connect"
layout: "aws"
page_title: "AWS: aws_connect_routing_profile"
description: |-
  Provides details about a specific Amazon Connect Routing Profile.
---

# Data Source: aws\_connect\_routing\_profile

Provides details about a specific Amazon Connect Routing Profile.

## Example Usage

By `name`

```hcl
data "aws_connect_routing_profile" "example" {
  instance_id = "aaaaaaaa-bbbb-cccc-dddd-111111111111"
  name        = "Example"
}
```

By `routingProfileId`

```hcl
data "aws_connect_routing_profile" "example" {
  instance_id        = "aaaaaaaa-bbbb-cccc-dddd-111111111111"
  routing_profile_id = "cccccccc-bbbb-cccc-dddd-111111111111"
}
```

## Argument Reference

\~> **NOTE:** `instanceId` and one of either `name` or `routingProfileId` is required.

The following arguments are supported:

* `instanceId` - Reference to the hosting Amazon Connect Instance
* `name` - (Optional) Returns information on a specific Routing Profile by name
* `routingProfileId` - (Optional) Returns information on a specific Routing Profile by Routing Profile id

## Attributes Reference

In addition to all of the arguments above, the following attributes are exported:

* `arn` - ARN of the Routing Profile.
* `defaultOutboundQueueId` - Specifies the default outbound queue for the Routing Profile.
* `description` - Description of the Routing Profile.
* `id` - Identifier of the hosting Amazon Connect Instance and identifier of the Routing Profile separated by a colon (`:`).
* `mediaConcurrencies` - One or more `mediaConcurrencies` blocks that specify the channels that agents can handle in the Contact Control Panel (CCP) for this Routing Profile. The `mediaConcurrencies` block is documented below.
* `queueConfigs` - One or more `queueConfigs` blocks that specify the inbound queues associated with the routing profile. If no queue is added, the agent only can make outbound calls. The `queueConfigs` block is documented below.
* `tags` - Map of tags to assign to the Routing Profile.

A `mediaConcurrencies` block supports the following attributes:

* `channel` - Channels that agents can handle in the Contact Control Panel (CCP). Valid values are `voice`, `chat`, `task`.
* `concurrency` - Number of contacts an agent can have on a channel simultaneously. Valid Range for `voice`: Minimum value of 1. Maximum value of 1. Valid Range for `chat`: Minimum value of 1. Maximum value of 10. Valid Range for `task`: Minimum value of 1. Maximum value of 10.

A `queueConfigs` block supports the following attributes:

* `channel` - Channels agents can handle in the Contact Control Panel (CCP) for this routing profile. Valid values are `voice`, `chat`, `task`.
* `delay` - Delay, in seconds, that a contact should be in the queue before they are routed to an available agent
* `priority` - Order in which contacts are to be handled for the queue.
* `queueArn` - ARN for the queue.
* `queueId` - Identifier for the queue.
* `queueName` - Name for the queue.
