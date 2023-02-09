---
subcategory: "Connect"
layout: "aws"
page_title: "AWS: aws_connect_prompt"
description: |-
  Provides details about a specific Amazon Connect Prompt.
---

# Data Source: aws\_connect\_prompt

Provides details about a specific Amazon Connect Prompt.

## Example Usage

By `name`

```hcl
data "aws_connect_prompt" "example" {
  instance_id = "aaaaaaaa-bbbb-cccc-dddd-111111111111"
  name        = "Beep.wav"
}
```

## Argument Reference

The following arguments are supported:

* `instanceId` - (Required) Reference to the hosting Amazon Connect Instance
* `name` - (Required) Returns information on a specific Prompt by name

## Attributes Reference

In addition to all of the arguments above, the following attributes are exported:

* `arn` - ARN of the Prompt.
* `promptId` - Identifier for the prompt.
