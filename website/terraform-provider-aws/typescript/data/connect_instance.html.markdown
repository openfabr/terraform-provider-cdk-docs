---
subcategory: "Connect"
layout: "aws"
page_title: "AWS: aws_connect_instance"
description: |-
  Provides details about a specific Connect Instance.
---

# Data Source: awsConnectInstance

Provides details about a specific Amazon Connect Instance.

## Example Usage

By instance\_alias

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsConnectInstance.DataAwsConnectInstance(this, "foo", {
  instanceAlias: "foo",
});

```

By instance\_id

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsConnectInstance.DataAwsConnectInstance(this, "foo", {
  instanceId: "97afc98d-101a-ba98-ab97-ae114fc115ec",
});

```

## Argument Reference

\~> **NOTE:** One of either `instanceId` or `instanceAlias` is required.

The following arguments are supported:

*   `instanceId` - (Optional) Returns information on a specific connect instance by id

*   `instanceAlias` - (Optional) Returns information on a specific connect instance by alias

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `createdTime` - When the instance was created.
* `arn` - ARN of the instance.
* `identityManagementType` - Specifies The identity management type attached to the instance.
* `inboundCallsEnabled` - Whether inbound calls are enabled.
* `outboundCallsEnabled` - Whether outbound calls are enabled.
* `earlyMediaEnabled` - Whether early media for outbound calls is enabled .
* `contactFlowLogsEnabled` - Whether contact flow logs are enabled.
* `contactLensEnabled` - Whether contact lens is enabled.
* `autoResolveBestVoices` - Whether auto resolve best voices is enabled.
* `multiPartyConferenceEnabled` - Whether multi-party calls/conference is enabled.
* `useCustomTtsVoices` - Whether use custom tts voices is enabled.
* `status` - State of the instance.
* `serviceRole` - Service role of the instance.
