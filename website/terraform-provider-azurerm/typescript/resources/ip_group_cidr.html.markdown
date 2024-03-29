---
subcategory: "Network"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_ip_group_cidr"
description: |-
  Manages a IP Group CIDR.
---

# azurermIpGroupCidr

Manages IP Group CIDR records.

\~> Warning Do not use this resource at the same time as the `cidrs` property of the
`azurermIpGroup` resource for the same IP Group. Doing so will cause a conflict and
CIDRS will be removed.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const azurermIpGroupExample = new azurerm.ipGroup.IpGroup(this, "example", {
  location: "${azurerm_resource_group.test.location}",
  name: "test-ipgroup",
  resource_group_name: "${azurerm_resource_group.test.name}",
});
const azurermIpGroupCidrExample = new azurerm.ipGroupCidr.IpGroupCidr(
  this,
  "example_1",
  {
    cidr: "10.10.10.0/24",
    ip_group_id: azurermIpGroupExample.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermIpGroupCidrExample.overrideLogicalId("example");
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example_2",
  {
    location: "West Europe",
    name: "test-rg",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermResourceGroupExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `ipGroupId` - (Required) The ID of the destination IP Group.
    Changing this forces a new IP Group CIDR to be created.

*   `cidr` - (Required) The `cidr` that should be added to the IP Group.
    Changing this forces a new IP Group CIDR to be created.

\~> **NOTE:** The AzureRM Terraform provider provides cidr support via this standalone resource and in-line within [azurerm\_ip\_group](ip_group.html) using the `cidrs` property. You cannot use both methods simultaneously. If cidrs are set via this resource then `ignoreChanges` should be used in the resource `azurermIpGroupCidr` configuration.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the IP Group CIDR.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/docs/configuration/resources.html#timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the IP Group CIDR.
* `read` - (Defaults to 5 minutes) Used when retrieving the IP Group CIDR.
* `delete` - (Defaults to 30 minutes) Used when deleting the IP Group CIDR.

## Import

IP Group CIDRs can be imported using the `resourceId` of the IP Group and
the CIDR value (`/` characters have to be replaced by `_`), e.g.

```console
terraform import azurerm_ip_group_cidr.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/test-rg/providers/Microsoft.Network/ipGroups/test-ipgroup/cidrs/10.1.0.0_24
```
