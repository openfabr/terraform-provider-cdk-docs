---
subcategory: "Blueprints"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_blueprint_definition"
description: |-
  Gets information about an existing Blueprint Definition
---

# Data Source: azurermBlueprintDefinition

Use this data source to access information about an existing Azure Blueprint Definition

\~> **NOTE:** Azure Blueprints are in Preview and potentially subject to breaking change without notice.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermClientConfigCurrent =
  new azurerm.dataAzurermClientConfig.DataAzurermClientConfig(
    this,
    "current",
    {}
  );
const dataAzurermManagementGroupRoot =
  new azurerm.dataAzurermManagementGroup.DataAzurermManagementGroup(
    this,
    "root",
    {
      name: dataAzurermClientConfigCurrent.tenantId,
    }
  );
new azurerm.dataAzurermBlueprintDefinition.DataAzurermBlueprintDefinition(
  this,
  "example",
  {
    name: "exampleManagementGroupBP",
    scope_id: dataAzurermManagementGroupRoot.id,
  }
);

```

## Argument Reference

*   `name` - (Required) The name of the Blueprint.

*   `scopeId` - (Required) The ID of the Subscription or Management Group, as the scope at which the blueprint definition is stored.

## Attributes Reference

*   `id` - The ID of the Blueprint Definition.

*   `description` - The description of the Blueprint Definition.

*   `displayName` - The display name of the Blueprint Definition.

*   `lastModified` - The timestamp of when this last modification was saved to the Blueprint Definition.

*   `targetScope` - The target scope.

*   `timeCreated` - The timestamp of when this Blueprint Definition was created.

*   `versions` - A list of versions published for this Blueprint Definition.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Blueprint Published Version.
