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
subcategory: "BigQuery Data Policy"
description: |-
  A BigQuery Data Policy
---

# googleBigqueryDatapolicyDataPolicy

A BigQuery Data Policy

To get more information about DataPolicy, see:

* [API documentation](https://cloud.google.com/bigquery/docs/reference/bigquerydatapolicy/rest/v1beta1/projects.locations.dataPolicies/create)
* How-to Guides
  * [Official Documentation](https://cloud.google.com/bigquery/docs/column-data-masking-intro)

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=bigquery_datapolicy_data_policy_basic&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Bigquery Datapolicy Data Policy Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleDataCatalogTaxonomyTaxonomy =
  new google.dataCatalogTaxonomy.DataCatalogTaxonomy(this, "taxonomy", {
    activated_policy_types: ["FINE_GRAINED_ACCESS_CONTROL"],
    description: "A collection of policy tags",
    display_name: "taxonomy",
    region: "us-central1",
  });
const googleDataCatalogPolicyTagPolicyTag =
  new google.dataCatalogPolicyTag.DataCatalogPolicyTag(this, "policy_tag", {
    description: "A policy tag normally associated with low security items",
    display_name: "Low security",
    taxonomy: googleDataCatalogTaxonomyTaxonomy.id,
  });
new google.bigqueryDatapolicyDataPolicy.BigqueryDatapolicyDataPolicy(
  this,
  "data_policy",
  {
    data_policy_id: "data_policy",
    data_policy_type: "COLUMN_LEVEL_SECURITY_POLICY",
    location: "us-central1",
    policy_tag: googleDataCatalogPolicyTagPolicyTag.name,
  }
);

```

## Argument Reference

The following arguments are supported:

*   `dataPolicyId` -
    (Required)
    User-assigned (human readable) ID of the data policy that needs to be unique within a project. Used as {dataPolicyId} in part of the resource name.

*   `location` -
    (Required)
    The name of the location of the data policy.

*   `policyTag` -
    (Required)
    Policy tag resource name, in the format of projects/{project\_number}/locations/{locationId}/taxonomies/{taxonomyId}/policyTags/{policyTag\_id}.

*   `dataPolicyType` -
    (Required)
    The enrollment level of the service.
    Possible values are `columnLevelSecurityPolicy` and `dataMaskingPolicy`.

***

*   `dataMaskingPolicy` -
    (Optional)
    The data masking policy that specifies the data masking rule to use.
    Structure is [documented below](#nested_data_masking_policy).

*   `project` - (Optional) The ID of the project in which the resource belongs.
    If it is not provided, the provider project is used.

<a name="nested_data_masking_policy"></a>The `dataMaskingPolicy` block supports:

* `predefinedExpression` -
  (Required)
  The available masking rules. Learn more here: https://cloud.google.com/bigquery/docs/column-data-masking-intro#masking\_options.
  Possible values are `sha256`, `alwaysNull`, `defaultMaskingValue`, `lastFourCharacters`, `firstFourCharacters`, `emailMask`, and `dateYearMask`.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `projects/{{project}}/locations/{{location}}/dataPolicies/{{dataPolicyId}}`

*   `name` -
    Resource name of this data policy, in the format of projects/{project\_number}/locations/{locationId}/dataPolicies/{dataPolicyId}.

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `update` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

DataPolicy can be imported using any of these accepted formats:

```console
$ terraform import google_bigquery_datapolicy_data_policy.default projects/{{project}}/locations/{{location}}/dataPolicies/{{data_policy_id}}
$ terraform import google_bigquery_datapolicy_data_policy.default {{project}}/{{location}}/{{data_policy_id}}
$ terraform import google_bigquery_datapolicy_data_policy.default {{location}}/{{data_policy_id}}
```

## User Project Overrides

This resource supports [User Project Overrides](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#user_project_override).
