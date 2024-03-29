---
subcategory: "Log Analytics"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_log_analytics_saved_search"
description: |-
  Manages a Log Analytics (formally Operational Insights) Saved Search.
---

# azurermLogAnalyticsSavedSearch

Manages a Log Analytics (formally Operational Insights) Saved Search.

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
const azurermLogAnalyticsWorkspaceExample =
  new azurerm.logAnalyticsWorkspace.LogAnalyticsWorkspace(this, "example_1", {
    location: azurermResourceGroupExample.location,
    name: "acctest-01",
    resource_group_name: azurermResourceGroupExample.name,
    retention_in_days: 30,
    sku: "PerGB2018",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLogAnalyticsWorkspaceExample.overrideLogicalId("example");
const azurermLogAnalyticsSavedSearchExample =
  new azurerm.logAnalyticsSavedSearch.LogAnalyticsSavedSearch(
    this,
    "example_2",
    {
      category: "exampleCategory",
      display_name: "exampleDisplayName",
      log_analytics_workspace_id: azurermLogAnalyticsWorkspaceExample.id,
      name: "exampleSavedSearch",
      query: "exampleQuery",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLogAnalyticsSavedSearchExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Specifies the name of the Log Analytics Saved Search. Changing this forces a new resource to be created.

*   `logAnalyticsWorkspaceId` - (Required) Specifies the ID of the Log Analytics Workspace that the Saved Search will be associated with. Changing this forces a new resource to be created.

*   `displayName` - (Required) The name that Saved Search will be displayed as. Changing this forces a new resource to be created.

*   `category` - (Required) The category that the Saved Search will be listed under. Changing this forces a new resource to be created.

*   `query` - (Required) The query expression for the saved search. Changing this forces a new resource to be created.

*   `functionAlias` - (Optional) The function alias if the query serves as a function. Changing this forces a new resource to be created.

*   `functionParameters` - (Optional) The function parameters if the query serves as a function. Changing this forces a new resource to be created.

*   `tags` - (Optional) A mapping of tags which should be assigned to the Logs Analytics Saved Search. Changing this forces a new resource to be created.

## Attributes Reference

The following attributes are exported:

* `id` - The Log Analytics Saved Search ID.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Log Analytics Saved Search.
* `update` - (Defaults to 30 minutes) Used when updating the Log Analytics Saved Search.
* `read` - (Defaults to 5 minutes) Used when retrieving the Log Analytics Saved Search.
* `delete` - (Defaults to 30 minutes) Used when deleting the Log Analytics Saved Search.

## Import

Log Analytics Saved Searches can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_log_analytics_saved_search.search1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.OperationalInsights/workspaces/workspace1/savedSearches/search1
```
