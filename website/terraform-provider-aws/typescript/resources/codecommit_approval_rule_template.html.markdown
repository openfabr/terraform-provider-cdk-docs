---
subcategory: "CodeCommit"
layout: "aws"
page_title: "AWS: aws_codecommit_approval_rule_template"
description: |-
  Provides a CodeCommit Approval Rule Template Resource.
---

# Resource: awsCodecommitApprovalRuleTemplate

Provides a CodeCommit Approval Rule Template Resource.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.codecommitApprovalRuleTemplate.CodecommitApprovalRuleTemplate(
  this,
  "example",
  {
    content:
      '${jsonencode({\n    Version               = "2018-11-08"\n    DestinationReferences = ["refs/heads/master"]\n    Statements = [{\n      Type                    = "Approvers"\n      NumberOfApprovalsNeeded = 2\n      ApprovalPoolMembers     = ["arn:aws:sts::123456789012:assumed-role/CodeCommitReview/*"]\n    }]\n  })}',
    description: "This is an example approval rule template",
    name: "MyExampleApprovalRuleTemplate",
  }
);

```

## Argument Reference

The following arguments are supported:

* `content` - (Required) The content of the approval rule template. Maximum of 3000 characters.
* `name` - (Required) The name for the approval rule template. Maximum of 100 characters.
* `description` - (Optional) The description of the approval rule template. Maximum of 1000 characters.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `approvalRuleTemplateId` - The ID of the approval rule template
* `creationDate` - The date the approval rule template was created, in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8).
* `lastModifiedDate` - The date the approval rule template was most recently changed, in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8).
* `lastModifiedUser` - The Amazon Resource Name (ARN) of the user who made the most recent changes to the approval rule template.
* `ruleContentSha256` - The SHA-256 hash signature for the content of the approval rule template.

## Import

CodeCommit approval rule templates can be imported using the `name`, e.g.

```console
$ terraform import aws_codecommit_approval_rule_template.imported ExistingApprovalRuleTemplateName
```
