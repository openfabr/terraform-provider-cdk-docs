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
subcategory: "Cloud Run (v2 API)"
description: |-
  Collection of resources to manage IAM policy for Cloud Run (v2 API) Job
---

# IAM policy for Cloud Run (v2 API) Job

Three different resources help you manage your IAM policy for Cloud Run (v2 API) Job. Each of these resources serves a different use case:

* `googleCloudRunV2JobIamPolicy`: Authoritative. Sets the IAM policy for the job and replaces any existing policy already attached.
* `googleCloudRunV2JobIamBinding`: Authoritative for a given role. Updates the IAM policy to grant a role to a list of members. Other roles within the IAM policy for the job are preserved.
* `googleCloudRunV2JobIamMember`: Non-authoritative. Updates the IAM policy to grant a role to a new member. Other members for the role for the job are preserved.

\~> **Note:** `googleCloudRunV2JobIamPolicy` **cannot** be used in conjunction with `googleCloudRunV2JobIamBinding` and `googleCloudRunV2JobIamMember` or they will fight over what your policy should be.

\~> **Note:** `googleCloudRunV2JobIamBinding` resources **can be** used in conjunction with `googleCloudRunV2JobIamMember` resources **only if** they do not grant privilege to the same role.

## googleCloudRunV2JobIamPolicy

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const dataGoogleIamPolicyAdmin =
  new google.dataGoogleIamPolicy.DataGoogleIamPolicy(this, "admin", {
    binding: [
      {
        members: ["user:jane@example.com"],
        role: "roles/viewer",
      },
    ],
  });
new google.cloudRunV2JobIamPolicy.CloudRunV2JobIamPolicy(this, "policy", {
  location: "${google_cloud_run_v2_job.default.location}",
  name: "${google_cloud_run_v2_job.default.name}",
  policy_data: dataGoogleIamPolicyAdmin.policyData,
  project: "${google_cloud_run_v2_job.default.project}",
});

```

## googleCloudRunV2JobIamBinding

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.cloudRunV2JobIamBinding.CloudRunV2JobIamBinding(this, "binding", {
  location: "${google_cloud_run_v2_job.default.location}",
  members: ["user:jane@example.com"],
  name: "${google_cloud_run_v2_job.default.name}",
  project: "${google_cloud_run_v2_job.default.project}",
  role: "roles/viewer",
});

```

## googleCloudRunV2JobIamMember

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.cloudRunV2JobIamMember.CloudRunV2JobIamMember(this, "member", {
  location: "${google_cloud_run_v2_job.default.location}",
  member: "user:jane@example.com",
  name: "${google_cloud_run_v2_job.default.name}",
  project: "${google_cloud_run_v2_job.default.project}",
  role: "roles/viewer",
});

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Used to find the parent resource to bind the IAM policy to

*   `location` - (Required) The location of the cloud run job Used to find the parent resource to bind the IAM policy to

*   `project` - (Optional) The ID of the project in which the resource belongs.
    If it is not provided, the project will be parsed from the identifier of the parent resource. If no project is provided in the parent identifier and no project is specified, the provider project is used.

*   `member/members` - (Required) Identities that will be granted the privilege in `role`.
    Each entry can have one of the following values:
    * **allUsers**: A special identifier that represents anyone who is on the internet; with or without a Google account.
    * **allAuthenticatedUsers**: A special identifier that represents anyone who is authenticated with a Google account or a service account.
    * **user:{emailid}**: An email address that represents a specific Google account. For example, alice@gmail.com or joe@example.com.
    * **serviceAccount:{emailid}**: An email address that represents a service account. For example, my-other-app@appspot.gserviceaccount.com.
    * **group:{emailid}**: An email address that represents a Google group. For example, admins@example.com.
    * **domain:{domain}**: A G Suite domain (primary, instead of alias) name that represents all the users of that domain. For example, google.com or example.com.
    * **projectOwner:projectid**: Owners of the given project. For example, "projectOwner:my-example-project"
    * **projectEditor:projectid**: Editors of the given project. For example, "projectEditor:my-example-project"
    * **projectViewer:projectid**: Viewers of the given project. For example, "projectViewer:my-example-project"

*   `role` - (Required) The role that should be applied. Only one
    `googleCloudRunV2JobIamBinding` can be used per role. Note that custom roles must be of the format
    `[projects|organizations]/{parentName}/roles/{roleName}`.

*   `policyData` - (Required only by `googleCloudRunV2JobIamPolicy`) The policy data generated by
    a `googleIamPolicy` data source.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are
exported:

* `etag` - (Computed) The etag of the IAM policy.

## Import

For all import syntaxes, the "resource in question" can take any of the following forms:

* projects/{{project}}/locations/{{location}}/jobs/{{name}}
* {{project}}/{{location}}/{{name}}
* {{location}}/{{name}}
* {{name}}

Any variables not passed in the import command will be taken from the provider configuration.

Cloud Run (v2 API) job IAM resources can be imported using the resource identifiers, role, and member.

IAM member imports use space-delimited identifiers: the resource in question, the role, and the member identity, e.g.

```console
$ terraform import google_cloud_run_v2_job_iam_member.editor "projects/{{project}}/locations/{{location}}/jobs/{{job}} roles/viewer user:jane@example.com"
```

IAM binding imports use space-delimited identifiers: the resource in question and the role, e.g.

```console
$ terraform import google_cloud_run_v2_job_iam_binding.editor "projects/{{project}}/locations/{{location}}/jobs/{{job}} roles/viewer"
```

IAM policy imports use the identifier of the resource in question, e.g.

```console
$ terraform import google_cloud_run_v2_job_iam_policy.editor projects/{{project}}/locations/{{location}}/jobs/{{job}}
```

\-> **Custom Roles**: If you're importing a IAM resource with a custom role, make sure to use the
full name of the custom role, e.g. `[projects/myProject|organizations/myOrg]/roles/myCustomRole`.

## User Project Overrides

This resource supports [User Project Overrides](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#user_project_override).
