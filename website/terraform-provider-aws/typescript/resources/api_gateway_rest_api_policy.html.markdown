---
subcategory: "API Gateway"
layout: "aws"
page_title: "AWS: aws_api_gateway_rest_api_policy"
description: |-
  Provides an API Gateway REST API Policy.
---

# Resource: awsApiGatewayRestApiPolicy

Provides an API Gateway REST API Policy.

\-> **Note:** Amazon API Gateway Version 1 resources are used for creating and deploying REST APIs. To create and deploy WebSocket and HTTP APIs, use Amazon API Gateway Version 2 [resources](/docs/providers/aws/r/apigatewayv2_api.html).

## Example Usage

### Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsApiGatewayRestApiTest = new aws.apiGatewayRestApi.ApiGatewayRestApi(
  this,
  "test",
  {
    name: "example-rest-api",
  }
);
const dataAwsIamPolicyDocumentTest =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(this, "test_1", {
    statement: [
      {
        actions: ["execute-api:Invoke"],
        condition: [
          {
            test: "IpAddress",
            values: ["123.123.123.123/32"],
            variable: "aws:SourceIp",
          },
        ],
        effect: "Allow",
        principals: [
          {
            identifiers: ["*"],
            type: "AWS",
          },
        ],
        resources: [awsApiGatewayRestApiTest.executionArn],
      },
    ],
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAwsIamPolicyDocumentTest.overrideLogicalId("test");
const awsApiGatewayRestApiPolicyTest =
  new aws.apiGatewayRestApiPolicy.ApiGatewayRestApiPolicy(this, "test_2", {
    policy: dataAwsIamPolicyDocumentTest.json,
    restApiId: awsApiGatewayRestApiTest.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsApiGatewayRestApiPolicyTest.overrideLogicalId("test");

```

## Argument Reference

The following arguments are supported:

* `restApiId` - (Required) ID of the REST API.
* `policy` - (Required) JSON formatted policy document that controls access to the API Gateway. For more information about building AWS IAM policy documents with Terraform, see the [AWS IAM Policy Document Guide](https://learn.hashicorp.com/terraform/aws/iam-policy)

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - ID of the REST API

## Import

`awsApiGatewayRestApiPolicy` can be imported by using the REST API ID, e.g.,

```console
$ terraform import aws_api_gateway_rest_api_policy.example 12345abcde
```
