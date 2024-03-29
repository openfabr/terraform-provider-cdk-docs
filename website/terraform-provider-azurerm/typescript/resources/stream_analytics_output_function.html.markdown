---
subcategory: "Stream Analytics"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_stream_analytics_output_function"
description: |-
  Manages a Stream Analytics Output Function.
---

# azurermStreamAnalyticsOutputFunction

Manages a Stream Analytics Output Function.

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
const azurermStorageAccountExample = new azurerm.storageAccount.StorageAccount(
  this,
  "example_1",
  {
    account_replication_type: "LRS",
    account_tier: "Standard",
    location: azurermResourceGroupExample.location,
    name: "examplestorageaccount",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const azurermStreamAnalyticsJobExample =
  new azurerm.streamAnalyticsJob.StreamAnalyticsJob(this, "example_2", {
    location: azurermResourceGroupExample.location,
    name: "examplestreamanalyticsjob",
    resource_group_name: azurermResourceGroupExample.name,
    streaming_units: 3,
    transformation_query:
      "    SELECT *\n    INTO [YourOutputAlias]\n    FROM [YourInputAlias]\n",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStreamAnalyticsJobExample.overrideLogicalId("example");
const azurermAppServicePlanExample = new azurerm.appServicePlan.AppServicePlan(
  this,
  "example_3",
  {
    kind: "FunctionApp",
    location: azurermResourceGroupExample.location,
    name: "exampleappserviceplan",
    reserved: true,
    resource_group_name: azurermResourceGroupExample.name,
    sku: [
      {
        size: "Y1",
        tier: "Dynamic",
      },
    ],
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermAppServicePlanExample.overrideLogicalId("example");
const azurermFunctionAppExample = new azurerm.functionApp.FunctionApp(
  this,
  "example_4",
  {
    app_service_plan_id: azurermAppServicePlanExample.id,
    location: azurermResourceGroupExample.location,
    name: "examplefunctionapp",
    os_type: "linux",
    resource_group_name: azurermResourceGroupExample.name,
    storage_account_access_key: azurermStorageAccountExample.primaryAccessKey,
    storage_account_name: azurermStorageAccountExample.name,
    version: "~3",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermFunctionAppExample.overrideLogicalId("example");
const azurermStreamAnalyticsOutputFunctionExample =
  new azurerm.streamAnalyticsOutputFunction.StreamAnalyticsOutputFunction(
    this,
    "example_5",
    {
      api_key: "exampleapikey",
      function_app: azurermFunctionAppExample.name,
      function_name: "examplefunctionname",
      name: "exampleoutput",
      resource_group_name: azurermStreamAnalyticsJobExample.resourceGroupName,
      stream_analytics_job_name: azurermStreamAnalyticsJobExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStreamAnalyticsOutputFunctionExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this Stream Analytics Output. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the Resource Group where the Stream Analytics Output should exist. Changing this forces a new resource to be created.

*   `streamAnalyticsJobName` - (Required) The name of the Stream Analytics Job. Changing this forces a new resource to be created.

*   `apiKey` - (Required) The API key for the Function.

*   `functionApp` - (Required) The name of the Function App.

*   `functionName` - (Required) The name of the function in the Function App.

***

*   `batchMaxCount` - (Optional) The maximum number of events in each batch that's sent to the function. Defaults to `100`.

*   `batchMaxInBytes` - (Optional) The maximum batch size in bytes that's sent to the function. Defaults to `262144` (256 kB).

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the Stream Analytics Output Function.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Stream Analytics Output Function.
* `read` - (Defaults to 5 minutes) Used when retrieving the Stream Analytics Output Function.
* `update` - (Defaults to 30 minutes) Used when updating the Stream Analytics Output Function.
* `delete` - (Defaults to 30 minutes) Used when deleting the Stream Analytics Output Function.

## Import

Stream Analytics Output Functions can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_stream_analytics_output_function.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.StreamAnalytics/streamingJobs/job1/outputs/output1
```
