---
subcategory: "Lake Formation"
layout: "aws"
page_title: "AWS: aws_lakeformation_resource"
description: |-
    Provides details about a Lake Formation resource.
---

# Data Source: awsLakeformationResource

Provides details about a Lake Formation resource.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsLakeformationResource.DataAwsLakeformationResource(
  this,
  "example",
  {
    arn: "arn:aws:s3:::tf-acc-test-9151654063908211878",
  }
);

```

## Argument Reference

* `arn` – (Required) ARN of the resource, an S3 path.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `lastModified` - Date and time the resource was last modified in [RFC 3339 format](https://tools.ietf.org/html/rfc3339#section-5.8).
* `roleArn` – Role that the resource was registered with.
