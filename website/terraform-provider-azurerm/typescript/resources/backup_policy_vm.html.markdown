---
subcategory: "Recovery Services"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_backup_policy_vm"
description: |-
  Manages an Azure Backup VM Backup Policy.
---

# azurermBackupPolicyVm

Manages an Azure Backup VM Backup Policy.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example",
  {
    location: "West Europe",
    name: "tfex-recovery_vault",
  }
);
const azurermRecoveryServicesVaultExample =
  new azurerm.recoveryServicesVault.RecoveryServicesVault(this, "example_1", {
    location: azurermResourceGroupExample.location,
    name: "tfex-recovery-vault",
    resource_group_name: azurermResourceGroupExample.name,
    sku: "Standard",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermRecoveryServicesVaultExample.overrideLogicalId("example");
const azurermBackupPolicyVmExample = new azurerm.backupPolicyVm.BackupPolicyVm(
  this,
  "example_2",
  {
    backup: [
      {
        frequency: "Daily",
        time: "23:00",
      },
    ],
    name: "tfex-recovery-vault-policy",
    recovery_vault_name: azurermRecoveryServicesVaultExample.name,
    resource_group_name: azurermResourceGroupExample.name,
    retention_daily: [
      {
        count: 10,
      },
    ],
    retention_monthly: [
      {
        count: 7,
        weekdays: ["Sunday", "Wednesday"],
        weeks: ["First", "Last"],
      },
    ],
    retention_weekly: [
      {
        count: 42,
        weekdays: ["Sunday", "Wednesday", "Friday", "Saturday"],
      },
    ],
    retention_yearly: [
      {
        count: 77,
        months: ["January"],
        weekdays: ["Sunday"],
        weeks: ["Last"],
      },
    ],
    timezone: "UTC",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermBackupPolicyVmExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Specifies the name of the Backup Policy. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the resource group in which to create the policy. Changing this forces a new resource to be created.

*   `recoveryVaultName` - (Required) Specifies the name of the Recovery Services Vault to use. Changing this forces a new resource to be created.

*   `backup` - (Required) Configures the Policy backup frequency, times & days as documented in the `backup` block below.

*   `policyType` - (Optional) Type of the Backup Policy. Possible values are `v1` and `v2` where `v2` stands for the Enhanced Policy. Defaults to `v1`. Changing this forces a new resource to be created.

*   `timezone` - (Optional) Specifies the timezone. [the possible values are defined here](https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/). Defaults to `utc`

*   `instantRestoreRetentionDays` - (Optional) Specifies the instant restore retention range in days. Possible values are between `1` and `5` when `policyType` is `v1`, and `1` to `30` when `policyType` is `v2`.

*   `instantRestoreResourceGroup` - (Optional) Specifies the instant restore resource group name as documented in the `instantRestoreResourceGroup` block below.

*   `retentionDaily` - (Optional) Configures the policy daily retention as documented in the `retentionDaily` block below. Required when backup frequency is `daily`.

*   `retentionWeekly` - (Optional) Configures the policy weekly retention as documented in the `retentionWeekly` block below. Required when backup frequency is `weekly`.

*   `retentionMonthly` - (Optional) Configures the policy monthly retention as documented in the `retentionMonthly` block below.

*   `retentionYearly` - (Optional) Configures the policy yearly retention as documented in the `retentionYearly` block below.

***

The `backup` block supports:

*   `frequency` - (Required) Sets the backup frequency. Possible values are `hourly`, `daily` and `weekly`.

*   `time` - (Required) The time of day to perform the backup in 24hour format.

*   `hourInterval` - (Optional) Interval in hour at which backup is triggered. Possible values are `4`, `6`, `8` and `12`. This is used when `frequency` is `hourly`.

*   `hourDuration` - (Optional) Duration of the backup window in hours. Possible values are between `4` and `24` This is used when `frequency` is `hourly`.

\~> **NOTE:** `hourDuration` must be multiplier of `hourInterval`

* `weekdays` - (Optional) The days of the week to perform backups on. Must be one of `sunday`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday` or `saturday`. This is used when `frequency` is `weekly`.

***

The `instantRestoreResourceGroup` block supports:

*   `prefix` - (Required) The prefix for the `instantRestoreResourceGroup` name.

*   `suffix` - (Optional) The suffix for the `instantRestoreResourceGroup` name.

***

The `retentionDaily` block supports:

* `count` - (Required) The number of daily backups to keep. Must be between `7` and `9999`.

\~> **Note:** Azure previously allows this field to be set to a minimum of 1 (day) - but for new resources/to update this value on existing Backup Policies - this value must now be at least 7 (days).

***

The `retentionWeekly` block supports:

*   `count` - (Required) The number of weekly backups to keep. Must be between `1` and `9999`

*   `weekdays` - (Required) The weekday backups to retain. Must be one of `sunday`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday` or `saturday`.

***

The `retentionMonthly` block supports:

*   `count` - (Required) The number of monthly backups to keep. Must be between `1` and `9999`

*   `weekdays` - (Required) The weekday backups to retain . Must be one of `sunday`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday` or `saturday`.

*   `weeks` - (Required) The weeks of the month to retain backups of. Must be one of `first`, `second`, `third`, `fourth`, `last`.

***

The `retentionYearly` block supports:

*   `count` - (Required) The number of yearly backups to keep. Must be between `1` and `9999`

*   `weekdays` - (Required) The weekday backups to retain . Must be one of `sunday`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday` or `saturday`.

*   `weeks` - (Required) The weeks of the month to retain backups of. Must be one of `first`, `second`, `third`, `fourth`, `last`.

*   `months` - (Required) The months of the year to retain backups of. Must be one of `january`, `february`, `march`, `april`, `may`, `june`, `july`, `august`, `september`, `october`, `november` and `december`.

***

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the VM Backup Policy.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the VM Backup Policy.
* `update` - (Defaults to 30 minutes) Used when updating the VM Backup Policy.
* `read` - (Defaults to 5 minutes) Used when retrieving the VM Backup Policy.
* `delete` - (Defaults to 30 minutes) Used when deleting the VM Backup Policy.

## Import

VM Backup Policies can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_backup_policy_vm.policy1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.RecoveryServices/vaults/example-recovery-vault/backupPolicies/policy1
```
