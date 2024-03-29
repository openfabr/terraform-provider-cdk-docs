---
subcategory: "Storage Gateway"
layout: "aws"
page_title: "AWS: aws_storagegateway_tape_pool"
description: |-
  Manages an AWS Storage Gateway Tape Pool
---

# Resource: awsStoragegatewayTapePool

Manages an AWS Storage Gateway Tape Pool.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.storagegatewayTapePool.StoragegatewayTapePool(this, "example", {
  poolName: "example",
  storageClass: "GLACIER",
});

```

## Argument Reference

The following arguments are supported:

* `poolName` - (Required) The name of the new custom tape pool.
* `storageClass` - (Required) The storage class that is associated with the new custom pool. When you use your backup application to eject the tape, the tape is archived directly into the storage class that corresponds to the pool. Possible values are `DEEP_ARCHIVE` or `glacier`.
* `retentionLockType` - (Required) Tape retention lock can be configured in two modes. When configured in governance mode, AWS accounts with specific IAM permissions are authorized to remove the tape retention lock from archived virtual tapes. When configured in compliance mode, the tape retention lock cannot be removed by any user, including the root AWS account. Possible values are `compliance`, `governance`, and `none`. Default value is `none`.
* `retentionLockTimeInDays` - (Optional) Tape retention lock time is set in days. Tape retention lock can be enabled for up to 100 years (36,500 days). Default value is 0.
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Volume Amazon Resource Name (ARN), e.g., `awsStoragegatewayTapePoolExampleArn:aws:storagegateway:usEast1:123456789012:tapepool/pool12345678`.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsStoragegatewayTapePool` can be imported by using the volume Amazon Resource Name (ARN), e.g.,

```console
$ terraform import aws_storagegateway_tape_pool.example arn:aws:storagegateway:us-east-1:123456789012:tapepool/pool-12345678
```
