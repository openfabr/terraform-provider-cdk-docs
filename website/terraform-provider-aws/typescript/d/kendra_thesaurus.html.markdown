---
subcategory: "Kendra"
layout: "aws"
page_title: "AWS: aws_kendra_thesaurus"
description: |-
  Provides details about a specific Amazon Kendra Thesaurus.
---

# Data Source: aws\_kendra\_thesaurus

Provides details about a specific Amazon Kendra Thesaurus.

## Example Usage

```hcl
data "aws_kendra_thesaurus" "example" {
  index_id     = "12345678-1234-1234-1234-123456789123"
  thesaurus_id = "87654321-1234-4321-4321-321987654321"
}
```

## Argument Reference

The following arguments are supported:

* `indexId` - (Required) Identifier of the index that contains the Thesaurus.
* `thesaurusId` - (Required) Identifier of the Thesaurus.

## Attributes Reference

In addition to all of the arguments above, the following attributes are exported:

* `arn` - ARN of the Thesaurus.
* `createdAt` - Unix datetime that the Thesaurus was created.
* `description` - Description of the Thesaurus.
* `errorMessage` - When the `status` field value is `failed`, this contains a message that explains why.
* `fileSizeBytes` - Size of the Thesaurus file in bytes.
* `id` - Unique identifiers of the Thesaurus and index separated by a slash (`/`).
* `name` - Name of the Thesaurus.
* `roleArn` - ARN of a role with permission to access the S3 bucket that contains the Thesaurus. For more information, see [IAM Roles for Amazon Kendra](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html).
* `sourceS3Path` - S3 location of the Thesaurus input data. Detailed below.
* `status` - Status of the Thesaurus. It is ready to use when the status is `active`.
* `synonymRuleCount` - Number of synonym rules in the Thesaurus file.
* `termCount` - Number of unique terms in the Thesaurus file. For example, the synonyms `a,b,c` and `a=>d`, the term count would be 4.
* `updatedAt` - Date and time that the Thesaurus was last updated.
* `tags` - Metadata that helps organize the Thesaurus you create.

The `sourceS3Path` configuration block supports the following attributes:

* `bucket` - Name of the S3 bucket that contains the file.
* `key` - Name of the file.
