---
subcategory: "CloudWatch Logs"
layout: "aws"
page_title: "AWS: aws_cloudwatch_log_groups"
description: |-
  Get list of Cloudwatch Log Groups.
---

# Data Source: awsCloudwatchLogGroups

Use this data source to get a list of AWS Cloudwatch Log Groups

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsCloudwatchLogGroups.DataAwsCloudwatchLogGroups(this, "example", {
  logGroupNamePrefix: "/MyImportantLogs",
});

```

## Argument Reference

The following arguments are supported:

* `logGroupNamePrefix` - (Optional) Group prefix of the Cloudwatch log groups to list

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arns` - Set of ARNs of the Cloudwatch log groups
* `logGroupNames` - Set of names of the Cloudwatch log groups
