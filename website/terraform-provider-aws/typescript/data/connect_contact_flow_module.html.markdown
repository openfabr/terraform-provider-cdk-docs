---
subcategory: "Connect"
layout: "aws"
page_title: "AWS: aws_connect_contact_flow_module"
description: |-
  Provides details about a specific Amazon Connect Contact Flow Module.
---

# Data Source: awsConnectContactFlowModule

Provides details about a specific Amazon Connect Contact Flow Module.

## Example Usage

By `name`

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsConnectContactFlowModule.DataAwsConnectContactFlowModule(
  this,
  "example",
  {
    instanceId: "aaaaaaaa-bbbb-cccc-dddd-111111111111",
    name: "example",
  }
);

```

By `contactFlowModuleId`

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsConnectContactFlowModule.DataAwsConnectContactFlowModule(
  this,
  "example",
  {
    contactFlowModuleId: "cccccccc-bbbb-cccc-dddd-111111111111",
    instanceId: "aaaaaaaa-bbbb-cccc-dddd-111111111111",
  }
);

```

## Argument Reference

\~> **NOTE:** `instanceId` and one of either `name` or `contactFlowModuleId` is required.

The following arguments are supported:

* `contactFlowModuleId` - (Optional) Returns information on a specific Contact Flow Module by contact flow module id
* `instanceId` - (Required) Reference to the hosting Amazon Connect Instance
* `name` - (Optional) Returns information on a specific Contact Flow Module by name

## Attributes Reference

In addition to all of the arguments above, the following attributes are exported:

* `arn` - ARN of the Contact Flow Module.
* `content` - Logic of the Contact Flow Module.
* `description` - Description of the Contact Flow Module.
* `tags` - Map of tags to assign to the Contact Flow Module.
* `state` - Type of Contact Flow Module Module. Values are either `active` or `archived`.
* `status` - Status of the Contact Flow Module Module. Values are either `published` or `saved`.
