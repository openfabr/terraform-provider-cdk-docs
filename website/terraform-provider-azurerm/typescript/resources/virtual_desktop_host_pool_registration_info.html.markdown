---
subcategory: "Desktop Virtualization"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_virtual_desktop_host_pool_registration_info"
description: |-
  Manages a Virtual Desktop Host Pool Registration Info.
---

# azurermVirtualDesktopHostPoolRegistrationInfo

Manages the Registration Info for a Virtual Desktop Host Pool.

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
    location: "westeurope",
    name: "example-hostpool",
  }
);
const azurermVirtualDesktopHostPoolExample =
  new azurerm.virtualDesktopHostPool.VirtualDesktopHostPool(this, "example_1", {
    load_balancer_type: "BreadthFirst",
    location: azurermResourceGroupExample.location,
    name: "example-HP",
    resource_group_name: azurermResourceGroupExample.name,
    type: "Pooled",
    validate_environment: true,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualDesktopHostPoolExample.overrideLogicalId("example");
const azurermVirtualDesktopHostPoolRegistrationInfoExample =
  new azurerm.virtualDesktopHostPoolRegistrationInfo.VirtualDesktopHostPoolRegistrationInfo(
    this,
    "example_2",
    {
      expiration_date: "2022-01-01T23:40:52Z",
      hostpool_id: azurermVirtualDesktopHostPoolExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualDesktopHostPoolRegistrationInfoExample.overrideLogicalId(
  "example"
);

```

## Arguments Reference

The following arguments are supported:

*   `expirationDate` - (Required) A valid `rfc3339Time` for the expiration of the token..

*   `hostpoolId` - (Required) The ID of the Virtual Desktop Host Pool to link the Registration Info to. Changing this forces a new Registration Info resource to be created. Only a single virtual\_desktop\_host\_pool\_registration\_info resource should be associated with a given hostpool. Assigning multiple resources will produce inconsistent results.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Virtual Desktop Host Pool Registration Info resource.

*   `token` - The registration token generated by the Virtual Desktop Host Pool for registration of session hosts.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the AVD Registration Info.
* `read` - (Defaults to 5 minutes) Used when retrieving the AVD Registration Info.
* `update` - (Defaults to 30 minutes) Used when updating the AVD Registration Info.
* `delete` - (Defaults to 30 minutes) Used when deleting the AVD Registration Info.

## Import

AVD Registration Infos can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_virtual_desktop_host_pool_registration_info.example /subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/resGroup1/providers/Microsoft.DesktopVirtualization/hostPools/pool1/registrationInfo/default
```
