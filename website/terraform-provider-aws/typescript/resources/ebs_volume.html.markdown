---
subcategory: "EBS (EC2)"
layout: "aws"
page_title: "AWS: aws_ebs_volume"
description: |-
  Provides an elastic block storage resource.
---

# Resource: awsEbsVolume

Manages a single EBS volume.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.ebsVolume.EbsVolume(this, "example", {
  availabilityZone: "us-west-2a",
  size: 40,
  tags: {
    Name: "HelloWorld",
  },
});

```

\~> **NOTE:** At least one of `size` or `snapshotId` is required when specifying an EBS volume

## Argument Reference

The following arguments are supported:

* `availabilityZone` - (Required) The AZ where the EBS volume will exist.
* `encrypted` - (Optional) If true, the disk will be encrypted.
* `finalSnapshot` - (Optional) If true, snapshot will be created before volume deletion. Any tags on the volume will be migrated to the snapshot. By default set to false
* `iops` - (Optional) The amount of IOPS to provision for the disk. Only valid for `type` of `io1`, `io2` or `gp3`.
* `multiAttachEnabled` - (Optional) Specifies whether to enable Amazon EBS Multi-Attach. Multi-Attach is supported on `io1` and `io2` volumes.
* `size` - (Optional) The size of the drive in GiBs.
* `snapshotId` (Optional) A snapshot to base the EBS volume off of.
* `outpostArn` - (Optional) The Amazon Resource Name (ARN) of the Outpost.
* `type` - (Optional) The type of EBS volume. Can be `standard`, `gp2`, `gp3`, `io1`, `io2`, `sc1` or `st1` (Default: `gp2`).
* `kmsKeyId` - (Optional) The ARN for the KMS encryption key. When specifying `kmsKeyId`, `encrypted` needs to be set to true. Note: Terraform must be running with credentials which have the `generateDataKeyWithoutPlaintext` permission on the specified KMS key as required by the [EBS KMS CMK volume provisioning process](https://docs.aws.amazon.com/kms/latest/developerguide/services-ebs.html#ebs-cmk) to prevent a volume from being created and almost immediately deleted.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `throughput` - (Optional) The throughput that the volume supports, in MiB/s. Only valid for `type` of `gp3`.

\~> **NOTE:** When changing the `size`, `iops` or `type` of an instance, there are [considerations](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/considerations.html) to be aware of.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The volume ID (e.g., vol-59fcb34e).
* `arn` - The volume ARN (e.g., arn:aws:ec2:us-east-1:0123456789012:volume/vol-59fcb34e).
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `5M`)
* `update` - (Default `5M`)
* `delete` - (Default `5M`)

## Import

EBS Volumes can be imported using the `id`, e.g.,

```console
$ terraform import aws_ebs_volume.id vol-049df61146c4d7901
```
