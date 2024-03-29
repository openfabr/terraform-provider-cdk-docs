---
subcategory: "Cloud (Stackdriver) Logging"
description: |-
  Manages a project-level logging exclusion.
---

# googleLoggingProjectExclusion

Manages a project-level logging exclusion. For more information see:

* [API documentation](https://cloud.google.com/logging/docs/reference/v2/rest/v2/projects.exclusions)
* How-to Guides
  * [Excluding Logs](https://cloud.google.com/logging/docs/exclusions)

\~> You can specify exclusions for log sinks created by terraform by using the exclusions field of `googleLoggingProjectSink`

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.loggingProjectExclusion.LoggingProjectExclusion(
  this,
  "my-exclusion",
  {
    description: "Exclude GCE instance debug logs",
    filter: "resource.type = gce_instance AND severity <= DEBUG",
    name: "my-instance-debug-exclusion",
  }
);

```

## Argument Reference

The following arguments are supported:

*   `filter` - (Required) The filter to apply when excluding logs. Only log entries that match the filter are excluded.
    See [Advanced Log Filters](https://cloud.google.com/logging/docs/view/advanced-filters) for information on how to
    write a filter.

*   `name` - (Required) The name of the logging exclusion.

*   `description` - (Optional) A human-readable description.

*   `disabled` - (Optional) Whether this exclusion rule should be disabled or not. This defaults to
    false.

*   `project` - (Optional) The project to create the exclusion in. If omitted, the project associated with the provider is
    used.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

* `id` - an identifier for the resource with format `projects/{{project}}/exclusions/{{name}}`

## Import

Project-level logging exclusions can be imported using their URI, e.g.

```console
$ terraform import google_logging_project_exclusion.my_exclusion projects/my-project/exclusions/my-exclusion
```
