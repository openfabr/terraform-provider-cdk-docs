---
subcategory: "DataSync"
layout: "aws"
page_title: "AWS: aws_datasync_location_fsx_openzfs_file_system"
description: |-
  Manages an FSx OpenZfs Location within AWS DataSync.
---

# Resource: awsDatasyncLocationFsxOpenzfsFileSystem

Manages an AWS DataSync FSx OpenZfs Location.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.datasyncLocationFsxOpenzfsFileSystem.DatasyncLocationFsxOpenzfsFileSystem(
  this,
  "example",
  {
    fsxFilesystemArn: "${aws_fsx_openzfs_file_system.example.arn}",
    protocol: {
      nfs: {
        mountOptions: {
          version: "AUTOMATIC",
        },
      },
    },
    securityGroupArns: ["${aws_security_group.example.arn}"],
  }
);

```

## Argument Reference

The following arguments are supported:

* `fsxFilesystemArn` - (Required) The Amazon Resource Name (ARN) for the FSx for OpenZfs file system.
* `protocol` - (Required) The type of protocol that DataSync uses to access your file system. See below.
* `securityGroupArns` - (Optional) The Amazon Resource Names (ARNs) of the security groups that are to use to configure the FSx for openzfs file system.
* `subdirectory` - (Optional) Subdirectory to perform actions as source or destination. Must start with `/fsx`.
* `tags` - (Optional) Key-value pairs of resource tags to assign to the DataSync Location. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### protocol

* `nfs` - (Required) Represents the Network File System (NFS) protocol that DataSync uses to access your FSx for OpenZFS file system. See below.

### nfs

* `mountOptions` - (Required) Represents the mount options that are available for DataSync to access an NFS location. See below.

### mountOptions

* `version` - (Optional) The specific NFS version that you want DataSync to use for mounting your NFS share. Valid values: `automatic`, `nfs3`, `NFS4_0` and `NFS4_1`. Default: `automatic`

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Amazon Resource Name (ARN) of the DataSync Location.
* `arn` - Amazon Resource Name (ARN) of the DataSync Location.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).
* `uri` - The URL of the FSx for openzfs location that was described.
* `creationTime` - The time that the FSx for openzfs location was created.

## Import

`awsDatasyncLocationFsxOpenzfsFileSystem` can be imported by using the `dataSyncArn#fSxOpenzfsArn`, e.g.,

```console
$ terraform import aws_datasync_location_fsx_openzfs_file_system.example arn:aws:datasync:us-west-2:123456789012:location/loc-12345678901234567#arn:aws:fsx:us-west-2:123456789012:file-system/fs-08e04cd442c1bb94a
```
