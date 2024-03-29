---
subcategory: "App Service (Web Apps)"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_app_service_slot_custom_hostname_binding"
description: |-
  Manages a Hostname Binding within an App Service Slot.

---

# azurermAppServiceSlotCustomHostnameBinding

Manages a Hostname Binding within an App Service Slot.

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
    name: "some-resource-group",
  }
);
const azurermAppServicePlanExample = new azurerm.appServicePlan.AppServicePlan(
  this,
  "example_1",
  {
    location: azurermResourceGroupExample.location,
    name: "some-app-service-plan",
    resource_group_name: azurermResourceGroupExample.name,
    sku: [
      {
        size: "S1",
        tier: "Standard",
      },
    ],
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermAppServicePlanExample.overrideLogicalId("example");
const azurermAppServiceExample = new azurerm.appService.AppService(
  this,
  "example_2",
  {
    app_service_plan_id: azurermAppServicePlanExample.id,
    location: azurermResourceGroupExample.location,
    name: "some-app-service",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermAppServiceExample.overrideLogicalId("example");
const azurermAppServiceSlotExample = new azurerm.appServiceSlot.AppServiceSlot(
  this,
  "example_3",
  {
    app_service_name: azurermAppServiceExample.name,
    app_service_plan_id: azurermAppServicePlanExample.id,
    location: azurermResourceGroupExample.location,
    name: "staging",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermAppServiceSlotExample.overrideLogicalId("example");
const azurermAppServiceSlotCustomHostnameBindingExample =
  new azurerm.appServiceSlotCustomHostnameBinding.AppServiceSlotCustomHostnameBinding(
    this,
    "example_4",
    {
      app_service_slot_id: azurermAppServiceSlotExample.id,
      hostname: "www.mywebsite.com",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermAppServiceSlotCustomHostnameBindingExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `appServiceSlotId` - (Required) The ID of the App Service Slot. Changing this forces a new resource to be created.

*   `hostname` - (Required) Specifies the Custom Hostname to use for the App Service, example `wwwExampleCom`. Changing this forces a new resource to be created.

\~> **NOTE:** A CNAME needs to be configured from this Hostname to the Azure Website - otherwise Azure will reject the Hostname Binding.

*   `sslState` - (Optional) The SSL type. Possible values are `ipBasedEnabled` and `sniEnabled`. Changing this forces a new resource to be created.

*   `thumbprint` - (Optional) The SSL certificate thumbprint. Changing this forces a new resource to be created.

\-> **NOTE:** `thumbprint` must be specified when `sslState` is set.

## Attributes Reference

The following attributes are exported:

*   `id` - The ID of the App Service Custom Hostname Binding

*   `virtualIp` - The virtual IP address assigned to the hostname if IP based SSL is enabled.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the App Service Custom Hostname Binding.
* `read` - (Defaults to 5 minutes) Used when retrieving the App Service Custom Hostname Binding.
* `delete` - (Defaults to 30 minutes) Used when deleting the App Service Custom Hostname Binding.

## Import

App Service Custom Hostname Bindings can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_app_service_slot_custom_hostname_binding.mywebsite /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Web/sites/instance1/slots/staging/hostNameBindings/mywebsite.com
```
