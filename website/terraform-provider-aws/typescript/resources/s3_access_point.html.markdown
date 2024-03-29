---
subcategory: "S3 Control"
layout: "aws"
page_title: "AWS: aws_s3_access_point"
description: |-
  Manages an S3 Access Point.
---

# Resource: awsS3AccessPoint

Provides a resource to manage an S3 Access Point.

\~> **NOTE on Access Points and Access Point Policies:** Terraform provides both a standalone [Access Point Policy](s3control_access_point_policy.html) resource and an Access Point resource with a resource policy defined in-line. You cannot use an Access Point with in-line resource policy in conjunction with an Access Point Policy resource. Doing so will cause a conflict of policies and will overwrite the access point's resource policy.

\-> Advanced usage: To use a custom API endpoint for this Terraform resource, use the [`s3Control` endpoint provider configuration](/docs/providers/aws/index.html#s3control), not the `s3` endpoint provider configuration.

## Example Usage

### AWS Partition Bucket

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "example",
});
const awsS3AccessPointExample = new aws.s3AccessPoint.S3AccessPoint(
  this,
  "example_1",
  {
    bucket: awsS3BucketExample.id,
    name: "example",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3AccessPointExample.overrideLogicalId("example");

```

### S3 on Outposts Bucket

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3ControlBucketExample = new aws.s3ControlBucket.S3ControlBucket(
  this,
  "example",
  {
    bucket: "example",
  }
);
const awsVpcExample = new aws.vpc.Vpc(this, "example_1", {
  cidrBlock: "10.0.0.0/16",
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsVpcExample.overrideLogicalId("example");
const awsS3AccessPointExample = new aws.s3AccessPoint.S3AccessPoint(
  this,
  "example_2",
  {
    bucket: awsS3ControlBucketExample.arn,
    name: "example",
    vpcConfiguration: {
      vpcId: awsVpcExample.id,
    },
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3AccessPointExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are required:

* `bucket` - (Required) Name of an AWS Partition S3 Bucket or the ARN of S3 on Outposts Bucket that you want to associate this access point with.
* `name` - (Required) Name you want to assign to this access point.

The following arguments are optional:

* `accountId` - (Optional) AWS account ID for the owner of the bucket for which you want to create an access point. Defaults to automatically determined account ID of the Terraform AWS provider.
* `bucketAccountId` - (Optional) AWS account ID associated with the S3 bucket associated with this access point.
* `policy` - (Optional) Valid JSON document that specifies the policy that you want to apply to this access point. Removing `policy` from your configuration or setting `policy` to null or an empty string (i.e., `policy = ""`) *will not* delete the policy since it could have been set by `awsS3ControlAccessPointPolicy`. To remove the `policy`, set it to `"{}"` (an empty JSON document).
* `publicAccessBlockConfiguration` - (Optional) Configuration block to manage the `publicAccessBlock` configuration that you want to apply to this Amazon S3 bucket. You can enable the configuration options in any combination. Detailed below.
* `vpcConfiguration` - (Optional) Configuration block to restrict access to this access point to requests from the specified Virtual Private Cloud (VPC). Required for S3 on Outposts. Detailed below.

### public\_access\_block\_configuration Configuration Block

The following arguments are optional:

* `blockPublicAcls` - (Optional) Whether Amazon S3 should block public ACLs for buckets in this account. Defaults to `true`. Enabling this setting does not affect existing policies or ACLs. When set to `true` causes the following behavior:
  * PUT Bucket acl and PUT Object acl calls fail if the specified ACL is public.
  * PUT Object calls fail if the request includes a public ACL.
  * PUT Bucket calls fail if the request includes a public ACL.
* `blockPublicPolicy` - (Optional) Whether Amazon S3 should block public bucket policies for buckets in this account. Defaults to `true`. Enabling this setting does not affect existing bucket policies. When set to `true` causes Amazon S3 to:
  * Reject calls to PUT Bucket policy if the specified bucket policy allows public access.
* `ignorePublicAcls` - (Optional) Whether Amazon S3 should ignore public ACLs for buckets in this account. Defaults to `true`. Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. When set to `true` causes Amazon S3 to:
  * Ignore all public ACLs on buckets in this account and any objects that they contain.
* `restrictPublicBuckets` - (Optional) Whether Amazon S3 should restrict public bucket policies for buckets in this account. Defaults to `true`. Enabling this setting does not affect previously stored bucket policies, except that public and cross-account access within any public bucket policy, including non-public delegation to specific accounts, is blocked. When set to `true`:
  * Only the bucket owner and AWS Services can access buckets with public policies.

### vpc\_configuration Configuration Block

The following arguments are required:

* `vpcId` - (Required)  This access point will only allow connections from the specified VPC ID.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `alias` - Alias of the S3 Access Point.
* `arn` - ARN of the S3 Access Point.
* `domainName` - DNS domain name of the S3 Access Point in the format *`name`*-*`accountId`*.s3-accesspoint.*region*.amazonaws.com.
  Note: S3 access points only support secure access by HTTPS. HTTP isn't supported.
* `endpoints` - VPC endpoints for the S3 Access Point.
* `hasPublicAccessPolicy` - Indicates whether this access point currently has a policy that allows public access.
* `id` - For Access Point of an AWS Partition S3 Bucket, the AWS account ID and access point name separated by a colon (`:`). For S3 on Outposts Bucket, the ARN of the Access Point.
* `networkOrigin` - Indicates whether this access point allows access from the public Internet. Values are `vpc` (the access point doesn't allow access from the public Internet) and `internet` (the access point allows access from the public Internet, subject to the access point and bucket access policies).

## Import

For Access Points associated with an AWS Partition S3 Bucket, this resource can be imported using the `accountId` and `name` separated by a colon (`:`), e.g.,

```console
$ terraform import aws_s3_access_point.example 123456789012:example
```

For Access Points associated with an S3 on Outposts Bucket, this resource can be imported using the ARN, e.g.,

```console
$ terraform import aws_s3_access_point.example arn:aws:s3-outposts:us-east-1:123456789012:outpost/op-1234567890123456/accesspoint/example
```
