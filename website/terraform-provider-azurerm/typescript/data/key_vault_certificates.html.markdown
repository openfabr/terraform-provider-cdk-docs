---
subcategory: "Key Vault"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_key_vault_certificates"
description: |-
  Gets a list of certificate names from an existing Key Vault.
---

# Data Source: azurermKeyVaultCertificates

Use this data source to retrieve a list of certificate names from an existing Key Vault.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermKeyVaultCertificatesExample =
  new azurerm.dataAzurermKeyVaultCertificates.DataAzurermKeyVaultCertificates(
    this,
    "example",
    {
      key_vault_id: "${data.azurerm_key_vault.existing.id}",
    }
  );
const dataAzurermKeyVaultCertificateExample =
  new azurerm.dataAzurermKeyVaultCertificate.DataAzurermKeyVaultCertificate(
    this,
    "example_1",
    {
      key_vault_id: "${data.azurerm_key_vault.existing.id}",
      name: "${each.key}",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAzurermKeyVaultCertificateExample.overrideLogicalId("example");
/*In most cases loops should be handled in the programming language context and 
not inside of the Terraform context. If you are looping over something external, e.g. a variable or a file input
you should consider using a for loop. If you are looping over something only known to Terraform, e.g. a result of a data source
you need to keep this like it is.*/
dataAzurermKeyVaultCertificateExample.addOverride(
  "for_each",
  `\${toset(${dataAzurermKeyVaultCertificatesExample.names})}`
);

```

## Argument Reference

The following arguments are supported:

* `keyVaultId` - Specifies the ID of the Key Vault instance to fetch certificate names from, available on the `azurermKeyVault` Data Source / Resource.

**NOTE:** The vault must be in the same subscription as the provider. If the vault is in another subscription, you must create an aliased provider for that subscription.

* `includePending` - Specifies whether to include certificates which are not completely provisioned. Defaults to true.

## Attributes Reference

In addition to the arguments above, the following attributes are exported:

*   `names` - List containing names of certificates that exist in this Key Vault.

*   `keyVaultId` - The Key Vault ID.

*   `certificates` - One or more `certificates` blocks as defined below.

***

A `certificates` block supports following:

*   `name` - The name of secret.

*   `enabled` - Whether this secret is enabled.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Key Vault Certificates.
