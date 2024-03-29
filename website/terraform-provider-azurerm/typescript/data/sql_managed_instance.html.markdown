---
subcategory: "Database"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_sql_managed_instance"
description: |-
  Gets information about a SQL Managed Instance.
---

# Data Source: azurermSqlManagedInstance

Use this data source to access information about an existing SQL Managed Instance.

\-> **Note:** The `azurermSqlManagedInstance` data source is deprecated in version 3.0 of the AzureRM provider and will be removed in version 4.0. Please use the [`azurermMssqlManagedInstance`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/mssql_managed_instance) data source instead.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermSqlManagedInstanceExample =
  new azurerm.dataAzurermSqlManagedInstance.DataAzurermSqlManagedInstance(
    this,
    "example",
    {
      name: "example_mi",
      resource_group_name: "example-resources",
    }
  );
new cdktf.TerraformOutput(this, "sql_instance_id", {
  value: dataAzurermSqlManagedInstanceExample.id,
});

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the SQL Managed Instance.

*   `resourceGroupName` - (Required) The name of the Resource Group in which the SQL Managed Instance exists.

## Attributes Reference

*   `id` - The SQL Managed Instance ID.

*   `fqdn` - The fully qualified domain name of the Azure Managed SQL Instance.

*   `location` - Location where the resource exists.

*   `skuName` - SKU Name for the SQL Managed Instance.

*   `vcores` - Number of cores assigned to your instance.

*   `storageSizeInGb` - Maximum storage space for your instance.

*   `licenseType` - Type of license the Managed Instance uses.

*   `administratorLogin` - The administrator login name for the new server.

*   `subnetId` - The subnet resource id that the SQL Managed Instance is associated with.

*   `collation` - Specifies how the SQL Managed Instance is collated.

*   `publicDataEndpointEnabled` - Is the public data endpoint enabled?

*   `minimumTlsVersion` - The Minimum TLS Version.

*   `proxyOverride` - How the SQL Managed Instance is accessed.

*   `timezoneId` - The TimeZone ID that the SQL Managed Instance is operating in.

*   `dnsZonePartnerId` - The ID of the Managed Instance which is sharing the DNS zone.

*   `identity` - An `identity` block as defined below.

*   `storageAccountType` - Storage account type used to store backups for this SQL Managed Instance.

*   `tags` - A mapping of tags assigned to the resource.

***

The `identity` block exports the following:

*   `principalId` - The Principal ID for the Service Principal associated with the Identity of this SQL Managed Instance.

*   `tenantId` - The Tenant ID for the Service Principal associated with the Identity of this SQL Managed Instance.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the SQL Azure Managed Instance.
