---
subcategory: "Data Share"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_data_share_dataset_data_lake_gen2"
description: |-
  Manages a Data Share Data Lake Gen2 Dataset.
---

# azurermDataShareDatasetDataLakeGen2

Manages a Data Share Data Lake Gen2 Dataset.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
import * as azuread from "./.gen/providers/azuread";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm, azuread.
For a more precise conversion please use the --provider flag in convert.*/
new azurerm.provider.AzurermProvider(this, "azurerm", {
  features: [{}],
});
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
  "example_2",
  {
    account_kind: "BlobStorage",
    account_replication_type: "LRS",
    account_tier: "Standard",
    location: azurermResourceGroupExample.location,
    name: "examplestr",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const azurermStorageDataLakeGen2FilesystemExample =
  new azurerm.storageDataLakeGen2Filesystem.StorageDataLakeGen2Filesystem(
    this,
    "example_3",
    {
      name: "example-dlg2fs",
      storage_account_id: azurermStorageAccountExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageDataLakeGen2FilesystemExample.overrideLogicalId("example");
const azurermDataShareAccountExample =
  new azurerm.dataShareAccount.DataShareAccount(this, "example_4", {
    identity: [
      {
        type: "SystemAssigned",
      },
    ],
    location: azurermResourceGroupExample.location,
    name: "example-dsa",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermDataShareAccountExample.overrideLogicalId("example");
const dataAzureadServicePrincipalExample =
  new azuread.dataAzureadServicePrincipal.DataAzureadServicePrincipal(
    this,
    "example_5",
    {
      display_name: azurermDataShareAccountExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAzureadServicePrincipalExample.overrideLogicalId("example");
const azurermDataShareExample = new azurerm.dataShare.DataShare(
  this,
  "example_6",
  {
    account_id: azurermDataShareAccountExample.id,
    kind: "CopyBased",
    name: "example_ds",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermDataShareExample.overrideLogicalId("example");
const azurermRoleAssignmentExample = new azurerm.roleAssignment.RoleAssignment(
  this,
  "example_7",
  {
    principal_id: dataAzureadServicePrincipalExample.objectId,
    role_definition_name: "Storage Blob Data Reader",
    scope: azurermStorageAccountExample.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermRoleAssignmentExample.overrideLogicalId("example");
const azurermDataShareDatasetDataLakeGen2Example =
  new azurerm.dataShareDatasetDataLakeGen2.DataShareDatasetDataLakeGen2(
    this,
    "example_8",
    {
      depends_on: [`\${${azurermRoleAssignmentExample.fqn}}`],
      file_path: "myfile.txt",
      file_system_name: azurermStorageDataLakeGen2FilesystemExample.name,
      name: "accexample-dlg2ds",
      share_id: azurermDataShareExample.id,
      storage_account_id: azurermStorageAccountExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermDataShareDatasetDataLakeGen2Example.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this Data Share Data Lake Gen2 Dataset. Changing this forces a new Data Share Data Lake Gen2 Dataset to be created.

*   `shareId` - (Required) The resource ID of the Data Share where this Data Share Data Lake Gen2 Dataset should be created. Changing this forces a new Data Share Data Lake Gen2 Dataset to be created.

*   `fileSystemName` - (Required) The name of the data lake file system to be shared with the receiver. Changing this forces a new Data Share Data Lake Gen2 Dataset to be created.

*   `storageAccountId` - (Required) The resource id of the storage account of the data lake file system to be shared with the receiver. Changing this forces a new Data Share Data Lake Gen2 Dataset to be created.

***

*   `filePath` - (Optional) The path of the file in the data lake file system to be shared with the receiver. Conflicts with `folderPath` Changing this forces a new Data Share Data Lake Gen2 Dataset to be created.

*   `folderPath` - (Optional) The folder path in the data lake file system to be shared with the receiver. Conflicts with `filePath` Changing this forces a new Data Share Data Lake Gen2 Dataset to be created.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The resource ID of the Data Share Data Lake Gen2 Dataset.

*   `displayName` - The name of the Data Share Dataset.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Data Share Data Lake Gen2 Dataset.
* `read` - (Defaults to 5 minutes) Used when retrieving the Data Share Data Lake Gen2 Dataset.
* `delete` - (Defaults to 30 minutes) Used when deleting the Data Share Data Lake Gen2 Dataset.

## Import

Data Share Data Lake Gen2 Datasets can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_data_share_dataset_data_lake_gen2.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.DataShare/accounts/account1/shares/share1/dataSets/dataSet1
```
