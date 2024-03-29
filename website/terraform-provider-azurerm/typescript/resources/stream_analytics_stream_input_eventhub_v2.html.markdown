---
subcategory: "Stream Analytics"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_stream_analytics_stream_input_eventhub_v2"
description: |-
  Manages a Stream Analytics Stream Input EventHub V2.
---

# azurermStreamAnalyticsStreamInputEventhubV2

\~> **Note:** This resource creates a Stream Input of type `microsoftEventHub/eventHub`, to create a Stream Input of type `microsoftServiceBus/eventHub` please use the resource azurerm\_stream\_analytics\_stream\_input\_eventhub.

Manages a Stream Analytics Stream Input EventHub V2.

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
const dataAzurermStreamAnalyticsJobExample =
  new azurerm.dataAzurermStreamAnalyticsJob.DataAzurermStreamAnalyticsJob(
    this,
    "example_1",
    {
      name: "example-job",
      resource_group_name: azurermResourceGroupExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAzurermStreamAnalyticsJobExample.overrideLogicalId("example");
const azurermEventhubNamespaceExample =
  new azurerm.eventhubNamespace.EventhubNamespace(this, "example_2", {
    capacity: 1,
    location: azurermResourceGroupExample.location,
    name: "example-namespace",
    resource_group_name: azurermResourceGroupExample.name,
    sku: "Standard",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermEventhubNamespaceExample.overrideLogicalId("example");
const azurermEventhubExample = new azurerm.eventhub.Eventhub(
  this,
  "example_3",
  {
    message_retention: 1,
    name: "example-eventhub",
    namespace_name: azurermEventhubNamespaceExample.name,
    partition_count: 2,
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermEventhubExample.overrideLogicalId("example");
const azurermEventhubConsumerGroupExample =
  new azurerm.eventhubConsumerGroup.EventhubConsumerGroup(this, "example_4", {
    eventhub_name: azurermEventhubExample.name,
    name: "example-consumergroup",
    namespace_name: azurermEventhubNamespaceExample.name,
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermEventhubConsumerGroupExample.overrideLogicalId("example");
const azurermStreamAnalyticsStreamInputEventhubV2Example =
  new azurerm.streamAnalyticsStreamInputEventhubV2.StreamAnalyticsStreamInputEventhubV2(
    this,
    "example_5",
    {
      eventhub_consumer_group_name: azurermEventhubConsumerGroupExample.name,
      eventhub_name: azurermEventhubExample.name,
      name: "eventhub-stream-input",
      serialization: [
        {
          encoding: "UTF8",
          type: "Json",
        },
      ],
      servicebus_namespace: azurermEventhubNamespaceExample.name,
      shared_access_policy_key:
        azurermEventhubNamespaceExample.defaultPrimaryKey,
      shared_access_policy_name: "RootManageSharedAccessKey",
      stream_analytics_job_id: dataAzurermStreamAnalyticsJobExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStreamAnalyticsStreamInputEventhubV2Example.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the Stream Input EventHub V2. Changing this forces a new resource to be created.

*   `streamAnalyticsJobId` - (Required) The name of the Stream Analytics Job. Changing this forces a new resource to be created.

*   `eventhubName` - (Required) The name of the Event Hub.

*   `servicebusNamespace` - (Required) The namespace that is associated with the desired Event Hub, Service Bus Queue, Service Bus Topic, etc.

*   `serialization` - (Required) A `serialization` block as defined below.

*   `partitionKey` - (Optional) The property the input Event Hub has been partitioned by.

*   `authenticationMode` - (Optional) The authentication mode for the Stream Output. Possible values are `msi` and `connectionString`. Defaults to `connectionString`.

*   `eventhubConsumerGroupName` - (Optional) The name of an Event Hub Consumer Group that should be used to read events from the Event Hub. Specifying distinct consumer group names for multiple inputs allows each of those inputs to receive the same events from the Event Hub. If not set the input will use the Event Hub's default consumer group.

*   `sharedAccessPolicyKey` - (Optional) The shared access policy key for the specified shared access policy.

*   `sharedAccessPolicyName` - (Optional) The shared access policy name for the Event Hub, Service Bus Queue, Service Bus Topic, etc.

***

A `serialization` block supports the following:

*   `type` - (Required) The serialization format used for incoming data streams. Possible values are `avro`, `csv` and `json`.

*   `encoding` - (Optional) The encoding of the incoming data in the case of input and the encoding of outgoing data in the case of output. It currently can only be set to `utf8`.

\-> **NOTE:** This is required when `type` is set to `csv` or `json`.

* `fieldDelimiter` - (Optional) The delimiter that will be used to separate comma-separated value (CSV) records. Possible values are `` (space), `,` (comma), `` (tab), `|` (pipe) and `;`.

\-> **NOTE:** This is required when `type` is set to `csv`.

## Attributes Reference

The following attributes are exported in addition to the arguments listed above:

* `id` - The ID of the Stream Analytics Stream Input EventHub V2.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Stream Analytics Stream Input EventHub V2.
* `update` - (Defaults to 30 minutes) Used when updating the Stream Analytics Stream Input EventHub V2.
* `read` - (Defaults to 5 minutes) Used when retrieving the Stream Analytics Stream Input EventHub V2.
* `delete` - (Defaults to 30 minutes) Used when deleting the Stream Analytics Stream Input EventHub V2.

## Import

Stream Analytics Stream Input EventHub's can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_stream_analytics_stream_input_eventhub_v2.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.StreamAnalytics/streamingJobs/job1/inputs/input1
```
