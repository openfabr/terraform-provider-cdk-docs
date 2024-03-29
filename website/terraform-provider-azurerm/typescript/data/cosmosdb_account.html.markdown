---
subcategory: "CosmosDB (DocumentDB)"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_cosmosdb_account"
description: |-
  Gets information about an existing CosmosDB (formally DocumentDB) Account.
---

# Data Source: azurermCosmosdbAccount

Use this data source to access information about an existing CosmosDB (formally DocumentDB) Account.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermCosmosdbAccountExample =
  new azurerm.dataAzurermCosmosdbAccount.DataAzurermCosmosdbAccount(
    this,
    "example",
    {
      name: "tfex-cosmosdb-account",
      resource_group_name: "tfex-cosmosdb-account-rg",
    }
  );
new cdktf.TerraformOutput(this, "cosmosdb_account_endpoint", {
  value: dataAzurermCosmosdbAccountExample.endpoint,
});

```

## Argument Reference

The following arguments are supported:

*   `name` - Specifies the name of the CosmosDB Account.

*   `resourceGroupName` - Specifies the name of the resource group in which the CosmosDB Account resides.

## Attributes Reference

The following attributes are exported:

*   `id` - The ID of the CosmosDB Account.

*   `location` - The Azure location where the resource exists.

*   `tags` - A mapping of tags assigned to the resource.

*   `offerType` - The Offer Type to used by this CosmosDB Account.

*   `kind` - The Kind of the CosmosDB account.

*   `keyVaultKeyId` - The Key Vault key URI for CMK encryption.

\~> **NOTE:** The CosmosDB service always uses the latest version of the specified key.

*   `ipRangeFilter` - The current IP Filter for this CosmosDB account

*   `enableFreeTier` - If Free Tier pricing option is enabled for this CosmosDB Account. You can have up to one free tier Azure Cosmos DB account per Azure subscription.

*   `enableAutomaticFailover` - If automatic failover is enabled for this CosmosDB Account.

*   `capabilities` - Capabilities enabled on this Cosmos DB account.

*   `isVirtualNetworkFilterEnabled` - If virtual network filtering is enabled for this Cosmos DB account.

*   `virtualNetworkRule` - Subnets that are allowed to access this CosmosDB account.

*   `enableMultipleWriteLocations` - If multiple write locations are enabled for this Cosmos DB account.

`consistencyPolicy` The current consistency Settings for this CosmosDB account with the following properties:

* `consistencyLevel` - The Consistency Level used by this CosmosDB Account.
* `maxIntervalInSeconds` - The amount of staleness (in seconds) tolerated when the consistency level is Bounded Staleness.
* `maxStalenessPrefix` - The number of stale requests tolerated when the consistency level is Bounded Staleness.

`geoLocation` The geographic locations data is replicated to with the following properties:

* `id` - The ID of the location.
* `location` - The name of the Azure region hosting replicated data.
* `priority` - The locations fail over priority.

`virtualNetworkRule` The virtual network subnets allowed to access this Cosmos DB account with the following properties:

*   `id` - The ID of the virtual network subnet.

*   `endpoint` - The endpoint used to connect to the CosmosDB account.

*   `readEndpoints` - A list of read endpoints available for this CosmosDB account.

*   `writeEndpoints` - A list of write endpoints available for this CosmosDB account.

*   `primaryKey` - The primary key for the CosmosDB account.

*   `secondaryKey` - The secondary key for the CosmosDB account.

*   `primaryReadonlyKey` - The primary read-only Key for the CosmosDB account.

*   `secondaryReadonlyKey` - The secondary read-only key for the CosmosDB account.

*   `primarySqlConnectionString` - The primary SQL connection string for the CosmosDB account.

*   `secondarySqlConnectionString` - The secondary SQL connection string for the CosmosDB account.

*   `primaryReadonlySqlConnectionString` - The primary read-only SQL connection string for the CosmosDB account.

*   `secondaryReadonlySqlConnectionString` - The secondary read-only SQL connection string for the CosmosDB account.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the CosmosDB Account.
