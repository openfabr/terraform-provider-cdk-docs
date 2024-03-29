---
subcategory: "API Gateway"
layout: "aws"
page_title: "AWS: aws_api_gateway_integration_response"
description: |-
  Provides an HTTP Method Integration Response for an API Gateway Resource.
---

# Resource: awsApiGatewayIntegrationResponse

Provides an HTTP Method Integration Response for an API Gateway Resource.

\-> **Note:** Depends on having `awsApiGatewayIntegration` inside your rest api. To ensure this
you might need to add an explicit `dependsOn` for clean runs.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsApiGatewayRestApiMyDemoApi =
  new aws.apiGatewayRestApi.ApiGatewayRestApi(this, "MyDemoAPI", {
    description: "This is my API for demonstration purposes",
    name: "MyDemoAPI",
  });
const awsApiGatewayResourceMyDemoResource =
  new aws.apiGatewayResource.ApiGatewayResource(this, "MyDemoResource", {
    parentId: awsApiGatewayRestApiMyDemoApi.rootResourceId,
    pathPart: "mydemoresource",
    restApiId: awsApiGatewayRestApiMyDemoApi.id,
  });
const awsApiGatewayMethodMyDemoMethod =
  new aws.apiGatewayMethod.ApiGatewayMethod(this, "MyDemoMethod", {
    authorization: "NONE",
    httpMethod: "GET",
    resourceId: awsApiGatewayResourceMyDemoResource.id,
    restApiId: awsApiGatewayRestApiMyDemoApi.id,
  });
const awsApiGatewayMethodResponseResponse200 =
  new aws.apiGatewayMethodResponse.ApiGatewayMethodResponse(
    this,
    "response_200",
    {
      httpMethod: awsApiGatewayMethodMyDemoMethod.httpMethod,
      resourceId: awsApiGatewayResourceMyDemoResource.id,
      restApiId: awsApiGatewayRestApiMyDemoApi.id,
      statusCode: "200",
    }
  );
new aws.apiGatewayIntegration.ApiGatewayIntegration(this, "MyDemoIntegration", {
  httpMethod: awsApiGatewayMethodMyDemoMethod.httpMethod,
  resourceId: awsApiGatewayResourceMyDemoResource.id,
  restApiId: awsApiGatewayRestApiMyDemoApi.id,
  type: "MOCK",
});
new aws.apiGatewayIntegrationResponse.ApiGatewayIntegrationResponse(
  this,
  "MyDemoIntegrationResponse",
  {
    httpMethod: awsApiGatewayMethodMyDemoMethod.httpMethod,
    resourceId: awsApiGatewayResourceMyDemoResource.id,
    responseTemplates: {
      "application/xml":
        '#set($inputRoot = $input.path(\'$\'))\n<?xml version="1.0" encoding="UTF-8"?>\n<message>\n    $inputRoot.body\n</message>\n',
    },
    restApiId: awsApiGatewayRestApiMyDemoApi.id,
    statusCode: awsApiGatewayMethodResponseResponse200.statusCode,
  }
);

```

## Argument Reference

The following arguments are required:

* `httpMethod` - (Required) HTTP method (`get`, `post`, `put`, `delete`, `head`, `options`, `any`).
* `resourceId` - (Required) API resource ID.
* `restApiId` - (Required) ID of the associated REST API.
* `statusCode` - (Required) HTTP status code.

The following arguments are optional:

* `contentHandling` - (Optional) How to handle request payload content type conversions. Supported values are `CONVERT_TO_BINARY` and `CONVERT_TO_TEXT`. If this property is not defined, the response payload will be passed through from the integration response to the method response without modification.
* `responseParameters` - (Optional) Map of response parameters that can be read from the backend response. For example: `responseParameters = { "methodResponseHeaderXSomeHeader" = "integrationResponseHeaderXSomeOtherHeader" }`.
* `responseTemplates` - (Optional) Map of templates used to transform the integration response body.
* `selectionPattern` - (Optional) Regular expression pattern used to choose an integration response based on the response from the backend. Omit configuring this to make the integration the default one. If the backend is an `aws` Lambda function, the AWS Lambda function error header is matched. For all other `http` and `aws` backends, the HTTP status code is matched.

## Attributes Reference

No additional attributes are exported.

## Import

`awsApiGatewayIntegrationResponse` can be imported using `restApiId/resourceId/httpMethod/statusCode`, e.g.,

```console
$ terraform import aws_api_gateway_integration_response.example 12345abcde/67890fghij/GET/200
```
