---
subcategory: "Database Migration"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_database_migration_project"
description: |-
  Gets information about an existing Database Migration Project
---

# Data Source: azurermDatabaseMigrationProject

Use this data source to access information about an existing Database Migration Project.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
new azurerm.provider.AzurermProvider(this, "azurerm", {
  features: [{}],
});
const dataAzurermDatabaseMigrationProjectExample =
  new azurerm.dataAzurermDatabaseMigrationProject.DataAzurermDatabaseMigrationProject(
    this,
    "example",
    {
      name: "example-dbms-project",
      resource_group_name: "example-rg",
      service_name: "example-dbms",
    }
  );
new cdktf.TerraformOutput(this, "name", {
  value: dataAzurermDatabaseMigrationProjectExample.name,
});

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Name of the database migration project.

*   `resourceGroupName` - (Required) Name of the resource group where resource belongs to.

*   `serviceName` - (Required) Name of the database migration service where resource belongs to.

## Attributes Reference

The following attributes are exported:

*   `id` - The ID of Database Migration Project.

*   `location` - Azure location where the resource exists.

*   `sourcePlatform` - The platform type of the migration source.

*   `targetPlatform` - The platform type of the migration target.

*   `tags` - A mapping of tags to assigned to the resource.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the API Management API.
