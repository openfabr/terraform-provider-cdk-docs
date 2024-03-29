---
subcategory: "API Management"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_api_management_gateway"
description: |-
  Manages an API Management Gateway.
---

# azurermApiManagementGateway

Manages an API Management Gateway.

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
const azurermApiManagementExample = new azurerm.apiManagement.ApiManagement(
  this,
  "example_1",
  {
    location: azurermResourceGroupExample.location,
    name: "example-apim",
    publisher_email: "pub1@email.com",
    publisher_name: "pub1",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "Consumption_0",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermApiManagementExample.overrideLogicalId("example");
const azurermApiManagementGatewayExample =
  new azurerm.apiManagementGateway.ApiManagementGateway(this, "example_2", {
    api_management_id: azurermApiManagementExample.id,
    description: "Example API Management gateway",
    location_data: [
      {
        city: "example city",
        district: "example district",
        name: "example name",
        region: "example region",
      },
    ],
    name: "example-gateway",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermApiManagementGatewayExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for the API Management Gateway. Changing this forces a new API Management Gateway to be created.

*   `apiManagementId` - (Required) The ID of the API Management Resource in which the gateway will be created. Changing this forces a new API Management Gateway resource to be created.

*   `locationData` - (Required) A `locationData` block as documented below.

*   `description` - (Optional) The description of the API Management Gateway.

***

A `locationData` block supports the following:

*   `name` - (Required) A canonical name for the geographic or physical location.

*   `city` - (Optional) The city or locality where the resource is located.

*   `district` - (Optional) The district, state, or province where the resource is located.

*   `region` - (Optional) The country or region where the resource is located.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the API Management Gateway.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the API Management Gateway.
* `read` - (Defaults to 5 minutes) Used when retrieving the API Management Gateway.
* `update` - (Defaults to 30 minutes) Used when updating the API Management Gateway.
* `delete` - (Defaults to 30 minutes) Used when deleting the API Management Gateway.

## Import

API Management Gateways can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_api_management_gateway.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.ApiManagement/service/service1/gateways/gateway1
```
