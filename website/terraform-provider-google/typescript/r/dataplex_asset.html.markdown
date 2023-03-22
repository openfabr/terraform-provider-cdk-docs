---
# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    Type: DCL     ***
#
# ----------------------------------------------------------------------------
#
#     This file is managed by Magic Modules (https:#github.com/GoogleCloudPlatform/magic-modules)
#     and is based on the DCL (https:#github.com/GoogleCloudPlatform/declarative-resource-client-library).
#     Changes will need to be made to the DCL or Magic Modules instead of here.
#
#     We are not currently able to accept contributions to this file. If changes
#     are required, please file an issue at https:#github.com/hashicorp/terraform-provider-google/issues/new/choose
#
# ----------------------------------------------------------------------------
subcategory: "Dataplex"
description: |-
  The Dataplex Asset resource
---

# google\_dataplex\_asset

The Dataplex Asset resource

## Example Usage - basic\_asset

```hcl
resource "google_storage_bucket" "basic_bucket" {
  name          = "dataplex-bucket-%{random_suffix}"
  location      = "us-west1"
  uniform_bucket_level_access = true
  lifecycle {
    ignore_changes = [
      labels
    ]
  }
 
  project = "my-project-name"
}
 
resource "google_dataplex_lake" "basic_lake" {
  name         = "lake"
  location     = "us-west1"
  project = "my-project-name"
}
 
 
resource "google_dataplex_zone" "basic_zone" {
  name         = "zone"
  location     = "us-west1"
  lake = google_dataplex_lake.basic_lake.name
  type = "RAW"
 
  discovery_spec {
    enabled = false
  }
 
 
  resource_spec {
    location_type = "SINGLE_REGION"
  }
 
  project = "my-project-name"
}
 
 
resource "google_dataplex_asset" "primary" {
  name          = "asset"
  location      = "us-west1"
 
  lake = google_dataplex_lake.basic_lake.name
  dataplex_zone = google_dataplex_zone.basic_zone.name
 
  discovery_spec {
    enabled = false
  }
 
  resource_spec {
    name = "projects/my-project-name/buckets/dataplex-bucket-%{random_suffix}"
    type = "STORAGE_BUCKET"
  }
 
  project = "my-project-name"
  depends_on = [
    google_storage_bucket.basic_bucket
  ]
}
```

## Argument Reference

The following arguments are supported:

*   `dataplexZone` -
    (Required)
    The zone for the resource

*   `discoverySpec` -
    (Required)
    Required. Specification of the discovery feature applied to data referenced by this asset. When this spec is left unset, the asset will use the spec set on the parent zone.

*   `lake` -
    (Required)
    The lake for the resource

*   `location` -
    (Required)
    The location for the resource

*   `name` -
    (Required)
    The name of the asset.

*   `resourceSpec` -
    (Required)
    Required. Immutable. Specification of the resource that is referenced by this asset.

The `discoverySpec` block supports:

*   `csvOptions` -
    (Optional)
    Optional. Configuration for CSV data.

*   `enabled` -
    (Required)
    Required. Whether discovery is enabled.

*   `excludePatterns` -
    (Optional)
    Optional. The list of patterns to apply for selecting data to exclude during discovery. For Cloud Storage bucket assets, these are interpreted as glob patterns used to match object names. For BigQuery dataset assets, these are interpreted as patterns to match table names.

*   `includePatterns` -
    (Optional)
    Optional. The list of patterns to apply for selecting data to include during discovery if only a subset of the data should considered. For Cloud Storage bucket assets, these are interpreted as glob patterns used to match object names. For BigQuery dataset assets, these are interpreted as patterns to match table names.

*   `jsonOptions` -
    (Optional)
    Optional. Configuration for Json data.

*   `schedule` -
    (Optional)
    Optional. Cron schedule (https://en.wikipedia.org/wiki/Cron) for running discovery periodically. Successive discovery runs must be scheduled at least 60 minutes apart. The default value is to run discovery every 60 minutes. To explicitly set a timezone to the cron tab, apply a prefix in the cron tab: "CRON\_TZ=${IANA\_TIME\_ZONE}" or TZ=${IANA\_TIME\_ZONE}". The ${IANA\_TIME\_ZONE} may only be a valid string from IANA time zone database. For example, "CRON\_TZ=America/New\_York 1 \* \* \* \*", or "TZ=America/New\_York 1 \* \* \* \*".

The `resourceSpec` block supports:

*   `name` -
    (Optional)
    Immutable. Relative name of the cloud resource that contains the data that is being managed within a lake. For example: `projects/{projectNumber}/buckets/{bucketId}` `projects/{projectNumber}/datasets/{datasetId}`

*   `type` -
    (Required)
    Required. Immutable. Type of resource. Possible values: STORAGE\_BUCKET, BIGQUERY\_DATASET

***

*   `description` -
    (Optional)
    Optional. Description of the asset.

*   `displayName` -
    (Optional)
    Optional. User friendly display name.

*   `labels` -
    (Optional)
    Optional. User defined labels for the asset.

*   `project` -
    (Optional)
    The project for the resource

The `csvOptions` block supports:

*   `delimiter` -
    (Optional)
    Optional. The delimiter being used to separate values. This defaults to ','.

*   `disableTypeInference` -
    (Optional)
    Optional. Whether to disable the inference of data type for CSV data. If true, all columns will be registered as strings.

*   `encoding` -
    (Optional)
    Optional. The character encoding of the data. The default is UTF-8.

*   `headerRows` -
    (Optional)
    Optional. The number of rows to interpret as header rows that should be skipped when reading data rows.

The `jsonOptions` block supports:

*   `disableTypeInference` -
    (Optional)
    Optional. Whether to disable the inference of data type for Json data. If true, all columns will be registered as their primitive types (strings, number or boolean).

*   `encoding` -
    (Optional)
    Optional. The character encoding of the data. The default is UTF-8.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `projects/{{project}}/locations/{{location}}/lakes/{{lake}}/zones/{{dataplexZone}}/assets/{{name}}`

*   `createTime` -
    Output only. The time when the asset was created.

*   `discoveryStatus` -
    Output only. Status of the discovery feature applied to data referenced by this asset.

*   `resourceStatus` -
    Output only. Status of the resource referenced by this asset.

*   `securityStatus` -
    Output only. Status of the security policy applied to resource referenced by this asset.

*   `state` -
    Output only. Current state of the asset. Possible values: STATE\_UNSPECIFIED, ACTIVE, CREATING, DELETING, ACTION\_REQUIRED

*   `uid` -
    Output only. System generated globally unique ID for the asset. This ID will be different if the asset is deleted and re-created with the same name.

*   `updateTime` -
    Output only. The time when the asset was last updated.

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `update` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

Asset can be imported using any of these accepted formats:

```console
$ terraform import google_dataplex_asset.default projects/{{project}}/locations/{{location}}/lakes/{{lake}}/zones/{{dataplex_zone}}/assets/{{name}}
$ terraform import google_dataplex_asset.default {{project}}/{{location}}/{{lake}}/{{dataplex_zone}}/{{name}}
$ terraform import google_dataplex_asset.default {{location}}/{{lake}}/{{dataplex_zone}}/{{name}}
```
