---
subcategory: "Cloud (Stackdriver) Logging"
description: |-
  Manages a folder-level logging sink.
---

# googleLoggingFolderSink

Manages a folder-level logging sink. For more information see:

* [API documentation](https://cloud.google.com/logging/docs/reference/v2/rest/v2/folders.sinks)
* How-to Guides
  * [Exporting Logs](https://cloud.google.com/logging/docs/export)

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleFolderMyFolder = new google.folder.Folder(this, "my-folder", {
  display_name: "My folder",
  parent: "organizations/123456",
});
const googleStorageBucketLogBucket = new google.storageBucket.StorageBucket(
  this,
  "log-bucket",
  {
    location: "US",
    name: "folder-logging-bucket",
  }
);
const googleLoggingFolderSinkMySink =
  new google.loggingFolderSink.LoggingFolderSink(this, "my-sink", {
    description: "some explanation on what this is",
    destination: `storage.googleapis.com/\${${googleStorageBucketLogBucket.name}}`,
    filter: "resource.type = gce_instance AND severity >= WARNING",
    folder: googleFolderMyFolder.name,
    name: "my-sink",
  });
new google.projectIamBinding.ProjectIamBinding(this, "log-writer", {
  members: [googleLoggingFolderSinkMySink.writerIdentity],
  project: "your-project-id",
  role: "roles/storage.objectCreator",
});

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the logging sink.

*   `folder` - (Required) The folder to be exported to the sink. Note that either `[folderId]` or `folders/[folderId]` is
    accepted.

*   `destination` - (Required) The destination of the sink (or, in other words, where logs are written to). Can be a
    Cloud Storage bucket, a PubSub topic, a BigQuery dataset or a Cloud Logging bucket. Examples:

    * `storageGoogleapisCom/[gcsBucket]`
    * `bigqueryGoogleapisCom/projects/[projectId]/datasets/[dataset]`
    * `pubsubGoogleapisCom/projects/[projectId]/topics/[topicId]`
    * `loggingGoogleapisCom/projects/[projectId]]/locations/global/buckets/[bucketId]`

    The writer associated with the sink must have access to write to the above resource.

*   `filter` - (Optional) The filter to apply when exporting logs. Only log entries that match the filter are exported.
    See [Advanced Log Filters](https://cloud.google.com/logging/docs/view/advanced_filters) for information on how to
    write a filter.

*   `description` - (Optional) A description of this sink. The maximum length of the description is 8000 characters.

*   `disabled` - (Optional) If set to True, then this sink is disabled and it does not export any log entries.

*   `includeChildren` - (Optional) Whether or not to include children folders in the sink export. If true, logs
    associated with child projects are also exported; otherwise only logs relating to the provided folder are included.

*   `bigqueryOptions` - (Optional) Options that affect sinks exporting data to BigQuery. Structure [documented below](#nested_bigquery_options).

*   `exclusions` - (Optional) Log entries that match any of the exclusion filters will not be exported. If a log entry is matched by both `filter` and one of `exclusionsFilter`, it will not be exported.  Can be repeated multiple times for multiple exclusions. Structure is [documented below](#nested_exclusions).

<a name="nested_bigquery_options"></a>The `bigqueryOptions` block supports:

* `usePartitionedTables` - (Required) Whether to use [BigQuery's partition tables](https://cloud.google.com/bigquery/docs/partitioned-tables).
  By default, Logging creates dated tables based on the log entries' timestamps, e.g. syslog\_20170523. With partitioned
  tables, the date suffix is no longer present and [special query syntax](https://cloud.google.com/bigquery/docs/querying-partitioned-tables)
  has to be used instead. In both cases, tables are sharded based on UTC timezone.

<a name="nested_exclusions"></a>The `exclusions` block supports:

* `name` - (Required) A client-assigned identifier, such as `loadBalancerExclusion`. Identifiers are limited to 100 characters and can include only letters, digits, underscores, hyphens, and periods. First character has to be alphanumeric.
* `description` - (Optional) A description of this exclusion.
* `filter` - (Required) An advanced logs filter that matches the log entries to be excluded. By using the sample function, you can exclude less than 100% of the matching log entries. See [Advanced Log Filters](https://cloud.google.com/logging/docs/view/advanced_filters) for information on how to
  write a filter.
* `disabled` - (Optional) If set to True, then this exclusion is disabled and it does not exclude any log entries.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are
exported:

*   `id` - an identifier for the resource with format `folders/{{folderId}}/sinks/{{name}}`

*   `writerIdentity` - The identity associated with this sink. This identity must be granted write access to the
    configured `destination`.

## Import

Folder-level logging sinks can be imported using this format:

```console
$ terraform import google_logging_folder_sink.my_sink folders/{{folder_id}}/sinks/{{name}}
```
