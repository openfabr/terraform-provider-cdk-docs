---
subcategory: "Database"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_postgresql_virtual_network_rule"
description: |-
  Manages a PostgreSQL Virtual Network Rule.
---

# azurermPostgresqlVirtualNetworkRule

Manages a PostgreSQL Virtual Network Rule.

\-> **NOTE:** PostgreSQL Virtual Network Rules [can only be used with SKU Tiers of `generalPurpose` or `memoryOptimized`](https://docs.microsoft.com/azure/postgresql/concepts-data-access-and-security-vnet)

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
    name: "example-resources",
  }
);
const azurermVirtualNetworkExample = new azurerm.virtualNetwork.VirtualNetwork(
  this,
  "example_1",
  {
    address_space: ["10.7.29.0/29"],
    location: azurermResourceGroupExample.location,
    name: "example-vnet",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualNetworkExample.overrideLogicalId("example");
const azurermPostgresqlServerExample =
  new azurerm.postgresqlServer.PostgresqlServer(this, "example_2", {
    administrator_login: "psqladmin",
    administrator_login_password: "H@Sh1CoR3!",
    backup_retention_days: 7,
    location: azurermResourceGroupExample.location,
    name: "postgresql-server-1",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "GP_Gen5_2",
    ssl_enforcement_enabled: true,
    storage_mb: 5120,
    version: "9.5",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermPostgresqlServerExample.overrideLogicalId("example");
const azurermSubnetInternal = new azurerm.subnet.Subnet(this, "internal", {
  address_prefixes: ["10.7.29.0/29"],
  name: "internal",
  resource_group_name: azurermResourceGroupExample.name,
  service_endpoints: ["Microsoft.Sql"],
  virtual_network_name: azurermVirtualNetworkExample.name,
});
const azurermPostgresqlVirtualNetworkRuleExample =
  new azurerm.postgresqlVirtualNetworkRule.PostgresqlVirtualNetworkRule(
    this,
    "example_4",
    {
      ignore_missing_vnet_service_endpoint: true,
      name: "postgresql-vnet-rule",
      resource_group_name: azurermResourceGroupExample.name,
      server_name: azurermPostgresqlServerExample.name,
      subnet_id: azurermSubnetInternal.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermPostgresqlVirtualNetworkRuleExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the PostgreSQL virtual network rule. Cannot be empty and must only contain alphanumeric characters and hyphens. Cannot start with a number, and cannot start or end with a hyphen. Changing this forces a new resource to be created.

\~> **NOTE:** `name` must be between 1-128 characters long and must satisfy all of the requirements below:

1. Contains only alphanumeric and hyphen characters
2. Cannot start with a number or hyphen
3. Cannot end with a hyphen

*   `resourceGroupName` - (Required) The name of the resource group where the PostgreSQL server resides. Changing this forces a new resource to be created.

*   `serverName` - (Required) The name of the SQL Server to which this PostgreSQL virtual network rule will be applied to. Changing this forces a new resource to be created.

*   `subnetId` - (Required) The ID of the subnet that the PostgreSQL server will be connected to.

*   `ignoreMissingVnetServiceEndpoint` - (Optional) Should the Virtual Network Rule be created before the Subnet has the Virtual Network Service Endpoint enabled?

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the PostgreSQL Virtual Network Rule.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the PostgreSQL Virtual Network Rule.
* `update` - (Defaults to 30 minutes) Used when updating the PostgreSQL Virtual Network Rule.
* `read` - (Defaults to 5 minutes) Used when retrieving the PostgreSQL Virtual Network Rule.
* `delete` - (Defaults to 30 minutes) Used when deleting the PostgreSQL Virtual Network Rule.

## Import

PostgreSQL Virtual Network Rules can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_postgresql_virtual_network_rule.rule1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.DBforPostgreSQL/servers/myserver/virtualNetworkRules/vnetrulename
```
