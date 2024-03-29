---
subcategory: "Automation"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_automation_variable_datetime"
description: |-
  Gets information about an existing Automation Datetime Variable
---

# Data Source: azurermAutomationVariableDatetime

Use this data source to access information about an existing Automation Datetime Variable.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermAutomationVariableDatetimeExample =
  new azurerm.dataAzurermAutomationVariableDatetime.DataAzurermAutomationVariableDatetime(
    this,
    "example",
    {
      automation_account_name: "tfex-example-account",
      name: "tfex-example-var",
      resource_group_name: "tfex-example-rg",
    }
  );
new cdktf.TerraformOutput(this, "variable_id", {
  value: dataAzurermAutomationVariableDatetimeExample.id,
});

```

## Argument Reference

The following arguments are supported:

*   `name` - The name of the Automation Variable.

*   `resourceGroupName` - The Name of the Resource Group where the automation account exists.

*   `automationAccountName` - The name of the automation account in which the Automation Variable exists.

## Attributes Reference

The following attributes are exported:

*   `id` - The ID of the Automation Variable.

*   `description` - The description of the Automation Variable.

*   `encrypted` - Specifies if the Automation Variable is encrypted. Defaults to `false`.

*   `value` - The value of the Automation Variable in the [RFC3339 Section 5.6 Internet Date/Time Format](https://tools.ietf.org/html/rfc3339#section-5.6).

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Automation Datetime Variable.
