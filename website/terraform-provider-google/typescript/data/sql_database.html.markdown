---
subcategory: "Cloud SQL"
description: |-
  Get a database in a Cloud SQL database instance.
---

# googleSqlDatabase

Use this data source to get information about a database in a Cloud SQL instance.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.dataGoogleSqlDatabase.DataGoogleSqlDatabase(this, "qa", {
  instance: "${google_sql_database_instance.main.name}",
  name: "test-sql-database",
});

```

## Argument Reference

The following arguments are supported:

*   `name` - (required) The name of the database.

*   `instance` - (required) The name of the Cloud SQL database instance in which the database belongs.

*   `project` - (optional) The ID of the project in which the instance belongs.

## Attributes Reference

See [google\_sql\_database](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) resource for details of all the available attributes.
