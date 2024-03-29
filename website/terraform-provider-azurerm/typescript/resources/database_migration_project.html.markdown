---
subcategory: "Database Migration"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_database_migration_project"
description: |-
  Manage Azure Database Migration Project instance.
---

# azurermDatabaseMigrationProject

Manage a Azure Database Migration Project.

\~> **NOTE:** Destroying a Database Migration Project will leave any outstanding tasks untouched. This is to avoid unexpectedly deleting any tasks managed outside of terraform.

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
    name: "example-rg",
  }
);
const azurermVirtualNetworkExample = new azurerm.virtualNetwork.VirtualNetwork(
  this,
  "example_1",
  {
    address_space: ["10.0.0.0/16"],
    location: azurermResourceGroupExample.location,
    name: "example-vnet",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualNetworkExample.overrideLogicalId("example");
const azurermSubnetExample = new azurerm.subnet.Subnet(this, "example_2", {
  address_prefixes: ["10.0.1.0/24"],
  name: "example-subnet",
  resource_group_name: azurermResourceGroupExample.name,
  virtual_network_name: azurermVirtualNetworkExample.name,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubnetExample.overrideLogicalId("example");
const azurermDatabaseMigrationServiceExample =
  new azurerm.databaseMigrationService.DatabaseMigrationService(
    this,
    "example_3",
    {
      location: azurermResourceGroupExample.location,
      name: "example-dbms",
      resource_group_name: azurermResourceGroupExample.name,
      sku_name: "Standard_1vCores",
      subnet_id: azurermSubnetExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermDatabaseMigrationServiceExample.overrideLogicalId("example");
const azurermDatabaseMigrationProjectExample =
  new azurerm.databaseMigrationProject.DatabaseMigrationProject(
    this,
    "example_4",
    {
      location: azurermResourceGroupExample.location,
      name: "example-dbms-project",
      resource_group_name: azurermResourceGroupExample.name,
      service_name: azurermDatabaseMigrationServiceExample.name,
      source_platform: "SQL",
      target_platform: "SQLDB",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermDatabaseMigrationProjectExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Specify the name of the database migration project. Changing this forces a new resource to be created.

*   `serviceName` - (Required) Name of the database migration service where resource belongs to. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) Name of the resource group in which to create the database migration project. Changing this forces a new resource to be created.

*   `location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.

*   `sourcePlatform` - (Required) The platform type of the migration source. Currently only support: `sql`(on-premises SQL Server). Changing this forces a new resource to be created.

*   `targetPlatform` - (Required) The platform type of the migration target. Currently only support: `sqldb`(Azure SQL Database). Changing this forces a new resource to be created.

*   `tags` - (Optional) A mapping of tags to assigned to the resource.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of Database Migration Project.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the API Management API.
* `update` - (Defaults to 30 minutes) Used when updating the API Management API.
* `read` - (Defaults to 5 minutes) Used when retrieving the API Management API.
* `delete` - (Defaults to 30 minutes) Used when deleting the API Management API.

## Import

Database Migration Projects can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_database_migration_project.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.DataMigration/services/example-dms/projects/project1
```
