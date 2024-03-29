---
subcategory: "API Management"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_api_management_authorization_server"
description: |-
  Manages an Authorization Server within an API Management Service.
---

# azurermApiManagementAuthorizationServer

Manages an Authorization Server within an API Management Service.

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
const dataAzurermApiManagementExample =
  new azurerm.dataAzurermApiManagement.DataAzurermApiManagement(
    this,
    "example",
    {
      name: "search-api",
      resource_group_name: "search-service",
    }
  );
const azurermApiManagementAuthorizationServerExample =
  new azurerm.apiManagementAuthorizationServer.ApiManagementAuthorizationServer(
    this,
    "example_2",
    {
      api_management_name: dataAzurermApiManagementExample.name,
      authorization_endpoint: "https://example.mydomain.com/client/authorize",
      authorization_methods: ["GET"],
      client_id: "42424242-4242-4242-4242-424242424242",
      client_registration_endpoint:
        "https://example.mydomain.com/client/register",
      display_name: "Test Server",
      grant_types: ["authorizationCode"],
      name: "test-server",
      resource_group_name: dataAzurermApiManagementExample.resourceGroupName,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermApiManagementAuthorizationServerExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `apiManagementName` - (Required) The name of the API Management Service in which this Authorization Server should be created. Changing this forces a new resource to be created.

*   `authorizationMethods` - (Required) The HTTP Verbs supported by the Authorization Endpoint. Possible values are `delete`, `get`, `head`, `options`, `patch`, `post`, `put` and `trace`.

\-> **NOTE:** `get` must always be present.

*   `authorizationEndpoint` - (Required) The OAUTH Authorization Endpoint.

*   `clientId` - (Required) The Client/App ID registered with this Authorization Server.

*   `clientRegistrationEndpoint` - (Required) The URI of page where Client/App Registration is performed for this Authorization Server.

*   `displayName` - (Required) The user-friendly name of this Authorization Server.

*   `grantTypes` - (Required) Form of Authorization Grants required when requesting an Access Token. Possible values are `authorizationCode`, `clientCredentials`, `implicit` and `resourceOwnerPassword`.

*   `name` - (Required) The name of this Authorization Server. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the Resource Group in which the API Management Service exists. Changing this forces a new resource to be created.

***

*   `bearerTokenSendingMethods` - (Optional) The mechanism by which Access Tokens are passed to the API. Possible values are `authorizationHeader` and `query`.

*   `clientAuthenticationMethod` - (Optional) The Authentication Methods supported by the Token endpoint of this Authorization Server.. Possible values are `basic` and `body`.

*   `clientSecret` - (Optional) The Client/App Secret registered with this Authorization Server.

*   `defaultScope` - (Optional) The Default Scope used when requesting an Access Token, specified as a string containing space-delimited values.

*   `description` - (Optional) A description of the Authorization Server, which may contain HTML formatting tags.

*   `resourceOwnerPassword` - (Optional) The password associated with the Resource Owner.

\-> **NOTE:** This can only be specified when `grantType` includes `resourceOwnerPassword`.

* `resourceOwnerUsername` - (Optional) The username associated with the Resource Owner.

\-> **NOTE:** This can only be specified when `grantType` includes `resourceOwnerPassword`.

*   `supportState` - (Optional) Does this Authorization Server support State? If this is set to `true` the client may use the state parameter to raise protocol security.

*   `tokenBodyParameter` - (Optional) A `tokenBodyParameter` block as defined below.

*   `tokenEndpoint` - (Optional) The OAUTH Token Endpoint.

***

A `tokenBodyParameter` block supports the following:

*   `name` - (Required) The Name of the Parameter.

*   `value` - (Required) The Value of the Parameter.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ID of the API Management Authorization Server.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the API Management Authorization Server.
* `update` - (Defaults to 30 minutes) Used when updating the API Management Authorization Server.
* `read` - (Defaults to 5 minutes) Used when retrieving the API Management Authorization Server.
* `delete` - (Defaults to 30 minutes) Used when deleting the API Management Authorization Server.

## Import

API Management Authorization Servers can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_api_management_authorization_server.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.ApiManagement/service/service1/authorizationServers/server1
```
