---
subcategory: "EBS (EC2)"
layout: "aws"
page_title: "AWS: aws_ebs_volume"
description: |-
  Get information on an EBS volume.
---

# Data Source: awsEbsVolume

Use this data source to get information about an EBS volume for use in other
resources.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsEbsVolume.DataAwsEbsVolume(this, "ebs_volume", {
  filter: [
    {
      name: "volume-type",
      values: ["gp2"],
    },
    {
      name: "tag:Name",
      values: ["Example"],
    },
  ],
  mostRecent: true,
});

```

## Argument Reference

The following arguments are supported:

* `mostRecent` - (Optional) If more than one result is returned, use the most
  recent Volume.
* `filter` - (Optional) One or more name/value pairs to filter off of. There are
  several valid keys, for a full reference, check out
  [describe-volumes in the AWS CLI reference][1].

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Volume ID (e.g., vol-59fcb34e).
* `volumeId` - Volume ID (e.g., vol-59fcb34e).
* `arn` - Volume ARN (e.g., arn:aws:ec2:us-east-1:0123456789012:volume/vol-59fcb34e).
* `availabilityZone` - AZ where the EBS volume exists.
* `encrypted` - Whether the disk is encrypted.
* `iops` - Amount of IOPS for the disk.
* `multiAttachEnabled` - (Optional) Specifies whether Amazon EBS Multi-Attach is enabled.
* `size` - Size of the drive in GiBs.
* `snapshotId` - Snapshot\_id the EBS volume is based off.
* `outpostArn` - ARN of the Outpost.
* `volumeType` - Type of EBS volume.
* `kmsKeyId` - ARN for the KMS encryption key.
* `tags` - Map of tags for the resource.
* `throughput` - Throughput that the volume supports, in MiB/s.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `read` - (Default `20M`)

[1]: http://docs.aws.amazon.com/cli/latest/reference/ec2/describe-volumes.html
