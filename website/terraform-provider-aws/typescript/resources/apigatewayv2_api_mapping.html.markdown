---
subcategory: "API Gateway V2"
layout: "aws"
page_title: "AWS: aws_apigatewayv2_api_mapping"
description: |-
  Manages an Amazon API Gateway Version 2 API mapping.
---

# Resource: awsApigatewayv2ApiMapping

Manages an Amazon API Gateway Version 2 API mapping.
More information can be found in the [Amazon API Gateway Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-custom-domains.html).

## Example Usage

### Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.apigatewayv2ApiMapping.Apigatewayv2ApiMapping(this, "example", {
  apiId: "${aws_apigatewayv2_api.example.id}",
  domainName: "${aws_apigatewayv2_domain_name.example.id}",
  stage: "${aws_apigatewayv2_stage.example.id}",
});

```

## Argument Reference

The following arguments are supported:

* `apiId` - (Required) API identifier.
* `domainName` - (Required) Domain name. Use the [`awsApigatewayv2DomainName`](/docs/providers/aws/r/apigatewayv2_domain_name.html) resource to configure a domain name.
* `stage` - (Required) API stage. Use the [`awsApigatewayv2Stage`](/docs/providers/aws/r/apigatewayv2_stage.html) resource to configure an API stage.
* `apiMappingKey` - (Optional) The [API mapping key](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-mapping-template-reference.html).

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - API mapping identifier.

## Import

`awsApigatewayv2ApiMapping` can be imported by using the API mapping identifier and domain name, e.g.,

```console
$ terraform import aws_apigatewayv2_api_mapping.example 1122334/ws-api.example.com
```
