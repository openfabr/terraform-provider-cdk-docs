---
subcategory: "Database"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_mysql_virtual_network_rule"
description: |-
  Manages a MySQL Virtual Network Rule.
---

# azurermMysqlVirtualNetworkRule

Manages a MySQL Virtual Network Rule.

\-> **NOTE:** MySQL Virtual Network Rules [can only be used with SKU Tiers of `generalPurpose` or `memoryOptimized`](https://docs.microsoft.com/azure/mysql/concepts-data-access-and-security-vnet)

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
    address_space: ["10.7.29.0/29"],
    location: azurermResourceGroupExample.location,
    name: "example-vnet",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualNetworkExample.overrideLogicalId("example");
const azurermMysqlServerExample = new azurerm.mysqlServer.MysqlServer(
  this,
  "example_3",
  {
    administrator_login: "mysqladminun",
    administrator_login_password: "H@Sh1CoR3!",
    backup_retention_days: 7,
    geo_redundant_backup_enabled: false,
    location: azurermResourceGroupExample.location,
    name: "example-mysqlserver",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "GP_Gen5_2",
    ssl_enforcement_enabled: true,
    storage_mb: 5120,
    version: "5.7",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermMysqlServerExample.overrideLogicalId("example");
const azurermSubnetInternal = new azurerm.subnet.Subnet(this, "internal", {
  address_prefixes: ["10.7.29.0/29"],
  name: "internal",
  resource_group_name: azurermResourceGroupExample.name,
  service_endpoints: ["Microsoft.Sql"],
  virtual_network_name: azurermVirtualNetworkExample.name,
});
const azurermMysqlVirtualNetworkRuleExample =
  new azurerm.mysqlVirtualNetworkRule.MysqlVirtualNetworkRule(
    this,
    "example_5",
    {
      name: "mysql-vnet-rule",
      resource_group_name: azurermResourceGroupExample.name,
      server_name: azurermMysqlServerExample.name,
      subnet_id: azurermSubnetInternal.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermMysqlVirtualNetworkRuleExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the MySQL Virtual Network Rule. Cannot be empty and must only contain alphanumeric characters and hyphens. Cannot start with a number, and cannot start or end with a hyphen. Changing this forces a new resource to be created.

\~> **NOTE:** `name` must be between 1-128 characters long and must satisfy all of the requirements below:

1. Contains only alphanumeric and hyphen characters
2. Cannot start with a number or hyphen
3. Cannot end with a hyphen

*   `resourceGroupName` - (Required) The name of the resource group where the MySQL server resides. Changing this forces a new resource to be created.

*   `serverName` - (Required) The name of the SQL Server to which this MySQL virtual network rule will be applied to. Changing this forces a new resource to be created.

*   `subnetId` - (Required) The ID of the subnet that the MySQL server will be connected to.

\~> **NOTE:** Due to [a bug in the Azure API](https://github.com/Azure/azure-rest-api-specs/issues/3719) this resource currently doesn't expose the `ignoreMissingVnetServiceEndpoint` field and defaults this to `false`. Terraform will check during the provisioning of the Virtual Network Rule that the Subnet contains the Service Rule to verify that the Virtual Network Rule can be created.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the MySQL Virtual Network Rule.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the MySQL Virtual Network Rule.
* `update` - (Defaults to 30 minutes) Used when updating the MySQL Virtual Network Rule.
* `read` - (Defaults to 5 minutes) Used when retrieving the MySQL Virtual Network Rule.
* `delete` - (Defaults to 30 minutes) Used when deleting the MySQL Virtual Network Rule.

## Import

MySQL Virtual Network Rules can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_mysql_virtual_network_rule.rule1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.DBforMySQL/servers/myserver/virtualNetworkRules/vnetrulename
```
