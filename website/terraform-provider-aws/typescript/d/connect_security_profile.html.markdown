---
subcategory: "Connect"
layout: "aws"
page_title: "AWS: aws_connect_security_profile"
description: |-
  Provides details about a specific Amazon Connect Security Profile.
---

# Data Source: aws\_connect\_security\_profile

Provides details about a specific Amazon Connect Security Profile.

## Example Usage

By `name`

```hcl
data "aws_connect_security_profile" "example" {
  instance_id = "aaaaaaaa-bbbb-cccc-dddd-111111111111"
  name        = "Example"
}
```

By `securityProfileId`

```hcl
data "aws_connect_security_profile" "example" {
  instance_id         = "aaaaaaaa-bbbb-cccc-dddd-111111111111"
  security_profile_id = "cccccccc-bbbb-cccc-dddd-111111111111"
}
```

## Argument Reference

\~> **NOTE:** `instanceId` and one of either `name` or `securityProfileId` is required.

The following arguments are supported:

* `securityProfileId` - (Optional) Returns information on a specific Security Profile by Security Profile id
* `instanceId` - (Required) Reference to the hosting Amazon Connect Instance
* `name` - (Optional) Returns information on a specific Security Profile by name

## Attributes Reference

In addition to all of the arguments above, the following attributes are exported:

* `arn` - ARN of the Security Profile.
* `description` - Description of the Security Profile.
* `id` - Identifier of the hosting Amazon Connect Instance and identifier of the Security Profile separated by a colon (`:`).
* `organizationResourceId` - The organization resource identifier for the security profile.
* `permissions` - List of permissions assigned to the security profile.
* `tags` - Map of tags to assign to the Security Profile.
