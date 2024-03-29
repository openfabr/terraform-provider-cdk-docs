---
subcategory: "Storage"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_hpc_cache_access_policy"
description: |-
  Manages a HPC Cache Access Policy.
---

# azurermHpcCacheAccessPolicy

Manages a HPC Cache Access Policy.

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
    name: "example-resources",
  }
);
const azurermVirtualNetworkExample = new azurerm.virtualNetwork.VirtualNetwork(
  this,
  "example_1",
  {
    address_space: ["10.0.0.0/16"],
    location: azurermResourceGroupExample.location,
    name: "examplevn",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualNetworkExample.overrideLogicalId("example");
const azurermSubnetExample = new azurerm.subnet.Subnet(this, "example_2", {
  address_prefixes: ["10.0.1.0/24"],
  name: "examplesubnet",
  resource_group_name: azurermResourceGroupExample.name,
  virtual_network_name: azurermVirtualNetworkExample.name,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubnetExample.overrideLogicalId("example");
const azurermHpcCacheExample = new azurerm.hpcCache.HpcCache(
  this,
  "example_3",
  {
    cache_size_in_gb: 3072,
    location: azurermResourceGroupExample.location,
    name: "examplehpccache",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "Standard_2G",
    subnet_id: azurermSubnetExample.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermHpcCacheExample.overrideLogicalId("example");
const azurermHpcCacheAccessPolicyExample =
  new azurerm.hpcCacheAccessPolicy.HpcCacheAccessPolicy(this, "example_4", {
    access_rule: [
      {
        access: "rw",
        scope: "default",
      },
    ],
    hpc_cache_id: azurermHpcCacheExample.id,
    name: "example",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermHpcCacheAccessPolicyExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this HPC Cache Access Policy. Changing this forces a new HPC Cache Access Policy to be created.

*   `hpcCacheId` - (Required) The ID of the HPC Cache that this HPC Cache Access Policy resides in. Changing this forces a new HPC Cache Access Policy to be created.

*   `accessRule` - (Required) Up to three `accessRule` blocks as defined below.

***

An `accessRule` block supports the following:

* `scope` - (Required) The scope of this rule. The `scope` and (potentially) the `filter` determine which clients match the rule. Possible values are: `default`, `network`, `host`.

\~> **NOTE:** Each `accessRule` should set a unique `scope`.

*   `access` - (Required) The access level for this rule. Possible values are: `rw`, `ro`, `no`.

*   `filter` - (Optional) The filter applied to the `scope` for this rule. The filter's format depends on its scope: `default` scope matches all clients and has no filter value; `network` scope takes a CIDR format; `host` takes an IP address or fully qualified domain name. If a client does not match any filter rule and there is no default rule, access is denied.

*   `suidEnabled` - (Optional) Whether [SUID](https://docs.microsoft.com/azure/hpc-cache/access-policies#suid) is allowed?

*   `submountAccessEnabled` - (Optional) Whether allow access to subdirectories under the root export?

*   `rootSquashEnabled` - (Optional) Whether to enable [root squash](https://docs.microsoft.com/azure/hpc-cache/access-policies#root-squash)?

*   `anonymousUid` - (Optional) The anonymous UID used when `rootSquashEnabled` is `true`.

*   `anonymousGid` - (Optional) The anonymous GID used when `rootSquashEnabled` is `true`.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the HPC Cache Access Policy.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the HPC Cache Access Policy.
* `read` - (Defaults to 5 minutes) Used when retrieving the HPC Cache Access Policy.
* `update` - (Defaults to 30 minutes) Used when updating the HPC Cache Access Policy.
* `delete` - (Defaults to 30 minutes) Used when deleting the HPC Cache Access Policy.

## Import

HPC Cache Access Policies can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_hpc_cache_access_policy.example /subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/group1/providers/Microsoft.StorageCache/caches/cache1/cacheAccessPolicies/policy1
```
