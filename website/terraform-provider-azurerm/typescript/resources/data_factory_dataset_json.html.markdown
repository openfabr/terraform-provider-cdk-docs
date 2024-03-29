---
subcategory: "Data Factory"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_data_factory_dataset_json"
description: |-
  Manages an Azure JSON Dataset inside an Azure Data Factory.
---

# azurermDataFactoryDatasetJson

Manages an Azure JSON Dataset inside an Azure Data Factory.

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
const azurermDataFactoryExample = new azurerm.dataFactory.DataFactory(
  this,
  "example_1",
  {
    location: azurermResourceGroupExample.location,
    name: "example",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermDataFactoryExample.overrideLogicalId("example");
const azurermDataFactoryLinkedServiceWebExample =
  new azurerm.dataFactoryLinkedServiceWeb.DataFactoryLinkedServiceWeb(
    this,
    "example_2",
    {
      authentication_type: "Anonymous",
      data_factory_id: azurermDataFactoryExample.id,
      name: "example",
      url: "https://www.bing.com",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermDataFactoryLinkedServiceWebExample.overrideLogicalId("example");
const azurermDataFactoryDatasetJsonExample =
  new azurerm.dataFactoryDatasetJson.DataFactoryDatasetJson(this, "example_3", {
    data_factory_id: azurermDataFactoryExample.id,
    encoding: "UTF-8",
    http_server_location: [
      {
        filename: "foo.txt",
        path: "foo/bar/",
        relative_url: "/fizz/buzz/",
      },
    ],
    linked_service_name: azurermDataFactoryLinkedServiceWebExample.name,
    name: "example",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermDataFactoryDatasetJsonExample.overrideLogicalId("example");

```

## Argument Reference

The following supported arguments are common across all Azure Data Factory Datasets:

*   `name` - (Required) Specifies the name of the Data Factory Dataset. Changing this forces a new resource to be created. Must be globally unique. See the [Microsoft documentation](https://docs.microsoft.com/azure/data-factory/naming-rules) for all restrictions.

*   `dataFactoryId` - (Required) The Data Factory ID in which to associate the Linked Service with. Changing this forces a new resource.

*   `linkedServiceName` - (Required) The Data Factory Linked Service name in which to associate the Dataset with.

*   `folder` - (Optional) The folder that this Dataset is in. If not specified, the Dataset will appear at the root level.

*   `schemaColumn` - (Optional) A `schemaColumn` block as defined below.

*   `description` - (Optional) The description for the Data Factory Dataset.

*   `annotations` - (Optional) List of tags that can be used for describing the Data Factory Dataset.

*   `parameters` - (Optional) A map of parameters to associate with the Data Factory Dataset.

*   `additionalProperties` - (Optional) A map of additional properties to associate with the Data Factory Dataset.

The following supported arguments are specific to JSON Dataset:

*   `httpServerLocation` - (Optional) A `httpServerLocation` block as defined below.

*   `azureBlobStorageLocation` - (Optional) A `azureBlobStorageLocation` block as defined below.

The following supported arguments are specific to Delimited Text Dataset:

* `encoding` - (Optional) The encoding format for the file.

***

A `schemaColumn` block supports the following:

*   `name` - (Required) The name of the column.

*   `type` - (Optional) Type of the column. Valid values are `byte`, `byte[]`, `boolean`, `date`, `dateTime`,`dateTimeOffset`, `decimal`, `double`, `guid`, `int16`, `int32`, `int64`, `single`, `string`, `timeSpan`. Please note these values are case sensitive.

*   `description` - (Optional) The description of the column.

***

A `httpServerLocation` block supports the following:

*   `relativeUrl` - (Required) The base URL to the web server hosting the file.

*   `path` - (Required) The folder path to the file on the web server.

*   `filename` - (Required) The filename of the file on the web server.

*   `dynamicPathEnabled` - (Optional) Is the `path` using dynamic expression, function or system variables? Defaults to `false`.

*   `dynamicFilenameEnabled` - (Optional) Is the `filename` using dynamic expression, function or system variables? Defaults to `false`.

***

A `azureBlobStorageLocation` block supports the following:

*   `container` - (Required) The container on the Azure Blob Storage Account hosting the file.

*   `path` - (Required) The folder path to the file on the web server.

*   `filename` - (Required) The filename of the file on the web server.

*   `dynamicContainerEnabled` - (Optional) Is the `container` using dynamic expression, function or system variables? Defaults to `false`.

*   `dynamicPathEnabled` - (Optional) Is the `path` using dynamic expression, function or system variables? Defaults to `false`.

*   `dynamicFilenameEnabled` - (Optional) Is the `filename` using dynamic expression, function or system variables? Defaults to `false`.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the Data Factory Dataset.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Data Factory Dataset.
* `update` - (Defaults to 30 minutes) Used when updating the Data Factory Dataset.
* `read` - (Defaults to 5 minutes) Used when retrieving the Data Factory Dataset.
* `delete` - (Defaults to 30 minutes) Used when deleting the Data Factory Dataset.

## Import

Data Factory Datasets can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_data_factory_dataset_json.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example/providers/Microsoft.DataFactory/factories/example/datasets/example
```
