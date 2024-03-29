---
subcategory: "API Management"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_api_management_product"
description: |-
  Gets information about an existing API Management Product.
---

# Data Source: azurermApiManagementProduct

Use this data source to access information about an existing API Management Product.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermApiManagementProductExample =
  new azurerm.dataAzurermApiManagementProduct.DataAzurermApiManagementProduct(
    this,
    "example",
    {
      api_management_name: "example-apim",
      product_id: "my-product",
      resource_group_name: "search-service",
    }
  );
new cdktf.TerraformOutput(this, "product_terms", {
  value: dataAzurermApiManagementProductExample.terms,
});

```

## Argument Reference

*   `apiManagementName` - The Name of the API Management Service in which this Product exists.

*   `productId` - The Identifier for the API Management Product.

*   `resourceGroupName` - The Name of the Resource Group in which the API Management Service exists.

## Attributes Reference

*   `id` - The ID of the API Management Product.

*   `approvalRequired` - Do subscribers need to be approved prior to being able to use the Product?

*   `displayName` - The Display Name for this API Management Product.

*   `published` - Is this Product Published?

*   `subscriptionRequired` - Is a Subscription required to access API's included in this Product?

*   `description` - The description of this Product, which may include HTML formatting tags.

*   `subscriptionsLimit` - The number of subscriptions a user can have to this Product at the same time.

*   `terms` - Any Terms and Conditions for this Product, which must be accepted by Developers before they can begin the Subscription process.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the API Management Product.
