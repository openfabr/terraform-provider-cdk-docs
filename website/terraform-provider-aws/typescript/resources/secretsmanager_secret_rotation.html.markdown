---
subcategory: "Secrets Manager"
layout: "aws"
page_title: "AWS: aws_secretsmanager_secret_rotation"
description: |-
  Provides a resource to manage AWS Secrets Manager secret rotation
---

# Resource: awsSecretsmanagerSecretRotation

Provides a resource to manage AWS Secrets Manager secret rotation. To manage a secret, see the [`awsSecretsmanagerSecret` resource](/docs/providers/aws/r/secretsmanager_secret.html). To manage a secret value, see the [`awsSecretsmanagerSecretVersion` resource](/docs/providers/aws/r/secretsmanager_secret_version.html).

## Example Usage

### Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.secretsmanagerSecretRotation.SecretsmanagerSecretRotation(
  this,
  "example",
  {
    rotationLambdaArn: "${aws_lambda_function.example.arn}",
    rotationRules: {
      automaticallyAfterDays: 30,
    },
    secretId: "${aws_secretsmanager_secret.example.id}",
  }
);

```

### Rotation Configuration

To enable automatic secret rotation, the Secrets Manager service requires usage of a Lambda function. The [Rotate Secrets section in the Secrets Manager User Guide](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets.html) provides additional information about deploying a prebuilt Lambda functions for supported credential rotation (e.g., RDS) or deploying a custom Lambda function.

\~> **NOTE:** Configuring rotation causes the secret to rotate once as soon as you enable rotation. Before you do this, you must ensure that all of your applications that use the credentials stored in the secret are updated to retrieve the secret from AWS Secrets Manager. The old credentials might no longer be usable after the initial rotation and any applications that you fail to update will break as soon as the old credentials are no longer valid.

\~> **NOTE:** If you cancel a rotation that is in progress (by removing the `rotation` configuration), it can leave the VersionStage labels in an unexpected state. Depending on what step of the rotation was in progress, you might need to remove the staging label AWSPENDING from the partially created version, specified by the SecretVersionId response value. You should also evaluate the partially rotated new version to see if it should be deleted, which you can do by removing all staging labels from the new version's VersionStage field.

## Argument Reference

The following arguments are supported:

* `secretId` - (Required) Specifies the secret to which you want to add a new version. You can specify either the Amazon Resource Name (ARN) or the friendly name of the secret. The secret must already exist.
* `rotationLambdaArn` - (Required) Specifies the ARN of the Lambda function that can rotate the secret.
* `rotationRules` - (Required) A structure that defines the rotation configuration for this secret. Defined below.

### rotationRules

* `automaticallyAfterDays` - (Required) Specifies the number of days between automatic scheduled rotations of the secret.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Amazon Resource Name (ARN) of the secret.
* `arn` - Amazon Resource Name (ARN) of the secret.
* `rotationEnabled` - Specifies whether automatic rotation is enabled for this secret.

## Import

`awsSecretsmanagerSecretRotation` can be imported by using the secret Amazon Resource Name (ARN), e.g.,

```console
$ terraform import aws_secretsmanager_secret_rotation.example arn:aws:secretsmanager:us-east-1:123456789012:secret:example-123456
```
