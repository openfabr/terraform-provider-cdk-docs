---
subcategory: "Network"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_network_watcher_flow_log"
description: |-
  Manages a Network Watcher Flow Log.

---

# azurermNetworkWatcherFlowLog

Manages a Network Watcher Flow Log.

\~> **Note** The `azurermNetworkWatcherFlowLog` creates a new storage lifecyle management rule that overwrites existing rules. Please make sure to use a `storageAccount` with no existing management rules, until the [issue](https://github.com/hashicorp/terraform-provider-azurerm/issues/6935) is fixed.

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
const azurermStorageAccountTest = new azurerm.storageAccount.StorageAccount(
  this,
  "test",
  {
    account_kind: "StorageV2",
    account_replication_type: "LRS",
    account_tier: "Standard",
    enable_https_traffic_only: true,
    location: azurermResourceGroupExample.location,
    name: "acctestsa",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
const azurermLogAnalyticsWorkspaceTest =
  new azurerm.logAnalyticsWorkspace.LogAnalyticsWorkspace(this, "test_2", {
    location: azurermResourceGroupExample.location,
    name: "acctestlaw",
    resource_group_name: azurermResourceGroupExample.name,
    sku: "PerGB2018",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLogAnalyticsWorkspaceTest.overrideLogicalId("test");
const azurermNetworkSecurityGroupTest =
  new azurerm.networkSecurityGroup.NetworkSecurityGroup(this, "test_3", {
    location: azurermResourceGroupExample.location,
    name: "acctestnsg",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermNetworkSecurityGroupTest.overrideLogicalId("test");
const azurermNetworkWatcherTest = new azurerm.networkWatcher.NetworkWatcher(
  this,
  "test_4",
  {
    location: azurermResourceGroupExample.location,
    name: "acctestnw",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermNetworkWatcherTest.overrideLogicalId("test");
const azurermNetworkWatcherFlowLogTest =
  new azurerm.networkWatcherFlowLog.NetworkWatcherFlowLog(this, "test_5", {
    enabled: true,
    name: "example-log",
    network_security_group_id: azurermNetworkSecurityGroupTest.id,
    network_watcher_name: azurermNetworkWatcherTest.name,
    resource_group_name: azurermResourceGroupExample.name,
    retention_policy: [
      {
        days: 7,
        enabled: true,
      },
    ],
    storage_account_id: azurermStorageAccountTest.id,
    traffic_analytics: [
      {
        enabled: true,
        interval_in_minutes: 10,
        workspace_id: azurermLogAnalyticsWorkspaceTest.workspaceId,
        workspace_region: azurermLogAnalyticsWorkspaceTest.location,
        workspace_resource_id: azurermLogAnalyticsWorkspaceTest.id,
      },
    ],
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermNetworkWatcherFlowLogTest.overrideLogicalId("test");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the Network Watcher Flow Log. Changing this forces a new resource to be created.

*   `networkWatcherName` - (Required) The name of the Network Watcher. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the resource group in which the Network Watcher was deployed. Changing this forces a new resource to be created.

*   `networkSecurityGroupId` - (Required) The ID of the Network Security Group for which to enable flow logs for. Changing this forces a new resource to be created.

*   `storageAccountId` - (Required) The ID of the Storage Account where flow logs are stored.

*   `enabled` - (Required) Should Network Flow Logging be Enabled?

*   `retentionPolicy` - (Required) A `retentionPolicy` block as documented below.

*   `location` - (Optional) The location where the Network Watcher Flow Log resides. Changing this forces a new resource to be created. Defaults to the `location` of the Network Watcher.

*   `trafficAnalytics` - (Optional) A `trafficAnalytics` block as documented below.

*   `version` - (Optional) The version (revision) of the flow log. Possible values are `1` and `2`.

*   `tags` - (Optional) A mapping of tags which should be assigned to the Network Watcher Flow Log.

***

The `retentionPolicy` block supports the following:

* `enabled` - (Required) Boolean flag to enable/disable retention.
* `days` - (Required) The number of days to retain flow log records.

***

The `trafficAnalytics` block supports the following:

* `enabled` - (Required) Boolean flag to enable/disable traffic analytics.
* `workspaceId` - (Required) The resource GUID of the attached workspace.
* `workspaceRegion` - (Required) The location of the attached workspace.
* `workspaceResourceId` - (Required) The resource ID of the attached workspace.
* `intervalInMinutes` - (Optional) How frequently service should do flow analytics in minutes. Defaults to `60`.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the Network Watcher.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Network Watcher Flow Log.
* `update` - (Defaults to 30 minutes) Used when updating the Network Watcher Flow Log.
* `read` - (Defaults to 5 minutes) Used when retrieving the Network Watcher Flow Log.
* `delete` - (Defaults to 30 minutes) Used when deleting the Network Watcher Flow Log.

## Import

Network Watcher Flow Logs can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_network_watcher_flow_log.watcher1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Network/networkWatchers/watcher1/flowLogs/log1
```
