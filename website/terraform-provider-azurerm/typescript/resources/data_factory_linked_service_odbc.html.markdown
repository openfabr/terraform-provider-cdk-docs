---
subcategory: "Data Factory"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_data_factory_linked_service_odbc"
description: |-
  Manages a Linked Service (connection) between a Database and Azure Data Factory through ODBC protocol.
---

# azurermDataFactoryLinkedServiceOdbc

Manages a Linked Service (connection) between a Database and Azure Data Factory through ODBC protocol.

\~> **Note:** All arguments including the connection\_string will be stored in the raw state as plain-text. [Read more about sensitive data in state](/docs/state/sensitive-data.html).

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
new azurerm.dataFactoryLinkedServiceOdbc.DataFactoryLinkedServiceOdbc(
  this,
  "anonymous",
  {
    connection_string:
      "Driver={SQL Server};Server=test;Database=test;Uid=test;Pwd=test;",
    data_factory_id: azurermDataFactoryExample.id,
    name: "anonymous",
  }
);
new azurerm.dataFactoryLinkedServiceOdbc.DataFactoryLinkedServiceOdbc(
  this,
  "basic_auth",
  {
    basic_authentication: [
      {
        password: "Ch4ngeM3!",
        username: "onrylmz",
      },
    ],
    connection_string:
      "Driver={SQL Server};Server=test;Database=test;Uid=test;Pwd=test;",
    data_factory_id: azurermDataFactoryExample.id,
    name: "basic_auth",
  }
);

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Specifies the name of the Data Factory Linked Service ODBC. Changing this forces a new resource to be created. Must be unique within a data factory. See the [Microsoft documentation](https://docs.microsoft.com/azure/data-factory/naming-rules) for all restrictions.

*   `dataFactoryId` - (Required) The Data Factory ID in which to associate the Linked Service with. Changing this forces a new resource.

*   `connectionString` - (Required) The connection string in which to authenticate with ODBC.

*   `basicAuthentication` - (Optional) A `basicAuthentication` block as defined below.

*   `description` - (Optional) The description for the Data Factory Linked Service ODBC.

*   `integrationRuntimeName` - (Optional) The integration runtime reference to associate with the Data Factory Linked Service ODBC.

*   `annotations` - (Optional) List of tags that can be used for describing the Data Factory Linked Service ODBC.

*   `parameters` - (Optional) A map of parameters to associate with the Data Factory Linked Service ODBC.

*   `additionalProperties` - (Optional) A map of additional properties to associate with the Data Factory Linked Service ODBC.

***

A `basicAuthentication` block supports the following:

*   `username` - (Required) The username which can be used to authenticate to the ODBC endpoint.

*   `password` - (Required) The password associated with the username, which can be used to authenticate to the ODBC endpoint.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the Data Factory ODBC Linked Service.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Data Factory ODBC Linked Service.
* `update` - (Defaults to 30 minutes) Used when updating the Data Factory ODBC Linked Service.
* `read` - (Defaults to 5 minutes) Used when retrieving the Data Factory ODBC Linked Service.
* `delete` - (Defaults to 30 minutes) Used when deleting the Data Factory ODBC Linked Service.

## Import

Data Factory ODBC Linked Service's can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_data_factory_linked_service_odbc.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example/providers/Microsoft.DataFactory/factories/example/linkedservices/example
```
