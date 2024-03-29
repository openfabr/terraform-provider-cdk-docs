---
# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    Type: MMv1     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in
#     .github/CONTRIBUTING.md.
#
# ----------------------------------------------------------------------------
subcategory: "Cloud Healthcare"
description: |-
  The Consent Management API is a tool for tracking user consents and the documentation associated with the consents.
---

# googleHealthcareConsentStore

The Consent Management API is a tool for tracking user consents and the documentation associated with the consents.

To get more information about ConsentStore, see:

* [API documentation](https://cloud.google.com/healthcare/docs/reference/rest/v1/projects.locations.datasets.consentStores)
* How-to Guides
  * [Creating a Consent store](https://cloud.google.com/healthcare/docs/how-tos/consent)

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=healthcare_consent_store_basic&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Healthcare Consent Store Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleHealthcareDatasetDataset =
  new google.healthcareDataset.HealthcareDataset(this, "dataset", {
    location: "us-central1",
    name: "my-dataset",
  });
new google.healthcareConsentStore.HealthcareConsentStore(this, "my-consent", {
  dataset: googleHealthcareDatasetDataset.id,
  name: "my-consent-store",
});

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=healthcare_consent_store_full&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Healthcare Consent Store Full

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleHealthcareDatasetDataset =
  new google.healthcareDataset.HealthcareDataset(this, "dataset", {
    location: "us-central1",
    name: "my-dataset",
  });
new google.healthcareConsentStore.HealthcareConsentStore(this, "my-consent", {
  dataset: googleHealthcareDatasetDataset.id,
  default_consent_ttl: "90000s",
  enable_consent_create_on_update: true,
  labels: [
    {
      label1: "labelvalue1",
    },
  ],
  name: "my-consent-store",
});

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=healthcare_consent_store_iam&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Healthcare Consent Store Iam

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleHealthcareDatasetDataset =
  new google.healthcareDataset.HealthcareDataset(this, "dataset", {
    location: "us-central1",
    name: "my-dataset",
  });
const googleServiceAccountTestAccount =
  new google.serviceAccount.ServiceAccount(this, "test-account", {
    account_id: "my-account",
    display_name: "Test Service Account",
  });
const googleHealthcareConsentStoreMyConsent =
  new google.healthcareConsentStore.HealthcareConsentStore(this, "my-consent", {
    dataset: googleHealthcareDatasetDataset.id,
    name: "my-consent-store",
  });
new google.healthcareConsentStoreIamMember.HealthcareConsentStoreIamMember(
  this,
  "test-iam",
  {
    consent_store_id: googleHealthcareConsentStoreMyConsent.name,
    dataset: googleHealthcareDatasetDataset.id,
    member: `serviceAccount:\${${googleServiceAccountTestAccount.email}}`,
    role: "roles/editor",
  }
);

```

## Argument Reference

The following arguments are supported:

*   `name` -
    (Required)
    The name of this ConsentStore, for example:
    "consent1"

*   `dataset` -
    (Required)
    Identifies the dataset addressed by this request. Must be in the format
    'projects/{project}/locations/{location}/datasets/{dataset}'

***

*   `defaultConsentTtl` -
    (Optional)
    Default time to live for consents in this store. Must be at least 24 hours. Updating this field will not affect the expiration time of existing consents.
    A duration in seconds with up to nine fractional digits, terminated by 's'. Example: "3.5s".

*   `enableConsentCreateOnUpdate` -
    (Optional)
    If true, \[consents.patch] \[google.cloud.healthcare.v1.consent.UpdateConsent] creates the consent if it does not already exist.

*   `labels` -
    (Optional)
    User-supplied key-value pairs used to organize Consent stores.
    Label keys must be between 1 and 63 characters long, have a UTF-8 encoding of maximum 128 bytes, and must
    conform to the following PCRE regular expression: `[\p{ll}\p{lo}][\p{ll}\p{lo}\p{n}_-]{0,62}`
    Label values are optional, must be between 1 and 63 characters long, have a UTF-8 encoding of maximum 128
    bytes, and must conform to the following PCRE regular expression: `[\p{ll}\p{lo}\p{n}_-]{0,63}`
    No more than 64 labels can be associated with a given store.
    An object containing a list of "key": value pairs.
    Example: { "name": "wrench", "mass": "1.3kg", "count": "3" }.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

* `id` - an identifier for the resource with format `{{dataset}}/consentStores/{{name}}`

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `update` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

ConsentStore can be imported using any of these accepted formats:

```console
$ terraform import google_healthcare_consent_store.default {{dataset}}/consentStores/{{name}}
```
