---
subcategory: "Cloud SQL"
description: |-
  Get a  SQL backup run in Google Cloud SQL.
---

# googleSqlBackupRun

Use this data source to get information about a Cloud SQL instance backup run.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.dataGoogleSqlBackupRun.DataGoogleSqlBackupRun(this, "backup", {
  instance: "${google_sql_database_instance.main.name}",
  most_recent: true,
});

```

## Argument Reference

The following arguments are supported:

*   `instance` - (required) The name of the instance the backup is taken from.

*   `backupId` - (optional) The identifier for this backup run. Unique only for a specific Cloud SQL instance.
    If left empty and multiple backups exist for the instance, `mostRecent` must be set to `true`.

*   `mostRecent` - (optional) Toggles use of the most recent backup run if multiple backups exist for a
    Cloud SQL instance.

*   `project` - (Optional) The project to list instances for. If it
    is not provided, the provider project is used.

## Attributes Reference

In addition to the arguments listed above, the following attributes are exported:

*   `location` -  Location of the backups.

*   `startTime` - The time the backup operation actually started in UTC timezone in RFC 3339 format, for
    example 2012-11-15T16:19:00.094Z.

*   `status` - The status of this run. Refer to [API reference](https://cloud.google.com/sql/docs/mysql/admin-api/rest/v1beta4/backupRuns#SqlBackupRunStatus) for possible status values.
