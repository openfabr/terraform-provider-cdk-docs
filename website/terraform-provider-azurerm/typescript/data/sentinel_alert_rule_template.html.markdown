---
subcategory: "Sentinel"
layout: "azurerm"
page_title: "Azure Resource Manager: Data Source: azurerm_sentinel_alert_rule_template"
description: |-
  Gets information about an existing Sentinel Alert Rule Template.
---

# Data Source: azurermSentinelAlertRuleTemplate

Use this data source to access information about an existing Sentinel Alert Rule Template.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermSentinelAlertRuleTemplateExample =
  new azurerm.dataAzurermSentinelAlertRuleTemplate.DataAzurermSentinelAlertRuleTemplate(
    this,
    "example",
    {
      display_name:
        "Create incidents based on Azure Security Center for IoT alerts",
      log_analytics_workspace_id:
        "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.OperationalInsights/workspaces/workspace1",
    }
  );
new cdktf.TerraformOutput(this, "id", {
  value: dataAzurermSentinelAlertRuleTemplateExample.id,
});

```

## Arguments Reference

The following arguments are supported:

* `logAnalyticsWorkspaceId` - (Required) The ID of the Log Analytics Workspace.

***

*   `name` - (Optional) The name of this Sentinel Alert Rule Template. Either `displayName` or `name` have to be specified.

*   `displayName` - (Optional) The display name of this Sentinel Alert Rule Template. Either `displayName` or `name` have to be specified.

\~> **NOTE** As `displayName` is not unique, errors may occur when there are multiple Sentinel Alert Rule Template with same `displayName`.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Sentinel.

*   `nrtTemplate` - A `nrtTemplate` block as defined below. This only applies to Sentinel NRT Alert Rule Template.

*   `securityIncidentTemplate` - A `securityIncidentTemplate` block as defined below. This only applies to Sentinel MS Security Incident Alert Rule Template.

*   `scheduledTemplate` - A `scheduledTemplate` block as defined below. This only applies to Sentinel Scheduled Alert Rule Template.

***

A `nrtTemplate` block exports the following:

*   `description` - The description of this Sentinel NRT Alert Rule Template.

*   `query` - The query of this Sentinel NRT Alert Rule Template.

*   `severity` - The alert severity of this Sentinel NRT Alert Rule Template.

*   `tactics` - A list of categories of attacks by which to classify the rule.

***

A `securityIncidentTemplate` block exports the following:

*   `description` - The description of this Sentinel MS Security Incident Alert Rule Template.

*   `productFilter` - The Microsoft Security Service from where the alert will be generated.

***

A `scheduledTemplate` block exports the following:

*   `description` - The description of this Sentinel Scheduled Alert Rule Template.

*   `query` - The query of this Sentinel Scheduled Alert Rule Template.

*   `queryFrequency` - The ISO 8601 timespan duration between two consecutive queries.

*   `queryPeriod` - The ISO 8601 timespan duration, which determine the time period of the data covered by the query.

*   `severity` - The alert severity of this Sentinel Scheduled Alert Rule Template.

*   `tactics` - A list of categories of attacks by which to classify the rule.

*   `triggerOperator` - The alert trigger operator, combined with `triggerThreshold`, setting alert threshold of this Sentinel Scheduled Alert Rule Template.

*   `triggerThreshold` - The baseline number of query results generated, combined with `triggerOperator`, setting alert threshold of this Sentinel Scheduled Alert Rule Template.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Sentinel.
