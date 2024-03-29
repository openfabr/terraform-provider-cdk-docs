---
subcategory: "CDN"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_cdn_endpoint_custom_domain"
description: |-
  Manages a Custom Domain for a CDN Endpoint.
---

# azurermCdnEndpointCustomDomain

Manages a Custom Domain for a CDN Endpoint.

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
    location: "west europe",
    name: "example-rg",
  }
);
const azurermStorageAccountExample = new azurerm.storageAccount.StorageAccount(
  this,
  "example_1",
  {
    account_replication_type: "GRS",
    account_tier: "Standard",
    location: azurermResourceGroupExample.location,
    name: "example",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const dataAzurermDnsZoneExample =
  new azurerm.dataAzurermDnsZone.DataAzurermDnsZone(this, "example_2", {
    name: "example-domain.com",
    resource_group_name: "domain-rg",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAzurermDnsZoneExample.overrideLogicalId("example");
const azurermCdnProfileExample = new azurerm.cdnProfile.CdnProfile(
  this,
  "example_3",
  {
    location: azurermResourceGroupExample.location,
    name: "example-profile",
    resource_group_name: azurermResourceGroupExample.name,
    sku: "Standard_Verizon",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermCdnProfileExample.overrideLogicalId("example");
const azurermCdnEndpointExample = new azurerm.cdnEndpoint.CdnEndpoint(
  this,
  "example_4",
  {
    location: azurermResourceGroupExample.location,
    name: "example-endpoint",
    origin: [
      {
        host_name: azurermStorageAccountExample.primaryBlobHost,
        name: "example",
      },
    ],
    profile_name: azurermCdnProfileExample.name,
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermCdnEndpointExample.overrideLogicalId("example");
const azurermDnsCnameRecordExample = new azurerm.dnsCnameRecord.DnsCnameRecord(
  this,
  "example_5",
  {
    name: "example",
    resource_group_name: dataAzurermDnsZoneExample.resourceGroupName,
    target_resource_id: azurermCdnEndpointExample.id,
    ttl: 3600,
    zone_name: dataAzurermDnsZoneExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermDnsCnameRecordExample.overrideLogicalId("example");
const azurermCdnEndpointCustomDomainExample =
  new azurerm.cdnEndpointCustomDomain.CdnEndpointCustomDomain(
    this,
    "example_6",
    {
      cdn_endpoint_id: azurermCdnEndpointExample.id,
      host_name: `\${${azurermDnsCnameRecordExample.name}}.\${${dataAzurermDnsZoneExample.name}}`,
      name: "example-domain",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermCdnEndpointCustomDomainExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this CDN Endpoint Custom Domain. Changing this forces a new CDN Endpoint Custom Domain to be created.

*   `cdnEndpointId` - (Required) The ID of the CDN Endpoint. Changing this forces a new CDN Endpoint Custom Domain to be created.

*   `hostName` - (Required) The host name of the custom domain. Changing this forces a new CDN Endpoint Custom Domain to be created.

*   `cdnManagedHttps` - (Optional) A `cdnManagedHttps` block as defined below.

*   `userManagedHttps` - (Optional) A `userManagedHttps` block as defined below.

\~> **NOTE** Only one of `cdnManagedHttps` and `userManagedHttps` can be specified.

***

A `cdnManagedHttps` block supports the following:

*   `certificateType` - (Required) The type of HTTPS certificate. Possible values are `shared` and `dedicated`.

*   `protocolType` - (Required) The type of protocol. Possible values are `serverNameIndication` and `ipBased`.

*   `tlsVersion` - (Optional) The minimum TLS protocol version that is used for HTTPS. Possible values are `tls10` (representing TLS 1.0/1.1), `tls12` (representing TLS 1.2) and `none` (representing no minimums). Defaults to `tls12`.

***

A `userManagedHttps` block supports the following:

*   `keyVaultCertificateId` - (Optional) The ID of the Key Vault Certificate that contains the HTTPS certificate. This is deprecated in favor of `keyVaultSecretId`.

*   `keyVaultSecretId` - (Optional) The ID of the Key Vault Secret that contains the HTTPS certificate.

\~> **NOTE** Either `keyVaultCertificateId` or `keyVaultSecretId` has to be specified.

* `tlsVersion` - (Optional) The minimum TLS protocol version that is used for HTTPS. Possible values are `tls10` (representing TLS 1.0/1.1), `tls12` (representing TLS 1.2) and `none` (representing no minimums). Defaults to `tls12`.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the CDN Endpoint Custom Domain.

## Timeouts

The `timeouts` block allows you to
specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 12 hours) Used when creating the Custom Domain for this CDN Endpoint.
* `read` - (Defaults to 5 minutes) Used when retrieving the CDN Endpoint Custom Domain.
* `update` - (Defaults to 24 hours) Used when updating the CDN Endpoint Custom Domain.
* `delete` - (Defaults to 12 hours) Used when deleting the CDN Endpoint Custom Domain.

## Import

CDN Endpoint Custom Domains can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_cdn_endpoint_custom_domain.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Cdn/profiles/profile1/endpoints/endpoint1/customDomains/domain1
```
