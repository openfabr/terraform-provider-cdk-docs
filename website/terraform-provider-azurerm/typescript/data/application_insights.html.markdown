---
subcategory: "Application Insights"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_application_insights"
description: |-
  Gets information about an existing Application Insights component.
---

# Data Source: azurermApplicationInsights

Use this data source to access information about an existing Application Insights component.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermApplicationInsightsExample =
  new azurerm.dataAzurermApplicationInsights.DataAzurermApplicationInsights(
    this,
    "example",
    {
      name: "production",
      resource_group_name: "networking",
    }
  );
new cdktf.TerraformOutput(this, "application_insights_instrumentation_key", {
  value: dataAzurermApplicationInsightsExample.instrumentationKey,
});

```

## Argument Reference

* `name` - Specifies the name of the Application Insights component.
* `resourceGroupName` - Specifies the name of the resource group the Application Insights component is located in.

## Attributes Reference

* `id` - The ID of the Application Insights component.
* `appId` - The App ID associated with this Application Insights component.
* `applicationType` - The type of the component.
* `instrumentationKey` - The instrumentation key of the Application Insights component.
* `connectionString` - The connection string of the Application Insights component. (Sensitive)
* `location` - The Azure location where the component exists.
* `retentionInDays` - The retention period in days.
* `workspaceId` - The id of the associated Log Analytics workspace
* `tags` - Tags applied to the component.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Application Insights component.
