---
subcategory: "Config"
layout: "aws"
page_title: "AWS: aws_config_remediation_configuration"
description: |-
  Provides an AWS Config Remediation Configuration.
---

# Resource: awsConfigRemediationConfiguration

Provides an AWS Config Remediation Configuration.

\~> **Note:** Config Remediation Configuration requires an existing [Config Rule](/docs/providers/aws/r/config_config_rule.html) to be present.

## Example Usage

AWS managed rules can be used by setting the source owner to `aws` and the source identifier to the name of the managed rule. More information about AWS managed rules can be found in the [AWS Config Developer Guide](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_use-managed-rules.html).

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsConfigConfigRuleThis = new aws.configConfigRule.ConfigConfigRule(
  this,
  "this",
  {
    name: "example",
    source: {
      owner: "AWS",
      sourceIdentifier: "S3_BUCKET_VERSIONING_ENABLED",
    },
  }
);
const awsConfigRemediationConfigurationThis =
  new aws.configRemediationConfiguration.ConfigRemediationConfiguration(
    this,
    "this_1",
    {
      automatic: true,
      configRuleName: awsConfigConfigRuleThis.name,
      executionControls: {
        ssmControls: {
          concurrentExecutionRatePercentage: 25,
          errorPercentage: 20,
        },
      },
      maximumAutomaticAttempts: 10,
      parameter: [
        {
          name: "AutomationAssumeRole",
          staticValue: "arn:aws:iam::875924563244:role/security_config",
        },
        {
          name: "BucketName",
          resourceValue: "RESOURCE_ID",
        },
        {
          name: "SSEAlgorithm",
          staticValue: "AES256",
        },
      ],
      resourceType: "AWS::S3::Bucket",
      retryAttemptSeconds: 600,
      targetId: "AWS-EnableS3BucketEncryption",
      targetType: "SSM_DOCUMENT",
      targetVersion: "1",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsConfigRemediationConfigurationThis.overrideLogicalId("this");

```

## Argument Reference

The following arguments are required:

* `configRuleName` - (Required) Name of the AWS Config rule.
* `targetId` - (Required) Target ID is the name of the public document.
* `targetType` - (Required) Type of the target. Target executes remediation. For example, SSM document.

The following arguments are optional:

* `automatic` - (Optional) Remediation is triggered automatically if `true`.
* `executionControls` - (Optional) Configuration block for execution controls. See below.
* `maximumAutomaticAttempts` - (Optional) Maximum number of failed attempts for auto-remediation. If you do not select a number, the default is 5.
* `parameter` - (Optional) Can be specified multiple times for each parameter. Each parameter block supports arguments below.
* `resourceType` - (Optional) Type of resource.
* `retryAttemptSeconds` - (Optional) Maximum time in seconds that AWS Config runs auto-remediation. If you do not select a number, the default is 60 seconds.
* `targetVersion` - (Optional) Version of the target. For example, version of the SSM document

### `executionControls`

* `ssmControls` - (Required) Configuration block for SSM controls. See below.

#### `ssmControls`

One or both of these values are required.

* `concurrentExecutionRatePercentage` - (Optional) Maximum percentage of remediation actions allowed to run in parallel on the non-compliant resources for that specific rule. The default value is 10%.
* `errorPercentage` - (Optional) Percentage of errors that are allowed before SSM stops running automations on non-compliant resources for that specific rule. The default is 50%.

### `parameter`

The value is either a dynamic (resource) value or a static value. You must select either a dynamic value or a static value.

* `name` - (Required) Name of the attribute.
* `resourceValue` - (Optional) Value is dynamic and changes at run-time.
* `staticValue` - (Optional) Value is static and does not change at run-time.
* `staticValues` - (Optional) List of static values.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the Config Remediation Configuration.

## Import

Remediation Configurations can be imported using the name config\_rule\_name, e.g.,

```console
$ terraform import aws_config_remediation_configuration.this example
```
