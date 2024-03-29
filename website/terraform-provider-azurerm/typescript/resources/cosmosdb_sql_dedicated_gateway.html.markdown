---
subcategory: "CosmosDB (DocumentDB)"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_cosmosdb_sql_dedicated_gateway"
description: |-
  Manages a SQL Dedicated Gateway within a Cosmos DB Account.
---

# azurermCosmosdbSqlDedicatedGateway

Manages a SQL Dedicated Gateway within a Cosmos DB Account.

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
    location: "West Europe",
    name: "example-resource-group",
  }
);
const azurermCosmosdbAccountExample =
  new azurerm.cosmosdbAccount.CosmosdbAccount(this, "example_1", {
    consistency_policy: [
      {
        consistency_level: "BoundedStaleness",
      },
    ],
    geo_location: [
      {
        failover_priority: 0,
        location: azurermResourceGroupExample.location,
      },
    ],
    kind: "GlobalDocumentDB",
    location: azurermResourceGroupExample.location,
    name: "example-ca",
    offer_type: "Standard",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermCosmosdbAccountExample.overrideLogicalId("example");
const azurermCosmosdbSqlDedicatedGatewayExample =
  new azurerm.cosmosdbSqlDedicatedGateway.CosmosdbSqlDedicatedGateway(
    this,
    "example_2",
    {
      cosmosdb_account_id: azurermCosmosdbAccountExample.id,
      instance_count: 1,
      instance_size: "Cosmos.D4s",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermCosmosdbSqlDedicatedGatewayExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `cosmosdbAccountId` - (Required) The resource ID of the CosmosDB Account. Changing this forces a new resource to be created.

*   `instanceSize` - (Required) The instance size for the CosmosDB SQL Dedicated Gateway. Changing this forces a new resource to be created. Possible values are `cosmosD4S`, `cosmosD8S` and `cosmosD16S`.

*   `instanceCount` - (Required) The instance count for the CosmosDB SQL Dedicated Gateway. Possible value is between `1` and `5`.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the CosmosDB SQL Dedicated Gateway.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the CosmosDB SQL Dedicated Gateway.
* `update` - (Defaults to 30 minutes) Used when updating the CosmosDB SQL Dedicated Gateway.
* `read` - (Defaults to 5 minutes) Used when retrieving the CosmosDB SQL Dedicated Gateway.
* `delete` - (Defaults to 30 minutes) Used when deleting the CosmosDB SQL Dedicated Gateway.

## Import

CosmosDB SQL Dedicated Gateways can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_cosmosdb_sql_dedicated_gateway.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup1/providers/Microsoft.DocumentDB/databaseAccounts/account1/services/SqlDedicatedGateway
```
