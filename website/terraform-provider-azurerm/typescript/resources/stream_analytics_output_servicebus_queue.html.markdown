---
subcategory: "Stream Analytics"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_stream_analytics_output_servicebus_queue"
description: |-
  Manages a Stream Analytics Output to a ServiceBus Queue.
---

# azurermStreamAnalyticsOutputServicebusQueue

Manages a Stream Analytics Output to a ServiceBus Queue.

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
    name: "rg-example",
  }
);
const azurermServicebusNamespaceExample =
  new azurerm.servicebusNamespace.ServicebusNamespace(this, "example_1", {
    location: azurermResourceGroupExample.location,
    name: "example-namespace",
    resource_group_name: azurermResourceGroupExample.name,
    sku: "Standard",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermServicebusNamespaceExample.overrideLogicalId("example");
const azurermServicebusQueueExample =
  new azurerm.servicebusQueue.ServicebusQueue(this, "example_2", {
    enable_partitioning: true,
    name: "example-queue",
    namespace_id: azurermServicebusNamespaceExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermServicebusQueueExample.overrideLogicalId("example");
const dataAzurermStreamAnalyticsJobExample =
  new azurerm.dataAzurermStreamAnalyticsJob.DataAzurermStreamAnalyticsJob(
    this,
    "example_3",
    {
      name: "example-job",
      resource_group_name: azurermResourceGroupExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAzurermStreamAnalyticsJobExample.overrideLogicalId("example");
const azurermStreamAnalyticsOutputServicebusQueueExample =
  new azurerm.streamAnalyticsOutputServicebusQueue.StreamAnalyticsOutputServicebusQueue(
    this,
    "example_4",
    {
      name: "blob-storage-output",
      queue_name: azurermServicebusQueueExample.name,
      resource_group_name:
        dataAzurermStreamAnalyticsJobExample.resourceGroupName,
      serialization: [
        {
          format: "Array",
          type: "Csv",
        },
      ],
      servicebus_namespace: azurermServicebusNamespaceExample.name,
      shared_access_policy_key:
        azurermServicebusNamespaceExample.defaultPrimaryKey,
      shared_access_policy_name: "RootManageSharedAccessKey",
      stream_analytics_job_name: dataAzurermStreamAnalyticsJobExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStreamAnalyticsOutputServicebusQueueExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the Stream Output. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the Resource Group where the Stream Analytics Job exists. Changing this forces a new resource to be created.

*   `streamAnalyticsJobName` - (Required) The name of the Stream Analytics Job. Changing this forces a new resource to be created.

*   `queueName` - (Required) The name of the Service Bus Queue.

*   `servicebusNamespace` - (Required) The namespace that is associated with the desired Event Hub, Service Bus Queue, Service Bus Topic, etc.

*   `sharedAccessPolicyKey` - (Optional) The shared access policy key for the specified shared access policy. Required if `authenticationMode` is `connectionString`.

*   `sharedAccessPolicyName` - (Optional) The shared access policy name for the Event Hub, Service Bus Queue, Service Bus Topic, etc. Required if `authenticationMode` is `connectionString`.

*   `serialization` - (Required) A `serialization` block as defined below.

*   `propertyColumns` - (Optional) A list of property columns to add to the Service Bus Queue output.

*   `authenticationMode` - (Optional) The authentication mode for the Stream Output. Possible values are `msi` and `connectionString`. Defaults to `connectionString`.

*   `systemPropertyColumns` - (Optional) A key-value pair of system property columns that will be attached to the outgoing messages for the Service Bus Queue Output.

\-> **NOTE:** The acceptable keys are `contentType`, `correlationId`, `label`, `messageId`, `partitionKey`, `replyTo`, `replyToSessionId`, `scheduledEnqueueTimeUtc`, `sessionId`, `timeToLive` and `to`.

***

A `serialization` block supports the following:

*   `type` - (Required) The serialization format used for outgoing data streams. Possible values are `avro`, `csv`, `json` and `parquet`.

*   `encoding` - (Optional) The encoding of the incoming data in the case of input and the encoding of outgoing data in the case of output. It currently can only be set to `utf8`.

\-> **NOTE:** This is required when `type` is set to `csv` or `json`.

* `fieldDelimiter` - (Optional) The delimiter that will be used to separate comma-separated value (CSV) records. Possible values are `` (space), `,` (comma), `` (tab), `|` (pipe) and `;`.

\-> **NOTE:** This is required when `type` is set to `csv`.

* `format` - (Optional) Specifies the format of the JSON the output will be written in. Possible values are `array` and `lineSeparated`.

\-> **NOTE:** This is Required and can only be specified when `type` is set to `json`.

## Attributes Reference

The following attributes are exported in addition to the arguments listed above:

* `id` - The ID of the Stream Analytics Output ServiceBus Queue.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Stream Analytics Output ServiceBus Queue.
* `update` - (Defaults to 30 minutes) Used when updating the Stream Analytics Output ServiceBus Queue.
* `read` - (Defaults to 5 minutes) Used when retrieving the Stream Analytics Output ServiceBus Queue.
* `delete` - (Defaults to 30 minutes) Used when deleting the Stream Analytics Output ServiceBus Queue.

## Import

Stream Analytics Output ServiceBus Queue's can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_stream_analytics_output_servicebus_queue.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.StreamAnalytics/streamingJobs/job1/outputs/output1
```
