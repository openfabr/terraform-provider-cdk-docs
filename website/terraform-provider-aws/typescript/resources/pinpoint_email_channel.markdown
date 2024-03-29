---
subcategory: "Pinpoint"
layout: "aws"
page_title: "AWS: aws_pinpoint_email_channel"
description: |-
  Provides a Pinpoint Email Channel resource.
---

# Resource: awsPinpointEmailChannel

Provides a Pinpoint Email Channel resource.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsPinpointAppApp = new aws.pinpointApp.PinpointApp(this, "app", {});
new aws.sesDomainIdentity.SesDomainIdentity(this, "identity", {
  domain: "example.com",
});
const dataAwsIamPolicyDocumentAssumeRole =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "assume_role",
    {
      statement: [
        {
          actions: ["sts:AssumeRole"],
          effect: "Allow",
          principals: [
            {
              identifiers: ["pinpoint.amazonaws.com"],
              type: "Service",
            },
          ],
        },
      ],
    }
  );
const dataAwsIamPolicyDocumentRolePolicy =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "role_policy",
    {
      statement: [
        {
          actions: ["mobileanalytics:PutEvents", "mobileanalytics:PutItems"],
          effect: "Allow",
          resources: ["*"],
        },
      ],
    }
  );
const awsIamRoleRole = new aws.iamRole.IamRole(this, "role", {
  assumeRolePolicy: dataAwsIamPolicyDocumentAssumeRole.json,
});
const awsIamRolePolicyRolePolicy = new aws.iamRolePolicy.IamRolePolicy(
  this,
  "role_policy_5",
  {
    name: "role_policy",
    policy: dataAwsIamPolicyDocumentRolePolicy.json,
    role: awsIamRoleRole.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamRolePolicyRolePolicy.overrideLogicalId("role_policy");
new aws.pinpointEmailChannel.PinpointEmailChannel(this, "email", {
  applicationId: awsPinpointAppApp.applicationId,
  fromAddress: "user@example.com",
  roleArn: awsIamRoleRole.arn,
});

```

## Argument Reference

The following arguments are supported:

* `applicationId` - (Required) The application ID.
* `enabled` - (Optional) Whether the channel is enabled or disabled. Defaults to `true`.
* `configurationSet` - (Optional) The ARN of the Amazon SES configuration set that you want to apply to messages that you send through the channel.
* `fromAddress` - (Required) The email address used to send emails from. You can use email only (`user@exampleCom`) or friendly address (`user <user@exampleCom>`). This field comply with [RFC 5322](https://www.ietf.org/rfc/rfc5322.txt).
* `identity` - (Required) The ARN of an identity verified with SES.
* `roleArn` - (Optional) The ARN of an IAM Role used to submit events to Mobile Analytics' event ingestion service.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `messagesPerSecond` - Messages per second that can be sent.

## Import

Pinpoint Email Channel can be imported using the `applicationId`, e.g.,

```console
$ terraform import aws_pinpoint_email_channel.email application-id
```
