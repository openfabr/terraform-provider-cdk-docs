---
subcategory: "Stream Analytics"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_stream_analytics_output_mssql"
description: |-
  Manages a Stream Analytics Output to Microsoft SQL Server Database.
---

# azurermStreamAnalyticsOutputMssql

Manages a Stream Analytics Output to Microsoft SQL Server Database.

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
    name: "rg-example",
  }
);
const azurermSqlServerExample = new azurerm.sqlServer.SqlServer(
  this,
  "example_1",
  {
    administrator_login: "dbadmin",
    administrator_login_password: "example-password",
    location: azurermResourceGroupExample.location,
    name: "example-server",
    resource_group_name: azurermResourceGroupExample.name,
    version: "12.0",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSqlServerExample.overrideLogicalId("example");
const dataAzurermStreamAnalyticsJobExample =
  new azurerm.dataAzurermStreamAnalyticsJob.DataAzurermStreamAnalyticsJob(
    this,
    "example_2",
    {
      name: "example-job",
      resource_group_name: azurermResourceGroupExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAzurermStreamAnalyticsJobExample.overrideLogicalId("example");
const azurermSqlDatabaseExample = new azurerm.sqlDatabase.SqlDatabase(
  this,
  "example_3",
  {
    collation: "SQL_LATIN1_GENERAL_CP1_CI_AS",
    create_mode: "Default",
    location: azurermResourceGroupExample.location,
    max_size_bytes: "268435456000",
    name: "exampledb",
    requested_service_objective_name: "S0",
    resource_group_name: azurermResourceGroupExample.name,
    server_name: azurermSqlServerExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSqlDatabaseExample.overrideLogicalId("example");
const azurermStreamAnalyticsOutputMssqlExample =
  new azurerm.streamAnalyticsOutputMssql.StreamAnalyticsOutputMssql(
    this,
    "example_4",
    {
      database: azurermSqlDatabaseExample.name,
      name: "example-output-sql",
      password: azurermSqlServerExample.administratorLoginPassword,
      resource_group_name:
        dataAzurermStreamAnalyticsJobExample.resourceGroupName,
      server: azurermSqlServerExample.fullyQualifiedDomainName,
      stream_analytics_job_name: dataAzurermStreamAnalyticsJobExample.name,
      table: "ExampleTable",
      user: azurermSqlServerExample.administratorLogin,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStreamAnalyticsOutputMssqlExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the Stream Output. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the Resource Group where the Stream Analytics Job exists. Changing this forces a new resource to be created.

*   `streamAnalyticsJobName` - (Required) The name of the Stream Analytics Job. Changing this forces a new resource to be created.

*   `server` - (Required) The SQL server url. Changing this forces a new resource to be created.

*   `user` - (Optional) Username used to login to the Microsoft SQL Server. Changing this forces a new resource to be created. Required if `authenticationMode` is `connectionString`.

*   `database` - (Required) The MS SQL database name where the reference table exists. Changing this forces a new resource to be created.

*   `password` - (Optional) Password used together with username, to login to the Microsoft SQL Server. Required if `authenticationMode` is `connectionString`.

*   `table` - (Required) Table in the database that the output points to. Changing this forces a new resource to be created.

*   `maxBatchCount` - (Optional) The max batch count to write to the SQL Database. Defaults to `10000`. Possible values are between `1` and `1073741824`.

*   `maxWriterCount` - (Optional) The max writer count for the SQL Database. Defaults to `1`. Possible values are `0` which bases the writer count on the query partition and `1` which corresponds to a single writer.

*   `authenticationMode` - (Optional) The authentication mode for the Stream Output. Possible values are `msi` and `connectionString`. Defaults to `connectionString`.

## Attributes Reference

The following attributes are exported in addition to the arguments listed above:

* `id` - The ID of the Stream Analytics Output Microsoft SQL Server Database.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Stream Analytics Output Microsoft SQL Server Database.
* `update` - (Defaults to 30 minutes) Used when updating the Stream Analytics Output Microsoft SQL Server Database.
* `read` - (Defaults to 5 minutes) Used when retrieving the Stream Analytics Output Microsoft SQL Server Database.
* `delete` - (Defaults to 30 minutes) Used when deleting the Stream Analytics Output Microsoft SQL Server Database.

## Import

Stream Analytics Outputs to Microsoft SQL Server Database can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_stream_analytics_output_mssql.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.StreamAnalytics/streamingJobs/job1/outputs/output1
```
