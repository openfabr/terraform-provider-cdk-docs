---
subcategory: "App Service (Web Apps)"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_function_app_active_slot"
description: |-
  Manages a Function App Active Slot.
---

# azurermFunctionAppActiveSlot

Manages a Function App Active Slot.

## Example Usage

### Windows Function App

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
new azurerm.provider.AzurermProvider(this, "azurerm", {
  features: [{}],
});
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example",
  {
    location: "West Europe",
    name: "example-resources",
  }
);
const azurermServicePlanExample = new azurerm.servicePlan.ServicePlan(
  this,
  "example_2",
  {
    location: azurermResourceGroupExample.location,
    name: "example-app-service-plan",
    os_type: "Windows",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "Y1",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermServicePlanExample.overrideLogicalId("example");
const azurermStorageAccountExample = new azurerm.storageAccount.StorageAccount(
  this,
  "example_3",
  {
    account_replication_type: "LRS",
    account_tier: "Standard",
    location: azurermResourceGroupExample.location,
    name: "windowsfunctionappsa",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const azurermWindowsFunctionAppExample =
  new azurerm.windowsFunctionApp.WindowsFunctionApp(this, "example_4", {
    location: azurermResourceGroupExample.location,
    name: "example-windows-function-app",
    resource_group_name: azurermResourceGroupExample.name,
    service_plan_id: azurermServicePlanExample.id,
    site_config: [{}],
    storage_account_name: azurermStorageAccountExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermWindowsFunctionAppExample.overrideLogicalId("example");
const azurermWindowsFunctionAppSlotExample =
  new azurerm.windowsFunctionAppSlot.WindowsFunctionAppSlot(this, "example_5", {
    function_app_id: azurermWindowsFunctionAppExample.id,
    name: "example-windows-function-app-slot",
    site_config: [{}],
    storage_account_name: azurermStorageAccountExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermWindowsFunctionAppSlotExample.overrideLogicalId("example");
const azurermFunctionAppActiveSlotExample =
  new azurerm.functionAppActiveSlot.FunctionAppActiveSlot(this, "example_6", {
    slot_id: azurermWindowsFunctionAppSlotExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermFunctionAppActiveSlotExample.overrideLogicalId("example");

```

### Linux Function App

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
new azurerm.provider.AzurermProvider(this, "azurerm", {
  features: [{}],
});
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example",
  {
    location: "West Europe",
    name: "example-resources",
  }
);
const azurermServicePlanExample = new azurerm.servicePlan.ServicePlan(
  this,
  "example_2",
  {
    location: azurermResourceGroupExample.location,
    name: "example-app-service-plan",
    os_type: "Linux",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "Y1",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermServicePlanExample.overrideLogicalId("example");
const azurermStorageAccountExample = new azurerm.storageAccount.StorageAccount(
  this,
  "example_3",
  {
    account_replication_type: "LRS",
    account_tier: "Standard",
    location: azurermResourceGroupExample.location,
    name: "linuxfunctionappsa",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const azurermLinuxFunctionAppExample =
  new azurerm.linuxFunctionApp.LinuxFunctionApp(this, "example_4", {
    location: azurermResourceGroupExample.location,
    name: "example-linux-function-app",
    resource_group_name: azurermResourceGroupExample.name,
    service_plan_id: azurermServicePlanExample.id,
    site_config: [{}],
    storage_account_name: azurermStorageAccountExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLinuxFunctionAppExample.overrideLogicalId("example");
const azurermLinuxFunctionAppSlotExample =
  new azurerm.linuxFunctionAppSlot.LinuxFunctionAppSlot(this, "example_5", {
    function_app_id: azurermLinuxFunctionAppExample.name,
    name: "example-linux-function-app-slot",
    site_config: [{}],
    storage_account_name: azurermStorageAccountExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLinuxFunctionAppSlotExample.overrideLogicalId("example");
const azurermFunctionAppActiveSlotExample =
  new azurerm.functionAppActiveSlot.FunctionAppActiveSlot(this, "example_6", {
    slot_id: azurermLinuxFunctionAppSlotExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermFunctionAppActiveSlotExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

* `slotId` - (Required) The ID of the Slot to swap with `production`.

***

* `overwriteNetworkConfig` - (Optional) The swap action should overwrite the Production slot's network configuration with the configuration from this slot. Defaults to `true`. Changing this forces a new resource to be created.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Function App Active Slot

*   `lastSuccessfulSwap` - The timestamp of the last successful swap with `production`

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Function App Active Slot.
* `update` - (Defaults to 30 minutes) Used when updating the Function App Active Slot.
* `read` - (Defaults to 5 minutes) Used when retrieving the Function App Active Slot.
* `delete` - (Defaults to 5 minutes) Used when deleting the Function App Active Slot.

## Import

a Function App Active Slot can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_function_app_active_slot.example "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/resGroup1/providers/Microsoft.Web/sites/site1"
```
