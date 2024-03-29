---
subcategory: "Recovery Services"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_site_recovery_protection_container"
description: |-
    Manages a site recovery services protection container on Azure.
---

# azurermSiteRecoveryProtectionContainer

Manages a Azure Site Recovery protection container. Protection containers serve as containers for replicated VMs and belong to a single region / recovery fabric. Protection containers can contain more than one replicated VM. To replicate a VM, a container must exist in both the source and target Azure regions.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const azurermResourceGroupPrimary = new azurerm.resourceGroup.ResourceGroup(
  this,
  "primary",
  {
    location: "West US",
    name: "tfex-network-mapping-primary",
  }
);
const azurermResourceGroupSecondary = new azurerm.resourceGroup.ResourceGroup(
  this,
  "secondary",
  {
    location: "East US",
    name: "tfex-network-mapping-secondary",
  }
);
const azurermRecoveryServicesVaultVault =
  new azurerm.recoveryServicesVault.RecoveryServicesVault(this, "vault", {
    location: azurermResourceGroupSecondary.location,
    name: "example-recovery-vault",
    resource_group_name: azurermResourceGroupSecondary.name,
    sku: "Standard",
  });
const azurermSiteRecoveryFabricFabric =
  new azurerm.siteRecoveryFabric.SiteRecoveryFabric(this, "fabric", {
    location: azurermResourceGroupPrimary.location,
    name: "primary-fabric",
    recovery_vault_name: azurermRecoveryServicesVaultVault.name,
    resource_group_name: azurermResourceGroupSecondary.name,
  });
new azurerm.siteRecoveryProtectionContainer.SiteRecoveryProtectionContainer(
  this,
  "protection-container",
  {
    name: "protection-container",
    recovery_fabric_name: azurermSiteRecoveryFabricFabric.name,
    recovery_vault_name: azurermRecoveryServicesVaultVault.name,
    resource_group_name: azurermResourceGroupSecondary.name,
  }
);

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the protection container. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) Name of the resource group where the vault that should be updated is located. Changing this forces a new resource to be created.

*   `recoveryVaultName` - (Required) The name of the vault that should be updated. Changing this forces a new resource to be created.

*   `recoveryFabricName` - (Required) Name of fabric that should contain this protection container. Changing this forces a new resource to be created.

## Attributes Reference

In addition to the arguments above, the following attributes are exported:

* `id` - The ID of the Site Recovery Protection Container.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Site Recovery Protection Container.
* `update` - (Defaults to 30 minutes) Used when updating the Site Recovery Protection Container.
* `read` - (Defaults to 5 minutes) Used when retrieving the Site Recovery Protection Container.
* `delete` - (Defaults to 30 minutes) Used when deleting the Site Recovery Protection Container.

## Import

Site Recovery Protection Containers can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_site_recovery_protection_container.mycontainer /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resource-group-name/providers/Microsoft.RecoveryServices/vaults/recovery-vault-name/replicationFabrics/fabric-name/replicationProtectionContainers/protection-container-name
```
