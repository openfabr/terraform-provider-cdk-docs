---
subcategory: "DynamoDB"
layout: "aws"
page_title: "AWS: aws_dynamodb_contributor_insights"
description: |-
  Provides a DynamoDB contributor insights resource
---

# Resource: awsDynamodbContributorInsights

Provides a DynamoDB contributor insights resource

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dynamodbContributorInsights.DynamodbContributorInsights(this, "test", {
  tableName: "ExampleTableName",
});

```

## Argument Reference

The following arguments are supported:

* `tableName` - (Required) The name of the table to enable contributor insights
* `indexName` - (Optional) The global secondary index name

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

## Import

`awsDynamodbContributorInsights` can be imported using the format `name:tableName/index:indexName`, followed by the account number, e.g.,

```console
$ terraform import aws_dynamodb_contributor_insights.test name:ExampleTableName/index:ExampleIndexName/123456789012
```
