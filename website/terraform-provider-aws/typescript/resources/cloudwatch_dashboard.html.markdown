---
subcategory: "CloudWatch"
layout: "aws"
page_title: "AWS: aws_cloudwatch_dashboard"
description: |-
  Provides a CloudWatch Dashboard resource.
---

# Resource: awsCloudwatchDashboard

Provides a CloudWatch Dashboard resource.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.cloudwatchDashboard.CloudwatchDashboard(this, "main", {
  dashboardBody:
    '${jsonencode({\n    widgets = [\n      {\n        type   = "metric"\n        x      = 0\n        y      = 0\n        width  = 12\n        height = 6\n\n        properties = {\n          metrics = [\n            [\n              "AWS/EC2",\n              "CPUUtilization",\n              "InstanceId",\n              "i-012345"\n            ]\n          ]\n          period = 300\n          stat   = "Average"\n          region = "us-east-1"\n          title  = "EC2 Instance CPU"\n        }\n      },\n      {\n        type   = "text"\n        x      = 0\n        y      = 7\n        width  = 3\n        height = 3\n\n        properties = {\n          markdown = "Hello world"\n        }\n      }\n    ]\n  })}',
  dashboardName: "my-dashboard",
});

```

## Argument Reference

The following arguments are supported:

* `dashboardName` - (Required) The name of the dashboard.
* `dashboardBody` - (Required) The detailed information about the dashboard, including what widgets are included and their location on the dashboard. You can read more about the body structure in the [documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html).

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `dashboardArn` - The Amazon Resource Name (ARN) of the dashboard.

## Import

CloudWatch dashboards can be imported using the `dashboardName`, e.g.,

```console
$ terraform import aws_cloudwatch_dashboard.sample dashboard_name
```
