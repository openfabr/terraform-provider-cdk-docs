---
subcategory: "Recovery Services"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_site_recovery_vmware_replication_policy"
description: |-
  Manages a VMWare Replication Policy.
---

# azurermSiteRecoveryVmwareReplicationPolicy

Manages a VMWare Replication Policy.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const azurermRecoveryServicesVaultExample =
  new azurerm.recoveryServicesVault.RecoveryServicesVault(this, "example", {
    classic_vmware_replication_enabled: true,
    location: "${azurerm_resource_group.test.location}",
    name: "example-vault",
    resource_group_name: "${azurerm_resource_group.test.name}",
    sku: "Standard",
    soft_delete_enabled: false,
  });
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example_1",
  {
    location: "eastus",
    name: "example-rg",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermResourceGroupExample.overrideLogicalId("example");
const azurermSiteRecoveryVmwareReplicationPolicyExample =
  new azurerm.siteRecoveryVmwareReplicationPolicy.SiteRecoveryVmwareReplicationPolicy(
    this,
    "example_2",
    {
      application_consistent_snapshot_frequency_in_minutes: 240,
      name: "example-policy",
      recovery_point_retention_in_minutes: 1440,
      recovery_vault_id: azurermRecoveryServicesVaultExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSiteRecoveryVmwareReplicationPolicyExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this Classic Replication Policy. Changing this forces a new Replication Policy to be created.

*   `recoveryVaultId` - (Required) ID of the Recovery Services Vault. Changing this forces a new Replication Policy to be created.

*   `recoveryPointRetentionInMinutes` - (Required) Specifies the period up to which the recovery points will be retained. Must between `0` to `21600`.

*   `applicationConsistentSnapshotFrequencyInMinutes` - (Required) Specifies the frequency at which to create application consistent recovery points. Must between `0` to `720`.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the Classic Replication Policy.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Classic Replication Policy.
* `read` - (Defaults to 5 minutes) Used when retrieving the Classic Replication Policy.
* `update` - (Defaults to 30 minutes) Used when updating the Classic Replication Policy.
* `delete` - (Defaults to 30 minutes) Used when deleting the Classic Replication Policy.

## Import

VMWare Replication Policy can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_site_recovery_vmware_replication_policy.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/vault1/providers/Microsoft.RecoveryServices/vaults/vault1/replicationPolicies/policy1
```
