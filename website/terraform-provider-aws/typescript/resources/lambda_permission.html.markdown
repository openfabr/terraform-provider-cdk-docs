---
subcategory: "Lambda"
layout: "aws"
page_title: "AWS: aws_lambda_permission"
description: |-
  Creates a Lambda function permission.
---

# Resource: awsLambdaPermission

Gives an external source (like an EventBridge Rule, SNS, or S3) permission to access the Lambda function.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsIamRoleIamForLambda = new aws.iamRole.IamRole(this, "iam_for_lambda", {
  assumeRolePolicy:
    '${jsonencode({\n    Version = "2012-10-17"\n    Statement = [\n      {\n        Action = "sts:AssumeRole"\n        Effect = "Allow"\n        Sid    = ""\n        Principal = {\n          Service = "lambda.amazonaws.com"\n        }\n      },\n    ]\n  })}',
  name: "iam_for_lambda",
});
const awsLambdaFunctionTestLambda = new aws.lambdaFunction.LambdaFunction(
  this,
  "test_lambda",
  {
    filename: "lambdatest.zip",
    functionName: "lambda_function_name",
    handler: "exports.handler",
    role: awsIamRoleIamForLambda.arn,
    runtime: "nodejs16.x",
  }
);
const awsLambdaAliasTestAlias = new aws.lambdaAlias.LambdaAlias(
  this,
  "test_alias",
  {
    description: "a sample description",
    functionName: awsLambdaFunctionTestLambda.functionName,
    functionVersion: "$LATEST",
    name: "testalias",
  }
);
new aws.lambdaPermission.LambdaPermission(this, "allow_cloudwatch", {
  action: "lambda:InvokeFunction",
  functionName: awsLambdaFunctionTestLambda.functionName,
  principal: "events.amazonaws.com",
  qualifier: awsLambdaAliasTestAlias.name,
  sourceArn: "arn:aws:events:eu-west-1:111122223333:rule/RunDaily",
  statementId: "AllowExecutionFromCloudWatch",
});

```

## Usage with SNS

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsIamRoleDefault = new aws.iamRole.IamRole(this, "default", {
  assumeRolePolicy:
    '${jsonencode({\n    Version = "2012-10-17"\n    Statement = [\n      {\n        Action = "sts:AssumeRole"\n        Effect = "Allow"\n        Sid    = ""\n        Principal = {\n          Service = "lambda.amazonaws.com"\n        }\n      },\n    ]\n  })}',
  name: "iam_for_lambda_with_sns",
});
const awsLambdaFunctionFunc = new aws.lambdaFunction.LambdaFunction(
  this,
  "func",
  {
    filename: "lambdatest.zip",
    functionName: "lambda_called_from_sns",
    handler: "exports.handler",
    role: awsIamRoleDefault.arn,
    runtime: "python3.7",
  }
);
const awsSnsTopicDefault = new aws.snsTopic.SnsTopic(this, "default_2", {
  name: "call-lambda-maybe",
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsSnsTopicDefault.overrideLogicalId("default");
new aws.snsTopicSubscription.SnsTopicSubscription(this, "lambda", {
  endpoint: awsLambdaFunctionFunc.arn,
  protocol: "lambda",
  topicArn: awsSnsTopicDefault.arn,
});
new aws.lambdaPermission.LambdaPermission(this, "with_sns", {
  action: "lambda:InvokeFunction",
  functionName: awsLambdaFunctionFunc.functionName,
  principal: "sns.amazonaws.com",
  sourceArn: awsSnsTopicDefault.arn,
  statementId: "AllowExecutionFromSNS",
});

```

## Specify Lambda permissions for API Gateway REST API

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsApiGatewayRestApiMyDemoApi =
  new aws.apiGatewayRestApi.ApiGatewayRestApi(this, "MyDemoAPI", {
    description: "This is my API for demonstration purposes",
    name: "MyDemoAPI",
  });
new aws.lambdaPermission.LambdaPermission(this, "lambda_permission", {
  action: "lambda:InvokeFunction",
  functionName: "MyDemoFunction",
  principal: "apigateway.amazonaws.com",
  sourceArn: `\${${awsApiGatewayRestApiMyDemoApi.executionArn}}/*`,
  statementId: "AllowMyDemoAPIInvoke",
});

