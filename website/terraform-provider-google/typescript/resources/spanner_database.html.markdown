---
# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    Type: MMv1     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in
#     .github/CONTRIBUTING.md.
#
# ----------------------------------------------------------------------------
subcategory: "Cloud Spanner"
description: |-
  A Cloud Spanner Database which is hosted on a Spanner instance.
---

# googleSpannerDatabase

A Cloud Spanner Database which is hosted on a Spanner instance.

To get more information about Database, see:

* [API documentation](https://cloud.google.com/spanner/docs/reference/rest/v1/projects.instances.databases)
* How-to Guides
  * [Official Documentation](https://cloud.google.com/spanner/)

\~> **Warning:** On newer versions of the provider, you must explicitly set `deletionProtection=false`
(and run `terraformApply` to write the field to state) in order to destroy an instance.
It is recommended to not set this field (or set it to true) until you're ready to destroy.
On older versions, it is strongly recommended to set `lifecycle {PreventDestroy =True }`
on databases in order to prevent accidental data loss. See [Terraform docs](https://www.terraform.io/docs/configuration/resources.html#prevent_destroy)
for more information on lifecycle parameters.

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=spanner_database_basic&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Spanner Database Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleSpannerInstanceMain = new google.spannerInstance.SpannerInstance(
  this,
  "main",
  {
    config: "regional-europe-west1",
    display_name: "main-instance",
    num_nodes: 1,
  }
);
new google.spannerDatabase.SpannerDatabase(this, "database", {
  ddl: [
    "CREATE TABLE t1 (t1 INT64 NOT NULL,) PRIMARY KEY(t1)",
    "CREATE TABLE t2 (t2 INT64 NOT NULL,) PRIMARY KEY(t2)",
  ],
  deletion_protection: false,
  instance: googleSpannerInstanceMain.name,
  name: "my-database",
  version_retention_period: "3d",
});

```

## Argument Reference

The following arguments are supported:

*   `name` -
    (Required)
    A unique identifier for the database, which cannot be changed after
    the instance is created. Values are of the form \[a-z]\[-a-z0-9]\*\[a-z0-9].

*   `instance` -
    (Required)
    The instance to create the database on.

***

*   `versionRetentionPeriod` -
    (Optional)
    The retention period for the database. The retention period must be between 1 hour
    and 7 days, and can be specified in days, hours, minutes, or seconds. For example,
    the values 1d, 24h, 1440m, and 86400s are equivalent. Default value is 1h.
    If this property is used, you must avoid adding new DDL statements to `ddl` that
    update the database's version\_retention\_period.

*   `ddl` -
    (Optional)
    An optional list of DDL statements to run inside the newly created
    database. Statements can create tables, indexes, etc. These statements
    execute atomically with the creation of the database: if there is an
    error in any statement, the database is not created.

*   `encryptionConfig` -
    (Optional)
    Encryption configuration for the database
    Structure is [documented below](#nested_encryption_config).

*   `databaseDialect` -
    (Optional)
    The dialect of the Cloud Spanner Database.
    If it is not provided, "GOOGLE\_STANDARD\_SQL" will be used.
    Possible values are `googleStandardSql` and `postgresql`.

*   `project` - (Optional) The ID of the project in which the resource belongs.
    If it is not provided, the provider project is used.

*   `deletionProtection` - (Optional) Whether or not to allow Terraform to destroy the instance. Unless this field is set to false
    in Terraform state, a `terraformDestroy` or `terraformApply` that would delete the instance will fail.

<a name="nested_encryption_config"></a>The `encryptionConfig` block supports:

* `kmsKeyName` -
  (Required)
  Fully qualified name of the KMS key to use to encrypt this database. This key must exist
  in the same location as the Spanner Database.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `{{instance}}/{{name}}`

*   `state` -
    An explanation of the status of the database.

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `update` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

Database can be imported using any of these accepted formats:

```console
$ terraform import google_spanner_database.default projects/{{project}}/instances/{{instance}}/databases/{{name}}
$ terraform import google_spanner_database.default instances/{{instance}}/databases/{{name}}
$ terraform import google_spanner_database.default {{project}}/{{instance}}/{{name}}
$ terraform import google_spanner_database.default {{instance}}/{{name}}
```

## User Project Overrides

This resource supports [User Project Overrides](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#user_project_override).
