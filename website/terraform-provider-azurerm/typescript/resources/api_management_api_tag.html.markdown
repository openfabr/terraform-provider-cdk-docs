---
subcategory: "API Management"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_api_management_api_tag"
description: |-
  Manages an API Management API Tag.
---

# azurermApiManagementApiTag

Manages the Assignment of an API Management API Tag to an API.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
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
const dataAzurermApiManagementExample =
  new azurerm.dataAzurermApiManagement.DataAzurermApiManagement(
    this,
    "example_2",
    {
      name: "example-apim",
      resource_group_name: azurermResourceGroupExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAzurermApiManagementExample.overrideLogicalId("example");
const azurermApiManagementApiExample =
  new azurerm.apiManagementApi.ApiManagementApi(this, "example_3", {
    api_management_name: dataAzurermApiManagementExample.name,
    name: "example-api",
    resource_group_name: azurermResourceGroupExample.name,
    revision: "1",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermApiManagementApiExample.overrideLogicalId("example");
const azurermApiManagementTagExample =
  new azurerm.apiManagementTag.ApiManagementTag(this, "example_4", {
    api_management_id: dataAzurermApiManagementExample.id,
    name: "example-tag",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermApiManagementTagExample.overrideLogicalId("example");
const azurermApiManagementApiTagExample =
  new azurerm.apiManagementApiTag.ApiManagementApiTag(this, "example_5", {
    api_id: azurermApiManagementApiExample.id,
    name: azurermApiManagementTagExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermApiManagementApiTagExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `apiId` - (Required) The ID of the API Management API. Changing this forces a new API Management API Tag to be created.

*   `name` - (Required) The name of the tag. It must be known in the API Management instance. Changing this forces a new API Management API Tag to be created.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the API Management API Tag.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the API Management API Tag.
* `read` - (Defaults to 5 minutes) Used when retrieving the API Management API Tag.
* `delete` - (Defaults to 30 minutes) Used when deleting the API Management API Tag.

## Import

API Management API Tags can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_api_management_api_tag.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.ApiManagement/service/service1/apis/api1/tags/tag1
```
