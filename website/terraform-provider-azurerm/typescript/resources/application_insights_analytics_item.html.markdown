---
subcategory: "Application Insights"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_application_insights_analytics_item"
description: |-
  Manages an Application Insights Analytics Item component.
---

# azurermApplicationInsightsAnalyticsItem

Manages an Application Insights Analytics Item component.

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
    name: "tf-test",
  }
);
const azurermApplicationInsightsExample =
  new azurerm.applicationInsights.ApplicationInsights(this, "example_1", {
    application_type: "web",
    location: azurermResourceGroupExample.location,
    name: "tf-test-appinsights",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermApplicationInsightsExample.overrideLogicalId("example");
const azurermApplicationInsightsAnalyticsItemExample =
  new azurerm.applicationInsightsAnalyticsItem.ApplicationInsightsAnalyticsItem(
    this,
    "example_2",
    {
      application_insights_id: azurermApplicationInsightsExample.id,
      content: "requests //simple example query",
      name: "testquery",
      scope: "shared",
      type: "query",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermApplicationInsightsAnalyticsItemExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Specifies the name of the Application Insights Analytics Item. Changing this forces a new resource to be created.

*   `applicationInsightsId` - (Required) The ID of the Application Insights component on which the Analytics Item exists. Changing this forces a new resource to be created.

*   `type` - (Required) The type of Analytics Item to create. Can be one of `query`, `function`, `folder`, `recent`. Changing this forces a new resource to be created.

*   `scope` - (Required) The scope for the Analytics Item. Can be `shared` or `user`. Changing this forces a new resource to be created. Must be `shared` for functions.

*   `content` - (Required) The content for the Analytics Item, for example the query text if `type` is `query`.

*   `functionAlias` - (Optional) The alias to use for the function. Required when `type` is `function`.

## Attributes Reference

The following attributes are exported:

*   `id` - The ID of the Application Insights Analytics Item.

*   `timeCreated` - A string containing the time the Analytics Item was created.

*   `timeModified` - A string containing the time the Analytics Item was last modified.

*   `version` - A string indicating the version of the query format

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Application Insights Analytics Item.
* `update` - (Defaults to 30 minutes) Used when updating the Application Insights Analytics Item.
* `read` - (Defaults to 5 minutes) Used when retrieving the Application Insights Analytics Item.
* `delete` - (Defaults to 30 minutes) Used when deleting the Application Insights Analytics Item.

## Import

Application Insights Analytics Items can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_application_insights_analytics_item.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Insights/components/mycomponent1/analyticsItems/11111111-1111-1111-1111-111111111111
```

\-> **Please Note:** This is a Terraform Unique ID matching the format: `{appInsightsId}/analyticsItems/{itemId}` for items with `scope` set to `shared`, or  `{appInsightsId}/myAnalyticsItems/{itemId}` for items with `scope` set to `user`

To find the Analytics Item ID you can query the REST API using the [`azRest` CLI command](https://docs.microsoft.com/cli/azure/reference-index?view=azure-cli-latest#az-rest), e.g.

```console
az rest --method GET --uri "https://management.azure.com/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/microsoft.insights/components/appinsightstest/analyticsItems?api-version=2015-05-01"
```
