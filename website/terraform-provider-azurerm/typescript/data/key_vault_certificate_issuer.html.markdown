---
subcategory: "Key Vault"
layout: "azurerm"
page_title: "Azure Resource Manager: Data Source: azurerm_key_vault_certificate_issuer"
description: |-
  Gets information about an existing Key Vault Certificate Issuer.
---

# Data Source: azurermKeyVaultCertificateIssuer

Use this data source to access information about an existing Key Vault Certificate Issuer.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermKeyVaultExample =
  new azurerm.dataAzurermKeyVault.DataAzurermKeyVault(this, "example", {
    name: "mykeyvault",
    resource_group_name: "some-resource-group",
  });
const dataAzurermKeyVaultCertificateIssuerExample =
  new azurerm.dataAzurermKeyVaultCertificateIssuer.DataAzurermKeyVaultCertificateIssuer(
    this,
    "example_1",
    {
      key_vault_id: dataAzurermKeyVaultExample.id,
      name: "existing",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAzurermKeyVaultCertificateIssuerExample.overrideLogicalId("example");
new cdktf.TerraformOutput(this, "id", {
  value: dataAzurermKeyVaultCertificateIssuerExample.id,
});

```

## Arguments Reference

The following arguments are supported:

*   `keyVaultId` - (Required) The ID of the Key Vault in which to locate the Certificate Issuer.

*   `name` - (Required) The name of the Key Vault Certificate Issuer.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Key Vault Certificate Issuer.

*   `accountId` - The account number with the third-party Certificate Issuer.

*   `orgId` - The organization ID with the third-party Certificate Issuer.

*   `admin` - A list of `admin` blocks as defined below.

*   `providerName` - The name of the third-party Certificate Issuer.

***

An `admin` block exports the following:

*   `emailAddress` - E-mail address of the admin.

*   `firstName` - First name of the admin.

*   `lastName` - Last name of the admin.

*   `phone` - Phone number of the admin.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Key Vault Certificate Issuer.
