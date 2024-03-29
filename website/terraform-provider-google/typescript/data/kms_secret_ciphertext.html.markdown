---
subcategory: "Cloud Key Management Service"
description: |-
  Encrypts secret data with Google Cloud KMS and provides access to the ciphertext
---

# googleKmsSecretCiphertext

!> **Warning:** This data source is deprecated. Use the [`googleKmsSecretCiphertext`](../r/kms_secret_ciphertext.html) **resource** instead.

This data source allows you to encrypt data with Google Cloud KMS and use the
ciphertext within your resource definitions.

For more information see
[the official documentation](https://cloud.google.com/kms/docs/encrypt-decrypt).

\~> **NOTE:** Using this data source will allow you to conceal secret data within your
resource definitions, but it does not take care of protecting that data in the
logging output, plan output, or state output.  Please take care to secure your secret
data outside of resource definitions.

## Example Usage

First, create a KMS KeyRing and CryptoKey using the resource definitions:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleKmsKeyRingMyKeyRing = new google.kmsKeyRing.KmsKeyRing(
  this,
  "my_key_ring",
  {
    location: "us-central1",
    name: "my-key-ring",
    project: "my-project",
  }
);
new google.kmsCryptoKey.KmsCryptoKey(this, "my_crypto_key", {
  key_ring: googleKmsKeyRingMyKeyRing.id,
  name: "my-crypto-key",
});

```

Next, encrypt some sensitive information and use the encrypted data in your resource definitions:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const dataGoogleKmsSecretCiphertextMyPassword =
  new google.dataGoogleKmsSecretCiphertext.DataGoogleKmsSecretCiphertext(
    this,
    "my_password",
    {
      crypto_key: "${google_kms_crypto_key.my_crypto_key.id}",
      plaintext: "my-secret-password",
    }
  );
new google.computeInstance.ComputeInstance(this, "instance", {
  boot_disk: [
    {
      initialize_params: [
        {
          image: "debian-cloud/debian-11",
        },
      ],
    },
  ],
  machine_type: "e2-medium",
  metadata: [
    {
      password: dataGoogleKmsSecretCiphertextMyPassword.ciphertext,
    },
  ],
  name: "test",
  network_interface: [
    {
      access_config: [{}],
      network: "default",
    },
  ],
  zone: "us-central1-a",
});

```

The resulting instance can then access the encrypted password from its metadata
and decrypt it, e.g. using the [Cloud SDK](https://cloud.google.com/sdk/gcloud/reference/kms/decrypt)):

```bash
$ curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/attributes/password \
> | base64 -d | gcloud kms decrypt \
> --project my-project \
> --location us-central1 \
> --keyring my-key-ring \
> --key my-crypto-key \
> --plaintext-file - \
> --ciphertext-file - \
my-secret-password
```

## Argument Reference

The following arguments are supported:

* `plaintext` (Required) - The plaintext to be encrypted
* `cryptoKey` (Required) - The id of the CryptoKey that will be used to
  encrypt the provided plaintext. This is represented by the format
  `{projectId}/{location}/{keyRingName}/{cryptoKeyName}`.

## Attributes Reference

The following attribute is exported:

* `ciphertext` - Contains the result of encrypting the provided plaintext, encoded in base64.

## User Project Overrides

This data source supports [User Project Overrides](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#user_project_override).
