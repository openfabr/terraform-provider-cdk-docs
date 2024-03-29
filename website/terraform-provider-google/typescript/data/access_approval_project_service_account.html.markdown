---
subcategory: "Access Approval"
description: |-
  Get the email address of a project's Access Approval service account.
---

# googleAccessApprovalProjectServiceAccount

Get the email address of a project's Access Approval service account.

Each Google Cloud project has a unique service account used by Access Approval.
When using Access Approval with a
[custom signing key](https://cloud.google.com/cloud-provider-access-management/access-approval/docs/review-approve-access-requests-custom-keys),
this account needs to be granted the `cloudkmsSignerVerifier` IAM role on the
Cloud KMS key used to sign approvals.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const dataGoogleAccessApprovalProjectServiceAccountServiceAccount =
  new google.dataGoogleAccessApprovalProjectServiceAccount.DataGoogleAccessApprovalProjectServiceAccount(
    this,
    "service_account",
    {
      project_id: "my-project",
    }
  );
new google.kmsCryptoKeyIamMember.KmsCryptoKeyIamMember(this, "iam", {
  crypto_key_id: "${google_kms_crypto_key.crypto_key.id}",
  member: `serviceAccount:\${${dataGoogleAccessApprovalProjectServiceAccountServiceAccount.accountEmail}}`,
  role: "roles/cloudkms.signerVerifier",
});

```

## Argument Reference

The following arguments are supported:

* `projectId` - (Required) The project ID the service account was created for.

## Attributes Reference

The following attributes are exported:

*   `name` - The Access Approval service account resource name. Format is "projects/{project\_id}/serviceAccount".

*   `accountEmail` - The email address of the service account. This value is
    often used to refer to the service account in order to grant IAM permissions.
