---
subcategory: "EventBridge"
layout: "aws"
page_title: "AWS: aws_cloudwatch_event_target"
description: |-
  Provides an EventBridge Target resource.
---

# Resource: awsCloudwatchEventTarget

Provides an EventBridge Target resource.

\~> **Note:** EventBridge was formerly known as CloudWatch Events. The functionality is identical.

## Example Usage

### Kinesis Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsCloudwatchEventRuleConsole =
  new aws.cloudwatchEventRule.CloudwatchEventRule(this, "console", {
    description: "Capture all EC2 scaling events",
    eventPattern:
      '${jsonencode({\n    source = [\n      "aws.autoscaling"\n    ]\n\n    detail-type = [\n      "EC2 Instance Launch Successful",\n      "EC2 Instance Terminate Successful",\n      "EC2 Instance Launch Unsuccessful",\n      "EC2 Instance Terminate Unsuccessful"\n    ]\n  })}',
    name: "capture-ec2-scaling-events",
  });
const awsKinesisStreamTestStream = new aws.kinesisStream.KinesisStream(
  this,
  "test_stream",
  {
    name: "terraform-kinesis-test",
    shardCount: 1,
  }
);
new aws.cloudwatchEventTarget.CloudwatchEventTarget(this, "yada", {
  arn: awsKinesisStreamTestStream.arn,
  rule: awsCloudwatchEventRuleConsole.name,
  runCommandTargets: [
    {
      key: "tag:Name",
      values: ["FooBar"],
    },
    {
      key: "InstanceIds",
      values: ["i-162058cd308bffec2"],
    },
  ],
  targetId: "Yada",
});

```

### SSM Document Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsCloudwatchEventRuleStopInstances =
  new aws.cloudwatchEventRule.CloudwatchEventRule(this, "stop_instances", {
    description: "Stop instances nightly",
    name: "StopInstance",
    scheduleExpression: "cron(0 0 * * ? *)",
  });
const awsSsmDocumentStopInstance = new aws.ssmDocument.SsmDocument(
  this,
  "stop_instance",
  {
    content:
      '${jsonencode({\n    schemaVersion = "1.2"\n    description   = "Stop an instance"\n    parameters    = {}\n    runtimeConfig = {\n      "aws:runShellScript" = {\n        properties = [\n          {\n            id         = "0.aws:runShellScript"\n            runCommand = ["halt"]\n          }\n        ]\n      }\n    }\n  })}',
    documentType: "Command",
    name: "stop_instance",
  }
);
const dataAwsIamPolicyDocumentSsmLifecycle =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "ssm_lifecycle",
    {
      statement: [
        {
          actions: ["ssm:SendCommand"],
          condition: [
            {
              test: "StringEquals",
              values: ["*"],
              variable: "ec2:ResourceTag/Terminate",
            },
          ],
          effect: "Allow",
          resources: ["arn:aws:ec2:eu-west-1:1234567890:instance/*"],
        },
        {
          actions: ["ssm:SendCommand"],
          effect: "Allow",
          resources: [awsSsmDocumentStopInstance.arn],
        },
      ],
    }
  );
const dataAwsIamPolicyDocumentSsmLifecycleTrust =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "ssm_lifecycle_trust",
    {
      statement: [
        {
          actions: ["sts:AssumeRole"],
          principals: [
            {
              identifiers: ["events.amazonaws.com"],
              type: "Service",
            },
          ],
        },
      ],
    }
  );
const awsIamPolicySsmLifecycle = new aws.iamPolicy.IamPolicy(
  this,
  "ssm_lifecycle_4",
  {
    name: "SSMLifecycle",
    policy: dataAwsIamPolicyDocumentSsmLifecycle.json,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamPolicySsmLifecycle.overrideLogicalId("ssm_lifecycle");
const awsIamRoleSsmLifecycle = new aws.iamRole.IamRole(
  this,
  "ssm_lifecycle_5",
  {
    assumeRolePolicy: dataAwsIamPolicyDocumentSsmLifecycleTrust.json,
    name: "SSMLifecycle",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamRoleSsmLifecycle.overrideLogicalId("ssm_lifecycle");
const awsIamRolePolicyAttachmentSsmLifecycle =
  new aws.iamRolePolicyAttachment.IamRolePolicyAttachment(
    this,
    "ssm_lifecycle_6",
    {
      policyArn: awsIamPolicySsmLifecycle.arn,
      role: awsIamRoleSsmLifecycle.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamRolePolicyAttachmentSsmLifecycle.overrideLogicalId("ssm_lifecycle");
const awsCloudwatchEventTargetStopInstances =
  new aws.cloudwatchEventTarget.CloudwatchEventTarget(
    this,
    "stop_instances_7",
    {
      arn: awsSsmDocumentStopInstance.arn,
      roleArn: awsIamRoleSsmLifecycle.arn,
      rule: awsCloudwatchEventRuleStopInstances.name,
      runCommandTargets: [
        {
          key: "tag:Terminate",
          values: ["midnight"],
        },
      ],
      targetId: "StopInstance",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsCloudwatchEventTargetStopInstances.overrideLogicalId("stop_instances");

```

