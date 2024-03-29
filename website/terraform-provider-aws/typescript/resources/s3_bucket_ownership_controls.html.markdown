---
subcategory: "S3 (Simple Storage)"
layout: "aws"
page_title: "AWS: aws_s3_bucket_ownership_controls"
description: |-
  Manages S3 Bucket Ownership Controls.
---

# Resource: awsS3BucketOwnershipControls

Provides a resource to manage S3 Bucket Ownership Controls. For more information, see the [S3 Developer Guide](https://docs.aws.amazon.com/AmazonS3/latest/dev/about-object-ownership.html).

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "example",
});
const awsS3BucketOwnershipControlsExample =
  new aws.s3BucketOwnershipControls.S3BucketOwnershipControls(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      rule: {
        objectOwnership: "BucketOwnerPreferred",
      },
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketOwnershipControlsExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are required:

* `bucket` - (Required) Name of the bucket that you want to associate this access point with.
* `rule` - (Required) Configuration block(s) with Ownership Controls rules. Detailed below.

### rule Configuration Block

The following arguments are required:

* `objectOwnership` - (Required) Object ownership. Valid values: `bucketOwnerPreferred`, `objectWriter` or `bucketOwnerEnforced`
  * `bucketOwnerPreferred` - Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the `bucketOwnerFullControl` canned ACL.
  * `objectWriter` - Uploading account will own the object if the object is uploaded with the `bucketOwnerFullControl` canned ACL.
  * `bucketOwnerEnforced` - Bucket owner automatically owns and has full control over every object in the bucket. ACLs no longer affect permissions to data in the S3 bucket.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - S3 Bucket name.

## Import

S3 Bucket Ownership Controls can be imported using S3 Bucket name, e.g.,

```console
$ terraform import aws_s3_bucket_ownership_controls.example my-bucket
```
