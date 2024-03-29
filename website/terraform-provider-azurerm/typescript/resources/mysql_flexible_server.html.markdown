---
subcategory: "Database"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_mysql_flexible_server"
description: |-
  Manages a MySQL Flexible Server.
---

# azurermMysqlFlexibleServer

Manages a MySQL Flexible Server.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
new azurerm.provider.AzurermProvider(this, "azurerm", {
  features: [{}],
});
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example",
  {
    location: "West Europe",
    name: "example-resources",
  }
);
const azurermVirtualNetworkExample = new azurerm.virtualNetwork.VirtualNetwork(
  this,
  "example_2",
  {
    address_space: ["10.0.0.0/16"],
    location: azurermResourceGroupExample.location,
    name: "example-vn",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualNetworkExample.overrideLogicalId("example");
const azurermPrivateDnsZoneExample = new azurerm.privateDnsZone.PrivateDnsZone(
  this,
  "example_3",
  {
    name: "example.mysql.database.azure.com",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermPrivateDnsZoneExample.overrideLogicalId("example");
const azurermPrivateDnsZoneVirtualNetworkLinkExample =
  new azurerm.privateDnsZoneVirtualNetworkLink.PrivateDnsZoneVirtualNetworkLink(
    this,
    "example_4",
    {
      name: "exampleVnetZone.com",
      private_dns_zone_name: azurermPrivateDnsZoneExample.name,
      resource_group_name: azurermResourceGroupExample.name,
      virtual_network_id: azurermVirtualNetworkExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermPrivateDnsZoneVirtualNetworkLinkExample.overrideLogicalId("example");
const azurermSubnetExample = new azurerm.subnet.Subnet(this, "example_5", {
  address_prefixes: ["10.0.2.0/24"],
  delegation: [
    {
      name: "fs",
      service_delegation: [
        {
          actions: ["Microsoft.Network/virtualNetworks/subnets/join/action"],
          name: "Microsoft.DBforMySQL/flexibleServers",
        },
      ],
    },
  ],
  name: "example-sn",
  resource_group_name: azurermResourceGroupExample.name,
  service_endpoints: ["Microsoft.Storage"],
  virtual_network_name: azurermVirtualNetworkExample.name,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubnetExample.overrideLogicalId("example");
const azurermMysqlFlexibleServerExample =
  new azurerm.mysqlFlexibleServer.MysqlFlexibleServer(this, "example_6", {
    administrator_login: "psqladmin",
    administrator_password: "H@Sh1CoR3!",
    backup_retention_days: 7,
    delegated_subnet_id: azurermSubnetExample.id,
    depends_on: [`\${${azurermPrivateDnsZoneVirtualNetworkLinkExample.fqn}}`],
    location: azurermResourceGroupExample.location,
    name: "example-fs",
    private_dns_zone_id: azurermPrivateDnsZoneExample.id,
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "GP_Standard_D2ds_v4",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermMysqlFlexibleServerExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created.

*   `resourceGroupName` - (Required) The name of the Resource Group where the MySQL Flexible Server should exist. Changing this forces a new MySQL Flexible Server to be created.

*   `location` - (Required) The Azure Region where the MySQL Flexible Server should exist. Changing this forces a new MySQL Flexible Server to be created.

*   `administratorLogin` - (Optional) The Administrator login for the MySQL Flexible Server. Required when `createMode` is `default`. Changing this forces a new MySQL Flexible Server to be created.

*   `administratorPassword` - (Optional) The Password associated with the `administratorLogin` for the MySQL Flexible Server. Required when `createMode` is `default`.

*   `backupRetentionDays` - (Optional) The backup retention days for the MySQL Flexible Server. Possible values are between `1` and `35` days. Defaults to `7`.

*   `createMode` - (Optional)The creation mode which can be used to restore or replicate existing servers. Possible values are `default`, `pointInTimeRestore`, `geoRestore`, and `replica`. Changing this forces a new MySQL Flexible Server to be created.

\~> **NOTE:** Creating a `geoRestore` server requires the source server with `geoRedundantBackupEnabled` enabled.

\~> **NOTE:** The best practise is that it has to wait greater than 10 minutes to create the `geoRestore` server once the source server is created.

*   `customerManagedKey` - (Optional) A `customerManagedKey` block as defined below.

*   `delegatedSubnetId` - (Optional) The ID of the virtual network subnet to create the MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created.

*   `geoRedundantBackupEnabled` - (Optional) Should geo redundant backup enabled? Defaults to `false`. Changing this forces a new MySQL Flexible Server to be created.

*   `highAvailability` - (Optional) A `highAvailability` block as defined below.

*   `identity` - (Optional) An `identity` block as defined below.

*   `maintenanceWindow` - (Optional) A `maintenanceWindow` block as defined below.

*   `pointInTimeRestoreTimeInUtc` - (Optional) The point in time to restore from `creationSourceServerId` when `createMode` is `pointInTimeRestore`. Changing this forces a new MySQL Flexible Server to be created.

*   `privateDnsZoneId` - (Optional) The ID of the private DNS zone to create the MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created.

\~> **NOTE:** The `privateDnsZoneId` is required when setting a `delegatedSubnetId`. The `azurermPrivateDnsZone` should end with suffix `mysqlDatabaseAzureCom`.

* `replicationRole` - (Optional) The replication role. Possible value is `none`.

\~> **NOTE:** The `replicationRole` cannot be set while creating and only can be updated from `replica` to `none`.

* `skuName` - (Optional) The SKU Name for the MySQL Flexible Server.

\-> **NOTE:** `skuName` should start with SKU tier `b (burstable)`, `gp (generalPurpose)`, `mo (memoryOptimized)` like `bStandardB1S`.

*   `sourceServerId` - (Optional)The resource ID of the source MySQL Flexible Server to be restored. Required when `createMode` is `pointInTimeRestore`, `geoRestore`, and `replica`. Changing this forces a new MySQL Flexible Server to be created.

*   `storage` - (Optional) A `storage` block as defined below.

*   `version` - (Optional) The version of the MySQL Flexible Server to use. Possible values are `57`, and `8021`. Changing this forces a new MySQL Flexible Server to be created.

*   `zone` - (Optional) Specifies the Availability Zone in which this MySQL Flexible Server should be located. Possible values are `1`, `2` and `3`.

*   `tags` - (Optional) A mapping of tags which should be assigned to the MySQL Flexible Server.

***

A `customerManagedKey` block supports the following:

*   `keyVaultKeyId` - (Optional) The ID of the Key Vault Key.

*   `primaryUserAssignedIdentityId` - (Optional) Specifies the primary user managed identity id for a Customer Managed Key. Should be added with `identityIds`.

*   `geoBackupKeyVaultKeyId` - (Optional) The ID of the geo backup Key Vault Key. It can't cross region and need Customer Managed Key in same region as geo backup.

*   `geoBackupUserAssignedIdentityId` - (Optional) The geo backup user managed identity id for a Customer Managed Key. Should be added with `identityIds`. It can't cross region and need identity in same region as geo backup.

\~> **NOTE:** `primaryUserAssignedIdentityId` or `geoBackupUserAssignedIdentityId` is required when `type` is set to `userAssigned` or `systemAssigned,UserAssigned`.

***

An `identity` block supports the following:

*   `type` - (Required) Specifies the type of Managed Service Identity that should be configured on this API Management Service. Should be set to `userAssigned`, `systemAssigned,UserAssigned` (to enable both).

*   `identityIds` - (Optional) A list of User Assigned Managed Identity IDs to be assigned to this API Management Service. Required if used together with `customerManagedKey` block.

\~> **NOTE:** This is required when `type` is set to `userAssigned` or `systemAssigned,UserAssigned`.

***

A `highAvailability` block supports the following:

* `mode` - (Required) The high availability mode for the MySQL Flexible Server. Possibles values are `sameZone` and `zoneRedundant`.

\~> **NOTE:** `storage0AutoGrowEnabled` must be enabled when `highAvailability` is enabled. To change the `highAvailability` for a MySQL Flexible Server created with `highAvailability` disabled during creation, the resource has to be recreated.

* `standbyAvailabilityZone` - (Optional) Specifies the Availability Zone in which the standby Flexible Server should be located. Possible values are `1`, `2` and `3`.

\~> **NOTE:** The `standbyAvailabilityZone` will be omitted when mode is `sameZone`, for the `standbyAvailabilityZone` will be the same as `zone`.

***

A `maintenanceWindow` block supports the following:

*   `dayOfWeek` - (Optional) The day of week for maintenance window. Defaults to `0`.

*   `startHour` - (Optional) The start hour for maintenance window. Defaults to `0`.

*   `startMinute` - (Optional) The start minute for maintenance window. Defaults to `0`.

***

A `storage` block supports the following:

*   `autoGrowEnabled` - (Optional) Should Storage Auto Grow be enabled? Defaults to `true`.

*   `iops` - (Optional) The storage IOPS for the MySQL Flexible Server. Possible values are between `360` and `20000`.

*   `sizeGb` - (Optional) The max storage allowed for the MySQL Flexible Server. Possible values are between `20` and `16384`.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the MySQL Flexible Server.

*   `fqdn` - The fully qualified domain name of the MySQL Flexible Server.

*   `publicNetworkAccessEnabled` - Is the public network access enabled?

*   `replicaCapacity` - The maximum number of replicas that a primary MySQL Flexible Server can have.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 1 hour) Used when creating the MySQL Flexible Server.
* `read` - (Defaults to 5 minutes) Used when retrieving the MySQL Flexible Server.
* `update` - (Defaults to 1 hour) Used when updating the MySQL Flexible Server.
* `delete` - (Defaults to 1 hour) Used when deleting the MySQL Flexible Server.

## Import

MySQL Flexible Servers can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_mysql_flexible_server.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.DBforMySQL/flexibleServers/flexibleServer1
```
