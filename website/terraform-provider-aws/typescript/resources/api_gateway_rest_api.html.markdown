---
subcategory: "API Gateway"
layout: "aws"
page_title: "AWS: aws_api_gateway_rest_api"
description: |-
  Manages an API Gateway REST API.
---

# Resource: awsApiGatewayRestApi

Manages an API Gateway REST API. The REST API can be configured via [importing an OpenAPI specification](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-import-api.html) in the `body` argument (with other arguments serving as overrides) or via other Terraform resources to manage the resources ([`awsApiGatewayResource` resource](api_gateway_resource.html)), methods ([`awsApiGatewayMethod` resource](api_gateway_method.html)), integrations ([`awsApiGatewayIntegration` resource](api_gateway_integration.html)), etc. of the REST API. Once the REST API is configured, the [`awsApiGatewayDeployment` resource](api_gateway_deployment.html) can be used along with the [`awsApiGatewayStage` resource](api_gateway_stage.html) to publish the REST API.

\-> **Note:** Amazon API Gateway Version 1 resources are used for creating and deploying REST APIs. To create and deploy WebSocket and HTTP APIs, use Amazon API Gateway Version 2 [resources](/docs/providers/aws/r/apigatewayv2_api.html).

!> **WARN:** When importing Open API Specifications with the `body` argument, by default the API Gateway REST API will be replaced with the Open API Specification thus removing any existing methods, resources, integrations, or endpoints. Endpoint mutations are asynchronous operations, and race conditions with DNS are possible. To overcome this limitation, use the `putRestApiMode` attribute and set it to `merge`.

## Example Usage

### OpenAPI Specification

