---
subcategory: "Messaging"
layout: "azurerm"
page_title: "Azure Resource Manager: Data Source: azurerm_servicebus_queue"
description: |-
  Gets information about an existing Service Bus Queue.
---

# Data Source: azurermServicebusQueue

Use this data source to access information about an existing Service Bus Queue.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermServicebusQueueExample =
  new azurerm.dataAzurermServicebusQueue.DataAzurermServicebusQueue(
    this,
    "example",
    {
      name: "existing",
      namespace_name: "existing",
      resource_group_name: "existing",
    }
  );
new cdktf.TerraformOutput(this, "id", {
  value: dataAzurermServicebusQueueExample.id,
});

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name of this Service Bus Queue.

*   `namespaceName` - (Required) The name of the ServiceBus Namespace.

*   `resourceGroupName` - (Required) The name of the Resource Group where the Service Bus Queue exists.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Service Bus Queue.

*   `autoDeleteOnIdle` - The ISO 8601 timespan duration of the idle interval after which the Queue is automatically deleted, minimum of 5 minutes.

*   `deadLetteringOnMessageExpiration` - Boolean flag which controls whether the Queue has dead letter support when a message expires.

*   `defaultMessageTtl` - The ISO 8601 timespan duration of the TTL of messages sent to this queue. This is the default value used when TTL is not set on a message itself.

*   `duplicateDetectionHistoryTimeWindow` - The ISO 8601 timespan duration during which duplicates can be detected.

*   `enableBatchedOperations` - Boolean flag which controls whether server-side batched operations are enabled.

*   `enableExpress` - Boolean flag which controls whether Express Entities are enabled. An express queue holds a message in memory temporarily before writing it to persistent storage.

*   `enablePartitioning` - Boolean flag which controls whether to enable the queue to be partitioned across multiple message brokers.

*   `forwardDeadLetteredMessagesTo` - The name of a Queue or Topic to automatically forward dead lettered messages to.

*   `forwardTo` - The name of a Queue or Topic to automatically forward messages to. Please [see the documentation](https://docs.microsoft.com/azure/service-bus-messaging/service-bus-auto-forwarding) for more information.

*   `lockDuration` - The ISO 8601 timespan duration of a peek-lock; that is, the amount of time that the message is locked for other receivers.

*   `maxDeliveryCount` - Integer value which controls when a message is automatically dead lettered.

*   `maxSizeInMegabytes` - Integer value which controls the size of memory allocated for the queue. For supported values see the "Queue or topic size" section of [Service Bus Quotas](https://docs.microsoft.com/azure/service-bus-messaging/service-bus-quotas).

*   `requiresDuplicateDetection` - Boolean flag which controls whether the Queue requires duplicate detection.

*   `requiresSession` - Boolean flag which controls whether the Queue requires sessions. This will allow ordered handling of unbounded sequences of related messages. With sessions enabled a queue can guarantee first-in-first-out delivery of messages.

*   `status` -  The status of the Queue. Possible values are `active`, `creating`, `deleting`, `disabled`, `receiveDisabled`, `renaming`, `sendDisabled`, `unknown`.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Service Bus Queue.
