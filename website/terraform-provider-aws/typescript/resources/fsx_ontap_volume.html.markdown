---
subcategory: "FSx"
layout: "aws"
page_title: "AWS: aws_fsx_ontap_volume"
description: |-
  Manages a FSx ONTAP Volume.
---

# Resource: awsFsxOntapVolume

Manages a FSx ONTAP Volume.
See the [FSx ONTAP User Guide](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/managing-volumes.html) for more information.

## Example Usage

### Basic Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.fsxOntapVolume.FsxOntapVolume(this, "test", {
  junctionPath: "/test",
  name: "test",
  sizeInMegabytes: 1024,
  storageEfficiencyEnabled: true,
  storageVirtualMachineId: "${aws_fsx_ontap_storage_virtual_machine.test.id}",
});

```

### Using Tiering Policy

Additional information on tiering policy with ONTAP Volumes can be found in the [FSx ONTAP Guide](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/managing-volumes.html).

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.fsxOntapVolume.FsxOntapVolume(this, "test", {
  junctionPath: "/test",
  name: "test",
  sizeInMegabytes: 1024,
  storageEfficiencyEnabled: true,
  storageVirtualMachineId: "${aws_fsx_ontap_storage_virtual_machine.test.id}",
  tieringPolicy: {
    coolingPeriod: 31,
    name: "AUTO",
  },
});

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the Volume. You can use a maximum of 203 alphanumeric characters, plus the underscore (\_) special character.
* `junctionPath` - (Required) Specifies the location in the storage virtual machine's namespace where the volume is mounted. The junction\_path must have a leading forward slash, such as `/vol3`
* `securityStyle` - (Optional) Specifies the volume security style, Valid values are `unix`, `ntfs`, and `mixed`. Default value is `unix`.
* `sizeInMegabytes` - (Required) Specifies the size of the volume, in megabytes (MB), that you are creating.
* `storageEfficiencyEnabled` - (Required) Set to true to enable deduplication, compression, and compaction storage efficiency features on the volume.
* `storageVirtualMachineId` - (Required) Specifies the storage virtual machine in which to create the volume.
* `tags` - (Optional) A map of tags to assign to the volume. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### tieringPolicy

The following arguments are supported for `tieringPolicy` configuration block:

* `name` - (Required) Specifies the tiering policy for the ONTAP volume for moving data to the capacity pool storage. Valid values are `SNAPSHOT_ONLY`, `auto`, `all`, `none`. Default value is `SNAPSHOT_ONLY`.
* `coolingPolicy` - (Optional) Specifies the number of days that user data in a volume must remain inactive before it is considered "cold" and moved to the capacity pool. Used with `auto` and `SNAPSHOT_ONLY` tiering policies only. Valid values are whole numbers between 2 and 183. Default values are 31 days for `auto` and 2 days for `SNAPSHOT_ONLY`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name of the volune.
* `id` - Identifier of the volume, e.g., `fsvol12345678`
* `fileSystemId` - Describes the file system for the volume, e.g. `fs12345679`
* `flexcacheEndpointType` - Specifies the FlexCache endpoint type of the volume, Valid values are `none`, `origin`, `cache`. Default value is `none`. These can be set by the ONTAP CLI or API and are use with FlexCache feature.
* `ontapVolumeType` - Specifies the type of volume, Valid values are `rw`, `dp`,  and `ls`. Default value is `rw`. These can be set by the ONTAP CLI or API. This setting is used as part of migration and replication [Migrating to Amazon FSx for NetApp ONTAP](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/migrating-fsx-ontap.html)
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).
* `uuid` - The Volume's UUID (universally unique identifier).
* `volumeType` - The type of volume, currently the only valid value is `ontap`.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `30M`)
* `delete` - (Default `30M`)
* `update` - (Default `30M`)

## Import

FSx ONTAP volume can be imported using the `id`, e.g.,

```console
$ terraform import aws_fsx_ontap_volume.example fsvol-12345678abcdef123
```