An end-to-end example of a REST API configured with OpenAPI can be found in the [`/examples/apiGatewayRestApiOpenapi` directory within the GitHub repository](https://github.com/hashicorp/terraform-provider-aws/tree/main/examples/api-gateway-rest-api-openapi).

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsApiGatewayRestApiExample = new aws.apiGatewayRestApi.ApiGatewayRestApi(
  this,
  "example",
  {
    body: '${jsonencode({\n    openapi = "3.0.1"\n    info = {\n      title   = "example"\n      version = "1.0"\n    }\n    paths = {\n      "/path1" = {\n        get = {\n          x-amazon-apigateway-integration = {\n            httpMethod           = "GET"\n            payloadFormatVersion = "1.0"\n            type                 = "HTTP_PROXY"\n            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"\n          }\n        }\n      }\n    }\n  })}',
    endpointConfiguration: {
      types: ["REGIONAL"],
    },
    name: "example",
  }
);
const awsApiGatewayDeploymentExample =
  new aws.apiGatewayDeployment.ApiGatewayDeployment(this, "example_1", {
    restApiId: awsApiGatewayRestApiExample.id,
    triggers: {
      redeployment: `\${sha1(jsonencode(${awsApiGatewayRestApiExample.body}))}`,
    },
  });
awsApiGatewayDeploymentExample.addOverride("lifecycle", [
  {
    create_before_destroy: true,
  },
]);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsApiGatewayDeploymentExample.overrideLogicalId("example");
const awsApiGatewayStageExample = new aws.apiGatewayStage.ApiGatewayStage(
  this,
  "example_2",
  {
    deploymentId: awsApiGatewayDeploymentExample.id,
    restApiId: awsApiGatewayRestApiExample.id,
    stageName: "example",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsApiGatewayStageExample.overrideLogicalId("example");

```

### OpenAPI Specification with Private Endpoints

Using `putRestApiMode` = `merge` when importing the OpenAPI Specification, the AWS control plane will not delete all existing literal properties that are not explicitly set in the OpenAPI definition. Impacted API Gateway properties: ApiKeySourceType, BinaryMediaTypes, Description, EndpointConfiguration, MinimumCompressionSize, Name, Policy).

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsVpcExample = new aws.vpc.Vpc(this, "example", {
  cidrBlock: "10.0.0.0/16",
  enableDnsHostnames: true,
  enableDnsSupport: true,
});
const dataAwsAvailabilityZonesAvailable =
  new aws.dataAwsAvailabilityZones.DataAwsAvailabilityZones(this, "available", {
    filter: [
      {
        name: "opt-in-status",
        values: ["opt-in-not-required"],
      },
    ],
    state: "available",
  });
const dataAwsRegionCurrent = new aws.dataAwsRegion.DataAwsRegion(
  this,
  "current",
  {}
);
const awsDefaultSecurityGroupExample =
  new aws.defaultSecurityGroup.DefaultSecurityGroup(this, "example_3", {
    vpcId: awsVpcExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsDefaultSecurityGroupExample.overrideLogicalId("example");
const awsSubnetExample = new aws.subnet.Subnet(this, "example_4", {
  availabilityZone: `\${${dataAwsAvailabilityZonesAvailable.names.fqn}[0]}`,
  cidrBlock: `\${cidrsubnet(${awsVpcExample.cidrBlock}, 8, 0)}`,
  vpcId: awsVpcExample.id,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsSubnetExample.overrideLogicalId("example");
const awsVpcEndpointExample = new aws.vpcEndpoint.VpcEndpoint(
  this,
  "example_5",
  {
    privateDnsEnabled: false,
    securityGroupIds: [awsDefaultSecurityGroupExample.id],
    serviceName: `com.amazonaws.\${${dataAwsRegionCurrent.name}}.execute-api`,
    subnetIds: [awsSubnetExample.id],
    vpcEndpointType: "Interface",
    vpcId: awsVpcExample.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsVpcEndpointExample.overrideLogicalId("example");
/*In most cases loops should be handled in the programming language context and 
not inside of the Terraform context. If you are looping over something external, e.g. a variable or a file input
you should consider using a for loop. If you are looping over something only known to Terraform, e.g. a result of a data source
you need to keep this like it is.*/
awsVpcEndpointExample.addOverride("count", 3);
const awsApiGatewayRestApiExample = new aws.apiGatewayRestApi.ApiGatewayRestApi(
  this,
  "example_6",
  {
    body: '${jsonencode({\n    openapi = "3.0.1"\n    info = {\n      title   = "example"\n      version = "1.0"\n    }\n    paths = {\n      "/path1" = {\n        get = {\n          x-amazon-apigateway-integration = {\n            httpMethod           = "GET"\n            payloadFormatVersion = "1.0"\n            type                 = "HTTP_PROXY"\n            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"\n          }\n        }\n      }\n    }\n  })}',
    endpointConfiguration: {
      types: ["PRIVATE"],
      vpcEndpointIds: [
        `\${${awsVpcEndpointExample.fqn}[0].id}`,
        `\${${awsVpcEndpointExample.fqn}[1].id}`,
        `\${${awsVpcEndpointExample.fqn}[2].id}`,
      ],
    },
    name: "example",
    putRestApiMode: "merge",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsApiGatewayRestApiExample.overrideLogicalId("example");
const awsApiGatewayDeploymentExample =
  new aws.apiGatewayDeployment.ApiGatewayDeployment(this, "example_7", {
    restApiId: awsApiGatewayRestApiExample.id,
    triggers: {
      redeployment: `\${sha1(jsonencode(${awsApiGatewayRestApiExample.body}))}`,
    },
  });
awsApiGatewayDeploymentExample.addOverride("lifecycle", [
  {
    create_before_destroy: true,
  },
]);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsApiGatewayDeploymentExample.overrideLogicalId("example");
const awsApiGatewayStageExample = new aws.apiGatewayStage.ApiGatewayStage(
  this,
  "example_8",
  {
    deploymentId: awsApiGatewayDeploymentExample.id,
    restApiId: awsApiGatewayRestApiExample.id,
    stageName: "example",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsApiGatewayStageExample.overrideLogicalId("example");

```

### Terraform Resources

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsApiGatewayRestApiExample = new aws.apiGatewayRestApi.ApiGatewayRestApi(
  this,
  "example",
  {
    name: "example",
  }
);
const awsApiGatewayResourceExample =
  new aws.apiGatewayResource.ApiGatewayResource(this, "example_1", {
    parentId: awsApiGatewayRestApiExample.rootResourceId,
    pathPart: "example",
    restApiId: awsApiGatewayRestApiExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsApiGatewayResourceExample.overrideLogicalId("example");
const awsApiGatewayMethodExample = new aws.apiGatewayMethod.ApiGatewayMethod(
  this,
  "example_2",
  {
    authorization: "NONE",
    httpMethod: "GET",
    resourceId: awsApiGatewayResourceExample.id,
    restApiId: awsApiGatewayRestApiExample.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsApiGatewayMethodExample.overrideLogicalId("example");
const awsApiGatewayIntegrationExample =
  new aws.apiGatewayIntegration.ApiGatewayIntegration(this, "example_3", {
    httpMethod: awsApiGatewayMethodExample.httpMethod,
    resourceId: awsApiGatewayResourceExample.id,
    restApiId: awsApiGatewayRestApiExample.id,
    type: "MOCK",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsApiGatewayIntegrationExample.overrideLogicalId("example");
const awsApiGatewayDeploymentExample =
  new aws.apiGatewayDeployment.ApiGatewayDeployment(this, "example_4", {
    restApiId: awsApiGatewayRestApiExample.id,
    triggers: {
      redeployment: `\${sha1(jsonencode([
      ${awsApiGatewayResourceExample.id},
      ${awsApiGatewayMethodExample.id},
      ${awsApiGatewayIntegrationExample.id},
    ]))}`,
    },
  });
awsApiGatewayDeploymentExample.addOverride("lifecycle", [
  {
    create_before_destroy: true,
  },
]);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsApiGatewayDeploymentExample.overrideLogicalId("example");
const awsApiGatewayStageExample = new aws.apiGatewayStage.ApiGatewayStage(
  this,
  "example_5",
  {
    deploymentId: awsApiGatewayDeploymentExample.id,
    restApiId: awsApiGatewayRestApiExample.id,
    stageName: "example",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsApiGatewayStageExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `apiKeySource` - (Optional) Source of the API key for requests. Valid values are `header` (default) and `authorizer`. If importing an OpenAPI specification via the `body` argument, this corresponds to the [`xAmazonApigatewayApiKeySource` extension](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-swagger-extensions-api-key-source.html). If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
* `binaryMediaTypes` - (Optional) List of binary media types supported by the REST API. By default, the REST API supports only UTF-8-encoded text payloads. If importing an OpenAPI specification via the `body` argument, this corresponds to the [`xAmazonApigatewayBinaryMediaTypes` extension](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-swagger-extensions-binary-media-types.html). If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
* `body` - (Optional) OpenAPI specification that defines the set of routes and integrations to create as part of the REST API. This configuration, and any updates to it, will replace all REST API configuration except values overridden in this resource configuration and other resource updates applied after this resource but before any `awsApiGatewayDeployment` creation. More information about REST API OpenAPI support can be found in the [API Gateway Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-import-api.html).
* `description` - (Optional) Description of the REST API. If importing an OpenAPI specification via the `body` argument, this corresponds to the `infoDescription` field. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
* `disableExecuteApiEndpoint` - (Optional) Whether clients can invoke your API by using the default execute-api endpoint. By default, clients can invoke your API with the default https://{api\_id}.execute-api.{region}.amazonaws.com endpoint. To require that clients use a custom domain name to invoke your API, disable the default endpoint. Defaults to `false`. If importing an OpenAPI specification via the `body` argument, this corresponds to the [`xAmazonApigatewayEndpointConfiguration` extension `disableExecuteApiEndpoint` property](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-swagger-extensions-endpoint-configuration.html). If the argument value is `true` and is different than the OpenAPI value, the argument value will override the OpenAPI value.
* `endpointConfiguration` - (Optional) Configuration block defining API endpoint configuration including endpoint type. Defined below.
* `minimumCompressionSize` - (Optional) Minimum response size to compress for the REST API. Integer between `1` and `10485760` (10MB). Setting a value greater than `1` will enable compression, `1` disables compression (default). If importing an OpenAPI specification via the `body` argument, this corresponds to the [`xAmazonApigatewayMinimumCompressionSize` extension](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-openapi-minimum-compression-size.html). If the argument value (*except* `1`) is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
* `name` - (Required) Name of the REST API. If importing an OpenAPI specification via the `body` argument, this corresponds to the `infoTitle` field. If the argument value is different than the OpenAPI value, the argument value will override the OpenAPI value.
* `parameters` - (Optional) Map of customizations for importing the specification in the `body` argument. For example, to exclude DocumentationParts from an imported API, set `ignore` equal to `documentation`. Additional documentation, including other parameters such as `basepath`, can be found in the [API Gateway Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-import-api.html).
* `policy` - (Optional) JSON formatted policy document that controls access to the API Gateway. For more information about building AWS IAM policy documents with Terraform, see the [AWS IAM Policy Document Guide](https://learn.hashicorp.com/terraform/aws/iam-policy). Terraform will only perform drift detection of its value when present in a configuration. We recommend using the [`awsApiGatewayRestApiPolicy` resource](/docs/providers/aws/r/api_gateway_rest_api_policy.html) instead. If importing an OpenAPI specification via the `body` argument, this corresponds to the [`xAmazonApigatewayPolicy` extension](https://docs.aws.amazon.com/apigateway/latest/developerguide/openapi-extensions-policy.html). If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
* `putRestApiMode` - (Optional) Mode of the PutRestApi operation when importing an OpenAPI specification via the `body` argument (create or update operation). Valid values are `merge` and `overwrite`. If unspecificed, defaults to `overwrite` (for backwards compatibility). This corresponds to the [`xAmazonApigatewayPutIntegrationMethod` extension](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-swagger-extensions-put-integration-method.html). If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

**Note**: If the `body` argument is provided, the OpenAPI specification will be used to configure the resources, methods and integrations for the Rest API. If this argument is provided, the following resources should not be managed as separate ones, as updates may cause manual resource updates to be overwritten:

* `awsApiGatewayResource`
* `awsApiGatewayMethod`
* `awsApiGatewayMethodResponse`
* `awsApiGatewayMethodSettings`
* `awsApiGatewayIntegration`
* `awsApiGatewayIntegrationResponse`
* `awsApiGatewayGatewayResponse`
* `awsApiGatewayModel`

### endpointConfiguration

* `types` - (Required) List of endpoint types. This resource currently only supports managing a single value. Valid values: `edge`, `regional` or `private`. If unspecified, defaults to `edge`. If set to `private` recommend to set `putRestApiMode` = `merge` to not cause the endpoints and associated Route53 records to be deleted. Refer to the [documentation](https://docs.aws.amazon.com/apigateway/latest/developerguide/create-regional-api.html) for more information on the difference between edge-optimized and regional APIs.
* `vpcEndpointIds` - (Optional) Set of VPC Endpoint identifiers. It is only supported for `private` endpoint type. If importing an OpenAPI specification via the `body` argument, this corresponds to the [`xAmazonApigatewayEndpointConfiguration` extension `vpcEndpointIds` property](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-swagger-extensions-endpoint-configuration.html). If the argument value is provided and is different than the OpenAPI value, **the argument value will override the OpenAPI value**.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN
* `createdDate` - Creation date of the REST API
* `executionArn` - Execution ARN part to be used in [`lambdaPermission`](/docs/providers/aws/r/lambda_permission.html)'s `sourceArn`
  when allowing API Gateway to invoke a Lambda function,
  e.g., `arn:aws:executeApi:euWest2:123456789012:z4675Bid1J`, which can be concatenated with allowed stage, method and resource path.
* `id` - ID of the REST API
* `rootResourceId` - Resource ID of the REST API's root
* `tagsAll` - Map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsApiGatewayRestApi` can be imported by using the REST API ID, e.g.,

```console
$ terraform import aws_api_gateway_rest_api.example 12345abcde
```

\~> **NOTE:** Resource import does not currently support the `body` attribute.
