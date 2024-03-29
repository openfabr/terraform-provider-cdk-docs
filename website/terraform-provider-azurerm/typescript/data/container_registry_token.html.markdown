---
subcategory: "Container"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_container_registry_token"
description: |-
  Get information about an existing Container Registry token

---

# Data Source: azurermContainerRegistryToken

Use this data source to access information about an existing Container Registry token.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermContainerRegistryTokenExample =
  new azurerm.dataAzurermContainerRegistryToken.DataAzurermContainerRegistryToken(
    this,
    "example",
    {
      container_registry_name: "example-registry",
      name: "exampletoken",
      resource_group_name: "example-resource-group",
    }
  );
new cdktf.TerraformOutput(this, "scope_map_id", {
  value: dataAzurermContainerRegistryTokenExample.scopeMapId,
});

```

## Argument Reference

* `name` - The name of the Container Registry token.
* `containerRegistryName` - The Name of the Container Registry where the token exists.
* `resourceGroupName` - The Name of the Resource Group where this Container Registry token exists.

## Attributes Reference

The following attributes are exported:

*   `id` - The Container Registry token ID.

*   `scopeMapId` - The Scope Map ID used by the token.

*   `enabled` - Whether this Token is enabled.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Container Registry token.
