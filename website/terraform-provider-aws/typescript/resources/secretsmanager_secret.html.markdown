---
subcategory: "Secrets Manager"
layout: "aws"
page_title: "AWS: aws_secretsmanager_secret"
description: |-
  Provides a resource to manage AWS Secrets Manager secret metadata
---

# Resource: awsSecretsmanagerSecret

Provides a resource to manage AWS Secrets Manager secret metadata. To manage secret rotation, see the [`awsSecretsmanagerSecretRotation` resource](/docs/providers/aws/r/secretsmanager_secret_rotation.html). To manage a secret value, see the [`awsSecretsmanagerSecretVersion` resource](/docs/providers/aws/r/secretsmanager_secret_version.html).

## Example Usage

### Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.secretsmanagerSecret.SecretsmanagerSecret(this, "example", {
  name: "example",
});

```

### Rotation Configuration

To enable automatic secret rotation, the Secrets Manager service requires usage of a Lambda function. The [Rotate Secrets section in the Secrets Manager User Guide](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets.html) provides additional information about deploying a prebuilt Lambda functions for supported credential rotation (e.g., RDS) or deploying a custom Lambda function.

\~> **NOTE:** Configuring rotation causes the secret to rotate once as soon as you store the secret. Before you do this, you must ensure that all of your applications that use the credentials stored in the secret are updated to retrieve the secret from AWS Secrets Manager. The old credentials might no longer be usable after the initial rotation and any applications that you fail to update will break as soon as the old credentials are no longer valid.

\~> **NOTE:** If you cancel a rotation that is in progress (by removing the `rotation` configuration), it can leave the VersionStage labels in an unexpected state. Depending on what step of the rotation was in progress, you might need to remove the staging label AWSPENDING from the partially created version, specified by the SecretVersionId response value. You should also evaluate the partially rotated new version to see if it should be deleted, which you can do by removing all staging labels from the new version's VersionStage field.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.secretsmanagerSecret.SecretsmanagerSecret(this, "rotation-example", {
  name: "rotation-example",
  rotationLambdaArn: "${aws_lambda_function.example.arn}",
  rotationRules: {
    automaticallyAfterDays: 7,
  },
});

```

## Argument Reference

The following arguments are supported:

* `description` - (Optional) Description of the secret.
* `kmsKeyId` - (Optional) ARN or Id of the AWS KMS key to be used to encrypt the secret values in the versions stored in this secret. If you don't specify this value, then Secrets Manager defaults to using the AWS account's default KMS key (the one named `aws/secretsmanager`). If the default KMS key with that name doesn't yet exist, then AWS Secrets Manager creates it for you automatically the first time.
* `namePrefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with `name`.
* `name` - (Optional) Friendly name of the new secret. The secret name can consist of uppercase letters, lowercase letters, digits, and any of the following characters: `/_+=.@-` Conflicts with `namePrefix`.
* `policy` - (Optional) Valid JSON document representing a [resource policy](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access_resource-based-policies.html). For more information about building AWS IAM policy documents with Terraform, see the [AWS IAM Policy Document Guide](https://learn.hashicorp.com/terraform/aws/iam-policy). Removing `policy` from your configuration or setting `policy` to null or an empty string (i.e., `policy = ""`) *will not* delete the policy since it could have been set by `awsSecretsmanagerSecretPolicy`. To delete the `policy`, set it to `"{}"` (an empty JSON document).
* `recoveryWindowInDays` - (Optional) Number of days that AWS Secrets Manager waits before it can delete the secret. This value can be `0` to force deletion without recovery or range from `7` to `30` days. The default value is `30`.
* `replica` - (Optional) Configuration block to support secret replication. See details below.
* `forceOverwriteReplicaSecret` - (Optional) Accepts boolean value to specify whether to overwrite a secret with the same name in the destination Region.
* `rotationLambdaArn` - (Optional, **DEPRECATED**) ARN of the Lambda function that can rotate the secret. Use the `awsSecretsmanagerSecretRotation` resource to manage this configuration instead. As of version 2.67.0, removal of this configuration will no longer remove rotation due to supporting the new resource. Either import the new resource and remove the configuration or manually remove rotation.
* `rotationRules` - (Optional, **DEPRECATED**) Configuration block for the rotation configuration of this secret. Defined below. Use the `awsSecretsmanagerSecretRotation` resource to manage this configuration instead. As of version 2.67.0, removal of this configuration will no longer remove rotation due to supporting the new resource. Either import the new resource and remove the configuration or manually remove rotation.
* `tags` - (Optional) Key-value map of user-defined tags that are attached to the secret. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### replica

* `kmsKeyId` - (Optional) ARN, Key ID, or Alias of the AWS KMS key within the region secret is replicated to. If one is not specified, then Secrets Manager defaults to using the AWS account's default KMS key (`aws/secretsmanager`) in the region or creates one for use if non-existent.
* `region` - (Required) Region for replicating the secret.

### rotationRules

* `automaticallyAfterDays` - (Required) Specifies the number of days between automatic scheduled rotations of the secret.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - ARN of the secret.
* `arn` - ARN of the secret.
* `rotationEnabled` - Whether automatic rotation is enabled for this secret.
* `replica` - Attributes of a replica are described below.
* `tagsAll` - Map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

### replica

* `lastAccessedDate` - Date that you last accessed the secret in the Region.
* `status` - Status can be `inProgress`, `failed`, or `inSync`.
* `statusMessage` - Message such as `replicationSucceeded` or `secretWithThisNameAlreadyExistsInThisRegion`.

## Import

`awsSecretsmanagerSecret` can be imported by using the secret Amazon Resource Name (ARN), e.g.,

```console
$ terraform import aws_secretsmanager_secret.example arn:aws:secretsmanager:us-east-1:123456789012:secret:example-123456
```
