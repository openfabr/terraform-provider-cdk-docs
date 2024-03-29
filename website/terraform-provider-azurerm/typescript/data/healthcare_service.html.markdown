---
subcategory: "Healthcare"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_healthcare_service"
description: |-
  Get information about an existing Healthcare Service
---

# Data Source: azurermHealthcareService

Use this data source to access information about an existing Healthcare Service

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermHealthcareServiceExample =
  new azurerm.dataAzurermHealthcareService.DataAzurermHealthcareService(
    this,
    "example",
    {
      location: "westus2",
      name: "example-healthcare_service",
      resource_group_name: "example-resources",
    }
  );
new cdktf.TerraformOutput(this, "healthcare_service_id", {
  value: dataAzurermHealthcareServiceExample.id,
});

```

## Argument Reference

*   `name` - Specifies the name of the Healthcare Service.

*   `resourceGroupName` - The name of the Resource Group in which the Healthcare Service exists.

## Attributes Reference

The following attributes are exported:

* `location` - The Azure Region where the Service is located.

\~> **Please Note**: Not all locations support this resource. Some are `westUs2`, `northCentralUs`, and `ukWest`.

* `kind` - The type of the service.
* `authenticationConfiguration` - An `authenticationConfiguration` block as defined below.
* `cosmosdbThroughput` - The provisioned throughput for the backing database.
* `cosmosdbKeyVaultKeyVersionlessId` - The versionless Key Vault Key ID for CMK encryption of the backing database.
* `corsConfiguration` - A `corsConfiguration` block as defined below.
* `tags` - A mapping of tags to assign to the resource.

***

An `authenticationConfiguration` exports the following:

* `authority` - The Azure Active Directory (tenant) that serves as the authentication authority to access the service.
* `audience` - The intended audience to receive authentication tokens for the service.
* `smartProxyEnabled` - Is the 'SMART on FHIR' option for mobile and web implementations enabled?

***

A `corsConfiguration` block exports the following:

* `allowedOrigins` - The set of origins to be allowed via CORS.
* `allowedHeaders` - The set of headers to be allowed via CORS.
* `allowedMethods` - The methods to be allowed via CORS.
* `maxAgeInSeconds` - The max age to be allowed via CORS.
* `allowCredentials` - Are credentials are allowed via CORS?

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Healthcare Service.
