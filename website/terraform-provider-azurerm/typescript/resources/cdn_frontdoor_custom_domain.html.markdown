---
subcategory: "CDN"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_cdn_frontdoor_custom_domain"
description: |-
  Manages a Front Door (standard/premium) Custom Domain.
---

# azurermCdnFrontdoorCustomDomain

Manages a Front Door (standard/premium) Custom Domain.

!>**IMPORTANT:** If you are using Terraform to manage your DNS Auth and DNS CNAME records for your Custom Domain you will need to add configuration blocks for both the `azurermDnsTxtRecord`(see the `exampleDnsAuthTxtRecordUsage` below) and the `azurermDnsCnameRecord`(see the `exampleCnameRecordUsage` below) to your configuration file.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const azurermDnsZoneExample = new azurerm.dnsZone.DnsZone(this, "example", {
  name: "sub-domain.domain.com",
  resource_group_name: "${azurerm_resource_group.test.name}",
});
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example_1",
  {
    location: "West Europe",
    name: "example-cdn-frontdoor",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermResourceGroupExample.overrideLogicalId("example");
const azurermCdnFrontdoorProfileExample =
  new azurerm.cdnFrontdoorProfile.CdnFrontdoorProfile(this, "example_2", {
    name: "example-profile",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "Standard_AzureFrontDoor",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermCdnFrontdoorProfileExample.overrideLogicalId("example");
const azurermCdnFrontdoorCustomDomainExample =
  new azurerm.cdnFrontdoorCustomDomain.CdnFrontdoorCustomDomain(
    this,
    "example_3",
    {
      cdn_frontdoor_profile_id: azurermCdnFrontdoorProfileExample.id,
      dns_zone_id: azurermDnsZoneExample.id,
      host_name: "contoso.fabrikam.com",
      name: "example-customDomain",
      tls: [
        {
          certificate_type: "ManagedCertificate",
          minimum_tls_version: "TLS12",
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermCdnFrontdoorCustomDomainExample.overrideLogicalId("example");

```

## Example DNS Auth TXT Record Usage

The name of your DNS TXT record should be in the format of `dnsauth.<yourSubdomain>`. So, for example, if we use the `hostName` in the example usage above you would create a DNS TXT record with the name of `dnsauthContoso` which contains the value of the Front Door Custom Domains `validationToken` field. See the [product documentation](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-add-custom-domain) for more information.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
new azurerm.dnsTxtRecord.DnsTxtRecord(this, "example", {
  name: '${join(".", ["_dnsauth", "contoso"])}',
  record: [
    {
      value: "${azurerm_cdn_frontdoor_custom_domain.example.validation_token}",
    },
  ],
  resource_group_name: "${azurerm_resource_group.example.name}",
  ttl: 3600,
  zone_name: "${azurerm_dns_zone.example.name}",
});

```

## Example CNAME Record Usage

!>**IMPORTANT:** You **must** include the `dependsOn` meta-argument which references both the `azurermCdnFrontdoorRoute` and the `azurermCdnFrontdoorSecurityPolicy` that are associated with your Custom Domain. The reason for these `dependsOn` meta-arguments is because all of the resources for the Custom Domain need to be associated within Front Door before the CNAME record can be written to the domains DNS, else the CNAME validation will fail and Front Door will not enable traffic to the Domain.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
new azurerm.dnsCnameRecord.DnsCnameRecord(this, "example", {
  depends_on: [
    "${azurerm_cdn_frontdoor_route.example}",
    "${azurerm_cdn_frontdoor_security_policy.example}",
  ],
  name: "contoso",
  record: "${azurerm_cdn_frontdoor_endpoint.example.host_name}",
  resource_group_name: "${azurerm_resource_group.example.name}",
  ttl: 3600,
  zone_name: "${azurerm_dns_zone.example.name}",
});

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this Front Door Custom Domain. Possible values must be between 2 and 260 characters in length, must begin with a letter or number, end with a letter or number and contain only letters, numbers and hyphens. Changing this forces a new Front Door Custom Domain to be created.

*   `cdnFrontdoorProfileId` - (Required) The ID of the Front Door Profile. Changing this forces a new Front Door Profile to be created.

*   `hostName` - (Required) The host name of the domain. The `hostName` field must be the FQDN of your domain(e.g. `contosoFabrikamCom`). Changing this forces a new Front Door Custom Domain to be created.

*   `dnsZoneId` - (Optional) The ID of the Azure DNS Zone which should be used for this Front Door Custom Domain. If you are using Azure to host your [DNS domains](https://learn.microsoft.com/azure/dns/dns-overview), you must delegate the domain provider's domain name system (DNS) to an Azure DNS Zone. For more information, see [Delegate a domain to Azure DNS](https://learn.microsoft.com/azure/dns/dns-delegate-domain-azure-dns). Otherwise, if you're using your own domain provider to handle your DNS, you must validate the Front Door Custom Domain by creating the DNS TXT records manually.

<!-- * `pre_validated_cdn_frontdoor_custom_domain_id` - (Optional) The resource ID of the pre-validated Front Door Custom Domain. This domain type is used when you wish to onboard a validated Azure service domain, and then configure the Azure service behind an Azure Front Door.

->**NOTE:** Currently `pre_validated_cdn_frontdoor_custom_domain_id` only supports domains validated by Static Web App. -->

* `tls` - (Required) A `tls` block as defined below.

***

A `tls` block supports the following:

* `certificateType` - (Optional) Defines the source of the SSL certificate. Possible values include `customerCertificate` and `managedCertificate`. Defaults to `managedCertificate`.

\->**NOTE:** It may take up to 15 minutes for the Front Door Service to validate the state and Domain ownership of the Custom Domain.

*   `minimumTlsVersion` - (Optional) TLS protocol version that will be used for Https. Possible values include `tls10` and `tls12`. Defaults to `tls12`.

*   `cdnFrontdoorSecretId` - (Optional) Resource ID of the Front Door Secret.

***

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Front Door Custom Domain.

*   `expirationDate` - The date time that the token expires.

*   `validationToken` - Challenge used for DNS TXT record or file based validation.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/docs/configuration/resources.html#timeouts) for certain actions:

* `create` - (Defaults to 12 hours) Used when creating the Front Door Custom Domain.
* `read` - (Defaults to 5 minutes) Used when retrieving the Front Door Custom Domain.
* `update` - (Defaults to 24 hours) Used when updating the Front Door Custom Domain.
* `delete` - (Defaults to 12 hours) Used when deleting the Front Door Custom Domain.

## Import

Front Door Custom Domains can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_cdn_frontdoor_custom_domain.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup1/providers/Microsoft.Cdn/profiles/profile1/customDomains/customDomain1
```
