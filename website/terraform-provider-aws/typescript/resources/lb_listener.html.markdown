---
subcategory: "ELB (Elastic Load Balancing)"
layout: "aws"
page_title: "AWS: aws_lb_listener"
description: |-
  Provides a Load Balancer Listener resource.
---

# Resource: awsLbListener

Provides a Load Balancer Listener resource.

\~> **Note:** `awsAlbListener` is known as `awsLbListener`. The functionality is identical.

## Example Usage

### Forward Action

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsLbFrontEnd = new aws.lb.Lb(this, "front_end", {});
const awsLbTargetGroupFrontEnd = new aws.lbTargetGroup.LbTargetGroup(
  this,
  "front_end_1",
  {}
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsLbTargetGroupFrontEnd.overrideLogicalId("front_end");
const awsLbListenerFrontEnd = new aws.lbListener.LbListener(
  this,
  "front_end_2",
  {
    certificateArn:
      "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4",
    defaultAction: [
      {
        targetGroupArn: awsLbTargetGroupFrontEnd.arn,
        type: "forward",
      },
    ],
    loadBalancerArn: awsLbFrontEnd.arn,
    port: "443",
    protocol: "HTTPS",
    sslPolicy: "ELBSecurityPolicy-2016-08",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsLbListenerFrontEnd.overrideLogicalId("front_end");

```

To a NLB:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.lbListener.LbListener(this, "front_end", {
  alpnPolicy: "HTTP2Preferred",
  certificateArn:
    "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4",
  defaultAction: [
    {
      targetGroupArn: "${aws_lb_target_group.front_end.arn}",
      type: "forward",
    },
  ],
  loadBalancerArn: "${aws_lb.front_end.arn}",
  port: "443",
  protocol: "TLS",
});

```

### Redirect Action

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsLbFrontEnd = new aws.lb.Lb(this, "front_end", {});
const awsLbListenerFrontEnd = new aws.lbListener.LbListener(
  this,
  "front_end_1",
  {
    defaultAction: [
      {
        redirect: {
          port: "443",
          protocol: "HTTPS",
          statusCode: "HTTP_301",
        },
        type: "redirect",
      },
    ],
    loadBalancerArn: awsLbFrontEnd.arn,
    port: "80",
    protocol: "HTTP",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsLbListenerFrontEnd.overrideLogicalId("front_end");

```

### Fixed-response Action

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsLbFrontEnd = new aws.lb.Lb(this, "front_end", {});
const awsLbListenerFrontEnd = new aws.lbListener.LbListener(
  this,
  "front_end_1",
  {
    defaultAction: [
      {
        fixedResponse: {
          contentType: "text/plain",
          messageBody: "Fixed response content",
          statusCode: "200",
        },
        type: "fixed-response",
      },
    ],
    loadBalancerArn: awsLbFrontEnd.arn,
    port: "80",
    protocol: "HTTP",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsLbListenerFrontEnd.overrideLogicalId("front_end");

```

### Authenticate-cognito Action

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsCognitoUserPoolPool = new aws.cognitoUserPool.CognitoUserPool(
  this,
  "pool",
  {}
);
const awsCognitoUserPoolClientClient =
  new aws.cognitoUserPoolClient.CognitoUserPoolClient(this, "client", {});
const awsCognitoUserPoolDomainDomain =
  new aws.cognitoUserPoolDomain.CognitoUserPoolDomain(this, "domain", {});
const awsLbFrontEnd = new aws.lb.Lb(this, "front_end", {});
const awsLbTargetGroupFrontEnd = new aws.lbTargetGroup.LbTargetGroup(
  this,
  "front_end_4",
  {}
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsLbTargetGroupFrontEnd.overrideLogicalId("front_end");
const awsLbListenerFrontEnd = new aws.lbListener.LbListener(
  this,
  "front_end_5",
  {
    defaultAction: [
      {
        authenticateCognito: {
          userPoolArn: awsCognitoUserPoolPool.arn,
          userPoolClientId: awsCognitoUserPoolClientClient.id,
          userPoolDomain: awsCognitoUserPoolDomainDomain.domain,
        },
        type: "authenticate-cognito",
      },
      {
        targetGroupArn: awsLbTargetGroupFrontEnd.arn,
        type: "forward",
      },
    ],
    loadBalancerArn: awsLbFrontEnd.arn,
    port: "80",
    protocol: "HTTP",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsLbListenerFrontEnd.overrideLogicalId("front_end");

```

### Authenticate-OIDC Action

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsLbFrontEnd = new aws.lb.Lb(this, "front_end", {});
const awsLbTargetGroupFrontEnd = new aws.lbTargetGroup.LbTargetGroup(
  this,
  "front_end_1",
  {}
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsLbTargetGroupFrontEnd.overrideLogicalId("front_end");
const awsLbListenerFrontEnd = new aws.lbListener.LbListener(
  this,
  "front_end_2",
  {
    defaultAction: [
      {
        authenticateOidc: {
          authorizationEndpoint: "https://example.com/authorization_endpoint",
          clientId: "client_id",
          clientSecret: "client_secret",
          issuer: "https://example.com",
          tokenEndpoint: "https://example.com/token_endpoint",
          userInfoEndpoint: "https://example.com/user_info_endpoint",
        },
        type: "authenticate-oidc",
      },
      {
        targetGroupArn: awsLbTargetGroupFrontEnd.arn,
        type: "forward",
      },
    ],
    loadBalancerArn: awsLbFrontEnd.arn,
    port: "80",
    protocol: "HTTP",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsLbListenerFrontEnd.overrideLogicalId("front_end");

```

### Gateway Load Balancer Listener

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsLbExample = new aws.lb.Lb(this, "example", {
  loadBalancerType: "gateway",
  name: "example",
  subnetMapping: [
    {
      subnetId: "${aws_subnet.example.id}",
    },
  ],
});
const awsLbTargetGroupExample = new aws.lbTargetGroup.LbTargetGroup(
  this,
  "example_1",
  {
    healthCheck: {
      port: 80,
      protocol: "HTTP",
    },
    name: "example",
    port: 6081,
    protocol: "GENEVE",
    vpcId: "${aws_vpc.example.id}",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsLbTargetGroupExample.overrideLogicalId("example");
const awsLbListenerExample = new aws.lbListener.LbListener(this, "example_2", {
  defaultAction: [
    {
      targetGroupArn: awsLbTargetGroupExample.id,
      type: "forward",
    },
  ],
  loadBalancerArn: awsLbExample.id,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsLbListenerExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are required:

* `defaultAction` - (Required) Configuration block for default actions. Detailed below.
* `loadBalancerArn` - (Required, Forces New Resource) ARN of the load balancer.

The following arguments are optional:

* `alpnPolicy` - (Optional)  Name of the Application-Layer Protocol Negotiation (ALPN) policy. Can be set if `protocol` is `tls`. Valid values are `http1Only`, `http2Only`, `http2Optional`, `http2Preferred`, and `none`.
* `certificateArn` - (Optional) ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS. For adding additional SSL certificates, see the [`awsLbListenerCertificate` resource](/docs/providers/aws/r/lb_listener_certificate.html).
* `port` - (Optional) Port on which the load balancer is listening. Not valid for Gateway Load Balancers.
* `protocol` - (Optional) Protocol for connections from clients to the load balancer. For Application Load Balancers, valid values are `http` and `https`, with a default of `http`. For Network Load Balancers, valid values are `tcp`, `tls`, `udp`, and `TCP_UDP`. Not valid to use `udp` or `TCP_UDP` if dual-stack mode is enabled. Not valid for Gateway Load Balancers.
* `sslPolicy` - (Optional) Name of the SSL Policy for the listener. Required if `protocol` is `https` or `tls`.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

\~> **NOTE::** Please note that listeners that are attached to Application Load Balancers must use either `http` or `https` protocols while listeners that are attached to Network Load Balancers must use the `tcp` protocol.

### defaultAction

The following arguments are required:

* `type` - (Required) Type of routing action. Valid values are `forward`, `redirect`, `fixedResponse`, `authenticateCognito` and `authenticateOidc`.

The following arguments are optional:

* `authenticateCognito` - (Optional) Configuration block for using Amazon Cognito to authenticate users. Specify only when `type` is `authenticateCognito`. Detailed below.
* `authenticateOidc` - (Optional) Configuration block for an identity provider that is compliant with OpenID Connect (OIDC). Specify only when `type` is `authenticateOidc`. Detailed below.
* `fixedResponse` - (Optional) Information for creating an action that returns a custom HTTP response. Required if `type` is `fixedResponse`.
* `forward` - (Optional) Configuration block for creating an action that distributes requests among one or more target groups. Specify only if `type` is `forward`. If you specify both `forward` block and `targetGroupArn` attribute, you can specify only one target group using `forward` and it must be the same target group specified in `targetGroupArn`. Detailed below.
* `order` - (Optional) Order for the action. This value is required for rules with multiple actions. The action with the lowest value for order is performed first. Valid values are between `1` and `50000`.
* `redirect` - (Optional) Configuration block for creating a redirect action. Required if `type` is `redirect`. Detailed below.
* `targetGroupArn` - (Optional) ARN of the Target Group to which to route traffic. Specify only if `type` is `forward` and you want to route to a single target group. To route to one or more target groups, use a `forward` block instead.

#### authenticateCognito

The following arguments are required:

* `userPoolArn` - (Required) ARN of the Cognito user pool.
* `userPoolClientId` - (Required) ID of the Cognito user pool client.
* `userPoolDomain` - (Required) Domain prefix or fully-qualified domain name of the Cognito user pool.

The following arguments are optional:

* `authenticationRequestExtraParams` - (Optional) Query parameters to include in the redirect request to the authorization endpoint. Max: 10. Detailed below.
* `onUnauthenticatedRequest` - (Optional) Behavior if the user is not authenticated. Valid values are `deny`, `allow` and `authenticate`.
* `scope` - (Optional) Set of user claims to be requested from the IdP.
* `sessionCookieName` - (Optional) Name of the cookie used to maintain session information.
* `sessionTimeout` - (Optional) Maximum duration of the authentication session, in seconds.

##### authenticationRequestExtraParams

* `key` - (Required) Key of query parameter.
* `value` - (Required) Value of query parameter.

#### authenticateOidc

The following arguments are required:

* `authorizationEndpoint` - (Required) Authorization endpoint of the IdP.
* `clientId` - (Required) OAuth 2.0 client identifier.
* `clientSecret` - (Required) OAuth 2.0 client secret.
* `issuer` - (Required) OIDC issuer identifier of the IdP.
* `tokenEndpoint` - (Required) Token endpoint of the IdP.
* `userInfoEndpoint` - (Required) User info endpoint of the IdP.

The following arguments are optional:

* `authenticationRequestExtraParams` - (Optional) Query parameters to include in the redirect request to the authorization endpoint. Max: 10.
* `onUnauthenticatedRequest` - (Optional) Behavior if the user is not authenticated. Valid values: `deny`, `allow` and `authenticate`
* `scope` - (Optional) Set of user claims to be requested from the IdP.
* `sessionCookieName` - (Optional) Name of the cookie used to maintain session information.
* `sessionTimeout` - (Optional) Maximum duration of the authentication session, in seconds.

#### fixedResponse

The following arguments are required:

* `contentType` - (Required) Content type. Valid values are `text/plain`, `text/css`, `text/html`, `application/javascript` and `application/json`.

The following arguments are optional:

* `messageBody` - (Optional) Message body.
* `statusCode` - (Optional) HTTP response code. Valid values are `2Xx`, `4Xx`, or `5Xx`.

#### forward

The following arguments are required:

* `targetGroup` - (Required) Set of 1-5 target group blocks. Detailed below.

The following arguments are optional:

* `stickiness` - (Optional) Configuration block for target group stickiness for the rule. Detailed below.

##### targetGroup

The following arguments are required:

* `arn` - (Required) ARN of the target group.

The following arguments are optional:

* `weight` - (Optional) Weight. The range is 0 to 999.

##### stickiness

The following arguments are required:

* `duration` - (Required) Time period, in seconds, during which requests from a client should be routed to the same target group. The range is 1-604800 seconds (7 days).

The following arguments are optional:

* `enabled` - (Optional) Whether target group stickiness is enabled. Default is `false`.

#### redirect

\~> **NOTE::** You can reuse URI components using the following reserved keywords: `#{protocol}`, `#{host}`, `#{port}`, `#{path}` (the leading "/" is removed) and `#{query}`.

The following arguments are required:

* `statusCode` - (Required) HTTP redirect code. The redirect is either permanent (`HTTP_301`) or temporary (`HTTP_302`).

The following arguments are optional:

* `host` - (Optional) Hostname. This component is not percent-encoded. The hostname can contain `#{host}`. Defaults to `#{host}`.
* `path` - (Optional) Absolute path, starting with the leading "/". This component is not percent-encoded. The path can contain #{host}, #{path}, and #{port}. Defaults to `/#{path}`.
* `port` - (Optional) Port. Specify a value from `1` to `65535` or `#{port}`. Defaults to `#{port}`.
* `protocol` - (Optional) Protocol. Valid values are `http`, `https`, or `#{protocol}`. Defaults to `#{protocol}`.
* `query` - (Optional) Query parameters, URL-encoded when necessary, but not percent-encoded. Do not include the leading "?". Defaults to `#{query}`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the listener (matches `id`).
* `id` - ARN of the listener (matches `arn`).
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Listeners can be imported using their ARN, e.g.,

```console
$ terraform import aws_lb_listener.front_end arn:aws:elasticloadbalancing:us-west-2:187416307283:listener/app/front-end-alb/8e4497da625e2d8a/9ab28ade35828f96
```
