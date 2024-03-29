---
subcategory: "App Service (Web Apps)"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_app_service_certificate_order"
description: |-
  Gets information about an existing App Service Certificate Order.
---

# Data Source: azurermAppServiceCertificateOrder

Use this data source to access information about an existing App Service Certificate Order.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermAppServiceCertificateOrderExample =
  new azurerm.dataAzurermAppServiceCertificateOrder.DataAzurermAppServiceCertificateOrder(
    this,
    "example",
    {
      name: "example-cert-order",
      resource_group_name: "example-resources",
    }
  );
new cdktf.TerraformOutput(this, "certificate_order_id", {
  value: dataAzurermAppServiceCertificateOrderExample.id,
});

```

## Argument Reference

*   `name` - The name of the App Service.

*   `resourceGroupName` - The Name of the Resource Group where the App Service exists.

## Attributes Reference

*   `id` - The ID of the App Service.

*   `location` - The Azure location where the App Service exists.

*   `autoRenew` - true if the certificate should be automatically renewed when it expires; otherwise, false.

*   `certificates` - State of the Key Vault secret. A `certificates` block as defined below.

*   `csr` - Last CSR that was created for this order.

*   `distinguishedName` - The Distinguished Name for the App Service Certificate Order.

*   `keySize` - Certificate key size.

*   `productType` - Certificate product type, such as `standard` or `wildCard`.

*   `validityInYears` - Duration in years (must be between 1 and 3).

*   `domainVerificationToken` - Domain verification token.

*   `status` - Current order status.

*   `expirationTime` - Certificate expiration time.

*   `isPrivateKeyExternal` - Whether the private key is external or not.

*   `appServiceCertificateNotRenewableReasons` - Reasons why App Service Certificate is not renewable at the current moment.

*   `signedCertificateThumbprint` - Certificate thumbprint for signed certificate.

*   `rootThumbprint` - Certificate thumbprint for root certificate.

*   `intermediateThumbprint` - Certificate thumbprint intermediate certificate.

*   `tags` - A mapping of tags to assign to the resource.

***

*   `certificateName` - The name of the App Service Certificate.

*   `keyVaultId` - Key Vault resource Id.

*   `keyVaultSecretName` - Key Vault secret name.

*   `provisioningState` - Status of the Key Vault secret.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the App Service Certificate Order.
