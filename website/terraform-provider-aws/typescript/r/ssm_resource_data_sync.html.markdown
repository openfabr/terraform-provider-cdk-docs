---
subcategory: "SSM (Systems Manager)"
layout: "aws"
page_title: "AWS: aws_ssm_resource_data_sync"
description: |-
  Provides a SSM resource data sync.
---

# Resource: aws\_ssm\_resource\_data\_sync

Provides a SSM resource data sync.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketHoge = new aws.s3Bucket.S3Bucket(this, "hoge", {
  bucket: "tf-test-bucket-1234",
});
const awsS3BucketPolicyHoge = new aws.s3BucketPolicy.S3BucketPolicy(
  this,
  "hoge_1",
  {
    bucket: awsS3BucketHoge.bucket,
    policy:
      '{\n    "Version": "2012-10-17",\n    "Statement": [\n        {\n            "Sid": "SSMBucketPermissionsCheck",\n            "Effect": "Allow",\n            "Principal": {\n                "Service": "ssm.amazonaws.com"\n            },\n            "Action": "s3:GetBucketAcl",\n            "Resource": "arn:aws:s3:::tf-test-bucket-1234"\n        },\n        {\n            "Sid": " SSMBucketDelivery",\n            "Effect": "Allow",\n            "Principal": {\n                "Service": "ssm.amazonaws.com"\n            },\n            "Action": "s3:PutObject",\n            "Resource": ["arn:aws:s3:::tf-test-bucket-1234/*"],\n            "Condition": {\n                "StringEquals": {\n                    "s3:x-amz-acl": "bucket-owner-full-control"\n                }\n            }\n        }\n    ]\n}\n',
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketPolicyHoge.overrideLogicalId("hoge");
new aws.ssmResourceDataSync.SsmResourceDataSync(this, "foo", {
  name: "foo",
  s3Destination: {
    bucketName: awsS3BucketHoge.bucket,
    region: awsS3BucketHoge.region,
  },
});

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) Name for the configuration.
* `s3Destination` - (Required) Amazon S3 configuration details for the sync.

## s3\_destination

`s3Destination` supports the following:

* `bucketName` - (Required) Name of S3 bucket where the aggregated data is stored.
* `region` - (Required) Region with the bucket targeted by the Resource Data Sync.
* `kmsKeyArn` - (Optional) ARN of an encryption key for a destination in Amazon S3.
* `prefix` - (Optional) Prefix for the bucket.
* `syncFormat` - (Optional) A supported sync format. Only JsonSerDe is currently supported. Defaults to JsonSerDe.

## Attributes Reference

No additional attributes are exported.

## Import

SSM resource data sync can be imported using the `name`, e.g.,

```sh
$ terraform import aws_ssm_resource_data_sync.example example-name
```
