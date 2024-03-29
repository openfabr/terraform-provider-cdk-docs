---
subcategory: "Web Services Budgets"
layout: "aws"
page_title: "AWS: aws_budgets_budget_action"
description: |-
  Provides a budget action resource.
---

# Resource: awsBudgetsBudgetAction

Provides a budget action resource. Budget actions are cost savings controls that run either automatically on your behalf or by using a workflow approval process.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsBudgetsBudgetExample = new aws.budgetsBudget.BudgetsBudget(
  this,
  "example",
  {
    budgetType: "USAGE",
    limitAmount: "10.0",
    limitUnit: "dollars",
    name: "example",
    timePeriodStart: "2006-01-02_15:04",
    timeUnit: "MONTHLY",
  }
);
const dataAwsIamPolicyDocumentExample =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(this, "example_1", {
    statement: [
      {
        actions: ["ec2:Describe*"],
        effect: "Allow",
        resources: ["*"],
      },
    ],
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAwsIamPolicyDocumentExample.overrideLogicalId("example");
const dataAwsPartitionCurrent = new aws.dataAwsPartition.DataAwsPartition(
  this,
  "current",
  {}
);
const awsIamPolicyExample = new aws.iamPolicy.IamPolicy(this, "example_3", {
  description: "My example policy",
  name: "example",
  policy: dataAwsIamPolicyDocumentExample.json,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamPolicyExample.overrideLogicalId("example");
const dataAwsIamPolicyDocumentAssumeRole =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "assume_role",
    {
      statement: [
        {
          actions: ["sts:AssumeRole"],
          effect: "Allow",
          principals: [
            {
              identifiers: [`budgets.\${${dataAwsPartitionCurrent.dnsSuffix}}`],
              type: "Service",
            },
          ],
        },
      ],
    }
  );
const awsIamRoleExample = new aws.iamRole.IamRole(this, "example_5", {
  assumeRolePolicy: dataAwsIamPolicyDocumentAssumeRole.json,
  name: "example",
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamRoleExample.overrideLogicalId("example");
const awsBudgetsBudgetActionExample =
  new aws.budgetsBudgetAction.BudgetsBudgetAction(this, "example_6", {
    actionThreshold: {
      actionThresholdType: "ABSOLUTE_VALUE",
      actionThresholdValue: 100,
    },
    actionType: "APPLY_IAM_POLICY",
    approvalModel: "AUTOMATIC",
    budgetName: awsBudgetsBudgetExample.name,
    definition: {
      iamActionDefinition: {
        policyArn: awsIamPolicyExample.arn,
        roles: [awsIamRoleExample.name],
      },
    },
    executionRoleArn: awsIamRoleExample.arn,
    notificationType: "ACTUAL",
    subscriber: [
      {
        address: "example@example.example",
        subscriptionType: "EMAIL",
      },
    ],
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsBudgetsBudgetActionExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `accountId` - (Optional) The ID of the target account for budget. Will use current user's account\_id by default if omitted.
* `budgetName` - (Required) The name of a budget.
* `actionThreshold` - (Required) The trigger threshold of the action. See [Action Threshold](#action-threshold).
* `actionType` - (Required) The type of action. This defines the type of tasks that can be carried out by this action. This field also determines the format for definition. Valid values are `APPLY_IAM_POLICY`, `APPLY_SCP_POLICY`, and `RUN_SSM_DOCUMENTS`.
* `approvalModel` - (Required) This specifies if the action needs manual or automatic approval. Valid values are `automatic` and `manual`.
* `definition` - (Required) Specifies all of the type-specific parameters. See [Definition](#definition).
* `executionRoleArn` - (Required) The role passed for action execution and reversion. Roles and actions must be in the same account.
* `notificationType` - (Required) The type of a notification. Valid values are `actual` or `forecasted`.
* `subscriber` - (Required) A list of subscribers. See [Subscriber](#subscriber).

### Action Threshold

* `actionThresholdType` - (Required) The type of threshold for a notification. Valid values are `percentage` or `ABSOLUTE_VALUE`.
* `actionThresholdValue` - (Required) The threshold of a notification.

### Subscriber

* `address` - (Required) The address that AWS sends budget notifications to, either an SNS topic or an email.
* `subscriptionType` - (Required) The type of notification that AWS sends to a subscriber. Valid values are `sns` or `email`.

### Definition

* `iamActionDefinition` - (Optional) The AWS Identity and Access Management (IAM) action definition details. See [IAM Action Definition](#iam-action-definition).
* `ssmActionDefinition` - (Optional) The AWS Systems Manager (SSM) action definition details. See [SSM Action Definition](#ssm-action-definition).
* `scpActionDefinition` - (Optional) The service control policies (SCPs) action definition details. See [SCP Action Definition](#scp-action-definition).

#### IAM Action Definition

* `policyArn` - (Required) The Amazon Resource Name (ARN) of the policy to be attached.
* `groups` - (Optional) A list of groups to be attached. There must be at least one group.
* `roles` - (Optional) A list of roles to be attached. There must be at least one role.
* `users` - (Optional) A list of users to be attached. There must be at least one user.

#### SCP Action Definition

* `policyId` - (Required) The policy ID attached.
* `targetIds` - (Optional) A list of target IDs.

#### SSM Action Definition

* `actionSubType` - (Required) The action subType. Valid values are `STOP_EC2_INSTANCES` or `STOP_RDS_INSTANCES`.
* `instanceIds` - (Required) The EC2 and RDS instance IDs.
* `region` - (Required) The Region to run the SSM document.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `actionId` - The id of the budget action.
* `id` - ID of resource.
* `arn` - The ARN of the budget action.
* `status` - The status of the budget action.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `5M`)
* `update` - (Default `5M`)

## Import

Budgets can be imported using `accountId:actionId:budgetName`, e.g.,

`$TerraformImportAwsBudgetsBudgetActionMyBudget123456789012:someId:myBudget`
