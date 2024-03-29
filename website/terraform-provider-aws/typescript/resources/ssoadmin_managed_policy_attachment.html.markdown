---
subcategory: "SSO Admin"
layout: "aws"
page_title: "AWS: aws_ssoadmin_managed_policy_attachment"
description: |-
  Manages an IAM managed policy for a Single Sign-On (SSO) Permission Set
---

# Resource: awsSsoadminManagedPolicyAttachment

Provides an IAM managed policy for a Single Sign-On (SSO) Permission Set resource

\~> **NOTE:** Creating this resource will automatically [Provision the Permission Set](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_ProvisionPermissionSet.html) to apply the corresponding updates to all assigned accounts.

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
const awsSsoadminPermissionSetExample =
  new aws.ssoadminPermissionSet.SsoadminPermissionSet(this, "example_1", {
    instanceArn: `\${tolist(${dataAwsSsoadminInstancesExample.arns})[0]}`,
    name: "Example",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsSsoadminPermissionSetExample.overrideLogicalId("example");
const awsSsoadminManagedPolicyAttachmentExample =
  new aws.ssoadminManagedPolicyAttachment.SsoadminManagedPolicyAttachment(
    this,
    "example_2",
    {
      instanceArn: `\${tolist(${dataAwsSsoadminInstancesExample.arns})[0]}`,
      managedPolicyArn: "arn:aws:iam::aws:policy/AlexaForBusinessDeviceSetup",
      permissionSetArn: awsSsoadminPermissionSetExample.arn,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsSsoadminManagedPolicyAttachmentExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `instanceArn` - (Required, Forces new resource) The Amazon Resource Name (ARN) of the SSO Instance under which the operation will be executed.
* `managedPolicyArn` - (Required, Forces new resource) The IAM managed policy Amazon Resource Name (ARN) to be attached to the Permission Set.
* `permissionSetArn` - (Required, Forces new resource) The Amazon Resource Name (ARN) of the Permission Set.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The Amazon Resource Names (ARNs) of the Managed Policy, Permission Set, and SSO Instance, separated by a comma (`,`).
* `managedPolicyName` - The name of the IAM Managed Policy.

## Import

SSO Managed Policy Attachments can be imported using the `managedPolicyArn`, `permissionSetArn`, and `instanceArn` separated by a comma (`,`) e.g.,

```console
$ terraform import aws_ssoadmin_managed_policy_attachment.example arn:aws:iam::aws:policy/AlexaForBusinessDeviceSetup,arn:aws:sso:::permissionSet/ssoins-2938j0x8920sbj72/ps-80383020jr9302rk,arn:aws:sso:::instance/ssoins-2938j0x8920sbj72
```
