---
subcategory: "App Service (Web Apps)"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_web_app_active_slot"
description: |-
  Manages a Web App Active Slot.
---

# azurermWebAppActiveSlot

Manages a Web App Active Slot.

## Example Usage

### Windows Web App

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
    name: "example-plan",
    os_type: "Windows",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "P1v2",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermServicePlanExample.overrideLogicalId("example");
const azurermWindowsWebAppExample = new azurerm.windowsWebApp.WindowsWebApp(
  this,
  "example_3",
  {
    location: azurermServicePlanExample.location,
    name: "example-windows-web-app",
    resource_group_name: azurermResourceGroupExample.name,
    service_plan_id: azurermServicePlanExample.id,
    site_config: [{}],
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermWindowsWebAppExample.overrideLogicalId("example");
const azurermWindowsWebAppSlotExample =
  new azurerm.windowsWebAppSlot.WindowsWebAppSlot(this, "example_4", {
    app_service_id: azurermWindowsWebAppExample.name,
    name: "example-windows-web-app-slot",
    site_config: [{}],
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermWindowsWebAppSlotExample.overrideLogicalId("example");
const azurermWebAppActiveSlotExample =
  new azurerm.webAppActiveSlot.WebAppActiveSlot(this, "example_5", {
    slot_id: azurermWindowsWebAppSlotExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermWebAppActiveSlotExample.overrideLogicalId("example");

```

### Linux Web App

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
    name: "example-plan",
    os_type: "Linux",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "P1v2",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermServicePlanExample.overrideLogicalId("example");
const azurermLinuxWebAppExample = new azurerm.linuxWebApp.LinuxWebApp(
  this,
  "example_3",
  {
    location: azurermServicePlanExample.location,
    name: "example-linux-web-app",
    resource_group_name: azurermResourceGroupExample.name,
    service_plan_id: azurermServicePlanExample.id,
    site_config: [{}],
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLinuxWebAppExample.overrideLogicalId("example");
const azurermLinuxWebAppSlotExample =
  new azurerm.linuxWebAppSlot.LinuxWebAppSlot(this, "example_4", {
    app_service_name: azurermLinuxWebAppExample.name,
    location: azurermServicePlanExample.location,
    name: "example-linux-web-app-slot",
    service_plan_id: azurermServicePlanExample.id,
    site_config: [{}],
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLinuxWebAppSlotExample.overrideLogicalId("example");
const azurermWebAppActiveSlotExample =
  new azurerm.webAppActiveSlot.WebAppActiveSlot(this, "example_5", {
    slot_id: azurermLinuxWebAppSlotExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermWebAppActiveSlotExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

* `slotId` - (Required) The ID of the Slot to swap with `production`.

***

* `overwriteNetworkConfig` - (Optional) The swap action should overwrite the Production slot's network configuration with the configuration from this slot. Defaults to `true`. Changing this forces a new resource to be created.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Web App Active Slot

*   `lastSuccessfulSwap` - The timestamp of the last successful swap with `production`.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Web App Active Slot.
* `update` - (Defaults to 30 minutes) Used when updating the Web App Active Slot.
* `read` - (Defaults to 5 minutes) Used when retrieving the Web App Active Slot.
* `delete` - (Defaults to 5 minutes) Used when deleting the Web App Active Slot.

## Import

a Web App Active Slot can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_web_app_active_slot.example "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/resGroup1/providers/Microsoft.Web/sites/site1"
```
