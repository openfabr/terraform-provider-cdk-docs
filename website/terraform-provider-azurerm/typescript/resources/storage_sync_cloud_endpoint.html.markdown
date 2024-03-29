---
subcategory: "Storage"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_storage_sync_cloud_endpoint"
description: |-
  Manages a Storage Sync Cloud Endpoint.
---

# azurermStorageSyncCloudEndpoint

Manages a Storage Sync Cloud Endpoint.

\-> **NOTE:** Please ensure Azure File Sync has access to the storage account in your subscription, which indicates that `microsoftStorageSync` is assigned role `readerAndDataAccess` ( refer to details [here](https://docs.microsoft.com/azure/storage/files/storage-sync-files-troubleshoot?tabs=portal1%2Cazure-portal#common-troubleshooting-steps)).

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
    name: "example",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const azurermStorageShareExample = new azurerm.storageShare.StorageShare(
  this,
  "example_2",
  {
    acl: [
      {
        access_policy: [
          {
            permissions: "r",
          },
        ],
        id: "GhostedRecall",
      },
    ],
    name: "example-share",
    quota: 50,
    storage_account_name: azurermStorageAccountExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageShareExample.overrideLogicalId("example");
const azurermStorageSyncExample = new azurerm.storageSync.StorageSync(
  this,
  "example_3",
  {
    location: azurermResourceGroupExample.location,
    name: "example-ss",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageSyncExample.overrideLogicalId("example");
const azurermStorageSyncGroupExample =
  new azurerm.storageSyncGroup.StorageSyncGroup(this, "example_4", {
    name: "example-ss-group",
    storage_sync_id: azurermStorageSyncExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageSyncGroupExample.overrideLogicalId("example");
const azurermStorageSyncCloudEndpointExample =
  new azurerm.storageSyncCloudEndpoint.StorageSyncCloudEndpoint(
    this,
    "example_5",
    {
      file_share_name: azurermStorageShareExample.name,
      name: "example-ss-ce",
      storage_account_id: azurermStorageAccountExample.id,
      storage_sync_group_id: azurermStorageSyncGroupExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageSyncCloudEndpointExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this Storage Sync Cloud Endpoint. Changing this forces a new Storage Sync Cloud Endpoint to be created.

*   `storageSyncGroupId` - (Required) The ID of the Storage Sync Group where this Cloud Endpoint should be created. Changing this forces a new Storage Sync Cloud Endpoint to be created.

*   `fileShareName` - (Required) The Storage Share name to be synchronized in this Storage Sync Cloud Endpoint. Changing this forces a new Storage Sync Cloud Endpoint to be created.

*   `storageAccountId` - (Required) The ID of the Storage Account where the Storage Share exists. Changing this forces a new Storage Sync Cloud Endpoint to be created.

*   `storageAccountTenantId` - (Optional) The Tenant ID of the Storage Account where the Storage Share exists. Changing this forces a new Storage Sync Cloud Endpoint to be created. Defaults to the current tenant id.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the Storage Sync Cloud Endpoint.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 45 minutes) Used when creating the Storage Sync Cloud Endpoint.
* `read` - (Defaults to 5 minutes) Used when retrieving the Storage Sync Cloud Endpoint.
* `delete` - (Defaults to 45 minutes) Used when deleting the Storage Sync Cloud Endpoint.

## Import

Storage Sync Cloud Endpoints can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_storage_sync_cloud_endpoint.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.StorageSync/storageSyncServices/sync1/syncGroups/syncgroup1/cloudEndpoints/cloudEndpoint1
```
