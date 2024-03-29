---
subcategory: "Connect"
layout: "aws"
page_title: "AWS: aws_connect_hours_of_operation"
description: |-
  Provides details about a specific Amazon Connect Hours of Operation.
---

# Resource: awsConnectHoursOfOperation

Provides an Amazon Connect Hours of Operation resource. For more information see
[Amazon Connect: Getting Started](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-get-started.html)

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.connectHoursOfOperation.ConnectHoursOfOperation(this, "test", {
  config: [
    {
      day: "MONDAY",
      endTime: {
        hours: 23,
        minutes: 8,
      },
      startTime: {
        hours: 8,
        minutes: 0,
      },
    },
    {
      day: "TUESDAY",
      endTime: {
        hours: 21,
        minutes: 0,
      },
      startTime: {
        hours: 9,
        minutes: 0,
      },
    },
  ],
  description: "Monday office hours",
  instanceId: "aaaaaaaa-bbbb-cccc-dddd-111111111111",
  name: "Office Hours",
  tags: {
    Name: "Example Hours of Operation",
  },
  timeZone: "EST",
});

```

## Argument Reference

The following arguments are supported:

* `config` - (Required) One or more config blocks which define the configuration information for the hours of operation: day, start time, and end time . Config blocks are documented below.
* `description` - (Optional) Specifies the description of the Hours of Operation.
* `instanceId` - (Required) Specifies the identifier of the hosting Amazon Connect Instance.
* `name` - (Required) Specifies the name of the Hours of Operation.
* `tags` - (Optional) Tags to apply to the Hours of Operation. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `timeZone` - (Required) Specifies the time zone of the Hours of Operation.

A `config` block supports the following arguments:

* `day` - (Required) Specifies the day that the hours of operation applies to.
* `endTime` - (Required) A end time block specifies the time that your contact center closes. The `endTime` is documented below.
* `startTime` - (Required) A start time block specifies the time that your contact center opens. The `startTime` is documented below.

A `endTime` block supports the following arguments:

* `hours` - (Required) Specifies the hour of closing.
* `minutes` - (Required) Specifies the minute of closing.

A `startTime` block supports the following arguments:

* `hours` - (Required) Specifies the hour of opening.
* `minutes` - (Required) Specifies the minute of opening.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The Amazon Resource Name (ARN) of the Hours of Operation.
* `hoursOfOperationArn` - (**Deprecated**) The Amazon Resource Name (ARN) of the Hours of Operation.
* `hoursOfOperationId` - The identifier for the hours of operation.
* `id` - The identifier of the hosting Amazon Connect Instance and identifier of the Hours of Operation separated by a colon (`:`).
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Amazon Connect Hours of Operations can be imported using the `instanceId` and `hoursOfOperationId` separated by a colon (`:`), e.g.,

```console
$ terraform import aws_connect_hours_of_operation.example f1288a1f-6193-445a-b47e-af739b2:c1d4e5f6-1b3c-1b3c-1b3c-c1d4e5f6c1d4e5
```
