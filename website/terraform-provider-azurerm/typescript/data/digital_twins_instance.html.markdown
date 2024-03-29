---
subcategory: "Digital Twins"
layout: "azurerm"
page_title: "Azure Resource Manager: Data Source: azurerm_digital_twins_instance"
description: |-
  Gets information about an existing Digital Twins instance.
---

# Data Source: azurermDigitalTwinsInstance

Use this data source to access information about an existing Digital Twins instance.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
new azurerm.provider.AzurermProvider(this, "azurerm", {
  features: [{}],
});
const dataAzurermDigitalTwinsInstanceExample =
  new azurerm.dataAzurermDigitalTwinsInstance.DataAzurermDigitalTwinsInstance(
    this,
    "example",
    {
      name: "existing-digital-twins",
      resource_group_name: "existing-resgroup",
    }
  );
new cdktf.TerraformOutput(this, "id", {
  value: dataAzurermDigitalTwinsInstanceExample.id,
});

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name of this Digital Twins instance.

*   `resourceGroupName` - (Required) The name of the Resource Group where the Digital Twins instance exists.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Digital Twins instance.

*   `hostName` - The API endpoint to work with this Digital Twins instance.

*   `location` - The Azure Region where the Digital Twins instance exists.

*   `tags` - A mapping of tags assigned to the Digital Twins instance.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Digital Twins instance.
