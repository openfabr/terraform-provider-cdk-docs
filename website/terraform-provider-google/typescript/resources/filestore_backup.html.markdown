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
subcategory: "Filestore"
description: |-
  A Google Cloud Filestore backup.
---

# googleFilestoreBackup

A Google Cloud Filestore backup.

To get more information about Backup, see:

* [API documentation](https://cloud.google.com/filestore/docs/reference/rest/v1/projects.locations.instances.backups)
* How-to Guides
  * [Official Documentation](https://cloud.google.com/filestore/docs/backups)
  * [Creating Backups](https://cloud.google.com/filestore/docs/create-backups)

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=filestore_backup_basic&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Filestore Backup Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleFilestoreInstanceInstance =
  new google.filestoreInstance.FilestoreInstance(this, "instance", {
    file_shares: [
      {
        capacity_gb: 2560,
        name: "share1",
      },
    ],
    location: "us-central1-b",
    name: "tf-fs-inst",
    networks: [
      {
        connect_mode: "DIRECT_PEERING",
        modes: ["MODE_IPV4"],
        network: "default",
      },
    ],
    tier: "BASIC_SSD",
  });
new google.filestoreBackup.FilestoreBackup(this, "backup", {
  description: "This is a filestore backup for the test instance",
  labels: [
    {
      files: "label1",
      "other-label": "label2",
    },
  ],
  location: "us-central1",
  name: "tf-fs-bkup",
  source_file_share: "share1",
  source_instance: googleFilestoreInstanceInstance.id,
});

```

## Argument Reference

The following arguments are supported:

*   `name` -
    (Required)
    The resource name of the backup. The name must be unique within the specified instance.
    The name must be 1-63 characters long, and comply with
    RFC1035. Specifically, the name must be 1-63 characters long and match
    the regular expression `[aZ]([AZ09]*[aZ09])?` which means the
    first character must be a lowercase letter, and all following
    characters must be a dash, lowercase letter, or digit, except the last
    character, which cannot be a dash.

*   `sourceInstance` -
    (Required)
    The resource name of the source Cloud Filestore instance, in the format projects/{projectId}/locations/{locationId}/instances/{instanceId}, used to create this backup.

*   `sourceFileShare` -
    (Required)
    Name of the file share in the source Cloud Filestore instance that the backup is created from.

*   `location` -
    (Required)
    The name of the location of the instance. This can be a region for ENTERPRISE tier instances.

***

*   `description` -
    (Optional)
    A description of the backup with 2048 characters or less. Requests with longer descriptions will be rejected.

*   `labels` -
    (Optional)
    Resource labels to represent user-provided metadata.

*   `project` - (Optional) The ID of the project in which the resource belongs.
    If it is not provided, the provider project is used.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `projects/{{project}}/locations/{{location}}/backups/{{name}}`

*   `state` -
    The backup state.

*   `createTime` -
    The time when the snapshot was created in RFC3339 text format.

*   `capacityGb` -
    The amount of bytes needed to allocate a full copy of the snapshot content.

*   `storageBytes` -
    The size of the storage used by the backup. As backups share storage, this number is expected to change with backup creation/deletion.

*   `sourceInstanceTier` -
    The service tier of the source Cloud Filestore instance that this backup is created from.

*   `downloadBytes` -
    Amount of bytes that will be downloaded if the backup is restored.

*   `kmsKeyName` -
    KMS key name used for data encryption.

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `update` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

Backup can be imported using any of these accepted formats:

```console
$ terraform import google_filestore_backup.default projects/{{project}}/locations/{{location}}/backups/{{name}}
$ terraform import google_filestore_backup.default {{project}}/{{location}}/{{name}}
$ terraform import google_filestore_backup.default {{location}}/{{name}}
```

## User Project Overrides

This resource supports [User Project Overrides](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#user_project_override).
