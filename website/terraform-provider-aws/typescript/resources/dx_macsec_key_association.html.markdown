---
subcategory: "Direct Connect"
layout: "aws"
page_title: "AWS: aws_dx_macsec_key_association"
description: |-
  Provides a MAC Security (MACSec) secret key resource for use with Direct Connect.
---

# Resource: awsDxMacsecKeyAssociation

Provides a MAC Security (MACSec) secret key resource for use with Direct Connect. See [MACsec prerequisites](https://docs.aws.amazon.com/directconnect/latest/UserGuide/direct-connect-mac-sec-getting-started.html#mac-sec-prerequisites) for information about MAC Security (MACsec) prerequisites.

Creating this resource will also create a resource of type [`awsSecretsmanagerSecret`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) which is managed by Direct Connect. While you can import this resource into your Terraform state, because this secret is managed by Direct Connect, you will not be able to make any modifications to it. See [How AWS Direct Connect uses AWS Secrets Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/integrating_how-services-use-secrets_directconnect.html) for details.

\~> **Note:** All arguments including `ckn` and `cak` will be stored in the raw state as plain-text.
[Read more about sensitive data in state](https://www.terraform.io/docs/state/sensitive-data.html).

\~> **Note:** The `secretArn` argument can only be used to reference a previously created MACSec key. You cannot associate a Secrets Manager secret created outside of the `awsDxMacsecKeyAssociation` resource.

## Example Usage

### Create MACSec key with CKN and CAK

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsDxConnectionExample =
  new aws.dataAwsDxConnection.DataAwsDxConnection(this, "example", {
    name: "tf-dx-connection",
  });
new aws.dxMacsecKeyAssociation.DxMacsecKeyAssociation(this, "test", {
  cak: "abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789",
  ckn: "0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef",
  connectionId: dataAwsDxConnectionExample.id,
});

```

### Create MACSec key with existing Secrets Manager secret

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsDxConnectionExample =
  new aws.dataAwsDxConnection.DataAwsDxConnection(this, "example", {
    name: "tf-dx-connection",
  });
const dataAwsSecretsmanagerSecretExample =
  new aws.dataAwsSecretsmanagerSecret.DataAwsSecretsmanagerSecret(
    this,
    "example_1",
    {
      name: "directconnect!prod/us-east-1/directconnect/0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAwsSecretsmanagerSecretExample.overrideLogicalId("example");
new aws.dxMacsecKeyAssociation.DxMacsecKeyAssociation(this, "test", {
  connectionId: dataAwsDxConnectionExample.id,
  secretArn: dataAwsSecretsmanagerSecretExample.arn,
});

```

## Argument Reference

The following arguments are supported:

* `cak` - (Optional) The MAC Security (MACsec) CAK to associate with the dedicated connection. The valid values are 64 hexadecimal characters (0-9, A-E). Required if using `ckn`.
* `ckn` - (Optional) The MAC Security (MACsec) CKN to associate with the dedicated connection. The valid values are 64 hexadecimal characters (0-9, A-E). Required if using `cak`.
* `connectionId` - (Required) The ID of the dedicated Direct Connect connection. The connection must be a dedicated connection in the `available` state.
* `secretArn` - (Optional) The Amazon Resource Name (ARN) of the MAC Security (MACsec) secret key to associate with the dedicated connection.

\~> **Note:** `ckn` and `cak` are mutually exclusive with `secretArn` - these arguments cannot be used together. If you use `ckn` and `cak`, you should not use `secretArn`. If you use the `secretArn` argument to reference an existing MAC Security (MACSec) secret key, you should not use `ckn` or `cak`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - ID of the MAC Security (MACSec) secret key resource.
* `startOn` - The date in UTC format that the MAC Security (MACsec) secret key takes effect.
* `state` -  The state of the MAC Security (MACsec) secret key. The possible values are: associating, associated, disassociating, disassociated. See [MacSecKey](https://docs.aws.amazon.com/directconnect/latest/APIReference/API_MacSecKey.html#DX-Type-MacSecKey-state) for descriptions of each state.
