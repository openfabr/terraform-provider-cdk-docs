---
subcategory: "Network"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_network_watcher"
description: |-
  Manages a Network Watcher.

---

# azurermNetworkWatcher

Manages a Network Watcher.

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
    name: "production-nwwatcher",
  }
);
const azurermNetworkWatcherExample = new azurerm.networkWatcher.NetworkWatcher(
  this,
  "example_1",
  {
    location: azurermResourceGroupExample.location,
    name: "production-nwwatcher",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermNetworkWatcherExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the Network Watcher. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the resource group in which to create the Network Watcher. Changing this forces a new resource to be created.

*   `location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.

*   `tags` - (Optional) A mapping of tags to assign to the resource.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the Network Watcher.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Network Watcher.
* `update` - (Defaults to 30 minutes) Used when updating the Network Watcher.
* `read` - (Defaults to 5 minutes) Used when retrieving the Network Watcher.
* `delete` - (Defaults to 30 minutes) Used when deleting the Network Watcher.

## Import

Network Watchers can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_network_watcher.watcher1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Network/networkWatchers/watcher1
```
