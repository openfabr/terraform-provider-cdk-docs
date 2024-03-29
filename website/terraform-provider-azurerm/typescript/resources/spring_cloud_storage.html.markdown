---
subcategory: "Spring Cloud"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_spring_cloud_storage"
description: |-
  Manages a Spring Cloud Storage.
---

# azurermSpringCloudStorage

Manages a Spring Cloud Storage.

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
const azurermSpringCloudServiceExample =
  new azurerm.springCloudService.SpringCloudService(this, "example_1", {
    location: azurermResourceGroupExample.location,
    name: "example",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSpringCloudServiceExample.overrideLogicalId("example");
const azurermStorageAccountExample = new azurerm.storageAccount.StorageAccount(
  this,
  "example_2",
  {
    account_replication_type: "GRS",
    account_tier: "Standard",
    location: azurermResourceGroupExample.location,
    name: "example",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const azurermSpringCloudStorageExample =
  new azurerm.springCloudStorage.SpringCloudStorage(this, "example_3", {
    name: "example",
    spring_cloud_service_id: azurermSpringCloudServiceExample.id,
    storage_account_key: azurermStorageAccountExample.primaryAccessKey,
    storage_account_name: azurermStorageAccountExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSpringCloudStorageExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this Spring Cloud Storage. Changing this forces a new Spring Cloud Storage to be created.

*   `springCloudServiceId` - (Required) The ID of the Spring Cloud Service where the Spring Cloud Storage should exist. Changing this forces a new Spring Cloud Storage to be created.

*   `storageAccountKey` - (Required) The access key of the Azure Storage Account.

*   `storageAccountName` - (Required) The account name of the Azure Storage Account.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the Spring Cloud Storage.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Spring Cloud Storage.
* `read` - (Defaults to 5 minutes) Used when retrieving the Spring Cloud Storage.
* `update` - (Defaults to 30 minutes) Used when updating the Spring Cloud Storage.
* `delete` - (Defaults to 30 minutes) Used when deleting the Spring Cloud Storage.

## Import

Spring Cloud Storages can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_spring_cloud_storage.example /subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/resourceGroup1/providers/Microsoft.AppPlatform/spring/service1/storages/storage1
```
