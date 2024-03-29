---
subcategory: "SQS (Simple Queue)"
layout: "aws"
page_title: "AWS: aws_sqs_queues"
description: |-
  Terraform data source for managing an AWS SQS (Simple Queue) Queues.
---

# Data Source: awsSqsQueues

Terraform data source for managing an AWS SQS (Simple Queue) Queues.

## Example Usage

### Basic Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsSqsQueues.DataAwsSqsQueues(this, "example", {
  queueNamePrefix: "example",
});

```

## Argument Reference

The following arguments are optional:

* `queueNamePrefix` - (Optional) A string to use for filtering the list results. Only those queues whose name begins with the specified string are returned. Queue URLs and names are case-sensitive.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `queueUrls` - A list of queue URLs.
