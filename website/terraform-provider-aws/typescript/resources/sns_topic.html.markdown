---
subcategory: "SNS (Simple Notification)"
layout: "aws"
page_title: "AWS: aws_sns_topic"
description: |-
  Provides an SNS topic resource.
---

# Resource: awsSnsTopic

Provides an SNS topic resource

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.snsTopic.SnsTopic(this, "user_updates", {
  name: "user-updates-topic",
});

```

## Example with Delivery Policy

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.snsTopic.SnsTopic(this, "user_updates", {
  deliveryPolicy:
    '{\n  "http": {\n    "defaultHealthyRetryPolicy": {\n      "minDelayTarget": 20,\n      "maxDelayTarget": 20,\n      "numRetries": 3,\n      "numMaxDelayRetries": 0,\n      "numNoDelayRetries": 0,\n      "numMinDelayRetries": 0,\n      "backoffFunction": "linear"\n    },\n    "disableSubscriptionOverrides": false,\n    "defaultThrottlePolicy": {\n      "maxReceivesPerSecond": 1\n    }\n  }\n}\n',
  name: "user-updates-topic",
});

```

## Example with Server-side encryption (SSE)

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.snsTopic.SnsTopic(this, "user_updates", {
  kmsMasterKeyId: "alias/aws/sns",
  name: "user-updates-topic",
});

```

## Example with First-In-First-Out (FIFO)

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.snsTopic.SnsTopic(this, "user_updates", {
  contentBasedDeduplication: true,
  fifoTopic: true,
  name: "user-updates-topic.fifo",
});

```

## Message Delivery Status Arguments

The `<endpoint>SuccessFeedbackRoleArn` and `<endpoint>FailureFeedbackRoleArn` arguments are used to give Amazon SNS write access to use CloudWatch Logs on your behalf. The `<endpoint>SuccessFeedbackSampleRate` argument is for specifying the sample rate percentage (0-100) of successfully delivered messages. After you configure the  `<endpoint>FailureFeedbackRoleArn` argument, then all failed message deliveries generate CloudWatch Logs.

## Argument Reference

The following arguments are supported:

* `name` - (Optional) The name of the topic. Topic names must be made up of only uppercase and lowercase ASCII letters, numbers, underscores, and hyphens, and must be between 1 and 256 characters long. For a FIFO (first-in-first-out) topic, the name must end with the `fifo` suffix. If omitted, Terraform will assign a random, unique name. Conflicts with `namePrefix`
* `namePrefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with `name`
* `displayName` - (Optional) The display name for the topic
* `policy` - (Optional) The fully-formed AWS policy as JSON. For more information about building AWS IAM policy documents with Terraform, see the [AWS IAM Policy Document Guide](https://learn.hashicorp.com/terraform/aws/iam-policy).
* `deliveryPolicy` - (Optional) The SNS delivery policy. More on [AWS documentation](https://docs.aws.amazon.com/sns/latest/dg/DeliveryPolicies.html)
* `applicationSuccessFeedbackRoleArn` - (Optional) The IAM role permitted to receive success feedback for this topic
* `applicationSuccessFeedbackSampleRate` - (Optional) Percentage of success to sample
* `applicationFailureFeedbackRoleArn` - (Optional) IAM role for failure feedback
* `httpSuccessFeedbackRoleArn` - (Optional) The IAM role permitted to receive success feedback for this topic
* `httpSuccessFeedbackSampleRate` - (Optional) Percentage of success to sample
* `httpFailureFeedbackRoleArn` - (Optional) IAM role for failure feedback
* `kmsMasterKeyId` - (Optional) The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK. For more information, see [Key Terms](https://docs.aws.amazon.com/sns/latest/dg/sns-server-side-encryption.html#sse-key-terms)
* `signatureVersion` - (Optional) If `signatureVersion` should be [1 (SHA1) or 2 (SHA256)](https://docs.aws.amazon.com/sns/latest/dg/sns-verify-signature-of-message.html). The signature version corresponds to the hashing algorithm used while creating the signature of the notifications, subscription confirmations, or unsubscribe confirmation messages sent by Amazon SNS.
* `tracingConfig` - (Optional) Tracing mode of an Amazon SNS topic. Valid values: `"passThrough"`, `"active"`.
* `fifoTopic` - (Optional) Boolean indicating whether or not to create a FIFO (first-in-first-out) topic (default is `false`).
* `contentBasedDeduplication` - (Optional) Enables content-based deduplication for FIFO topics. For more information, see the [related documentation](https://docs.aws.amazon.com/sns/latest/dg/fifo-message-dedup.html)
* `lambdaSuccessFeedbackRoleArn` - (Optional) The IAM role permitted to receive success feedback for this topic
* `lambdaSuccessFeedbackSampleRate` - (Optional) Percentage of success to sample
* `lambdaFailureFeedbackRoleArn` - (Optional) IAM role for failure feedback
* `sqsSuccessFeedbackRoleArn` - (Optional) The IAM role permitted to receive success feedback for this topic
* `sqsSuccessFeedbackSampleRate` - (Optional) Percentage of success to sample
* `sqsFailureFeedbackRoleArn` - (Optional) IAM role for failure feedback
* `firehoseSuccessFeedbackRoleArn` - (Optional) The IAM role permitted to receive success feedback for this topic
* `firehoseSuccessFeedbackSampleRate` - (Optional) Percentage of success to sample
* `firehoseFailureFeedbackRoleArn` - (Optional) IAM role for failure feedback
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ARN of the SNS topic
* `arn` - The ARN of the SNS topic, as a more obvious property (clone of id)
* `owner` - The AWS Account ID of the SNS topic owner
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

SNS Topics can be imported using the `topicArn`, e.g.,

```console
$ terraform import aws_sns_topic.user_updates arn:aws:sns:us-west-2:0123456789012:my-topic
```
