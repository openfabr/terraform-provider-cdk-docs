---
subcategory: "SSM (Systems Manager)"
layout: "aws"
page_title: "AWS: aws_ssm_patch_baseline"
description: |-
  Provides an SSM Patch Baseline data source
---

# Data Source: awsSsmPatchBaseline

Provides an SSM Patch Baseline data source. Useful if you wish to reuse the default baselines provided.

## Example Usage

To retrieve a baseline provided by AWS:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsSsmPatchBaseline.DataAwsSsmPatchBaseline(this, "centos", {
  namePrefix: "AWS-",
  operatingSystem: "CENTOS",
  owner: "AWS",
});

```

To retrieve a baseline on your account:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsSsmPatchBaseline.DataAwsSsmPatchBaseline(
  this,
  "default_custom",
  {
    defaultBaseline: true,
    namePrefix: "MyCustomBaseline",
    operatingSystem: "WINDOWS",
    owner: "Self",
  }
);

```

## Argument Reference

The following arguments are supported:

* `owner` - (Required) Owner of the baseline. Valid values: `all`, `aws`, `self` (the current account).
* `namePrefix` - (Optional) Filter results by the baseline name prefix.
* `defaultBaseline` - (Optional) Filters the results against the baselines default\_baseline field.
* `operatingSystem` - (Optional) Specified OS for the baseline. Valid values: `AMAZON_LINUX`, `AMAZON_LINUX_2`, `ubuntu`, `REDHAT_ENTERPRISE_LINUX`, `suse`, `centos`, `ORACLE_LINUX`, `debian`, `macos`, `raspbian` and `ROCKY_LINUX`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `approvedPatches` - List of explicitly approved patches for the baseline.
* `approvedPatchesComplianceLevel` - The compliance level for approved patches.
* `approvedPatchesEnableNonSecurity` - Indicates whether the list of approved patches includes non-security updates that should be applied to the instances.
* `approvalRule` - List of rules used to include patches in the baseline.
  * `approveAfterDays` - The number of days after the release date of each patch matched by the rule the patch is marked as approved in the patch baseline.
  * `approveUntilDate` - The cutoff date for auto approval of released patches. Any patches released on or before this date are installed automatically. Date is formatted as `yyyyMmDd`. Conflicts with `approveAfterDays`
  * `complianceLevel` - The compliance level for patches approved by this rule.
  * `enableNonSecurity` - Boolean enabling the application of non-security updates.
  * `patchFilter` - The patch filter group that defines the criteria for the rule.
    * `key` - The key for the filter.
    * `values` - The value for the filter.
* `globalFilter` - Set of global filters used to exclude patches from the baseline.
  * `key` - The key for the filter.
  * `values` - The value for the filter.
* `id` - ID of the baseline.
* `name` - Name of the baseline.
* `description` - Description of the baseline.
* `rejectedPatches` - List of rejected patches.
* `rejectedPatchesAction` - The action specified to take on patches included in the `rejectedPatches` list.
* `source` - Information about the patches to use to update the managed nodes, including target operating systems and source repositories.
  * `configuration` - The value of the yum repo configuration.
  * `name` - The name specified to identify the patch source.
  * `products` - The specific operating system versions a patch repository applies to.
