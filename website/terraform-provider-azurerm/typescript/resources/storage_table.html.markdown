---
subcategory: "Storage"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_storage_table"
description: |-
  Manages a Table within an Azure Storage Account.
---

# azurermStorageTable

Manages a Table within an Azure Storage Account.

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
    name: "azuretest",
  }
);
const azurermStorageAccountExample = new azurerm.storageAccount.StorageAccount(
  this,
  "example_1",
  {
    account_replication_type: "LRS",
    account_tier: "Standard",
    location: azurermResourceGroupExample.location,
    name: "azureteststorage1",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const azurermStorageTableExample = new azurerm.storageTable.StorageTable(
  this,
  "example_2",
  {
    name: "mysampletable",
    storage_account_name: azurermStorageAccountExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageTableExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the storage table. Only Alphanumeric characters allowed, starting with a letter. Must be unique within the storage account the table is located. Changing this forces a new resource to be created.

*   `storageAccountName` - (Required) Specifies the storage account in which to create the storage table. Changing this forces a new resource to be created.

*   `acl` - (Optional) One or more `acl` blocks as defined below.

***

A `acl` block supports the following:

*   `id` - (Required) The ID which should be used for this Shared Identifier.

*   `accessPolicy` - (Optional) An `accessPolicy` block as defined below.

***

A `accessPolicy` block supports the following:

*   `expiry` - (Required) The ISO8061 UTC time at which this Access Policy should be valid until.

*   `permissions` - (Required) The permissions which should associated with this Shared Identifier.

*   `start` - (Required) The ISO8061 UTC time at which this Access Policy should be valid from.

## Attributes Reference

The following attributes are exported in addition to the arguments listed above:

* `id` - The ID of the Table within the Storage Account.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Storage Table.
* `update` - (Defaults to 30 minutes) Used when updating the Storage Table.
* `read` - (Defaults to 5 minutes) Used when retrieving the Storage Table.
* `delete` - (Defaults to 30 minutes) Used when deleting the Storage Table.

## Import

Table's within a Storage Account can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_storage_table.table1 "https://example.table.core.windows.net/Tables('replace-with-table-name')"
```
