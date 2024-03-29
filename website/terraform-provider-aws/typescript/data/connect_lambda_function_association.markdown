---
subcategory: "Connect"
layout: "aws"
page_title: "AWS: aws_connect_lambda_function_association"
description: |-
  Provides details about a specific Connect Lambda Function Association.
---

# Data Source: awsConnectLambdaFunctionAssociation

Provides details about a specific Connect Lambda Function Association.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsConnectLambdaFunctionAssociation.DataAwsConnectLambdaFunctionAssociation(
  this,
  "example",
  {
    functionArn: "arn:aws:lambda:us-west-2:123456789123:function:abcdefg",
    instanceId: "aaaaaaaa-bbbb-cccc-dddd-111111111111",
  }
);

```

## Argument Reference

The following arguments are supported:

* `functionArn` - (Required) ARN of the Lambda Function, omitting any version or alias qualifier.
* `instanceId` - (Required) Identifier of the Amazon Connect instance. You can find the instanceId in the ARN of the instance.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - AWS Region.
