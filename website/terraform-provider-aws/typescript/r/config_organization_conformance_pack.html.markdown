---
subcategory: "Config"
layout: "aws"
page_title: "AWS: aws_config_organization_conformance_pack"
description: |-
  Manages a Config Organization Conformance Pack
---

# Resource: aws\_config\_organization\_conformance\_pack

Manages a Config Organization Conformance Pack. More information can be found in the [Managing Conformance Packs Across all Accounts in Your Organization](https://docs.aws.amazon.com/config/latest/developerguide/conformance-pack-organization-apis.html) and [AWS Config Managed Rules](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_use-managed-rules.html) documentation. Example conformance pack templates may be found in the [AWS Config Rules Repository](https://github.com/awslabs/aws-config-rules/tree/master/aws-config-conformance-packs).

\~> **NOTE:** This resource must be created in the Organization master account or a delegated administrator account, and the Organization must have all features enabled. Every Organization account except those configured in the `excludedAccounts` argument must have a Configuration Recorder with proper IAM permissions before the Organization Conformance Pack will successfully create or update. See also the [`awsConfigConfigurationRecorder` resource](/docs/providers/aws/r/config_configuration_recorder.html).

## Example Usage

### Using Template Body

```hcl
resource "aws_config_organization_conformance_pack" "example" {
  name = "example"

  input_parameter {
    parameter_name  = "AccessKeysRotatedParameterMaxAccessKeyAge"
    parameter_value = "90"
  }

  template_body = <<EOT
Parameters:
  AccessKeysRotatedParameterMaxAccessKeyAge:
    Type: String
Resources:
  IAMPasswordPolicy:
    Properties:
      ConfigRuleName: IAMPasswordPolicy
      Source:
        Owner: AWS
        SourceIdentifier: IAM_PASSWORD_POLICY
    Type: AWS::Config::ConfigRule
EOT

  depends_on = [aws_config_configuration_recorder.example, aws_organizations_organization.example]
}

resource "aws_organizations_organization" "example" {
  aws_service_access_principals = ["config-multiaccountsetup.amazonaws.com"]
  feature_set                   = "ALL"
}
```

### Using Template S3 URI

```hcl
resource "aws_config_organization_conformance_pack" "example" {
  name            = "example"
  template_s3_uri = "s3://${aws_s3_bucket.example.bucket}/${aws_s3_object.example.key}"

  depends_on = [aws_config_configuration_recorder.example, aws_organizations_organization.example]
}

resource "aws_organizations_organization" "example" {
  aws_service_access_principals = ["config-multiaccountsetup.amazonaws.com"]
  feature_set                   = "ALL"
}

resource "aws_s3_bucket" "example" {
  bucket = "example"
}

resource "aws_s3_object" "example" {
  bucket  = aws_s3_bucket.example.id
  key     = "example-key"
  content = <<EOT
Resources:
  IAMPasswordPolicy:
    Properties:
      ConfigRuleName: IAMPasswordPolicy
      Source:
        Owner: AWS
        SourceIdentifier: IAM_PASSWORD_POLICY
    Type: AWS::Config::ConfigRule
EOT
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required, Forces new resource) The name of the organization conformance pack. Must begin with a letter and contain from 1 to 128 alphanumeric characters and hyphens.
* `deliveryS3Bucket` - (Optional) Amazon S3 bucket where AWS Config stores conformance pack templates. Delivery bucket must begin with `awsconfigconforms` prefix. Maximum length of 63.
* `deliveryS3KeyPrefix` - (Optional) The prefix for the Amazon S3 bucket. Maximum length of 1024.
* `excludedAccounts` - (Optional) Set of AWS accounts to be excluded from an organization conformance pack while deploying a conformance pack. Maximum of 1000 accounts.
* `inputParameter` - (Optional) Set of configuration blocks describing input parameters passed to the conformance pack template. Documented below. When configured, the parameters must also be included in the `templateBody` or in the template stored in Amazon S3 if using `templateS3Uri`.
* `templateBody` - (Optional, Conflicts with `templateS3Uri`) A string containing full conformance pack template body. Maximum length of 51200. Drift detection is not possible with this argument.
* `templateS3Uri` - (Optional, Conflicts with `templateBody`) Location of file, e.g., `s3://bucketname/prefix`, containing the template body. The uri must point to the conformance pack template that is located in an Amazon S3 bucket in the same region as the conformance pack. Maximum length of 1024. Drift detection is not possible with this argument.

### input\_parameter Argument Reference

The `inputParameter` configuration block supports the following arguments:

* `parameterName` - (Required) The input key.
* `parameterValue` - (Required) The input value.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the organization conformance pack.
* `id` - The name of the organization conformance pack.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `10M`)
* `update` - (Default `10M`)
* `delete` - (Default `20M`)

## Import

Config Organization Conformance Packs can be imported using the `name`, e.g.,

```console
$ terraform import aws_config_organization_conformance_pack.example example
```
