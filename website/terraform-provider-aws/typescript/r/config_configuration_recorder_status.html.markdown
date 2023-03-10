---
subcategory: "Config"
layout: "aws"
page_title: "AWS: aws_config_configuration_recorder_status"
description: |-
  Manages status of an AWS Config Configuration Recorder.
---

# Resource: aws\_config\_configuration\_recorder\_status

Manages status (recording / stopped) of an AWS Config Configuration Recorder.

\~> **Note:** Starting Configuration Recorder requires a [Delivery Channel](/docs/providers/aws/r/config_delivery_channel.html) to be present. Use of `dependsOn` (as shown below) is recommended to avoid race conditions.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsIamRoleR = new aws.iamRole.IamRole(this, "r", {
  assumeRolePolicy:
    '{\n  "Version": "2012-10-17",\n  "Statement": [\n    {\n      "Action": "sts:AssumeRole",\n      "Principal": {\n        "Service": "config.amazonaws.com"\n      },\n      "Effect": "Allow",\n      "Sid": ""\n    }\n  ]\n}\n',
  name: "example-awsconfig",
});
new aws.iamRolePolicyAttachment.IamRolePolicyAttachment(this, "a", {
  policyArn: "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole",
  role: awsIamRoleR.name,
});
const awsS3BucketB = new aws.s3Bucket.S3Bucket(this, "b", {
  bucket: "awsconfig-example",
});
const awsConfigConfigurationRecorderFoo =
  new aws.configConfigurationRecorder.ConfigConfigurationRecorder(this, "foo", {
    name: "example",
    roleArn: awsIamRoleR.arn,
  });
const awsConfigDeliveryChannelFoo =
  new aws.configDeliveryChannel.ConfigDeliveryChannel(this, "foo_4", {
    name: "example",
    s3BucketName: awsS3BucketB.bucket,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsConfigDeliveryChannelFoo.overrideLogicalId("foo");
new aws.iamRolePolicy.IamRolePolicy(this, "p", {
  name: "awsconfig-example",
  policy: `{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "\${${awsS3BucketB.arn}}",
        "\${${awsS3BucketB.arn}}/*"
      ]
    }
  ]
}
`,
  role: awsIamRoleR.id,
});
const awsConfigConfigurationRecorderStatusFoo =
  new aws.configConfigurationRecorderStatus.ConfigConfigurationRecorderStatus(
    this,
    "foo_6",
    {
      depends_on: [`\${${awsConfigDeliveryChannelFoo.fqn}}`],
      isEnabled: true,
      name: awsConfigConfigurationRecorderFoo.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsConfigConfigurationRecorderStatusFoo.overrideLogicalId("foo");

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the recorder
* `isEnabled` - (Required) Whether the configuration recorder should be enabled or disabled.

## Attributes Reference

No additional attributes are exported.

## Import

Configuration Recorder Status can be imported using the name of the Configuration Recorder, e.g.,

```console
$ terraform import aws_config_configuration_recorder_status.foo example
```