```

## Usage with CloudWatch log group

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsCloudwatchLogGroupDefault =
  new aws.cloudwatchLogGroup.CloudwatchLogGroup(this, "default", {
    name: "/default",
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
const awsIamRoleDefault = new aws.iamRole.IamRole(this, "default_2", {
  assumeRolePolicy: dataAwsIamPolicyDocumentAssumeRole.json,
  name: "iam_for_lambda_called_from_cloudwatch_logs",
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamRoleDefault.overrideLogicalId("default");
const awsLambdaFunctionLogging = new aws.lambdaFunction.LambdaFunction(
  this,
  "logging",
  {
    filename: "lamba_logging.zip",
    functionName: "lambda_called_from_cloudwatch_logs",
    handler: "exports.handler",
    role: awsIamRoleDefault.arn,
    runtime: "python3.7",
  }
);
const awsLambdaPermissionLogging = new aws.lambdaPermission.LambdaPermission(
  this,
  "logging_4",
  {
    action: "lambda:InvokeFunction",
    functionName: awsLambdaFunctionLogging.functionName,
    principal: "logs.eu-west-1.amazonaws.com",
    sourceArn: `\${${awsCloudwatchLogGroupDefault.arn}}:*`,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsLambdaPermissionLogging.overrideLogicalId("logging");
const awsCloudwatchLogSubscriptionFilterLogging =
  new aws.cloudwatchLogSubscriptionFilter.CloudwatchLogSubscriptionFilter(
    this,
    "logging_5",
    {
      depends_on: [`\${${awsLambdaPermissionLogging.fqn}}`],
      destinationArn: awsLambdaFunctionLogging.arn,
      filterPattern: "",
      logGroupName: awsCloudwatchLogGroupDefault.name,
      name: "logging_default",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsCloudwatchLogSubscriptionFilterLogging.overrideLogicalId("logging");

```

## Example function URL cross-account invoke policy

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.lambdaFunctionUrl.LambdaFunctionUrl(this, "url", {
  authorizationType: "AWS_IAM",
  functionName: "${aws_lambda_function.example.function_name}",
});
const awsLambdaPermissionUrl = new aws.lambdaPermission.LambdaPermission(
  this,
  "url_1",
  {
    action: "lambda:InvokeFunctionUrl",
    functionName: "${aws_lambda_function.example.function_name}",
    functionUrlAuthType: "AWS_IAM",
    principal: "arn:aws:iam::444455556666:role/example",
    sourceAccount: "444455556666",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsLambdaPermissionUrl.overrideLogicalId("url");

```

## Argument Reference

* `action` - (Required) The AWS Lambda action you want to allow in this statement. (e.g., `lambda:invokeFunction`)
* `eventSourceToken` - (Optional) The Event Source Token to validate.  Used with [Alexa Skills][1].
* `functionName` - (Required) Name of the Lambda function whose resource policy you are updating
* `functionUrlAuthType` - (Optional) Lambda Function URLs [authentication type][3]. Valid values are: `AWS_IAM` or `none`. Only supported for `lambda:invokeFunctionUrl` action.
* `principal` - (Required) The principal who is getting this permission e.g., `s3AmazonawsCom`, an AWS account ID, or AWS IAM principal, or AWS service principal such as `eventsAmazonawsCom` or `snsAmazonawsCom`.
* `qualifier` - (Optional) Query parameter to specify function version or alias name. The permission will then apply to the specific qualified ARN e.g., `arn:aws:lambda:awsRegion:acctId:function:functionName:2`
* `sourceAccount` - (Optional) This parameter is used when allowing cross-account access, or for S3 and SES. The AWS account ID (without a hyphen) of the source owner.
* `sourceArn` - (Optional) When the principal is an AWS service, the ARN of the specific resource within that service to grant permission to.
  Without this, any resource from `principal` will be granted permission – even if that resource is from another account.
  For S3, this should be the ARN of the S3 Bucket.
  For EventBridge events, this should be the ARN of the EventBridge Rule.
  For API Gateway, this should be the ARN of the API, as described [here][2].
* `statementId` - (Optional) A unique statement identifier. By default generated by Terraform.
* `statementIdPrefix` - (Optional) A statement identifier prefix. Terraform will generate a unique suffix. Conflicts with `statementId`.
* `principalOrgId` - (Optional) The identifier for your organization in AWS Organizations. Use this to grant permissions to all the AWS accounts under this organization.

[1]: https://developer.amazon.com/docs/custom-skills/host-a-custom-skill-as-an-aws-lambda-function.html#use-aws-cli

[2]: https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html

[3]: https://docs.aws.amazon.com/lambda/latest/dg/urls-auth.html

## Attributes Reference

No additional attributes are exported.

## Import

Lambda permission statements can be imported using function\_name/statement\_id, with an optional qualifier, e.g.,

```console
$ terraform import aws_lambda_permission.test_lambda_permission my_test_lambda_function/AllowExecutionFromCloudWatch

$ terraform import aws_lambda_permission.test_lambda_permission my_test_lambda_function:qualifier_name/AllowExecutionFromCloudWatch
```
