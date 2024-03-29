---
subcategory: "Messaging"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_eventgrid_system_topic"
description: |-
  Manages an Event Grid System Topic
---

# azurermEventgridSystemTopic

Manages an Event Grid System Topic.

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
    name: "examplestoracct",
    resource_group_name: azurermResourceGroupExample.name,
    tags: {
      environment: "staging",
    },
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const azurermEventgridSystemTopicExample =
  new azurerm.eventgridSystemTopic.EventgridSystemTopic(this, "example_2", {
    location: azurermResourceGroupExample.location,
    name: "example-topic",
    resource_group_name: azurermResourceGroupExample.name,
    source_arm_resource_id: azurermStorageAccountExample.id,
    topic_type: "Microsoft.Storage.StorageAccounts",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermEventgridSystemTopicExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `location` - (Required) The Azure Region where the Event Grid System Topic should exist. Changing this forces a new Event Grid System Topic to be created.

*   `name` - (Required) The name which should be used for this Event Grid System Topic. Changing this forces a new Event Grid System Topic to be created.

*   `resourceGroupName` - (Required) The name of the Resource Group where the Event Grid System Topic should exist. Changing this forces a new Event Grid System Topic to be created.

*   `identity` - (Optional) An `identity` block as defined below.

*   `sourceArmResourceId` - (Required) The ID of the Event Grid System Topic ARM Source. Changing this forces a new Event Grid System Topic to be created.

*   `topicType` - (Required) The Topic Type of the Event Grid System Topic. The topic type is validated by Azure and there may be additional topic types beyond the following: `microsoftAppConfigurationConfigurationStores`, `microsoftCommunicationCommunicationServices`, `microsoftContainerRegistryRegistries`, `microsoftDevicesIoTHubs`, `microsoftEventGridDomains`, `microsoftEventGridTopics`, `microsoftEventhubNamespaces`, `microsoftKeyVaultVaults`, `microsoftMachineLearningServicesWorkspaces`, `microsoftMapsAccounts`, `microsoftMediaMediaServices`, `microsoftResourcesResourceGroups`, `microsoftResourcesSubscriptions`, `microsoftServiceBusNamespaces`, `microsoftSignalRServiceSignalR`, `microsoftStorageStorageAccounts`, `microsoftWebServerFarms` and `microsoftWebSites`. Changing this forces a new Event Grid System Topic to be created.

\~> **NOTE:** Some `topicType`s (e.g. **Microsoft.Resources.Subscriptions**) requires location to be set to `global` instead of a real location like `westUs`.

\~> **NOTE:** You can use Azure CLI to get a full list of the available topic types: `azEventgridTopicTypeListOutputJson |GrepWId`

***

A `identity` block supports the following:

*   `type` - (Required) Specifies the type of Managed Service Identity that should be configured on this Event Grid System Topic. Possible values are `systemAssigned`, `userAssigned`.

*   `identityIds` - (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Event Grid System Topic.

\~> **NOTE:** This is required when `type` is set to `userAssigned`

\~> **NOTE:** When `type` is set to `systemAssigned`, The assigned `principalId` and `tenantId` can be retrieved after the Event Grid System Topic has been created. More details are available below.

***

* `tags` - (Optional) A mapping of tags which should be assigned to the Event Grid System Topic.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Event Grid System Topic.

*   `identity` - An `identity` block as defined below.

*   `metricArmResourceId` - The Metric ARM Resource ID of the Event Grid System Topic.

***

An `identity` block exports the following:

*   `principalId` - The Principal ID associated with this Managed Service Identity.

*   `tenantId` - The Tenant ID associated with this Managed Service Identity.

***

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Event Grid System Topic.
* `read` - (Defaults to 5 minutes) Used when retrieving the Event Grid System Topic.
* `update` - (Defaults to 30 minutes) Used when updating the Event Grid System Topic.
* `delete` - (Defaults to 30 minutes) Used when deleting the Event Grid System Topic.

## Import

Event Grid System Topic can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_eventgrid_system_topic.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.EventGrid/systemTopics/systemTopic1
```
