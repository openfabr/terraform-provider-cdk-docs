---
subcategory: "API Management"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_api_management_group"
description: |-
  Manages an API Management Group.
---

# azurermApiManagementGroup

Manages an API Management Group.

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
    sku_name: "Developer_1",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermApiManagementExample.overrideLogicalId("example");
const azurermApiManagementGroupExample =
  new azurerm.apiManagementGroup.ApiManagementGroup(this, "example_2", {
    api_management_name: azurermApiManagementExample.name,
    description: "This is an example API management group.",
    display_name: "Example Group",
    name: "example-apimg",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermApiManagementGroupExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the API Management Group. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the Resource Group in which the API Management Group should exist. Changing this forces a new resource to be created.

*   `apiManagementName` - (Required) The name of the [API Management Service](api_management.html) in which the API Management Group should exist. Changing this forces a new resource to be created.

*   `displayName` - (Required) The display name of this API Management Group.

*   `description` - (Optional) The description of this API Management Group.

*   `externalId` - (Optional) The identifier of the external Group. For example, an Azure Active Directory group `aad://<tenantId>/groups/<groupObjectId>`. Changing this forces a new resource to be created.

*   `type` - (Optional) The type of this API Management Group. Possible values are `custom`, `external` and `system`. Default is `custom`. Changing this forces a new resource to be created.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ID of the API Management Group.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the API Management Group.
* `update` - (Defaults to 30 minutes) Used when updating the API Management Group.
* `read` - (Defaults to 5 minutes) Used when retrieving the API Management Group.
* `delete` - (Defaults to 30 minutes) Used when deleting the API Management Group.

## Import

API Management Groups can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_api_management_group.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resources/providers/Microsoft.ApiManagement/service/example-apim/groups/example-apimg
```
