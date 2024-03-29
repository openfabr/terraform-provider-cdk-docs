---
subcategory: "Base"
layout: "azurerm"
page_title: "Azure Resource Manager: Data Source: azurerm_resource_group"
description: |-
  Gets information about an existing Resource Group.
---

# Data Source: azurermResourceGroup

Use this data source to access information about an existing Resource Group.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermResourceGroupExample =
  new azurerm.dataAzurermResourceGroup.DataAzurermResourceGroup(
    this,
    "example",
    {
      name: "existing",
    }
  );
new cdktf.TerraformOutput(this, "id", {
  value: dataAzurermResourceGroupExample.id,
});

```

## Arguments Reference

The following arguments are supported:

* `name` - (Required) The Name of this Resource Group.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Resource Group.

*   `location` - The Azure Region where the Resource Group exists.

*   `tags` - A mapping of tags assigned to the Resource Group.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Resource Group.