### RunCommand Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsCloudwatchEventRuleStopInstances =
  new aws.cloudwatchEventRule.CloudwatchEventRule(this, "stop_instances", {
    description: "Stop instances nightly",
    name: "StopInstance",
    scheduleExpression: "cron(0 0 * * ? *)",
  });
const awsCloudwatchEventTargetStopInstances =
  new aws.cloudwatchEventTarget.CloudwatchEventTarget(
    this,
    "stop_instances_1",
    {
      arn: "arn:aws:ssm:${var.aws_region}::document/AWS-RunShellScript",
      input: '{"commands":["halt"]}',
      roleArn: "${aws_iam_role.ssm_lifecycle.arn}",
      rule: awsCloudwatchEventRuleStopInstances.name,
      runCommandTargets: [
        {
          key: "tag:Terminate",
          values: ["midnight"],
        },
      ],
      targetId: "StopInstance",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsCloudwatchEventTargetStopInstances.overrideLogicalId("stop_instances");

```

### ECS Run Task with Role and Task Override Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
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
              identifiers: ["events.amazonaws.com"],
              type: "Service",
            },
          ],
        },
      ],
    }
  );
const dataAwsIamPolicyDocumentEcsEventsRunTaskWithAnyRole =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "ecs_events_run_task_with_any_role",
    {
      statement: [
        {
          actions: ["iam:PassRole"],
          effect: "Allow",
          resources: ["*"],
        },
        {
          actions: ["ecs:RunTask"],
          effect: "Allow",
          resources: [
            '${replace(aws_ecs_task_definition.task_name.arn, "/:\\\\d+$/", ":*")}',
          ],
        },
      ],
    }
  );
const awsIamRoleEcsEvents = new aws.iamRole.IamRole(this, "ecs_events", {
  assumeRolePolicy: dataAwsIamPolicyDocumentAssumeRole.json,
  name: "ecs_events",
});
const awsIamRolePolicyEcsEventsRunTaskWithAnyRole =
  new aws.iamRolePolicy.IamRolePolicy(
    this,
    "ecs_events_run_task_with_any_role_3",
    {
      name: "ecs_events_run_task_with_any_role",
      policy: dataAwsIamPolicyDocumentEcsEventsRunTaskWithAnyRole.json,
      role: awsIamRoleEcsEvents.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamRolePolicyEcsEventsRunTaskWithAnyRole.overrideLogicalId(
  "ecs_events_run_task_with_any_role"
);
new aws.cloudwatchEventTarget.CloudwatchEventTarget(
  this,
  "ecs_scheduled_task",
  {
    arn: "${aws_ecs_cluster.cluster_name.arn}",
    ecsTarget: {
      taskCount: 1,
      taskDefinitionArn: "${aws_ecs_task_definition.task_name.arn}",
    },
    input:
      '${jsonencode({\n    containerOverrides = [\n      {\n        name = "name-of-container-to-override",\n        command = [\n          "bin/console",\n          "scheduled-task"\n        ]\n      }\n    ]\n  })}',
    roleArn: awsIamRoleEcsEvents.arn,
    rule: "${aws_cloudwatch_event_rule.every_hour.name}",
    targetId: "run-scheduled-task-every-hour",
  }
);

```

### API Gateway target

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsApiGatewayDeploymentExample =
  new aws.apiGatewayDeployment.ApiGatewayDeployment(this, "example", {
    restApiId: "${aws_api_gateway_rest_api.example.id}",
  });
const awsApiGatewayStageExample = new aws.apiGatewayStage.ApiGatewayStage(
  this,
  "example_1",
  {
    deploymentId: awsApiGatewayDeploymentExample.id,
    restApiId: "${aws_api_gateway_rest_api.example.id}",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsApiGatewayStageExample.overrideLogicalId("example");
const awsCloudwatchEventRuleExample =
  new aws.cloudwatchEventRule.CloudwatchEventRule(this, "example_2", {});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsCloudwatchEventRuleExample.overrideLogicalId("example");
const awsCloudwatchEventTargetExample =
  new aws.cloudwatchEventTarget.CloudwatchEventTarget(this, "example_3", {
    arn: `\${${awsApiGatewayStageExample.executionArn}}/GET`,
    httpTarget: {
      headerParameters: {
        env: "Test",
      },
      queryStringParameters: {
        body: "$.detail.body",
      },
    },
    rule: awsCloudwatchEventRuleExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsCloudwatchEventTargetExample.overrideLogicalId("example");

```

### Cross-Account Event Bus target

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsCloudwatchEventRuleStopInstances =
  new aws.cloudwatchEventRule.CloudwatchEventRule(this, "stop_instances", {
    description: "Stop instances nightly",
    name: "StopInstance",
    scheduleExpression: "cron(0 0 * * ? *)",
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
              identifiers: ["events.amazonaws.com"],
              type: "Service",
            },
          ],
        },
      ],
    }
  );
const dataAwsIamPolicyDocumentEventBusInvokeRemoteEventBus =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "event_bus_invoke_remote_event_bus",
    {
      statement: [
        {
          actions: ["events:PutEvents"],
          effect: "Allow",
          resources: [
            "arn:aws:events:eu-west-1:1234567890:event-bus/My-Event-Bus",
          ],
        },
      ],
    }
  );
const awsIamPolicyEventBusInvokeRemoteEventBus = new aws.iamPolicy.IamPolicy(
  this,
  "event_bus_invoke_remote_event_bus_3",
  {
    name: "event_bus_invoke_remote_event_bus",
    policy: dataAwsIamPolicyDocumentEventBusInvokeRemoteEventBus.json,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamPolicyEventBusInvokeRemoteEventBus.overrideLogicalId(
  "event_bus_invoke_remote_event_bus"
);
const awsIamRoleEventBusInvokeRemoteEventBus = new aws.iamRole.IamRole(
  this,
  "event_bus_invoke_remote_event_bus_4",
  {
    assumeRolePolicy: dataAwsIamPolicyDocumentAssumeRole.json,
    name: "event-bus-invoke-remote-event-bus",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamRoleEventBusInvokeRemoteEventBus.overrideLogicalId(
  "event_bus_invoke_remote_event_bus"
);
const awsIamRolePolicyAttachmentEventBusInvokeRemoteEventBus =
  new aws.iamRolePolicyAttachment.IamRolePolicyAttachment(
    this,
    "event_bus_invoke_remote_event_bus_5",
    {
      policyArn: awsIamPolicyEventBusInvokeRemoteEventBus.arn,
      role: awsIamRoleEventBusInvokeRemoteEventBus.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamRolePolicyAttachmentEventBusInvokeRemoteEventBus.overrideLogicalId(
  "event_bus_invoke_remote_event_bus"
);
const awsCloudwatchEventTargetStopInstances =
  new aws.cloudwatchEventTarget.CloudwatchEventTarget(
    this,
    "stop_instances_6",
    {
      arn: "arn:aws:events:eu-west-1:1234567890:event-bus/My-Event-Bus",
      roleArn: awsIamRoleEventBusInvokeRemoteEventBus.arn,
      rule: awsCloudwatchEventRuleStopInstances.name,
      targetId: "StopInstance",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsCloudwatchEventTargetStopInstances.overrideLogicalId("stop_instances");

```

### Input Transformer Usage - JSON Object

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsCloudwatchEventRuleExample =
  new aws.cloudwatchEventRule.CloudwatchEventRule(this, "example", {});
const awsCloudwatchEventTargetExample =
  new aws.cloudwatchEventTarget.CloudwatchEventTarget(this, "example_1", {
    arn: "${aws_lambda_function.example.arn}",
    inputTransformer: {
      inputPaths: {
        instance: "$.detail.instance",
        status: "$.detail.status",
      },
      inputTemplate:
        '{\n  "instance_id": <instance>,\n  "instance_status": <status>\n}\n',
    },
    rule: awsCloudwatchEventRuleExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsCloudwatchEventTargetExample.overrideLogicalId("example");

```

### Input Transformer Usage - Simple String

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsCloudwatchEventRuleExample =
  new aws.cloudwatchEventRule.CloudwatchEventRule(this, "example", {});
const awsCloudwatchEventTargetExample =
  new aws.cloudwatchEventTarget.CloudwatchEventTarget(this, "example_1", {
    arn: "${aws_lambda_function.example.arn}",
    inputTransformer: {
      inputPaths: {
        instance: "$.detail.instance",
        status: "$.detail.status",
      },
      inputTemplate: '"<instance> is in state <status>"',
    },
    rule: awsCloudwatchEventRuleExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsCloudwatchEventTargetExample.overrideLogicalId("example");

```

### Cloudwatch Log Group Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsCloudwatchEventRuleExample =
  new aws.cloudwatchEventRule.CloudwatchEventRule(this, "example", {
    description: "GuardDuty Findings",
    eventPattern:
      '${jsonencode(\n    {\n      "source" : [\n        "aws.guardduty"\n      ]\n    }\n  )}',
    name: "guard-duty_event_rule",
    tags: {
      Environment: "example",
    },
  });
const awsCloudwatchLogGroupExample =
  new aws.cloudwatchLogGroup.CloudwatchLogGroup(this, "example_1", {
    name: "/aws/events/guardduty/logs",
    retentionInDays: 1,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsCloudwatchLogGroupExample.overrideLogicalId("example");
const dataAwsIamPolicyDocumentExampleLogPolicy =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "example_log_policy",
    {
      statement: [
        {
          actions: ["logs:CreateLogStream"],
          effect: "Allow",
          principals: [
            {
              identifiers: ["events.amazonaws.com"],
              type: "Service",
            },
          ],
          resources: [`\${${awsCloudwatchLogGroupExample.arn}}:*`],
        },
        {
          actions: ["logs:PutLogEvents"],
          condition: [
            {
              test: "ArnEquals",
              values: [awsCloudwatchEventRuleExample.arn],
              variable: "aws:SourceArn",
            },
          ],
          effect: "Allow",
          principals: [
            {
              identifiers: ["events.amazonaws.com"],
              type: "Service",
            },
          ],
          resources: [`\${${awsCloudwatchLogGroupExample.arn}}:*:*`],
        },
      ],
    }
  );
const awsCloudwatchEventTargetExample =
  new aws.cloudwatchEventTarget.CloudwatchEventTarget(this, "example_3", {
    arn: awsCloudwatchLogGroupExample.arn,
    rule: awsCloudwatchEventRuleExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsCloudwatchEventTargetExample.overrideLogicalId("example");
const awsCloudwatchLogResourcePolicyExample =
  new aws.cloudwatchLogResourcePolicy.CloudwatchLogResourcePolicy(
    this,
    "example_4",
    {
      policyDocument: dataAwsIamPolicyDocumentExampleLogPolicy.json,
      policyName: "guardduty-log-publishing-policy",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsCloudwatchLogResourcePolicyExample.overrideLogicalId("example");

```

## Argument Reference

\-> **Note:** In order to be able to have your AWS Lambda function or
SNS topic invoked by an EventBridge rule, you must set up the right permissions
using [`awsLambdaPermission`](/docs/providers/aws/r/lambda_permission.html)
or [`awsSnsTopicPolicy`](/docs/providers/aws/r/sns_topic.html#policy).
More info [here](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-use-resource-based.html).

The following arguments are required:

* `arn` - (Required) The Amazon Resource Name (ARN) of the target.
* `rule` - (Required) The name of the rule you want to add targets to.

The following arguments are optional:

* `batchTarget` - (Optional) Parameters used when you are using the rule to invoke an Amazon Batch Job. Documented below. A maximum of 1 are allowed.
* `deadLetterConfig` - (Optional)  Parameters used when you are providing a dead letter config. Documented below. A maximum of 1 are allowed.
* `ecsTarget` - (Optional) Parameters used when you are using the rule to invoke Amazon ECS Task. Documented below. A maximum of 1 are allowed.
* `eventBusName` - (Optional) The name or ARN of the event bus to associate with the rule.
  If you omit this, the `default` event bus is used.
* `httpTarget` - (Optional) Parameters used when you are using the rule to invoke an API Gateway REST endpoint. Documented below. A maximum of 1 is allowed.
* `input` - (Optional) Valid JSON text passed to the target. Conflicts with `inputPath` and `inputTransformer`.
* `inputPath` - (Optional) The value of the [JSONPath](http://goessner.net/articles/JsonPath/) that is used for extracting part of the matched event when passing it to the target. Conflicts with `input` and `inputTransformer`.
* `inputTransformer` - (Optional) Parameters used when you are providing a custom input to a target based on certain event data. Conflicts with `input` and `inputPath`.
* `kinesisTarget` - (Optional) Parameters used when you are using the rule to invoke an Amazon Kinesis Stream. Documented below. A maximum of 1 are allowed.
* `roleArn` - (Optional) The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered. Required if `ecsTarget` is used or target in `arn` is EC2 instance, Kinesis data stream, Step Functions state machine, or Event Bus in different account or region.
* `runCommandTargets` - (Optional) Parameters used when you are using the rule to invoke Amazon EC2 Run Command. Documented below. A maximum of 5 are allowed.
* `redshiftTarget` - (Optional) Parameters used when you are using the rule to invoke an Amazon Redshift Statement. Documented below. A maximum of 1 are allowed.
* `retryPolicy` - (Optional)  Parameters used when you are providing retry policies. Documented below. A maximum of 1 are allowed.
* `sqsTarget` - (Optional) Parameters used when you are using the rule to invoke an Amazon SQS Queue. Documented below. A maximum of 1 are allowed.
* `targetId` - (Optional) The unique target assignment ID. If missing, will generate a random, unique id.

### batchTarget

* `jobDefinition` - (Required) The ARN or name of the job definition to use if the event target is an AWS Batch job. This job definition must already exist.
* `jobName` - (Required) The name to use for this execution of the job, if the target is an AWS Batch job.
* `arraySize` - (Optional) The size of the array, if this is an array batch job. Valid values are integers between 2 and 10,000.
* `jobAttempts` - (Optional) The number of times to attempt to retry, if the job fails. Valid values are 1 to 10.

### capacityProviderStrategy

* `capacityProvider` - (Required) Short name of the capacity provider.
* `weight` - (Required) The weight value designates the relative percentage of the total number of tasks launched that should use the specified capacity provider. The weight value is taken into consideration after the base value, if defined, is satisfied.
* `base` - (Optional) The base value designates how many tasks, at a minimum, to run on the specified capacity provider. Only one capacity provider in a capacity provider strategy can have a base defined. Defaults to `0`.

### deadLetterConfig

* `arn` - (Optional) - ARN of the SQS queue specified as the target for the dead-letter queue.

### ecsTarget

* `taskDefinitionArn` - (Required) The ARN of the task definition to use if the event target is an Amazon ECS cluster.
* `capacityProviderStrategy` - (Optional) The capacity provider strategy to use for the task. If a `capacityProviderStrategy` specified, the `launchType` parameter must be omitted. If no `capacityProviderStrategy` or `launchType` is specified, the default capacity provider strategy for the cluster is used. Can be one or more. See below.
* `enableEcsManagedTags` - (Optional) Specifies whether to enable Amazon ECS managed tags for the task.
* `enableExecuteCommand` - (Optional) Whether or not to enable the execute command functionality for the containers in this task. If true, this enables execute command functionality on all containers in the task.
* `group` - (Optional) Specifies an ECS task group for the task. The maximum length is 255 characters.
* `launchType` - (Optional) Specifies the launch type on which your task is running. The launch type that you specify here must match one of the launch type (compatibilities) of the target task. Valid values include: `ec2`, `external`, or `fargate`.
* `networkConfiguration` - (Optional) Use this if the ECS task uses the awsvpc network mode. This specifies the VPC subnets and security groups associated with the task, and whether a public IP address is to be used. Required if `launchType` is `fargate` because the awsvpc mode is required for Fargate tasks.
* `placementConstraint` - (Optional) An array of placement constraint objects to use for the task. You can specify up to 10 constraints per task (including constraints in the task definition and those specified at runtime). See Below.
* `platformVersion` - (Optional) Specifies the platform version for the task. Specify only the numeric portion of the platform version, such as `110`. This is used only if LaunchType is FARGATE. For more information about valid platform versions, see [AWS Fargate Platform Versions](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html).
* `propagateTags` - (Optional) Specifies whether to propagate the tags from the task definition to the task. If no value is specified, the tags are not propagated. Tags can only be propagated to the task during task creation. The only valid value is: `TASK_DEFINITION`.
* `taskCount` - (Optional) The number of tasks to create based on the TaskDefinition. Defaults to `1`.
* `tags` - (Optional) A map of tags to assign to ecs resources.

### httpTarget

* `headerParameters` - (Optional) Enables you to specify HTTP headers to add to the request.
* `pathParameterValues` - (Optional) The list of values that correspond sequentially to any path variables in your endpoint ARN (for example `arn:aws:executeApi:usEast1:123456:myapi/*/post/pets/*`).
* `queryStringParameters` - (Optional) Represents keys/values of query string parameters that are appended to the invoked endpoint.

### inputTransformer

* `inputTemplate` - (Required) Template to customize data sent to the target. Must be valid JSON. To send a string value, the string value must include double quotes. Values must be escaped for both JSON and Terraform, e.g., `"\"yourStringGoesHere.\\nANewLine.\""`
* `inputPaths` - (Optional) Key value pairs specified in the form of JSONPath (for example, time = $.time)
  * You can have as many as 100 key-value pairs.
  * You must use JSON dot notation, not bracket notation.
  * The keys can't start with "AWS".

### kinesisTarget

* `partitionKeyPath` - (Optional) The JSON path to be extracted from the event and used as the partition key.

### networkConfiguration

* `subnets` - (Required) The subnets associated with the task or service.
* `securityGroups` - (Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used.
* `assignPublicIp` - (Optional) Assign a public IP address to the ENI (Fargate launch type only). Valid values are `true` or `false`. Defaults to `false`.

For more information, see [Task Networking](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html)

### placementConstraint

* `type` - (Required) Type of constraint. The only valid values at this time are `memberOf` and `distinctInstance`.
* `expression` -  (Optional) Cluster Query Language expression to apply to the constraint. Does not need to be specified for the `distinctInstance` type. For more information, see [Cluster Query Language in the Amazon EC2 Container Service Developer Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cluster-query-language.html).

### redshiftTarget

* `database` - (Required) The name of the database.
* `dbUser` - (Optional) The database user name.
* `secretsManagerArn` - (Optional) The name or ARN of the secret that enables access to the database.
* `sql` - (Optional) The SQL statement text to run.
* `statementName` - (Optional) The name of the SQL statement.
* `withEvent` - (Optional) Indicates whether to send an event back to EventBridge after the SQL statement runs.

### retryPolicy

* `maximumEventAgeInSeconds` - (Optional) The age in seconds to continue to make retry attempts.
* `maximumRetryAttempts` - (Optional) maximum number of retry attempts to make before the request fails

### runCommandTargets

* `key` - (Required) Can be either `tag:tagKey` or `instanceIds`.
* `values` - (Required) If Key is `tag:tagKey`, Values is a list of tag values. If Key is `instanceIds`, Values is a list of Amazon EC2 instance IDs.

### sqsTarget

* `messageGroupId` - (Optional) The FIFO message group ID to use as the target.

## Attributes Reference

No additional attributes are exported.

## Import

EventBridge Targets can be imported using `eventBusName/ruleName/targetId` (if you omit `eventBusName`, the `default` event bus will be used).

```console
$ terraform import aws_cloudwatch_event_target.test-event-target rule-name/target-id
```
