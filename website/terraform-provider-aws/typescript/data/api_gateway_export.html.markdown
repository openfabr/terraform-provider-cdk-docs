---
subcategory: "API Gateway"
layout: "aws"
page_title: "AWS: aws_api_gateway_export"
description: |-
  Get information on an API Gateway REST API Key
---

# Data Source: awsApiGatewayExport

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsApiGatewayExport.DataAwsApiGatewayExport(this, "example", {
  exportType: "oas30",
  restApiId: "${aws_api_gateway_stage.example.rest_api_id}",
  stageName: "${aws_api_gateway_stage.example.stage_name}",
});

```

## Argument Reference

* `exportType` - (Required) Type of export. Acceptable values are `oas30` for OpenAPI 3.0.x and `swagger` for Swagger/OpenAPI 2.0.
* `restApiId` - (Required) Identifier of the associated REST API.
* `stageName` - (Required) Name of the Stage that will be exported.
* `accepts` - (Optional) Content-type of the export. Valid values are `application/json` and `application/yaml` are supported for `exportType` `ofoas30` and `swagger`.
* `parameters` - (Optional) Key-value map of query string parameters that specify properties of the export. the following parameters are supported: `extensions='integrations'` or `extensions='apigateway'` will export the API with x-amazon-apigateway-integration extensions. `extensions='authorizers'` will export the API with x-amazon-apigateway-authorizer extensions.

## Attributes Reference

* `id` - The `restApiId:stageName`
* `body` - API Spec.
* `contentType` - Content-type header value in the HTTP response.
* `contentDisposition` - Content-disposition header value in the HTTP response.
