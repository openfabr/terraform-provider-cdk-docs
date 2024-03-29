---
subcategory: "Database"
layout: "azurerm"
page_title: "Azure Resource Manager: Data Source: azurerm_mssql_managed_instance"
description: |-
  Gets information about a Microsoft SQL Azure Managed Instance.
---

# Data Source: azurermMssqlManagedInstance

Use this data source to access information about an existing Microsoft SQL Azure Managed Instance.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
new azurerm.dataAzurermMssqlManagedInstance.DataAzurermMssqlManagedInstance(
  this,
  "example",
  {
    name: "managedsqlinstance",
    resource_group_name: "${azurerm_resource_group.example.name}",
  }
);

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the SQL Managed Instance.

*   `resourceGroupName` - (Required) The name of the resource group where the SQL Managed Instance exists.

## Attributes Reference

The following attributes are exported:

*   `administratorLogin` - The administrator login name for the SQL Managed Instance.

*   `collation` - Specifies how the SQL Managed Instance will be collated.

*   `customerManagedKey` - Specifies KeyVault key, used by SQL Managed Instance for Transparent Data Encryption.

*   `dnsZonePartnerId` - The ID of the SQL Managed Instance which shares the DNS zone.

*   `fqdn` - The fully qualified domain name of the Azure Managed SQL Instance.

*   `id` - The SQL Managed Instance ID.

*   `identity` - An `identity` block as defined below.

*   `licenseType` - What type of license the SQL Managed Instance uses.

*   `location` - Specifies the supported Azure location where the resource exists.

*   `minimumTlsVersion` - The Minimum TLS Version.

*   `proxyOverride` - Specifies how the SQL Managed Instance will be accessed.

*   `publicDataEndpointEnabled` - Whether the public data endpoint is enabled.

*   `skuName` - Specifies the SKU Name of the SQL Managed Instance.

*   `storageAccountType` - Specifies the storage account type used to store backups for this database.

*   `storageSizeInGb` - Maximum storage space allocated for the SQL Managed Instance.

*   `subnetId` - The subnet resource ID that the SQL Managed Instance is associated with.

*   `tags` - A mapping of tags assigned to the resource.

*   `timezoneId` - The TimeZone ID that the SQL Managed Instance is running in.

*   `vcores` - Number of cores that are assigned to the SQL Managed Instance.

***

The `identity` block exports the following:

*   `principalId` - The Principal ID for the Service Principal associated with the Identity of this SQL Managed Instance.

*   `tenantId` - The Tenant ID for the Service Principal associated with the Identity of this SQL Managed Instance.

*   `identityIds` - A list of User Assigned Managed Identity IDs assigned with the Identity of this SQL Managed Instance.

*   `type` - The identity type of the SQL Managed Instance.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Microsoft SQL Managed Instance.
