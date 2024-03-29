---
subcategory: "API Gateway"
layout: "aws"
page_title: "AWS: aws_api_gateway_account"
description: |-
  Provides a settings of an API Gateway Account.
---

# Resource: awsApiGatewayAccount

Provides a settings of an API Gateway Account. Settings is applied region-wide per `provider` block.

\-> **Note:** As there is no API method for deleting account settings or resetting it to defaults, destroying this resource will keep your account settings intact

## Example Usage

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
              identifiers: ["apigateway.amazonaws.com"],
              type: "Service",
            },
          ],
        },
      ],
    }
  );
const dataAwsIamPolicyDocumentCloudwatch =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "cloudwatch",
    {
      statement: [
        {
          actions: [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams",
            "logs:PutLogEvents",
            "logs:GetLogEvents",
            "logs:FilterLogEvents",
          ],
          effect: "Allow",
          resources: ["*"],
        },
      ],
    }
  );
const awsIamRoleCloudwatch = new aws.iamRole.IamRole(this, "cloudwatch_2", {
  assumeRolePolicy: dataAwsIamPolicyDocumentAssumeRole.json,
  name: "api_gateway_cloudwatch_global",
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamRoleCloudwatch.overrideLogicalId("cloudwatch");
const awsIamRolePolicyCloudwatch = new aws.iamRolePolicy.IamRolePolicy(
  this,
  "cloudwatch_3",
  {
    name: "default",
    policy: dataAwsIamPolicyDocumentCloudwatch.json,
    role: awsIamRoleCloudwatch.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamRolePolicyCloudwatch.overrideLogicalId("cloudwatch");
new aws.apiGatewayAccount.ApiGatewayAccount(this, "demo", {
  cloudwatchRoleArn: awsIamRoleCloudwatch.arn,
});

```

## Argument Reference

The following argument is supported:

* `cloudwatchRoleArn` - (Optional) ARN of an IAM role for CloudWatch (to allow logging & monitoring). See more [in AWS Docs](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-stage-settings.html#how-to-stage-settings-console). Logging & monitoring can be enabled/disabled and otherwise tuned on the API Gateway Stage level.

## Attributes Reference

The following attribute is exported:

* `throttleSettings` - Account-Level throttle settings. See exported fields below.

`throttleSettings` block exports the following:

* `burstLimit` - Absolute maximum number of times API Gateway allows the API to be called per second (RPS).
* `rateLimit` - Number of times API Gateway allows the API to be called per second on average (RPS).

## Import

API Gateway Accounts can be imported using the word `apiGatewayAccount`, e.g.,

```console
$ terraform import aws_api_gateway_account.demo api-gateway-account
```
