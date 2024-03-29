---
subcategory: "SFN (Step Functions)"
layout: "aws"
page_title: "AWS: aws_sfn_state_machine"
description: |-
  Provides a Step Function State Machine resource.
---

# Resource: awsSfnStateMachine

Provides a Step Function State Machine resource

## Example Usage

### Basic (Standard Workflow)

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.sfnStateMachine.SfnStateMachine(this, "sfn_state_machine", {
  definition:
    '{\n  "Comment": "A Hello World example of the Amazon States Language using an AWS Lambda Function",\n  "StartAt": "HelloWorld",\n  "States": {\n    "HelloWorld": {\n      "Type": "Task",\n      "Resource": "${aws_lambda_function.lambda.arn}",\n      "End": true\n    }\n  }\n}\n',
  name: "my-state-machine",
  roleArn: "${aws_iam_role.iam_for_sfn.arn}",
});

```

### Basic (Express Workflow)

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.sfnStateMachine.SfnStateMachine(this, "sfn_state_machine", {
  definition:
    '{\n  "Comment": "A Hello World example of the Amazon States Language using an AWS Lambda Function",\n  "StartAt": "HelloWorld",\n  "States": {\n    "HelloWorld": {\n      "Type": "Task",\n      "Resource": "${aws_lambda_function.lambda.arn}",\n      "End": true\n    }\n  }\n}\n',
  name: "my-state-machine",
  roleArn: "${aws_iam_role.iam_for_sfn.arn}",
  type: "EXPRESS",
});

```

### Logging

\~> *NOTE:* See the [AWS Step Functions Developer Guide](https://docs.aws.amazon.com/step-functions/latest/dg/welcome.html) for more information about enabling Step Function logging.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.sfnStateMachine.SfnStateMachine(this, "sfn_state_machine", {
  definition:
    '{\n  "Comment": "A Hello World example of the Amazon States Language using an AWS Lambda Function",\n  "StartAt": "HelloWorld",\n  "States": {\n    "HelloWorld": {\n      "Type": "Task",\n      "Resource": "${aws_lambda_function.lambda.arn}",\n      "End": true\n    }\n  }\n}\n',
  loggingConfiguration: {
    includeExecutionData: true,
    level: "ERROR",
    logDestination: "${aws_cloudwatch_log_group.log_group_for_sfn.arn}:*",
  },
  name: "my-state-machine",
  roleArn: "${aws_iam_role.iam_for_sfn.arn}",
});

```

## Argument Reference

The following arguments are supported:

* `definition` - (Required) The [Amazon States Language](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-amazon-states-language.html) definition of the state machine.
* `loggingConfiguration` - (Optional) Defines what execution history events are logged and where they are logged. The `loggingConfiguration` parameter is only valid when `type` is set to `express`. Defaults to `off`. For more information see [Logging Express Workflows](https://docs.aws.amazon.com/step-functions/latest/dg/cw-logs.html) and [Log Levels](https://docs.aws.amazon.com/step-functions/latest/dg/cloudwatch-log-level.html) in the AWS Step Functions User Guide.
* `name` - (Optional) The name of the state machine. The name should only contain `0`-`9`, `a`-`z`, `a`-`z`, `-` and `_`. If omitted, Terraform will assign a random, unique name.
* `namePrefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with `name`.
* `roleArn` - (Required) The Amazon Resource Name (ARN) of the IAM role to use for this state machine.
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `tracingConfiguration` - (Optional) Selects whether AWS X-Ray tracing is enabled.
* `type` - (Optional) Determines whether a Standard or Express state machine is created. The default is `standard`. You cannot update the type of a state machine once it has been created. Valid values: `standard`, `express`.

### `loggingConfiguration` Configuration Block

* `includeExecutionData` - (Optional) Determines whether execution data is included in your log. When set to `false`, data is excluded.
* `level` - (Optional) Defines which category of execution history events are logged. Valid values: `all`, `error`, `fatal`, `off`
* `logDestination` - (Optional) Amazon Resource Name (ARN) of a CloudWatch log group. Make sure the State Machine has the correct IAM policies for logging. The ARN must end with `:*`

### `tracingConfiguration` Configuration Block

* `enabled` - (Optional) When set to `true`, AWS X-Ray tracing is enabled. Make sure the State Machine has the correct IAM policies for logging. See the [AWS Step Functions Developer Guide](https://docs.aws.amazon.com/step-functions/latest/dg/xray-iam.html) for details.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ARN of the state machine.
* `arn` - The ARN of the state machine.
* `creationDate` - The date the state machine was created.
* `status` - The current status of the state machine. Either `active` or `deleting`.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

State Machines can be imported using the `arn`, e.g.,

```console
$ terraform import aws_sfn_state_machine.foo arn:aws:states:eu-west-1:123456789098:stateMachine:bar
```
