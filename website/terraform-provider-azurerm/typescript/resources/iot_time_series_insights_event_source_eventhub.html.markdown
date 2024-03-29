---
subcategory: "Time Series Insights"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_iot_time_series_insights_event_source_eventhub"
description: |-
  Manages an Azure IoT Time Series Insights EventHub Event Source.
---

# azurermTimeSeriesInsightsEventSourceEventhub

Manages an Azure IoT Time Series Insights EventHub Event Source.

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
    name: "example",
  }
);
const azurermStorageAccountExample = new azurerm.storageAccount.StorageAccount(
  this,
  "example_1",
  {
    account_replication_type: "LRS",
    account_tier: "Standard",
    location: azurermResourceGroupExample.location,
    name: "example",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const azurermEventhubNamespaceExample =
  new azurerm.eventhubNamespace.EventhubNamespace(this, "example_2", {
    location: azurermResourceGroupExample.location,
    name: "example",
    resource_group_name: azurermResourceGroupExample.name,
    sku: "Standard",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermEventhubNamespaceExample.overrideLogicalId("example");
const azurermIotTimeSeriesInsightsGen2EnvironmentExample =
  new azurerm.iotTimeSeriesInsightsGen2Environment.IotTimeSeriesInsightsGen2Environment(
    this,
    "example_3",
    {
      id_properties: ["id"],
      location: azurermResourceGroupExample.location,
      name: "example",
      resource_group_name: azurermResourceGroupExample.name,
      sku_name: "L1",
      storage: [
        {
          key: azurermStorageAccountExample.primaryAccessKey,
          name: azurermStorageAccountExample.name,
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermIotTimeSeriesInsightsGen2EnvironmentExample.overrideLogicalId("example");
const azurermEventhubExample = new azurerm.eventhub.Eventhub(
  this,
  "example_4",
  {
    message_retention: 7,
    name: "example",
    namespace_name: azurermEventhubNamespaceExample.name,
    partition_count: 2,
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermEventhubExample.overrideLogicalId("example");
const azurermEventhubAuthorizationRuleExample =
  new azurerm.eventhubAuthorizationRule.EventhubAuthorizationRule(
    this,
    "example_5",
    {
      eventhub_name: azurermEventhubExample.name,
      listen: true,
      manage: false,
      name: "example",
      namespace_name: azurermEventhubNamespaceExample.name,
      resource_group_name: azurermResourceGroupExample.name,
      send: false,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermEventhubAuthorizationRuleExample.overrideLogicalId("example");
const azurermEventhubConsumerGroupExample =
  new azurerm.eventhubConsumerGroup.EventhubConsumerGroup(this, "example_6", {
    eventhub_name: azurermEventhubExample.name,
    name: "example",
    namespace_name: azurermEventhubNamespaceExample.name,
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermEventhubConsumerGroupExample.overrideLogicalId("example");
const azurermIotTimeSeriesInsightsEventSourceEventhubExample =
  new azurerm.iotTimeSeriesInsightsEventSourceEventhub.IotTimeSeriesInsightsEventSourceEventhub(
    this,
    "example_7",
    {
      consumer_group_name: azurermEventhubConsumerGroupExample.name,
      environment_id: azurermIotTimeSeriesInsightsGen2EnvironmentExample.id,
      event_source_resource_id: azurermEventhubExample.id,
      eventhub_name: azurermEventhubExample.name,
      location: azurermResourceGroupExample.location,
      name: "example",
      namespace_name: azurermEventhubNamespaceExample.name,
      shared_access_key: azurermEventhubAuthorizationRuleExample.primaryKey,
      shared_access_key_name: azurermEventhubAuthorizationRuleExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermIotTimeSeriesInsightsEventSourceEventhubExample.overrideLogicalId(
  "example"
);

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Specifies the name of the Azure IoT Time Series Insights EventHub Event Source. Changing this forces a new resource to be created. Must be globally unique.

*   `environmentId` - (Required) Specifies the id of the IoT Time Series Insights Environment that the Event Source should be associated with. Changing this forces a new resource to created.

*   `location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.

*   `eventhubName` - (Required) Specifies the name of the EventHub which will be associated with this resource.

*   `consumerGroupName` - (Required) Specifies the name of the EventHub Consumer Group that holds the partitions from which events will be read.

*   `eventSourceResourceId` - (Required) Specifies the resource id where events will be coming from.

*   `namespaceName` - (Required) Specifies the EventHub Namespace name.

*   `sharedAccessKeyName` - (Required) Specifies the name of the Shared Access key that grants the Event Source access to the EventHub.

*   `sharedAccessKey` - (Required) Specifies the value of the Shared Access Policy key that grants the Time Series Insights service read access to the EventHub.

*   `timestampPropertyName` - (Optional) Specifies the value that will be used as the event source's timestamp. This value defaults to the event creation time.

*   `tags` - (Optional) A mapping of tags to assign to the resource.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the IoT Time Series Insights EventHub Event Source.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the IoT Time Series Insights EventHub Event Source.
* `update` - (Defaults to 30 minutes) Used when updating the IoT Time Series Insights EventHub Event Source.
* `read` - (Defaults to 5 minutes) Used when retrieving the IoT Time Series Insights EventHub Event Source.
* `delete` - (Defaults to 30 minutes) Used when deleting the IoT Time Series Insights EventHub Event Source.

## Import

Azure IoT Time Series Insights EventHub Event Source can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_iot_time_series_insights_event_source_eventhub.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example/providers/Microsoft.TimeSeriesInsights/environments/environment1/eventSources/example
```
