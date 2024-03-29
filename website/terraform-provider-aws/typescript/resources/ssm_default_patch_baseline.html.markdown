---
subcategory: "SSM (Systems Manager)"
layout: "aws"
page_title: "AWS: aws_ssm_default_patch_baseline"
description: |-
  Terraform resource for managing an AWS Systems Manager Default Patch Baseline.
---

# Resource: awsSsmDefaultPatchBaseline

Terraform resource for registering an AWS Systems Manager Default Patch Baseline.

## Example Usage

### Basic Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsSsmPatchBaselineExample = new aws.ssmPatchBaseline.SsmPatchBaseline(
  this,
  "example",
  {
    approvedPatches: ["KB123456"],
    name: "example",
  }
);
const awsSsmDefaultPatchBaselineExample =
  new aws.ssmDefaultPatchBaseline.SsmDefaultPatchBaseline(this, "example_1", {
    baselineId: awsSsmPatchBaselineExample.id,
    operatingSystem: awsSsmPatchBaselineExample.operatingSystem,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsSsmDefaultPatchBaselineExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are required:

* `baselineId` - (Required) ID of the patch baseline.
  Can be an ID or an ARN.
  When specifying an AWS-provided patch baseline, must be the ARN.
* `operatingSystem` - (Required) The operating system the patch baseline applies to.
  Valid values are
  `AMAZON_LINUX`,
  `AMAZON_LINUX_2`,
  `AMAZON_LINUX_2022`,
  `centos`,
  `debian`,
  `macos`,
  `ORACLE_LINUX`,
  `raspbian`,
  `REDHAT_ENTERPRISE_LINUX`,
  `ROCKY_LINUX`,
  `suse`,
  `ubuntu`, and
  `windows`.

## Attributes Reference

No additional attributes are exported.

## Import

The Systems Manager Default Patch Baseline can be imported using the patch baseline ID, patch baseline ARN, or the operating system value, e.g.,

```console
$ terraform import aws_ssm_default_patch_baseline.example pb-1234567890abcdef1
```

```console
$ terraform import aws_ssm_default_patch_baseline.example arn:aws:ssm:us-west-2:123456789012:patchbaseline/pb-1234567890abcdef1
```

```console
$ terraform import aws_ssm_default_patch_baseline.example CENTOS
```
