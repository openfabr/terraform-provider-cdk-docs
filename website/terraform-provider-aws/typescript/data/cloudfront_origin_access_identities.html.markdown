---
subcategory: "CloudFront"
layout: "aws"
page_title: "AWS: aws_cloudfront_origin_access_identities"
description: |-
  Use this data source to retrieve information about a set of Amazon CloudFront origin access identities.
---

# Data Source: awsCloudfrontOriginAccessIdentities

Use this data source to get ARNs, ids and S3 canonical user IDs of Amazon CloudFront origin access identities.

## Example Usage

### All origin access identities in the account

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsCloudfrontOriginAccessIdentities.DataAwsCloudfrontOriginAccessIdentities(
  this,
  "example",
  {}
);

```

### Origin access identities filtered by comment/name

Origin access identities whose comments are `exampleComment1`, `exampleComment2`

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsCloudfrontOriginAccessIdentities.DataAwsCloudfrontOriginAccessIdentities(
  this,
  "example",
  {
    comments: ["example-comment1", "example-comment2"],
  }
);

```

## Argument Reference

* `comments` (Optional) - Filter origin access identities by comment.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `iamArns` - Set of ARNs of the matched origin access identities.
* `ids` - Set of ids of the matched origin access identities.
* `s3CanonicalUserIds` - Set of S3 canonical user IDs of the matched origin access identities.
