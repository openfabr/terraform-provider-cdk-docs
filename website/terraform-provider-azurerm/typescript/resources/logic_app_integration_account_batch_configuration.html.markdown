---
subcategory: "Logic App"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_logic_app_integration_account_batch_configuration"
description: |-
  Manages a Logic App Integration Account Batch Configuration.
---

# azurermLogicAppIntegrationAccountBatchConfiguration

Manages a Logic App Integration Account Batch Configuration.

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
const azurermLogicAppIntegrationAccountExample =
  new azurerm.logicAppIntegrationAccount.LogicAppIntegrationAccount(
    this,
    "example_1",
    {
      location: azurermResourceGroupExample.location,
      name: "example-ia",
      resource_group_name: azurermResourceGroupExample.name,
      sku_name: "Standard",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLogicAppIntegrationAccountExample.overrideLogicalId("example");
const azurermLogicAppIntegrationAccountBatchConfigurationExample =
  new azurerm.logicAppIntegrationAccountBatchConfiguration.LogicAppIntegrationAccountBatchConfiguration(
    this,
    "example_2",
    {
      batch_group_name: "TestBatchGroup",
      integration_account_name: azurermLogicAppIntegrationAccountExample.name,
      name: "exampleiabc",
      release_criteria: [
        {
          message_count: 80,
        },
      ],
      resource_group_name: azurermResourceGroupExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLogicAppIntegrationAccountBatchConfigurationExample.overrideLogicalId(
  "example"
);

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this Logic App Integration Account Batch Configuration. Only Alphanumeric characters allowed. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the Resource Group where the Logic App Integration Account Batch Configuration should exist. Changing this forces a new resource to be created.

*   `integrationAccountName` - (Required) The name of the Logic App Integration Account. Changing this forces a new resource to be created.

*   `batchGroupName` - (Required) The batch group name of the Logic App Integration Batch Configuration. Changing this forces a new resource to be created.

*   `releaseCriteria` - (Required) A `releaseCriteria` block as documented below, which is used to select the criteria to meet before processing each batch.

*   `metadata` - (Optional) A JSON mapping of any Metadata for this Logic App Integration Account Batch Configuration.

***

A `releaseCriteria` block exports the following:

*   `batchSize` - (Optional) The batch size in bytes for the Logic App Integration Batch Configuration.

*   `messageCount` - (Optional) The message count for the Logic App Integration Batch Configuration.

*   `recurrence` - (Optional) A `recurrence` block as documented below.

***

A `recurrence` block exports the following:

*   `frequency` - (Required) The frequency of the schedule. Possible values are `day`, `hour`, `minute`, `month`, `notSpecified`, `second`, `week` and `year`.

*   `interval` - (Required) The number of `frequency`s between runs.

*   `endTime` - (Optional) The end time of the schedule, formatted as an RFC3339 string.

*   `schedule` - (Optional) A `schedule` block as documented below.

*   `startTime` - (Optional) The start time of the schedule, formatted as an RFC3339 string.

*   `timeZone` - (Optional) The timezone of the start/end time.

***

A `schedule` block exports the following:

*   `hours` - (Optional) A list containing a single item, which specifies the Hour interval at which this recurrence should be triggered.

*   `minutes` - (Optional) A list containing a single item which specifies the Minute interval at which this recurrence should be triggered.

*   `monthDays` - (Optional) A list of days of the month that the job should execute on.

*   `monthly` - (Optional) A `monthly` block as documented below.

*   `weekDays` - (Optional) A list of days of the week that the job should execute on. Possible values are `sunday`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday` and `saturday`.

***

A `monthly` block exports the following:

*   `weekday` - (Required) The day of the occurrence. Possible values are `sunday`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday` and `saturday`.

*   `week` - (Required) The occurrence of the week within the month.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the Logic App Integration Account Batch Configuration.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Logic App Integration Account Batch Configuration.
* `read` - (Defaults to 5 minutes) Used when retrieving the Logic App Integration Account Batch Configuration.
* `update` - (Defaults to 30 minutes) Used when updating the Logic App Integration Account Batch Configuration.
* `delete` - (Defaults to 30 minutes) Used when deleting the Logic App Integration Account Batch Configuration.

## Import

Logic App Integration Account Batch Configurations can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_logic_app_integration_account_batch_configuration.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.Logic/integrationAccounts/account1/batchConfigurations/batchConfiguration1
```
