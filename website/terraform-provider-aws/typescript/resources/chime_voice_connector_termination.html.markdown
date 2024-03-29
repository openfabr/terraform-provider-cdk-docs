---
subcategory: "Chime"
layout: "aws"
page_title: "AWS: aws_chime_voice_connector_termination"
description: |-
    Enable Termination settings to control outbound calling from your SIP infrastructure.
---

# Resource: awsChimeVoiceConnectorTermination

Enable Termination settings to control outbound calling from your SIP infrastructure.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsChimeVoiceConnectorDefault =
  new aws.chimeVoiceConnector.ChimeVoiceConnector(this, "default", {
    name: "vc-name-test",
    requireEncryption: true,
  });
const awsChimeVoiceConnectorTerminationDefault =
  new aws.chimeVoiceConnectorTermination.ChimeVoiceConnectorTermination(
    this,
    "default_1",
    {
      callingRegions: ["US", "CA"],
      cidrAllowList: ["50.35.78.96/31"],
      cpsLimit: 1,
      disabled: false,
      voiceConnectorId: awsChimeVoiceConnectorDefault.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsChimeVoiceConnectorTerminationDefault.overrideLogicalId("default");

```

## Argument Reference

The following arguments are supported:

* `voiceConnectorId` - (Required) The Amazon Chime Voice Connector ID.
* `cidrAllowList` - (Required) The IP addresses allowed to make calls, in CIDR format.
* `callingRegions` - (Required) The countries to which calls are allowed, in ISO 3166-1 alpha-2 format.
* `disabled` - (Optional) When termination settings are disabled, outbound calls can not be made.
* `defaultPhoneNumber` - (Optional) The default caller ID phone number.
* `cpsLimit` - (Optional) The limit on calls per second. Max value based on account service quota. Default value of `1`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The Amazon Chime Voice Connector ID.

## Import

Chime Voice Connector Termination can be imported using the `voiceConnectorId`, e.g.,

```console
$ terraform import aws_chime_voice_connector_termination.default abcdef1ghij2klmno3pqr4
```
