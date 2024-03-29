---
subcategory: "Container"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_container_registry_token"
description: |-
  Manages an Azure Container Registry token.

---

# azurermContainerRegistryToken

Manages an Azure Container Registry token. Tokens are a preview feature only available in Premium SKU Container registries.

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
    name: "example-resource-group",
  }
);
const azurermContainerRegistryExample =
  new azurerm.containerRegistry.ContainerRegistry(this, "example_1", {
    admin_enabled: false,
    georeplications: [
      {
        location: "East US",
      },
      {
        location: "West Europe",
      },
    ],
    location: azurermResourceGroupExample.location,
    name: "example",
    resource_group_name: azurermResourceGroupExample.name,
    sku: "Premium",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermContainerRegistryExample.overrideLogicalId("example");
const azurermContainerRegistryScopeMapExample =
  new azurerm.containerRegistryScopeMap.ContainerRegistryScopeMap(
    this,
    "example_2",
    {
      actions: [
        "repositories/repo1/content/read",
        "repositories/repo1/content/write",
      ],
      container_registry_name: azurermContainerRegistryExample.name,
      name: "example-scope-map",
      resource_group_name: azurermResourceGroupExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermContainerRegistryScopeMapExample.overrideLogicalId("example");
const azurermContainerRegistryTokenExample =
  new azurerm.containerRegistryToken.ContainerRegistryToken(this, "example_3", {
    container_registry_name: azurermContainerRegistryExample.name,
    name: "exampletoken",
    resource_group_name: azurermResourceGroupExample.name,
    scope_map_id: azurermContainerRegistryScopeMapExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermContainerRegistryTokenExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Specifies the name of the token. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the resource group in which to create the Container Registry token. Changing this forces a new resource to be created.

*   `containerRegistryName` - (Required) The name of the Container Registry. Changing this forces a new resource to be created.

*   `scopeMapId` - (Required) The ID of the Container Registry Scope Map associated with the token.

*   `enabled` - (Optional) Should the Container Registry token be enabled? Defaults to `true`.

***

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the Container Registry token.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Container Registry token.
* `update` - (Defaults to 30 minutes) Used when updating the Container Registry token.
* `read` - (Defaults to 5 minutes) Used when retrieving the Container Registry token.
* `delete` - (Defaults to 30 minutes) Used when deleting the Container Registry token.

## Import

Container Registries can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_container_registry_token.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.ContainerRegistry/registries/myregistry1/tokens/token1
```
