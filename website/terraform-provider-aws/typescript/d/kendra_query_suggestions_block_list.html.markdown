---
subcategory: "Kendra"
layout: "aws"
page_title: "AWS: aws_kendra_query_suggestions_block_list"
description: |-
  Provides details about a specific Amazon Kendra block list used for query suggestions for an index.
---

# Data Source: aws\_kendra\_query\_suggestions\_block\_list

Provides details about a specific Amazon Kendra block list used for query suggestions for an index.

## Example Usage

```hcl
data "aws_kendra_query_suggestions_block_list" "example" {
  index_id                        = "12345678-1234-1234-1234-123456789123"
  query_suggestions_block_list_id = "87654321-1234-4321-4321-321987654321"
}
```

## Argument Reference

The following arguments are supported:

* `indexId` - (Required) Identifier of the index that contains the block list.
* `querySuggestionsBlockListId` - (Required) Identifier of the block list.

## Attributes Reference

In addition to all of the arguments above, the following attributes are exported:

* `arn` - ARN of the block list.
* `createdAt` - Date-time a block list was created.
* `description` - Description for the block list.
* `errorMessage` - Error message containing details if there are issues processing the block list.
* `fileSizeBytes` - Current size of the block list text file in S3.
* `id` - Unique identifiers of the block list and index separated by a slash (`/`).
* `itemCount` - Current number of valid, non-empty words or phrases in the block list text file.
* `name` - Name of the block list.
* `roleArn` - ARN of a role with permission to access the S3 bucket that contains the block list. For more information, see [IAM Roles for Amazon Kendra](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html).
* `sourceS3Path` - S3 location of the block list input data. Detailed below.
* `status` - Current status of the block list. When the value is `active`, the block list is ready for use.
* `updatedAt` - Date and time that the block list was last updated.
* `tags` - Metadata that helps organize the block list you create.

The `sourceS3Path` configuration block supports the following attributes:

* `bucket` - Name of the S3 bucket that contains the file.
* `key` - Name of the file.
