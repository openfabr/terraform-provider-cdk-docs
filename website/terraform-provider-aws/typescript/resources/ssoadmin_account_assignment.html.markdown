---
subcategory: "SSO Admin"
layout: "aws"
page_title: "AWS: aws_ssoadmin_account_assignment"
description: |-
  Manages a Single Sign-On (SSO) Account Assignment
---

# Resource: awsSsoadminAccountAssignment

Provides a Single Sign-On (SSO) Account Assignment resource

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsSsoadminInstancesExample =
  new aws.dataAwsSsoadminInstances.DataAwsSsoadminInstances(
    this,
    "example",
    {}
  );
const dataAwsSsoadminPermissionSetExample =
  new aws.dataAwsSsoadminPermissionSet.DataAwsSsoadminPermissionSet(
    this,
    "example_1",
    {
      instanceArn: `\${tolist(${dataAwsSsoadminInstancesExample.arns})[0]}`,
      name: "AWSReadOnlyAccess",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAwsSsoadminPermissionSetExample.overrideLogicalId("example");
const dataAwsIdentitystoreGroupExample =
  new aws.dataAwsIdentitystoreGroup.DataAwsIdentitystoreGroup(
    this,
    "example_2",
    {
      alternateIdentifier: {
        uniqueAttribute: {
          attributePath: "DisplayName",
          attributeValue: "ExampleGroup",
        },
      },
      identityStoreId: `\${tolist(${dataAwsSsoadminInstancesExample.identityStoreIds})[0]}`,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAwsIdentitystoreGroupExample.overrideLogicalId("example");
const awsSsoadminAccountAssignmentExample =
  new aws.ssoadminAccountAssignment.SsoadminAccountAssignment(
    this,
    "example_3",
    {
      instanceArn: `\${tolist(${dataAwsSsoadminInstancesExample.arns})[0]}`,
      permissionSetArn: dataAwsSsoadminPermissionSetExample.arn,
      principalId: dataAwsIdentitystoreGroupExample.groupId,
      principalType: "GROUP",
      targetId: "012347678910",
      targetType: "AWS_ACCOUNT",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsSsoadminAccountAssignmentExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `instanceArn` - (Required, Forces new resource) The Amazon Resource Name (ARN) of the SSO Instance.
* `permissionSetArn` - (Required, Forces new resource) The Amazon Resource Name (ARN) of the Permission Set that the admin wants to grant the principal access to.
* `principalId` - (Required, Forces new resource) An identifier for an object in SSO, such as a user or group. PrincipalIds are GUIDs (For example, `f81D4Fae7Dec11D0A76500A0C91E6Bf6`).
* `principalType` - (Required, Forces new resource) The entity type for which the assignment will be created. Valid values: `user`, `group`.
* `targetId` - (Required, Forces new resource) An AWS account identifier, typically a 10-12 digit string.
* `targetType` - (Optional, Forces new resource) The entity type for which the assignment will be created. Valid values: `AWS_ACCOUNT`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The identifier of the Account Assignment i.e., `principalId`, `principalType`, `targetId`, `targetType`, `permissionSetArn`, `instanceArn` separated by commas (`,`).

## Import

SSO Account Assignments can be imported using the `principalId`, `principalType`, `targetId`, `targetType`, `permissionSetArn`, `instanceArn` separated by commas (`,`) e.g.,

```console
$ terraform import aws_ssoadmin_account_assignment.example f81d4fae-7dec-11d0-a765-00a0c91e6bf6,GROUP,1234567890,AWS_ACCOUNT,arn:aws:sso:::permissionSet/ssoins-0123456789abcdef/ps-0123456789abcdef,arn:aws:sso:::instance/ssoins-0123456789abcdef
```
