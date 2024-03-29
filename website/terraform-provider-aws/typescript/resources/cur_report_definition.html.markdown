---
subcategory: "Cost and Usage Report"
layout: "aws"
page_title: "AWS: aws_cur_report_definition"
description: |-
  Provides a Cost and Usage Report Definition.
---

# Resource: awsCurReportDefinition

Manages Cost and Usage Report Definitions.

\~> *NOTE:* The AWS Cost and Usage Report service is only available in `usEast1` currently.

\~> *NOTE:* If AWS Organizations is enabled, only the master account can use this resource.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.curReportDefinition.CurReportDefinition(
  this,
  "example_cur_report_definition",
  {
    additionalArtifacts: ["REDSHIFT", "QUICKSIGHT"],
    additionalSchemaElements: ["RESOURCES"],
    compression: "GZIP",
    format: "textORcsv",
    reportName: "example-cur-report-definition",
    s3Bucket: "example-bucket-name",
    s3Region: "us-east-1",
    timeUnit: "HOURLY",
  }
);

```

## Argument Reference

The following arguments are supported:

* `reportName` - (Required) Unique name for the report. Must start with a number/letter and is case sensitive. Limited to 256 characters.
* `timeUnit` - (Required) The frequency on which report data are measured and displayed.  Valid values are: `daily`, `hourly`, `monthly`.
* `format` - (Required) Format for report. Valid values are: `textORcsv`, `parquet`. If `parquet` is used, then Compression must also be `parquet`.
* `compression` - (Required) Compression format for report. Valid values are: `gzip`, `zip`, `parquet`. If `parquet` is used, then format must also be `parquet`.
* `additionalSchemaElements` - (Required) A list of schema elements. Valid values are: `resources`.
* `s3Bucket` - (Required) Name of the existing S3 bucket to hold generated reports.
* `s3Prefix` - (Optional) Report path prefix. Limited to 256 characters.
* `s3Region` - (Required) Region of the existing S3 bucket to hold generated reports.
* `additionalArtifacts` - (Required) A list of additional artifacts. Valid values are: `redshift`, `quicksight`, `athena`. When ATHENA exists within additional\_artifacts, no other artifact type can be declared and report\_versioning must be `OVERWRITE_REPORT`.
* `refreshClosedReports` - (Optional) Set to true to update your reports after they have been finalized if AWS detects charges related to previous months.
* `reportVersioning` - (Optional) Overwrite the previous version of each report or to deliver the report in addition to the previous versions. Valid values are: `CREATE_NEW_REPORT` and `OVERWRITE_REPORT`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The Amazon Resource Name (ARN) specifying the cur report.

## Import

Report Definitions can be imported using the `reportName`, e.g.,

```console
$ terraform import aws_cur_report_definition.example_cur_report_definition example-cur-report-definition
```
