---
subcategory: "Redis Enterprise"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_redis_enterprise_database"
description: |-
  Manages a Redis Enterprise Database.
---

# azurermRedisEnterpriseDatabase

Manages a Redis Enterprise Database.

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
    name: "example-redisenterprise",
  }
);
const azurermRedisEnterpriseClusterExample =
  new azurerm.redisEnterpriseCluster.RedisEnterpriseCluster(this, "example_1", {
    location: azurermResourceGroupExample.location,
    name: "example-redisenterprise",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "Enterprise_E20-4",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermRedisEnterpriseClusterExample.overrideLogicalId("example");
const azurermRedisEnterpriseClusterExample1 =
  new azurerm.redisEnterpriseCluster.RedisEnterpriseCluster(this, "example1", {
    location: azurermResourceGroupExample.location,
    name: "example-redisenterprise1",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "Enterprise_E20-4",
  });
const azurermRedisEnterpriseDatabaseExample =
  new azurerm.redisEnterpriseDatabase.RedisEnterpriseDatabase(
    this,
    "example_3",
    {
      client_protocol: "Encrypted",
      cluster_id: azurermRedisEnterpriseClusterExample.id,
      clustering_policy: "EnterpriseCluster",
      eviction_policy: "NoEviction",
      linked_database_group_nickname: "tftestGeoGroup",
      linked_database_id: [
        `\${${azurermRedisEnterpriseClusterExample.id}}/databases/default`,
        `\${${azurermRedisEnterpriseClusterExample1.id}}/databases/default`,
      ],
      name: "default",
      port: 10000,
      resource_group_name: azurermResourceGroupExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermRedisEnterpriseDatabaseExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Optional) The name which should be used for this Redis Enterprise Database. Currently the acceptable value for this argument is `default`. Defaults to `default`. Changing this forces a new Redis Enterprise Database to be created.

*   `resourceGroupName` - (Optional) The name of the Resource Group where the Redis Enterprise Database should exist. Changing this forces a new Redis Enterprise Database to be created.

*   `clusterId` - (Required) The resource id of the Redis Enterprise Cluster to deploy this Redis Enterprise Database. Changing this forces a new Redis Enterprise Database to be created.

*   `clientProtocol` - (Optional) Specifies whether redis clients can connect using TLS-encrypted or plaintext redis protocols. Default is TLS-encrypted. Possible values are `encrypted` and `plaintext`. Defaults to `encrypted`. Changing this forces a new Redis Enterprise Database to be created.

*   `clusteringPolicy` - (Optional) Clustering policy - default is OSSCluster. Specified at create time. Possible values are `enterpriseCluster` and `ossCluster`. Defaults to `ossCluster`. Changing this forces a new Redis Enterprise Database to be created.

*   `evictionPolicy` - (Optional) Redis eviction policy - default is `volatileLru`. Possible values are `allKeysLfu`, `allKeysLru`, `allKeysRandom`, `volatileLru`, `volatileLfu`, `volatileTtl`, `volatileRandom` and `noEviction`. Changing this forces a new Redis Enterprise Database to be created.

*   `module` - (Optional) A `module` block as defined below. Changing this forces a new resource to be created.

\-> **NOTE:** Only RediSearch module is allowed with geo-replication

* `linkedDatabaseId` - (Optional) A list of database resources to link with this database with a maximum of 5.

\-> **NOTE:** Only the newly created databases can be added to an existing geo-replication group. Existing regular databases or recreated databases cannot be added to the existing geo-replication group. Any linked database be removed from the list will be forcefully unlinked.The only recommended operation is to delete after force-unlink and the recommended scenario of force-unlink is region outrage. The database cannot be linked again after force-unlink.

*   `linkedDatabaseGroupNickname` - (Optional) Nickname of the group of linked databases. Changing this force a new Redis Enterprise Geo Database to be created.

*   `port` - (Optional) TCP port of the database endpoint. Specified at create time. Defaults to an available port. Changing this forces a new Redis Enterprise Database to be created. Defaults to `10000`.

***

An `module` block exports the following:

*   `name` - (Required) The name which should be used for this module. Possible values are `redisBloom`, `redisTimeSeries`, `rediSearch` and `redisJson`. Changing this forces a new Redis Enterprise Database to be created.

*   `args` - (Optional) Configuration options for the module (e.g. `errorRate000InitialSize400`). Changing this forces a new resource to be created. Defaults to `""`.

***

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Redis Enterprise Database.

*   `primaryAccessKey` - The Primary Access Key for the Redis Enterprise Database Instance.

*   `secondaryAccessKey` - The Secondary Access Key for the Redis Enterprise Database Instance.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Redis Enterprise Database.
* `read` - (Defaults to 5 minutes) Used when retrieving the Redis Enterprise Database.
* `update` - (Defaults to 30 minutes) Used when updating the Redis Enterprise Database.
* `delete` - (Defaults to 30 minutes) Used when deleting the Redis Enterprise Database.

## Import

Redis Enterprise Databases can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_redis_enterprise_database.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.Cache/redisEnterprise/cluster1/databases/database1
```
