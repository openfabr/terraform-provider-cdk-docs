---
subcategory: "CodeBuild"
layout: "aws"
page_title: "AWS: aws_codebuild_resource_policy"
description: |-
  Provides a CodeBuild Resource Policy resource.
---

# Resource: awsCodebuildResourcePolicy

Provides a CodeBuild Resource Policy Resource.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsCodebuildReportGroupExample =
  new aws.codebuildReportGroup.CodebuildReportGroup(this, "example", {
    exportConfig: {
      type: "NO_EXPORT",
    },
    name: "example",
    type: "TEST",
  });
const awsCodebuildResourcePolicyExample =
  new aws.codebuildResourcePolicy.CodebuildResourcePolicy(this, "example_1", {
    policy:
      '${jsonencode({\n    Version = "2012-10-17"\n    Id      = "default"\n    Statement = [{\n      Sid    = "default"\n      Effect = "Allow"\n      Principal = {\n        AWS = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"\n      }\n      Action = [\n        "codebuild:BatchGetReportGroups",\n        "codebuild:BatchGetReports",\n        "codebuild:ListReportsForReportGroup",\n        "codebuild:DescribeTestCases",\n      ]\n      Resource = aws_codebuild_report_group.example.arn\n    }]\n  })}',
    resourceArn: awsCodebuildReportGroupExample.arn,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsCodebuildResourcePolicyExample.overrideLogicalId("example");
new aws.dataAwsCallerIdentity.DataAwsCallerIdentity(this, "current", {});
const dataAwsPartitionCurrent = new aws.dataAwsPartition.DataAwsPartition(
  this,
  "current_3",
  {}
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAwsPartitionCurrent.overrideLogicalId("current");

```

## Argument Reference

The following arguments are supported:

* `resourceArn` - (Required) The ARN of the Project or ReportGroup resource you want to associate with a resource policy.
* `policy` - (Required) A JSON-formatted resource policy. For more information, see [Sharing a Projec](https://docs.aws.amazon.com/codebuild/latest/userguide/project-sharing.html#project-sharing-share) and [Sharing a Report Group](https://docs.aws.amazon.com/codebuild/latest/userguide/report-groups-sharing.html#report-groups-sharing-share).

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ARN of Resource.

## Import

CodeBuild Resource Policy can be imported using the CodeBuild Resource Policy arn, e.g.,

```console
$ terraform import aws_codebuild_resource_policy.example arn:aws:codebuild:us-west-2:123456789:report-group/report-group-name
```
