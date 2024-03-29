---
subcategory: "Spring Cloud"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_spring_cloud_gateway"
description: |-
  Manages a Spring Cloud Gateway.
---

# azurermSpringCloudGateway

\-> **NOTE:** This resource is applicable only for Spring Cloud Service with enterprise tier.

Manages a Spring Cloud Gateway.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
new azurerm.provider.AzurermProvider(this, "azurerm", {
  features: [{}],
});
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example",
  {
    location: "West Europe",
    name: "example",
  }
);
const azurermSpringCloudServiceExample =
  new azurerm.springCloudService.SpringCloudService(this, "example_2", {
    location: azurermResourceGroupExample.location,
    name: "example",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "E0",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSpringCloudServiceExample.overrideLogicalId("example");
const azurermSpringCloudGatewayExample =
  new azurerm.springCloudGateway.SpringCloudGateway(this, "example_3", {
    api_metadata: [
      {
        description: "example description",
        documentation_url: "https://www.example.com/docs",
        server_url: "https://wwww.example.com",
        title: "example title",
        version: "1.0",
      },
    ],
    cors: [
      {
        allowed_headers: ["*"],
        allowed_methods: ["PUT"],
        allowed_origins: ["example.com"],
        credentials_allowed: false,
        exposed_headers: ["x-example-header"],
        max_age_seconds: 86400,
      },
    ],
    https_only: false,
    instance_count: 2,
    name: "default",
    public_network_access_enabled: true,
    quota: [
      {
        cpu: "1",
        memory: "2Gi",
      },
    ],
    spring_cloud_service_id: azurermSpringCloudServiceExample.id,
    sso: [
      {
        client_id: "example id",
        client_secret: "example secret",
        issuer_uri: "https://www.test.com/issueToken",
        scope: ["read"],
      },
    ],
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSpringCloudGatewayExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this Spring Cloud Gateway. Changing this forces a new Spring Cloud Gateway to be created. The only possible value is `default`.

*   `springCloudServiceId` - (Required) The ID of the Spring Cloud Service. Changing this forces a new Spring Cloud Gateway to be created.

***

*   `apiMetadata` - (Optional) A `apiMetadata` block as defined below.

*   `applicationPerformanceMonitoringTypes` - (Optional) Specifies a list of application performance monitoring types used in the Spring Cloud Gateway. The allowed values are `appDynamics`, `applicationInsights`, `dynatrace`, `elasticApm` and `newRelic`.

*   `cors` - (Optional) A `cors` block as defined below.

*   `environmentVariables` - (Optional) Specifies the environment variables of the Spring Cloud Gateway as a map of key-value pairs. Changing this forces a new resource to be created.

*   `httpsOnly` - (Optional) is only https is allowed?

*   `instanceCount` - (Optional) Specifies the required instance count of the Spring Cloud Gateway. Possible Values are between `1` and `500`. Defaults to `1` if not specified.

*   `publicNetworkAccessEnabled` - (Optional) Indicates whether the Spring Cloud Gateway exposes endpoint.

*   `quota` - (Optional) A `quota` block as defined below.

*   `sensitiveEnvironmentVariables` - (Optional) Specifies the sensitive environment variables of the Spring Cloud Gateway as a map of key-value pairs. Changing this forces a new resource to be created.

*   `sso` - (Optional) A `sso` block as defined below.

***

A `apiMetadata` block supports the following:

*   `description` - (Optional) Detailed description of the APIs available on the Gateway instance.

*   `documentationUrl` - (Optional) Location of additional documentation for the APIs available on the Gateway instance.

*   `serverUrl` - (Optional) Base URL that API consumers will use to access APIs on the Gateway instance.

*   `title` - (Optional) Specifies the title describing the context of the APIs available on the Gateway instance.

*   `version` - (Optional) Specifies the version of APIs available on this Gateway instance.

***

A `cors` block supports the following:

*   `credentialsAllowed` - (Optional) is user credentials are supported on cross-site requests?

*   `allowedHeaders` - (Optional) Allowed headers in cross-site requests. The special value `*` allows actual requests to send any header.

*   `allowedMethods` - (Optional) Allowed HTTP methods on cross-site requests. The special value `*` allows all methods. If not set, `get` and `head` are allowed by default. Possible values are `delete`, `get`, `head`, `merge`, `post`, `options` and `put`.

*   `allowedOrigins` - (Optional) Allowed origins to make cross-site requests. The special value `*` allows all domains.

*   `exposedHeaders` - (Optional) HTTP response headers to expose for cross-site requests.

*   `maxAgeSeconds` - (Optional) How long, in seconds, the response from a pre-flight request can be cached by clients.

***

The `quota` block supports the following:

* `cpu` - (Optional) Specifies the required cpu of the Spring Cloud Deployment. Possible Values are `500M`, `1`, `2`, `3` and `4`. Defaults to `1` if not specified.

\-> **Note:** `cpu` supports `500M` and `1` for Basic tier, `500M`, `1`, `2`, `3` and `4` for Standard tier.

* `memory` - (Optional) Specifies the required memory size of the Spring Cloud Deployment. Possible Values are `512Mi`, `1Gi`, `2Gi`, `3Gi`, `4Gi`, `5Gi`, `6Gi`, `7Gi`, and `8Gi`. Defaults to `1Gi` if not specified.

\-> **Note:** `memory` supports `512Mi`, `1Gi` and `2Gi` for Basic tier, `512Mi`, `1Gi`, `2Gi`, `3Gi`, `4Gi`, `5Gi`, `6Gi`, `7Gi`, and `8Gi` for Standard tier.

***

A `sso` block supports the following:

*   `clientId` - (Optional) The public identifier for the application.

*   `clientSecret` - (Optional) The secret known only to the application and the authorization server.

*   `issuerUri` - (Optional) The URI of Issuer Identifier.

*   `scope` - (Optional) It defines the specific actions applications can be allowed to do on a user's behalf.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Spring Cloud Gateway.

*   `url` - URL of the Spring Cloud Gateway, exposed when 'public\_network\_access\_enabled' is true.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Spring Cloud Gateway.
* `read` - (Defaults to 5 minutes) Used when retrieving the Spring Cloud Gateway.
* `update` - (Defaults to 30 minutes) Used when updating the Spring Cloud Gateway.
* `delete` - (Defaults to 30 minutes) Used when deleting the Spring Cloud Gateway.

## Import

Spring Cloud Gateways can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_spring_cloud_gateway.example /subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/resourceGroup1/providers/Microsoft.AppPlatform/spring/service1/gateways/gateway1
```
