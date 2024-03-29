---
subcategory: "Storage"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_storage_share_file"
description: |-
  Manages a File within an Azure Storage File Share.
---

# azurermStorageShareFile

Manages a File within an Azure Storage File Share.

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
    name: "azureteststorage",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const azurermStorageShareExample = new azurerm.storageShare.StorageShare(
  this,
  "example_2",
  {
    name: "sharename",
    quota: 50,
    storage_account_name: azurermStorageAccountExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageShareExample.overrideLogicalId("example");
const azurermStorageShareFileExample =
  new azurerm.storageShareFile.StorageShareFile(this, "example_3", {
    name: "my-awesome-content.zip",
    source: "some-local-file.zip",
    storage_share_id: azurermStorageShareExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageShareFileExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name (or path) of the File that should be created within this File Share. Changing this forces a new resource to be created.

*   `storageShareId` - (Required) The Storage Share ID in which this file will be placed into. Changing this forces a new resource to be created.

*   `path` - (Optional) The storage share directory that you would like the file placed into. Changing this forces a new resource to be created. Defaults to `""`.

*   `source` - (Optional) An absolute path to a file on the local system. Changing this forces a new resource to be created.

*   `contentType` - (Optional) The content type of the share file. Defaults to `application/octetStream`.

*   `contentMd5` - (Optional) The MD5 sum of the file contents. Changing this forces a new resource to be created.

*   `contentEncoding` - (Optional) Specifies which content encodings have been applied to the file.

*   `contentDisposition` - (Optional) Sets the file’s Content-Disposition header.

*   `metadata` - (Optional) A mapping of metadata to assign to this file.

## Attributes Reference

The following attributes are exported in addition to the arguments listed above:

* `id` - The ID of the file within the File Share.
* `contentLength` - The length in bytes of the file content

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Storage Share File.
* `update` - (Defaults to 30 minutes) Used when updating the Storage Share File.
* `read` - (Defaults to 5 minutes) Used when retrieving the Storage Share File.
* `delete` - (Defaults to 30 minutes) Used when deleting the Storage Share File.

## Import

Directories within an Azure Storage File Share can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_storage_share_file.example https://account1.file.core.windows.net/share1/file1
```
