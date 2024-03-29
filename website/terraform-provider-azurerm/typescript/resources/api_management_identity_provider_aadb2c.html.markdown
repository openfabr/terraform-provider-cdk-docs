---
subcategory: "API Management"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_api_management_identity_provider_aadb2c"
description: |-
  Manages an API Management Azure AD B2C Identity Provider.
---

# azurermApiManagementIdentityProviderAadb2C

Manages an API Management Azure AD B2C Identity Provider.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azuread from "./.gen/providers/azuread";
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azuread, azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const azureadApplicationExample = new azuread.application.Application(
  this,
  "example",
  {
    display_name: "acctestam-example",
  }
);
const azureadApplicationPasswordExample =
  new azuread.applicationPassword.ApplicationPassword(this, "example_1", {
    application_object_id: azureadApplicationExample.objectId,
    end_date_relative: "36h",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azureadApplicationPasswordExample.overrideLogicalId("example");
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example_2",
  {
    location: "West Europe",
    name: "example-resources",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermResourceGroupExample.overrideLogicalId("example");
const azurermApiManagementExample = new azurerm.apiManagement.ApiManagement(
  this,
  "example_3",
  {
    location: azurermResourceGroupExample.location,
    name: "example-apim",
    publisher_email: "company@terraform.io",
    publisher_name: "My Company",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "Developer_1",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermApiManagementExample.overrideLogicalId("example");
const azurermApiManagementIdentityProviderAadb2CExample =
  new azurerm.apiManagementIdentityProviderAadb2C.ApiManagementIdentityProviderAadb2C(
    this,
    "example_4",
    {
      allowed_tenant: "myb2ctenant.onmicrosoft.com",
      api_management_name: azurermApiManagementExample.name,
      authority: "myb2ctenant.b2clogin.com",
      client_id: azureadApplicationExample.applicationId,
      client_secret: "P@55w0rD!",
      depends_on: [`\${${azureadApplicationPasswordExample.fqn}}`],
      resource_group_name: azurermResourceGroupExample.name,
      signin_policy: "B2C_1_Login",
      signin_tenant: "myb2ctenant.onmicrosoft.com",
      signup_policy: "B2C_1_Signup",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermApiManagementIdentityProviderAadb2CExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `apiManagementName` - (Required) The Name of the API Management Service where this AAD Identity Provider should be created. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The Name of the Resource Group where the API Management Service exists. Changing this forces a new resource to be created.

*   `clientId` - (Required) Client ID of the Application in your B2C tenant.

*   `clientSecret` - (Required) Client secret of the Application in your B2C tenant.

*   `allowedTenant` - (Required) The allowed AAD tenant, usually your B2C tenant domain.

*   `signinTenant` - (Required) The tenant to use instead of Common when logging into Active Directory, usually your B2C tenant domain.

*   `authority` - (Required) OpenID Connect discovery endpoint hostname, usually your b2clogin.com domain.

*   `signinPolicy` - (Required) Signin Policy Name.

*   `signupPolicy` - (Required) Signup Policy Name.

***

*   `passwordResetPolicy` - (Optional) Password reset Policy Name.

*   `profileEditingPolicy` - (Optional) Profile editing Policy Name.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the API Management Azure AD B2C Identity Provider Resource.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the API Management Azure AD B2C Identity Provider.
* `read` - (Defaults to 5 minutes) Used when retrieving the API Management Azure AD B2C Identity Provider.
* `update` - (Defaults to 30 minutes) Used when updating the API Management Azure AD B2C Identity Provider.
* `delete` - (Defaults to 30 minutes) Used when deleting the API Management Azure AD B2C Identity Provider.

## Import

API Management Azure AD B2C Identity Providers can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_api_management_identity_provider_aadb2c.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.ApiManagement/service/service1/identityProviders/aadB2C
```
