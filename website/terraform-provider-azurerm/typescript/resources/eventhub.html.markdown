---
subcategory: "Messaging"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_eventhub"
description: |-
  Manages a Event Hubs as a nested resource within an Event Hubs namespace.
---

# azurermEventhub

Manages a Event Hubs as a nested resource within a Event Hubs namespace.

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
const azurermEventhubNamespaceExample =
  new azurerm.eventhubNamespace.EventhubNamespace(this, "example_1", {
    capacity: 1,
    location: azurermResourceGroupExample.location,
    name: "acceptanceTestEventHubNamespace",
    resource_group_name: azurermResourceGroupExample.name,
    sku: "Standard",
    tags: {
      environment: "Production",
    },
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermEventhubNamespaceExample.overrideLogicalId("example");
const azurermEventhubExample = new azurerm.eventhub.Eventhub(
  this,
  "example_2",
  {
    message_retention: 1,
    name: "acceptanceTestEventHub",
    namespace_name: azurermEventhubNamespaceExample.name,
    partition_count: 2,
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermEventhubExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Specifies the name of the EventHub resource. Changing this forces a new resource to be created.

*   `namespaceName` - (Required) Specifies the name of the EventHub Namespace. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the resource group in which the EventHub's parent Namespace exists. Changing this forces a new resource to be created.

*   `partitionCount` - (Required) Specifies the current number of shards on the Event Hub. Changing this will force-recreate the resource.

\~> **Note:** `partitionCount` cannot be changed unless Eventhub Namespace SKU is `premium`.

\~> **Note:** When using a dedicated Event Hubs cluster, maximum value of `partitionCount` is 1024. When using a shared parent EventHub Namespace, maximum value is 32.

* `messageRetention` - (Required) Specifies the number of days to retain the events for this Event Hub.

\~> **Note:** When using a dedicated Event Hubs cluster, maximum value of `messageRetention` is 90 days. When using a shared parent EventHub Namespace, maximum value is 7 days; or 1 day when using a Basic SKU for the shared parent EventHub Namespace.

*   `captureDescription` - (Optional) A `captureDescription` block as defined below.

*   `status` - (Optional) Specifies the status of the Event Hub resource. Possible values are `active`, `disabled` and `sendDisabled`. Defaults to `active`.

***

A `captureDescription` block supports the following:

*   `enabled` - (Required) Specifies if the Capture Description is Enabled.

*   `encoding` - (Required) Specifies the Encoding used for the Capture Description. Possible values are `avro` and `avroDeflate`.

*   `intervalInSeconds` - (Optional) Specifies the time interval in seconds at which the capture will happen. Values can be between `60` and `900` seconds. Defaults to `300` seconds.

*   `sizeLimitInBytes` - (Optional) Specifies the amount of data built up in your EventHub before a Capture Operation occurs. Value should be between `10485760` and `524288000` bytes. Defaults to `314572800` bytes.

*   `skipEmptyArchives` - (Optional) Specifies if empty files should not be emitted if no events occur during the Capture time window. Defaults to `false`.

*   `destination` - (Required) A `destination` block as defined below.

***

A `destination` block supports the following:

* `name` - (Required) The Name of the Destination where the capture should take place. At this time the only supported value is `eventHubArchiveAzureBlockBlob`.

\-> At this time it's only possible to Capture EventHub messages to Blob Storage. There's [a Feature Request for the Azure SDK to add support for Capturing messages to Azure Data Lake here](https://github.com/Azure/azure-rest-api-specs/issues/2255).

*   `archiveNameFormat` - (Required) The Blob naming convention for archiving. e.g. `{namespace}/{eventHub}/{partitionId}/{year}/{month}/{day}/{hour}/{minute}/{second}`. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order

*   `blobContainerName` - (Required) The name of the Container within the Blob Storage Account where messages should be archived.

*   `storageAccountId` - (Required) The ID of the Blob Storage Account where messages should be archived.

## Attributes Reference

The following attributes are exported:

*   `id` - The ID of the EventHub.

*   `partitionIds` - The identifiers for partitions created for Event Hubs.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the EventHub.
* `update` - (Defaults to 30 minutes) Used when updating the EventHub.
* `read` - (Defaults to 5 minutes) Used when retrieving the EventHub.
* `delete` - (Defaults to 30 minutes) Used when deleting the EventHub.

## Import

EventHubs can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_eventhub.eventhub1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.EventHub/namespaces/namespace1/eventhubs/eventhub1
```
