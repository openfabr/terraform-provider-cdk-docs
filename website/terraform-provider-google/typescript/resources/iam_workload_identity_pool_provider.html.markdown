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
subcategory: "Cloud IAM"
description: |-
  A configuration for an external identity provider.
---

# googleIamWorkloadIdentityPoolProvider

A configuration for an external identity provider.

To get more information about WorkloadIdentityPoolProvider, see:

* [API documentation](https://cloud.google.com/iam/docs/reference/rest/v1/projects.locations.workloadIdentityPools.providers)
* How-to Guides
  * [Managing workload identity providers](https://cloud.google.com/iam/docs/manage-workload-identity-pools-providers#managing_workload_identity_providers)

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=iam_workload_identity_pool_provider_aws_basic&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Iam Workload Identity Pool Provider Aws Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleIamWorkloadIdentityPoolPool =
  new google.iamWorkloadIdentityPool.IamWorkloadIdentityPool(this, "pool", {
    workload_identity_pool_id: "example-pool",
  });
new google.iamWorkloadIdentityPoolProvider.IamWorkloadIdentityPoolProvider(
  this,
  "example",
  {
    aws: [
      {
        account_id: "999999999999",
      },
    ],
    workload_identity_pool_id:
      googleIamWorkloadIdentityPoolPool.workloadIdentityPoolId,
    workload_identity_pool_provider_id: "example-prvdr",
  }
);

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=iam_workload_identity_pool_provider_aws_full&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Iam Workload Identity Pool Provider Aws Full

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleIamWorkloadIdentityPoolPool =
  new google.iamWorkloadIdentityPool.IamWorkloadIdentityPool(this, "pool", {
    workload_identity_pool_id: "example-pool",
  });
new google.iamWorkloadIdentityPoolProvider.IamWorkloadIdentityPoolProvider(
  this,
  "example",
  {
    attribute_condition:
      'attribute.aws_role=="arn:aws:sts::999999999999:assumed-role/stack-eu-central-1-lambdaRole"',
    attribute_mapping: [
      {
        "attribute.aws_account": "assertion.account",
        "attribute.environment":
          'assertion.arn.contains(":instance-profile/Production") ? "prod" : "test"',
        "google.subject": "assertion.arn",
      },
    ],
    aws: [
      {
        account_id: "999999999999",
      },
    ],
    description: "AWS identity pool provider for automated test",
    disabled: true,
    display_name: "Name of provider",
    workload_identity_pool_id:
      googleIamWorkloadIdentityPoolPool.workloadIdentityPoolId,
    workload_identity_pool_provider_id: "example-prvdr",
  }
);

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=iam_workload_identity_pool_provider_oidc_basic&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Iam Workload Identity Pool Provider Oidc Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleIamWorkloadIdentityPoolPool =
  new google.iamWorkloadIdentityPool.IamWorkloadIdentityPool(this, "pool", {
    workload_identity_pool_id: "example-pool",
  });
new google.iamWorkloadIdentityPoolProvider.IamWorkloadIdentityPoolProvider(
  this,
  "example",
  {
    attribute_mapping: [
      {
        "google.subject": "assertion.sub",
      },
    ],
    oidc: [
      {
        issuer_uri: "https://sts.windows.net/azure-tenant-id",
      },
    ],
    workload_identity_pool_id:
      googleIamWorkloadIdentityPoolPool.workloadIdentityPoolId,
    workload_identity_pool_provider_id: "example-prvdr",
  }
);

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=iam_workload_identity_pool_provider_oidc_full&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Iam Workload Identity Pool Provider Oidc Full

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleIamWorkloadIdentityPoolPool =
  new google.iamWorkloadIdentityPool.IamWorkloadIdentityPool(this, "pool", {
    workload_identity_pool_id: "example-pool",
  });
new google.iamWorkloadIdentityPoolProvider.IamWorkloadIdentityPoolProvider(
  this,
  "example",
  {
    attribute_condition:
      '"e968c2ef-047c-498d-8d79-16ca1b61e77e" in assertion.groups',
    attribute_mapping: [
      {
        "attribute.managed_identity_name":
          '      {\n        "8bb39bdb-1cc5-4447-b7db-a19e920eb111":"workload1",\n        "55d36609-9bcf-48e0-a366-a3cf19027d2a":"workload2"\n      }[assertion.oid]\n',
        "attribute.tid": "assertion.tid",
        "google.subject": '"azure::" + assertion.tid + "::" + assertion.sub',
      },
    ],
    description: "OIDC identity pool provider for automated test",
    disabled: true,
    display_name: "Name of provider",
    oidc: [
      {
        allowed_audiences: [
          "https://example.com/gcp-oidc-federation",
          "example.com/gcp-oidc-federation",
        ],
        issuer_uri: "https://sts.windows.net/azure-tenant-id",
      },
    ],
    workload_identity_pool_id:
      googleIamWorkloadIdentityPoolPool.workloadIdentityPoolId,
    workload_identity_pool_provider_id: "example-prvdr",
  }
);

```

## Argument Reference

The following arguments are supported:

*   `workloadIdentityPoolId` -
    (Required)
    The ID used for the pool, which is the final component of the pool resource name. This
    value should be 4-32 characters, and may contain the characters \[a-z0-9-]. The prefix
    `gcp` is reserved for use by Google, and may not be specified.

*   `workloadIdentityPoolProviderId` -
    (Required)
    The ID for the provider, which becomes the final component of the resource name. This
    value must be 4-32 characters, and may contain the characters \[a-z0-9-]. The prefix
    `gcp` is reserved for use by Google, and may not be specified.

***

*   `displayName` -
    (Optional)
    A display name for the provider. Cannot exceed 32 characters.

*   `description` -
    (Optional)
    A description for the provider. Cannot exceed 256 characters.

*   `disabled` -
    (Optional)
    Whether the provider is disabled. You cannot use a disabled provider to exchange tokens.
    However, existing tokens still grant access.

*   `attributeMapping` -
    (Optional)
    Maps attributes from authentication credentials issued by an external identity provider
    to Google Cloud attributes, such as `subject` and `segment`.
    Each key must be a string specifying the Google Cloud IAM attribute to map to.
    The following keys are supported:
    * `googleSubject`: The principal IAM is authenticating. You can reference this value
      in IAM bindings. This is also the subject that appears in Cloud Logging logs.
      Cannot exceed 127 characters.
    * `googleGroups`: Groups the external identity belongs to. You can grant groups
      access to resources using an IAM `principalSet` binding; access applies to all
      members of the group.
      You can also provide custom attributes by specifying `attribute.{customAttribute}`,
      where `{customAttribute}` is the name of the custom attribute to be mapped. You can
      define a maximum of 50 custom attributes. The maximum length of a mapped attribute key
      is 100 characters, and the key may only contain the characters \[a-z0-9\_].
      You can reference these attributes in IAM policies to define fine-grained access for a
      workload to Google Cloud resources. For example:
    * `googleSubject`:
      `principal://iamGoogleapisCom/projects/{project}/locations/{location}/workloadIdentityPools/{pool}/subject/{value}`
    * `googleGroups`:
      `principalSet://iamGoogleapisCom/projects/{project}/locations/{location}/workloadIdentityPools/{pool}/group/{value}`
    * `attribute.{customAttribute}`:
      `principalSet://iamGoogleapisCom/projects/{project}/locations/{location}/workloadIdentityPools/{pool}/attribute.{customAttribute}/{value}`
      Each value must be a [Common Expression Language](https://opensource.google/projects/cel)
      function that maps an identity provider credential to the normalized attribute specified
      by the corresponding map key.
      You can use the `assertion` keyword in the expression to access a JSON representation of
      the authentication credential issued by the provider.
      The maximum length of an attribute mapping expression is 2048 characters. When evaluated,
      the total size of all mapped attributes must not exceed 8KB.
      For AWS providers, the following rules apply:

    <!---->

    * If no attribute mapping is defined, the following default mapping applies:
      ```console
      {
        "google.subject":"assertion.arn",
        "attribute.aws_role":
          "assertion.arn.contains('assumed-role')"
          " ? assertion.arn.extract('{account_arn}assumed-role/')"
          "   + 'assumed-role/'"
          "   + assertion.arn.extract('assumed-role/{role_name}/')"
          " : assertion.arn",
      }
      ```
    * If any custom attribute mappings are defined, they must include a mapping to the
      `googleSubject` attribute.
      For OIDC providers, the following rules apply:
    * Custom attribute mappings must be defined, and must include a mapping to the
      `googleSubject` attribute. For example, the following maps the `sub` claim of the
      incoming credential to the `subject` attribute on a Google token.
      ```console
      {"google.subject": "assertion.sub"}
      ```

*   `attributeCondition` -
    (Optional)
    [A Common Expression Language](https://opensource.google/projects/cel) expression, in
    plain text, to restrict what otherwise valid authentication credentials issued by the
    provider should not be accepted.
    The expression must output a boolean representing whether to allow the federation.
    The following keywords may be referenced in the expressions:
    * `assertion`: JSON representing the authentication credential issued by the provider.
    * `google`: The Google attributes mapped from the assertion in the `attributeMappings`.
    * `attribute`: The custom attributes mapped from the assertion in the `attributeMappings`.
      The maximum length of the attribute condition expression is 4096 characters. If
      unspecified, all valid authentication credential are accepted.
      The following example shows how to only allow credentials with a mapped `googleGroups`
      value of `admins`:
    ```console
    "'admins' in google.groups"
    ```

*   `aws` -
    (Optional)
    An Amazon Web Services identity provider. Not compatible with the property oidc.
    Structure is [documented below](#nested_aws).

*   `oidc` -
    (Optional)
    An OpenId Connect 1.0 identity provider. Not compatible with the property aws.
    Structure is [documented below](#nested_oidc).

*   `project` - (Optional) The ID of the project in which the resource belongs.
    If it is not provided, the provider project is used.

<a name="nested_aws"></a>The `aws` block supports:

* `accountId` -
  (Required)
  The AWS account ID.

<a name="nested_oidc"></a>The `oidc` block supports:

*   `allowedAudiences` -
    (Optional)
    Acceptable values for the `aud` field (audience) in the OIDC token. Token exchange
    requests are rejected if the token audience does not match one of the configured
    values. Each audience may be at most 256 characters. A maximum of 10 audiences may
    be configured.
    If this list is empty, the OIDC token audience must be equal to the full canonical
    resource name of the WorkloadIdentityPoolProvider, with or without the HTTPS prefix.
    For example:
    ```console
    //iam.googleapis.com/projects/<project-number>/locations/<location>/workloadIdentityPools/<pool-id>/providers/<provider-id>
    https://iam.googleapis.com/projects/<project-number>/locations/<location>/workloadIdentityPools/<pool-id>/providers/<provider-id>
    ```

*   `issuerUri` -
    (Required)
    The OIDC issuer URL.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `projects/{{project}}/locations/global/workloadIdentityPools/{{workloadIdentityPoolId}}/providers/{{workloadIdentityPoolProviderId}}`

*   `state` -
    The state of the provider.
    * STATE\_UNSPECIFIED: State unspecified.
    * ACTIVE: The provider is active, and may be used to validate authentication credentials.
    * DELETED: The provider is soft-deleted. Soft-deleted providers are permanently deleted
      after approximately 30 days. You can restore a soft-deleted provider using
      UndeleteWorkloadIdentityPoolProvider. You cannot reuse the ID of a soft-deleted provider
      until it is permanently deleted.

*   `name` -
    The resource name of the provider as
    `projects/{projectNumber}/locations/global/workloadIdentityPools/{workloadIdentityPoolId}/providers/{workloadIdentityPoolProviderId}`.

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `update` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

WorkloadIdentityPoolProvider can be imported using any of these accepted formats:

```console
$ terraform import google_iam_workload_identity_pool_provider.default projects/{{project}}/locations/global/workloadIdentityPools/{{workload_identity_pool_id}}/providers/{{workload_identity_pool_provider_id}}
$ terraform import google_iam_workload_identity_pool_provider.default {{project}}/{{workload_identity_pool_id}}/{{workload_identity_pool_provider_id}}
$ terraform import google_iam_workload_identity_pool_provider.default {{workload_identity_pool_id}}/{{workload_identity_pool_provider_id}}
```

## User Project Overrides

This resource supports [User Project Overrides](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#user_project_override).
