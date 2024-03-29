---
# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    Type: DCL     ***
#
# ----------------------------------------------------------------------------
#
#     This file is managed by Magic Modules (https:#github.com/GoogleCloudPlatform/magic-modules)
#     and is based on the DCL (https:#github.com/GoogleCloudPlatform/declarative-resource-client-library).
#     Changes will need to be made to the DCL or Magic Modules instead of here.
#
#     We are not currently able to accept contributions to this file. If changes
#     are required, please file an issue at https:#github.com/hashicorp/terraform-provider-google/issues/new/choose
#
# ----------------------------------------------------------------------------
subcategory: "Eventarc"
description: |-
  The Eventarc GoogleChannelConfig resource
---

# googleEventarcGoogleChannelConfig

The Eventarc GoogleChannelConfig resource

## Example Usage - basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const dataGoogleKmsKeyRingTestKeyRing =
  new google.dataGoogleKmsKeyRing.DataGoogleKmsKeyRing(this, "test_key_ring", {
    location: "us-west1",
    name: "keyring",
  });
const dataGoogleProjectTestProject =
  new google.dataGoogleProject.DataGoogleProject(this, "test_project", {
    project_id: "my-project-name",
  });
const googleKmsCryptoKeyIamMemberKey1Member =
  new google.kmsCryptoKeyIamMember.KmsCryptoKeyIamMember(this, "key1_member", {
    crypto_key_id: "${data.google_kms_crypto_key.key1.id}",
    member: `serviceAccount:service-\${${dataGoogleProjectTestProject.number}}@gcp-sa-eventarc.iam.gserviceaccount.com`,
    role: "roles/cloudkms.cryptoKeyEncrypterDecrypter",
  });
new google.dataGoogleKmsCryptoKey.DataGoogleKmsCryptoKey(this, "key", {
  key_ring: dataGoogleKmsKeyRingTestKeyRing.id,
  name: "key",
});
new google.eventarcGoogleChannelConfig.EventarcGoogleChannelConfig(
  this,
  "primary",
  {
    crypto_key_name: "${data.google_kms_crypto_key.key1.id}",
    depends_on: [`\${${googleKmsCryptoKeyIamMemberKey1Member.fqn}}`],
    location: "us-west1",
    name: "channel",
    project: dataGoogleProjectTestProject.projectId,
  }
);

```

## Argument Reference

The following arguments are supported:

*   `location` -
    (Required)
    The location for the resource

*   `name` -
    (Required)
    Required. The resource name of the config. Must be in the format of, `projects/{project}/locations/{location}/googleChannelConfig`.

***

*   `cryptoKeyName` -
    (Optional)
    Optional. Resource name of a KMS crypto key (managed by the user) used to encrypt/decrypt their event data. It must match the pattern `projects/*/locations/*/keyRings/*/cryptoKeys/*`.

*   `project` -
    (Optional)
    The project for the resource

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `projects/{{project}}/locations/{{location}}/googleChannelConfig`

*   `updateTime` -
    Output only. The last-modified time.

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `update` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

GoogleChannelConfig can be imported using any of these accepted formats:

```console
$ terraform import google_eventarc_google_channel_config.default projects/{{project}}/locations/{{location}}/googleChannelConfig
$ terraform import google_eventarc_google_channel_config.default {{project}}/{{location}}
$ terraform import google_eventarc_google_channel_config.default {{location}}
```
