---
subcategory: "S3 (Simple Storage)"
layout: "aws"
page_title: "AWS: aws_s3_bucket_notification"
description: |-
  Manages a S3 Bucket Notification Configuration
---

# Resource: awsS3BucketNotification

Manages a S3 Bucket Notification Configuration. For additional information, see the [Configuring S3 Event Notifications section in the Amazon S3 Developer Guide](https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html).

\~> **NOTE:** S3 Buckets only support a single notification configuration. Declaring multiple `awsS3BucketNotification` resources to the same S3 Bucket will cause a perpetual difference in configuration. See the example "Trigger multiple Lambda functions" for an option.

## Example Usage

### Add notification configuration to SNS Topic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketBucket = new aws.s3Bucket.S3Bucket(this, "bucket", {
  bucket: "your-bucket-name",
});
const dataAwsIamPolicyDocumentTopic =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(this, "topic", {
    statement: [
      {
        actions: ["SNS:Publish"],
        condition: [
          {
            test: "ArnLike",
            values: [awsS3BucketBucket.arn],
            variable: "aws:SourceArn",
          },
        ],
        effect: "Allow",
        principals: [
          {
            identifiers: ["s3.amazonaws.com"],
            type: "Service",
          },
        ],
        resources: ["arn:aws:sns:*:*:s3-event-notification-topic"],
      },
    ],
  });
