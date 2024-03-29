---
subcategory: "Lambda"
layout: "aws"
page_title: "AWS: aws_lambda_code_signing_config"
description: |-
  Provides a Lambda Code Signing Config data source.
---

# Data Source: awsLambdaCodeSigningConfig

Provides information about a Lambda Code Signing Config. A code signing configuration defines a list of allowed signing profiles and defines the code-signing validation policy (action to be taken if deployment validation checks fail).

For information about Lambda code signing configurations and how to use them, see [configuring code signing for Lambda functions][1]

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsLambdaCodeSigningConfig.DataAwsLambdaCodeSigningConfig(
  this,
  "existing_csc",
  {
    arn: "arn:aws:lambda:${var.aws_region}:${var.aws_account}:code-signing-config:csc-0f6c334abcdea4d8b",
  }
);

```

## Argument Reference

The following arguments are supported:

* `arn` - (Required) ARN of the code signing configuration.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `allowedPublishers` - List of allowed publishers as signing profiles for this code signing configuration.
* `configId` - Unique identifier for the code signing configuration.
* `description` - Code signing configuration description.
* `lastModified` - Date and time that the code signing configuration was last modified.
* `policies` - List of code signing policies that control the validation failure action for signature mismatch or expiry.

`allowedPublishers` is exported with the following attribute:

* `signingProfileVersionArns` - The ARN for each of the signing profiles. A signing profile defines a trusted user who can sign a code package.

`policies` is exported with the following attribute:

* `untrustedArtifactOnDeployment` - Code signing configuration policy for deployment validation failure.

[1]: https://docs.aws.amazon.com/lambda/latest/dg/configuration-codesigning.html
