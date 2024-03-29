---
subcategory: "Compute"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_dedicated_host_group"
description: |-
  Manage a Dedicated Host Group.
---

# azurermDedicatedHostGroup

Manage a Dedicated Host Group.

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
    name: "example-rg-compute",
  }
);
const azurermDedicatedHostGroupExample =
  new azurerm.dedicatedHostGroup.DedicatedHostGroup(this, "example_1", {
    location: azurermResourceGroupExample.location,
    name: "example-dedicated-host-group",
    platform_fault_domain_count: 1,
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermDedicatedHostGroupExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Specifies the name of the Dedicated Host Group. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) Specifies the name of the resource group the Dedicated Host Group is located in. Changing this forces a new resource to be created.

*   `location` - (Required) The Azure location where the Dedicated Host Group exists. Changing this forces a new resource to be created.

*   `platformFaultDomainCount` - (Required) The number of fault domains that the Dedicated Host Group spans. Changing this forces a new resource to be created.

*   `automaticPlacementEnabled` - (Optional) Would virtual machines or virtual machine scale sets be placed automatically on this Dedicated Host Group? Defaults to `false`. Changing this forces a new resource to be created.

*   `zone` - (Optional) Specifies the Availability Zone in which this Dedicated Host Group should be located. Changing this forces a new Dedicated Host Group to be created.

*   `tags` - (Optional) A mapping of tags to assign to the resource.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the Dedicated Host Group.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Dedicated Host Group.
* `update` - (Defaults to 30 minutes) Used when updating the Dedicated Host Group.
* `read` - (Defaults to 5 minutes) Used when retrieving the Dedicated Host Group.
* `delete` - (Defaults to 30 minutes) Used when deleting the Dedicated Host Group.

## Import

Dedicated Host Group can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_dedicated_host_group.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Compute/hostGroups/group1
```
