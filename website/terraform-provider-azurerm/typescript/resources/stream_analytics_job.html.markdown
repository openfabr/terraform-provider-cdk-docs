---
subcategory: "Stream Analytics"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_stream_analytics_job"
description: |-
  Manages a Stream Analytics Job.
---

# azurermStreamAnalyticsJob

Manages a Stream Analytics Job.

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
const azurermStreamAnalyticsJobExample =
  new azurerm.streamAnalyticsJob.StreamAnalyticsJob(this, "example_1", {
    compatibility_level: "1.2",
    data_locale: "en-GB",
    events_late_arrival_max_delay_in_seconds: 60,
    events_out_of_order_max_delay_in_seconds: 50,
    events_out_of_order_policy: "Adjust",
    location: azurermResourceGroupExample.location,
    name: "example-job",
    output_error_policy: "Drop",
    resource_group_name: azurermResourceGroupExample.name,
    streaming_units: 3,
    tags: {
      environment: "Example",
    },
    transformation_query:
      "    SELECT *\n    INTO [YourOutputAlias]\n    FROM [YourInputAlias]\n",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStreamAnalyticsJobExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the Stream Analytics Job. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the Resource Group where the Stream Analytics Job should exist. Changing this forces a new resource to be created.

*   `location` - (Required) The Azure Region in which the Resource Group exists. Changing this forces a new resource to be created.

*   `streamAnalyticsClusterId` - (Optional) The ID of an existing Stream Analytics Cluster where the Stream Analytics Job should run.

*   `compatibilityLevel` - (Optional) Specifies the compatibility level for this job - which controls certain runtime behaviours of the streaming job. Possible values are `10`, `11` and `12`.

\-> **NOTE:** Support for Compatibility Level 1.2 is dependent on a new version of the Stream Analytics API, which [being tracked in this issue](https://github.com/Azure/azure-rest-api-specs/issues/5604).

*   `dataLocale` - (Optional) Specifies the Data Locale of the Job, which [should be a supported .NET Culture](https://msdn.microsoft.com/en-us/library/system.globalization.culturetypes\(v=vs.110\).aspx).

*   `eventsLateArrivalMaxDelayInSeconds` - (Optional) Specifies the maximum tolerable delay in seconds where events arriving late could be included. Supported range is `1` (indefinite) to `1814399` (20d 23h 59m 59s). Default is `0`.

*   `eventsOutOfOrderMaxDelayInSeconds` - (Optional) Specifies the maximum tolerable delay in seconds where out-of-order events can be adjusted to be back in order. Supported range is `0` to `599` (9m 59s). Default is `5`.

*   `eventsOutOfOrderPolicy` - (Optional) Specifies the policy which should be applied to events which arrive out of order in the input event stream. Possible values are `adjust` and `drop`. Default is `adjust`.

*   `type` - (Optional) The type of the Stream Analytics Job. Possible values are `cloud` and `edge`. Defaults to `cloud`. Changing this forces a new resource to be created.

\-> **NOTE:** `edge` doesn't support `streamAnalyticsClusterId` and `streamingUnits`.

*   `identity` - (Optional) An `identity` block as defined below.

*   `outputErrorPolicy` - (Optional) Specifies the policy which should be applied to events which arrive at the output and cannot be written to the external storage due to being malformed (such as missing column values, column values of wrong type or size). Possible values are `drop` and `stop`. Default is `drop`.

*   `streamingUnits` - (Optional) Specifies the number of streaming units that the streaming job uses. Supported values are `1`, `3`, `6` and multiples of `6` up to `120`.

\-> **NOTE:** `streamingUnits` must be set when `type` is `cloud`.

*   `contentStoragePolicy` - (Optional) The policy for storing stream analytics content. Possible values are `jobStorageAccount`, `systemAccount`.

*   `jobStorageAccount` - (Optional) The details of the job storage account. A `jobStorageAccount` block as defined below.

***

A `jobStorageAccount` block supports the following:

*   `authenticationMode` - (Optional) The authentication mode of the storage account. The only supported value is `connectionString`. Defaults to `connectionString`.

*   `accountName` - (Required) The name of the Azure storage account.

*   `accountKey` - (Required) The account key for the Azure storage account.

***

*   `transformationQuery` - (Required) Specifies the query that will be run in the streaming job, [written in Stream Analytics Query Language (SAQL)](https://msdn.microsoft.com/library/azure/dn834998).

*   `tags` - (Optional) A mapping of tags assigned to the resource.

***

An `identity` block supports the following:

* `type` - (Required) Specifies the type of Managed Service Identity that should be configured on this Stream Analytics Job. The only possible value is `systemAssigned`.

## Attributes Reference

The following attributes are exported in addition to the arguments listed above:

*   `id` - The ID of the Stream Analytics Job.

*   `jobId` - The Job ID assigned by the Stream Analytics Job.

*   `identity` - (Optional) An `identity` block as defined below.

***

An `identity` block exports the following:

*   `principalId` - The Principal ID associated with this Managed Service Identity.

*   `tenantId` - The Tenant ID associated with this Managed Service Identity.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Stream Analytics Job.
* `update` - (Defaults to 30 minutes) Used when updating the Stream Analytics Job.
* `read` - (Defaults to 5 minutes) Used when retrieving the Stream Analytics Job.
* `delete` - (Defaults to 30 minutes) Used when deleting the Stream Analytics Job.

## Import

Stream Analytics Job's can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_stream_analytics_job.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.StreamAnalytics/streamingJobs/job1
```
