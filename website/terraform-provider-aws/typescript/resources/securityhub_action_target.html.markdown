---
subcategory: "Security Hub"
layout: "aws"
page_title: "AWS: aws_securityhub_action_target"
description: |-
  Creates Security Hub custom action.
---

# Resource: awsSecurityhubActionTarget

Creates Security Hub custom action.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsSecurityhubAccountExample =
  new aws.securityhubAccount.SecurityhubAccount(this, "example", {});
const awsSecurityhubActionTargetExample =
  new aws.securityhubActionTarget.SecurityhubActionTarget(this, "example_1", {
    depends_on: [`\${${awsSecurityhubAccountExample.fqn}}`],
    description: "This is custom action sends selected findings to chat",
    identifier: "SendToChat",
    name: "Send notification to chat",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsSecurityhubActionTargetExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The description for the custom action target.
* `identifier` - (Required) The ID for the custom action target.
* `description` - (Required) The name of the custom action target.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the Security Hub custom action target.

## Import

Security Hub custom action can be imported using the action target ARN e.g.,

```sh
$ terraform import aws_securityhub_action_target.example arn:aws:securityhub:eu-west-1:312940875350:action/custom/a
```
