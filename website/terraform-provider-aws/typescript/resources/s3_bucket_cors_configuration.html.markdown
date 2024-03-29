---
subcategory: "S3 (Simple Storage)"
layout: "aws"
page_title: "AWS: aws_s3_bucket_cors_configuration"
description: |-
  Provides an S3 bucket CORS configuration resource.
---

# Resource: awsS3BucketCorsConfiguration

Provides an S3 bucket CORS configuration resource. For more information about CORS, go to [Enabling Cross-Origin Resource Sharing](https://docs.aws.amazon.com/AmazonS3/latest/userguide/cors.html) in the Amazon S3 User Guide.

\~> **NOTE:** S3 Buckets only support a single CORS configuration. Declaring multiple `awsS3BucketCorsConfiguration` resources to the same S3 Bucket will cause a perpetual difference in configuration.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "mybucket",
});
const awsS3BucketCorsConfigurationExample =
  new aws.s3BucketCorsConfiguration.S3BucketCorsConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      corsRule: [
        {
          allowedHeaders: ["*"],
          allowedMethods: ["PUT", "POST"],
          allowedOrigins: ["https://s3-website-test.hashicorp.com"],
          exposeHeaders: ["ETag"],
          maxAgeSeconds: 3000,
        },
        {
          allowedMethods: ["GET"],
          allowedOrigins: ["*"],
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketCorsConfigurationExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `bucket` - (Required, Forces new resource) Name of the bucket.
* `expectedBucketOwner` - (Optional, Forces new resource) Account ID of the expected bucket owner.
* `corsRule` - (Required) Set of origins and methods (cross-origin access that you want to allow). [See below](#cors_rule). You can configure up to 100 rules.

### corsRule

The `corsRule` configuration block supports the following arguments:

* `allowedHeaders` - (Optional) Set of Headers that are specified in the `accessControlRequestHeaders` header.
* `allowedMethods` - (Required) Set of HTTP methods that you allow the origin to execute. Valid values are `get`, `put`, `head`, `post`, and `delete`.
* `allowedOrigins` - (Required) Set of origins you want customers to be able to access the bucket from.
* `exposeHeaders` - (Optional) Set of headers in the response that you want customers to be able to access from their applications (for example, from a JavaScript `xmlHttpRequest` object).
* `id` - (Optional) Unique identifier for the rule. The value cannot be longer than 255 characters.
* `maxAgeSeconds` - (Optional) Time in seconds that your browser is to cache the preflight response for the specified resource.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The `bucket` or `bucket` and `expectedBucketOwner` separated by a comma (`,`) if the latter is provided.

## Import

S3 bucket CORS configuration can be imported in one of two ways.

If the owner (account ID) of the source bucket is the same account used to configure the Terraform AWS Provider,
the S3 bucket CORS configuration resource should be imported using the `bucket` e.g.,

```console
$ terraform import aws_s3_bucket_cors_configuration.example bucket-name
```

If the owner (account ID) of the source bucket differs from the account used to configure the Terraform AWS Provider,
the S3 bucket CORS configuration resource should be imported using the `bucket` and `expectedBucketOwner` separated by a comma (`,`) e.g.,

```console
$ terraform import aws_s3_bucket_cors_configuration.example bucket-name,123456789012
```
