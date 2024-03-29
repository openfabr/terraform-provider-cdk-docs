---
subcategory: "API Management"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_api_management_certificate"
description: |-
  Manages an Certificate within an API Management Service.
---

# azurermApiManagementCertificate

Manages an Certificate within an API Management Service.

## Example Usage (with Base64 Certificate)

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
const azurermApiManagementExample = new azurerm.apiManagement.ApiManagement(
  this,
  "example_2",
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
const azurermApiManagementCertificateExample =
  new azurerm.apiManagementCertificate.ApiManagementCertificate(
    this,
    "example_3",
    {
      api_management_name: azurermApiManagementExample.name,
      data: '${filebase64("example.pfx")}',
      name: "example-cert",
      resource_group_name: azurermResourceGroupExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermApiManagementCertificateExample.overrideLogicalId("example");

```

## Example Usage (with Key Vault Certificate)

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
const dataAzurermClientConfigCurrent =
  new azurerm.dataAzurermClientConfig.DataAzurermClientConfig(
    this,
    "current",
    {}
  );
const azurermApiManagementExample = new azurerm.apiManagement.ApiManagement(
  this,
  "example_3",
  {
    identity: [
      {
        type: "SystemAssigned",
      },
    ],
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
const azurermKeyVaultExample = new azurerm.keyVault.KeyVault(
  this,
  "example_4",
  {
    location: azurermResourceGroupExample.location,
    name: "examplekeyvault",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "standard",
    tenant_id: dataAzurermClientConfigCurrent.tenantId,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermKeyVaultExample.overrideLogicalId("example");
const azurermKeyVaultAccessPolicyExample =
  new azurerm.keyVaultAccessPolicy.KeyVaultAccessPolicy(this, "example_5", {
    certificate_permissions: ["Get"],
    key_vault_id: azurermKeyVaultExample.id,
    object_id: `\${${azurermApiManagementExample.identity}.0.principal_id}`,
    secret_permissions: ["Get"],
    tenant_id: `\${${azurermApiManagementExample.identity}.0.tenant_id}`,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermKeyVaultAccessPolicyExample.overrideLogicalId("example");
const azurermKeyVaultCertificateExample =
  new azurerm.keyVaultCertificate.KeyVaultCertificate(this, "example_6", {
    certificate: [
      {
        contents: '${filebase64("example_cert.pfx")}',
        password: "terraform",
      },
    ],
    certificate_policy: [
      {
        issuer_parameters: [
          {
            name: "Self",
          },
        ],
        key_properties: [
          {
            exportable: true,
            key_size: 2048,
            key_type: "RSA",
            reuse_key: false,
          },
        ],
        secret_properties: [
          {
            content_type: "application/x-pkcs12",
          },
        ],
      },
    ],
    key_vault_id: azurermKeyVaultExample.id,
    name: "example-cert",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermKeyVaultCertificateExample.overrideLogicalId("example");
const azurermApiManagementCertificateExample =
  new azurerm.apiManagementCertificate.ApiManagementCertificate(
    this,
    "example_7",
    {
      api_management_name: azurermApiManagementExample.name,
      key_vault_secret_id: azurermKeyVaultCertificateExample.secretId,
      name: "example-cert",
      resource_group_name: azurermResourceGroupExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermApiManagementCertificateExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the API Management Certificate. Changing this forces a new resource to be created.

*   `apiManagementName` - (Required) The Name of the API Management Service where this Service should be created. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The Name of the Resource Group where the API Management Service exists. Changing this forces a new resource to be created.

\-> **NOTE:** Either `data` or `keyVaultSecretId` must be specified - but not both.

*   `data` - (Optional) The base-64 encoded certificate data, which must be a PFX file.

*   `password` - (Optional) The password used for this certificate.

*   `keyVaultSecretId` - (Optional) The ID of the Key Vault Secret containing the SSL Certificate, which must be of the type `application/xPkcs12`.

\-> **NOTE:** Setting this field requires the `identity` block to be specified in API Management Service, since this identity is used to retrieve the Key Vault Certificate. Possible values are versioned or versionless secret ID. Auto-updating the Certificate from the Key Vault requires that Secret version isn't specified.

* `keyVaultIdentityClientId` - (Optional) The Client ID of the User Assigned Managed Identity to use for retrieving certificate.

\-> **NOTE:** If not specified, will use System Assigned identity of the API Management Service.

***

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

*   `id` - The ID of the API Management Certificate.

*   `expiration` - The Expiration Date of this Certificate, formatted as an RFC3339 string.

*   `subject` - The Subject of this Certificate.

*   `thumbprint` - The Thumbprint of this Certificate.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the API Management Certificate.
* `update` - (Defaults to 30 minutes) Used when updating the API Management Certificate.
* `read` - (Defaults to 5 minutes) Used when retrieving the API Management Certificate.
* `delete` - (Defaults to 30 minutes) Used when deleting the API Management Certificate.

## Import

API Management Certificates can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_api_management_certificate.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.ApiManagement/service/instance1/certificates/certificate1
```
