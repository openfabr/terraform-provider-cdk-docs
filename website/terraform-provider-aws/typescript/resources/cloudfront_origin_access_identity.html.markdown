---
subcategory: "CloudFront"
layout: "aws"
page_title: "AWS: aws_cloudfront_origin_access_identity"
description: |-
  Provides a CloudFront origin access identity.
---

# Resource: awsCloudfrontOriginAccessIdentity

Creates an Amazon CloudFront origin access identity.

For information about CloudFront distributions, see the
[Amazon CloudFront Developer Guide][1]. For more information on generating
origin access identities, see
[Using an Origin Access Identity to Restrict Access to Your Amazon S3 Content][2].

## Example Usage

The following example below creates a CloudFront origin access identity.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.cloudfrontOriginAccessIdentity.CloudfrontOriginAccessIdentity(
  this,
  "example",
  {
    comment: "Some comment",
  }
);

```

## Argument Reference

* `comment` (Optional) - An optional comment for the origin access identity.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The identifier for the distribution. For example: `edfdvbd632Bhds5`.
* `callerReference` - Internal value used by CloudFront to allow future
  updates to the origin access identity.
* `cloudfrontAccessIdentityPath` - A shortcut to the full path for the
  origin access identity to use in CloudFront, see below.
* `etag` - The current version of the origin access identity's information.
  For example: `e2Qwruhapomqzl`.
* `iamArn` - A pre-generated ARN for use in S3 bucket policies (see below).
  Example: `arn:aws:iam::cloudfront:user/cloudFrontOriginAccessIdentity
  E2Qwruhapomqzl`.
* `s3CanonicalUserId` - The Amazon S3 canonical user ID for the origin
  access identity, which you use when giving the origin access identity read
  permission to an object in Amazon S3.

## Using With CloudFront

Normally, when referencing an origin access identity in CloudFront, you need to
prefix the ID with the `originAccessIdentity/cloudfront/` special path.
The `cloudfrontAccessIdentityPath` allows this to be circumvented.
The below snippet demonstrates use with the `s3OriginConfig` structure for the
[`awsCloudfrontDistribution`][3] resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.cloudfrontDistribution.CloudfrontDistribution(this, "example", {
  origin: [
    {
      s3OriginConfig: {
        originAccessIdentity:
          "${aws_cloudfront_origin_access_identity.example.cloudfront_access_identity_path}",
      },
    },
  ],
});

```

### Updating your bucket policy

Note that the AWS API may translate the `s3CanonicalUserId` `canonicalUser`
principal into an `aws` IAM ARN principal when supplied in an
[`awsS3Bucket`][4] bucket policy, causing spurious diffs in Terraform. If
you see this behaviour, use the `iamArn` instead:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsIamPolicyDocumentS3Policy =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(this, "s3_policy", {
    statement: [
      {
        actions: ["s3:GetObject"],
        principals: [
          {
            identifiers: [
              "${aws_cloudfront_origin_access_identity.example.iam_arn}",
            ],
            type: "AWS",
          },
        ],
        resources: ["${aws_s3_bucket.example.arn}/*"],
      },
    ],
  });
new aws.s3BucketPolicy.S3BucketPolicy(this, "example", {
  bucket: "${aws_s3_bucket.example.id}",
  policy: dataAwsIamPolicyDocumentS3Policy.json,
});

```

[1]: http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html

[2]: http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html

[3]: /docs/providers/aws/r/cloudfront_distribution.html

[4]: /docs/providers/aws/r/s3_bucket.html

## Import

Cloudfront Origin Access Identities can be imported using the `id`, e.g.,

```console
$ terraform import aws_cloudfront_origin_access_identity.origin_access E74FTE3AEXAMPLE
```