const awsSnsTopicTopic = new aws.snsTopic.SnsTopic(this, "topic_2", {
  name: "s3-event-notification-topic",
  policy: dataAwsIamPolicyDocumentTopic.json,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsSnsTopicTopic.overrideLogicalId("topic");
new aws.s3BucketNotification.S3BucketNotification(this, "bucket_notification", {
  bucket: awsS3BucketBucket.id,
  topic: [
    {
      events: ["s3:ObjectCreated:*"],
      filterSuffix: ".log",
      topicArn: awsSnsTopicTopic.arn,
    },
  ],
});

```

### Add notification configuration to SQS Queue

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketBucket = new aws.s3Bucket.S3Bucket(this, "bucket", {
  bucket: "your-bucket-name",
});
const dataAwsIamPolicyDocumentQueue =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(this, "queue", {
    statement: [
      {
        actions: ["sqs:SendMessage"],
        condition: [
          {
            test: "ArnEquals",
            values: [awsS3BucketBucket.arn],
            variable: "aws:SourceArn",
          },
        ],
        effect: "Allow",
        principals: [
          {
            identifiers: ["*"],
            type: "*",
          },
        ],
        resources: ["arn:aws:sqs:*:*:s3-event-notification-queue"],
      },
    ],
  });
const awsSqsQueueQueue = new aws.sqsQueue.SqsQueue(this, "queue_2", {
  name: "s3-event-notification-queue",
  policy: dataAwsIamPolicyDocumentQueue.json,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsSqsQueueQueue.overrideLogicalId("queue");
new aws.s3BucketNotification.S3BucketNotification(this, "bucket_notification", {
  bucket: awsS3BucketBucket.id,
  queue: [
    {
      events: ["s3:ObjectCreated:*"],
      filterSuffix: ".log",
      queueArn: awsSqsQueueQueue.arn,
    },
  ],
});

```

### Add notification configuration to Lambda Function

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketBucket = new aws.s3Bucket.S3Bucket(this, "bucket", {
  bucket: "your-bucket-name",
});
const dataAwsIamPolicyDocumentAssumeRole =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "assume_role",
    {
      statement: [
        {
          actions: ["sts:AssumeRole"],
          effect: "Allow",
          principals: [
            {
              identifiers: ["lambda.amazonaws.com"],
              type: "Service",
            },
          ],
        },
      ],
    }
  );
const awsIamRoleIamForLambda = new aws.iamRole.IamRole(this, "iam_for_lambda", {
  assumeRolePolicy: dataAwsIamPolicyDocumentAssumeRole.json,
  name: "iam_for_lambda",
});
const awsLambdaFunctionFunc = new aws.lambdaFunction.LambdaFunction(
  this,
  "func",
  {
    filename: "your-function.zip",
    functionName: "example_lambda_name",
    handler: "exports.example",
    role: awsIamRoleIamForLambda.arn,
    runtime: "go1.x",
  }
);
const awsLambdaPermissionAllowBucket =
  new aws.lambdaPermission.LambdaPermission(this, "allow_bucket", {
    action: "lambda:InvokeFunction",
    functionName: awsLambdaFunctionFunc.arn,
    principal: "s3.amazonaws.com",
    sourceArn: awsS3BucketBucket.arn,
    statementId: "AllowExecutionFromS3Bucket",
  });
new aws.s3BucketNotification.S3BucketNotification(this, "bucket_notification", {
  bucket: awsS3BucketBucket.id,
  depends_on: [`\${${awsLambdaPermissionAllowBucket.fqn}}`],
  lambdaFunction: [
    {
      events: ["s3:ObjectCreated:*"],
      filterPrefix: "AWSLogs/",
      filterSuffix: ".log",
      lambdaFunctionArn: awsLambdaFunctionFunc.arn,
    },
  ],
});

```

### Trigger multiple Lambda functions

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketBucket = new aws.s3Bucket.S3Bucket(this, "bucket", {
  bucket: "your-bucket-name",
});
const dataAwsIamPolicyDocumentAssumeRole =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "assume_role",
    {
      actions: ["sts:AssumeRole"],
      effect: "Allow",
      principals: [
        {
          identifiers: ["lambda.amazonaws.com"],
          type: "Service",
        },
      ],
    }
  );
const awsIamRoleIamForLambda = new aws.iamRole.IamRole(this, "iam_for_lambda", {
  assumeRolePolicy: dataAwsIamPolicyDocumentAssumeRole.json,
  name: "iam_for_lambda",
});
const awsLambdaFunctionFunc1 = new aws.lambdaFunction.LambdaFunction(
  this,
  "func1",
  {
    filename: "your-function1.zip",
    functionName: "example_lambda_name1",
    handler: "exports.example",
    role: awsIamRoleIamForLambda.arn,
    runtime: "go1.x",
  }
);
const awsLambdaFunctionFunc2 = new aws.lambdaFunction.LambdaFunction(
  this,
  "func2",
  {
    filename: "your-function2.zip",
    functionName: "example_lambda_name2",
    handler: "exports.example",
    role: awsIamRoleIamForLambda.arn,
  }
);
const awsLambdaPermissionAllowBucket1 =
  new aws.lambdaPermission.LambdaPermission(this, "allow_bucket1", {
    action: "lambda:InvokeFunction",
    functionName: awsLambdaFunctionFunc1.arn,
    principal: "s3.amazonaws.com",
    sourceArn: awsS3BucketBucket.arn,
    statementId: "AllowExecutionFromS3Bucket1",
  });
const awsLambdaPermissionAllowBucket2 =
  new aws.lambdaPermission.LambdaPermission(this, "allow_bucket2", {
    action: "lambda:InvokeFunction",
    functionName: awsLambdaFunctionFunc2.arn,
    principal: "s3.amazonaws.com",
    sourceArn: awsS3BucketBucket.arn,
    statementId: "AllowExecutionFromS3Bucket2",
  });
new aws.s3BucketNotification.S3BucketNotification(this, "bucket_notification", {
  bucket: awsS3BucketBucket.id,
  depends_on: [
    `\${${awsLambdaPermissionAllowBucket1.fqn}}`,
    `\${${awsLambdaPermissionAllowBucket2.fqn}}`,
  ],
  lambdaFunction: [
    {
      events: ["s3:ObjectCreated:*"],
      filterPrefix: "AWSLogs/",
      filterSuffix: ".log",
      lambdaFunctionArn: awsLambdaFunctionFunc1.arn,
    },
    {
      events: ["s3:ObjectCreated:*"],
      filterPrefix: "OtherLogs/",
      filterSuffix: ".log",
      lambdaFunctionArn: awsLambdaFunctionFunc2.arn,
    },
  ],
});

```

### Add multiple notification configurations to SQS Queue

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketBucket = new aws.s3Bucket.S3Bucket(this, "bucket", {
  bucket: "your-bucket-name",
});
const dataAwsIamPolicyDocumentQueue =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(this, "queue", {
    statement: [
      {
        actions: ["sqs:SendMessage"],
        condition: [
          {
            test: "ArnEquals",
            values: [awsS3BucketBucket.arn],
            variable: "aws:SourceArn",
          },
        ],
        effect: "Allow",
        principals: [
          {
            identifiers: ["*"],
            type: "*",
          },
        ],
        resources: ["arn:aws:sqs:*:*:s3-event-notification-queue"],
      },
    ],
  });
const awsSqsQueueQueue = new aws.sqsQueue.SqsQueue(this, "queue_2", {
  name: "s3-event-notification-queue",
  policy: dataAwsIamPolicyDocumentQueue.json,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsSqsQueueQueue.overrideLogicalId("queue");
new aws.s3BucketNotification.S3BucketNotification(this, "bucket_notification", {
  bucket: awsS3BucketBucket.id,
  queue: [
    {
      events: ["s3:ObjectCreated:*"],
      filterPrefix: "images/",
      id: "image-upload-event",
      queueArn: awsSqsQueueQueue.arn,
    },
    {
      events: ["s3:ObjectCreated:*"],
      filterPrefix: "videos/",
      id: "video-upload-event",
      queueArn: awsSqsQueueQueue.arn,
    },
  ],
});

```

For Terraform's [JSON syntax](https://www.terraform.io/docs/configuration/syntax.html), use an array instead of defining the `queue` key twice.

```json
{
	"bucket": "${aws_s3_bucket.bucket.id}",
	"queue": [
		{
			"id": "image-upload-event",
			"queue_arn": "${aws_sqs_queue.queue.arn}",
			"events": ["s3:ObjectCreated:*"],
			"filter_prefix": "images/"
		},
		{
			"id": "video-upload-event",
			"queue_arn": "${aws_sqs_queue.queue.arn}",
			"events": ["s3:ObjectCreated:*"],
			"filter_prefix": "videos/"
		}
	]
}
```

## Argument Reference

The following arguments are required:

* `bucket` - (Required) Name of the bucket for notification configuration.

The following arguments are optional:

* `eventbridge` - (Optional) Whether to enable Amazon EventBridge notifications.
* `lambdaFunction` - (Optional, Multiple) Used to configure notifications to a Lambda Function. See below.
* `queue` - (Optional) Notification configuration to SQS Queue. See below.
* `topic` - (Optional) Notification configuration to SNS Topic. See below.

### `lambdaFunction`

* `events` - (Required) [Event](http://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html#notification-how-to-event-types-and-destinations) for which to send notifications.
* `filterPrefix` - (Optional) Object key name prefix.
* `filterSuffix` - (Optional) Object key name suffix.
* `id` - (Optional) Unique identifier for each of the notification configurations.
* `lambdaFunctionArn` - (Required) Lambda function ARN.

### `queue`

* `events` - (Required) Specifies [event](http://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html#notification-how-to-event-types-and-destinations) for which to send notifications.
* `filterPrefix` - (Optional) Object key name prefix.
* `filterSuffix` - (Optional) Object key name suffix.
* `id` - (Optional) Unique identifier for each of the notification configurations.
* `queueArn` - (Required) SQS queue ARN.

### `topic`

* `events` - (Required) [Event](http://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html#notification-how-to-event-types-and-destinations) for which to send notifications.
* `filterPrefix` - (Optional) Object key name prefix.
* `filterSuffix` - (Optional) Object key name suffix.
* `id` - (Optional) Unique identifier for each of the notification configurations.
* `topicArn` - (Required) SNS topic ARN.

## Attributes Reference

No additional attributes are exported.

## Import

S3 bucket notification can be imported using the `bucket`, e.g.,

```console
$ terraform import aws_s3_bucket_notification.bucket_notification bucket-name
```
