---
subcategory: "Data Explorer"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_kusto_attached_database_configuration"
description: |-
  Manages Kusto / Data Explorer Attached Database Configuration
---

# azurermKustoAttachedDatabaseConfiguration

Manages a Kusto (also known as Azure Data Explorer) Attached Database Configuration

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
    name: "my-kusto-rg",
  }
);
const azurermKustoClusterFollowedCluster =
  new azurerm.kustoCluster.KustoCluster(this, "followed_cluster", {
    location: azurermResourceGroupExample.location,
    name: "cluster2",
    resource_group_name: azurermResourceGroupExample.name,
    sku: [
      {
        capacity: 1,
        name: "Dev(No SLA)_Standard_D11_v2",
      },
    ],
  });
const azurermKustoClusterFollowerCluster =
  new azurerm.kustoCluster.KustoCluster(this, "follower_cluster", {
    location: azurermResourceGroupExample.location,
    name: "cluster1",
    resource_group_name: azurermResourceGroupExample.name,
    sku: [
      {
        capacity: 1,
        name: "Dev(No SLA)_Standard_D11_v2",
      },
    ],
  });
const azurermKustoDatabaseExample = new azurerm.kustoDatabase.KustoDatabase(
  this,
  "example_3",
  {
    cluster_name: azurermKustoClusterFollowerCluster.name,
    location: azurermResourceGroupExample.location,
    name: "example",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermKustoDatabaseExample.overrideLogicalId("example");
new azurerm.kustoDatabase.KustoDatabase(this, "followed_database", {
  cluster_name: azurermKustoClusterFollowerCluster.name,
  location: azurermResourceGroupExample.location,
  name: "my-followed-database",
  resource_group_name: azurermResourceGroupExample.name,
});
const azurermKustoAttachedDatabaseConfigurationExample =
  new azurerm.kustoAttachedDatabaseConfiguration.KustoAttachedDatabaseConfiguration(
    this,
    "example_5",
    {
      cluster_name: azurermKustoClusterFollowerCluster.name,
      cluster_resource_id: azurermKustoClusterFollowedCluster.id,
      database_name: azurermKustoDatabaseExample.name,
      location: azurermResourceGroupExample.location,
      name: "configuration1",
      resource_group_name: azurermResourceGroupExample.name,
      sharing: [
        {
          external_tables_to_exclude: ["ExternalTable2"],
          external_tables_to_include: ["ExternalTable1"],
          materialized_views_to_exclude: ["MaterializedViewTable2"],
          materialized_views_to_include: ["MaterializedViewTable1"],
          tables_to_exclude: ["Table2"],
          tables_to_include: ["Table1"],
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermKustoAttachedDatabaseConfigurationExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the Kusto Attached Database Configuration to create. Changing this forces a new resource to be created.

*   `location` - (Required) Specifies the location of the Kusto Cluster for which the configuration will be created. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) Specifies the resource group of the Kusto Cluster for which the configuration will be created. Changing this forces a new resource to be created.

*   `clusterName` - (Required) Specifies the name of the Kusto Cluster for which the configuration will be created. Changing this forces a new resource to be created.

*   `clusterResourceId` - (Required) The resource id of the cluster where the databases you would like to attach reside. Changing this forces a new resource to be created.

*   `databaseName` - (Required) The name of the database which you would like to attach, use \* if you want to follow all current and future databases. Changing this forces a new resource to be created.

*   `defaultPrincipalModificationKind` - (Optional) The default principals modification kind. Valid values are: `none` (default), `replace` and `union`.

*   `sharing` - (Optional) A `sharing` block as defined below.

***

An `sharing` block exports the following:

*   `externalTablesToExclude` - (Optional) List of external tables exclude from the follower database.

*   `externalTablesToInclude` - (Optional) List of external tables to include in the follower database.

*   `materializedViewsToExclude` - (Optional) List of materialized views exclude from the follower database.

*   `materializedViewsToInclude` - (Optional) List of materialized views to include in the follower database.

*   `tablesToExclude` - (Optional) List of tables to exclude from the follower database.

*   `tablesToInclude` - (Optional) List of tables to include in the follower database.

## Attributes Reference

The following attributes are exported:

*   `id` - The Kusto Attached Database Configuration ID.

*   `attachedDatabaseNames` - The list of databases from the `clusterResourceId` which are currently attached to the cluster.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 60 minutes) Used when creating the Kusto Database.
* `update` - (Defaults to 60 minutes) Used when updating the Kusto Database.
* `read` - (Defaults to 5 minutes) Used when retrieving the Kusto Database.
* `delete` - (Defaults to 60 minutes) Used when deleting the Kusto Database.

## Import

Kusto Attached Database Configurations can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_kusto_attached_database_configuration.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.Kusto/clusters/cluster1/attachedDatabaseConfigurations/configuration1
```
