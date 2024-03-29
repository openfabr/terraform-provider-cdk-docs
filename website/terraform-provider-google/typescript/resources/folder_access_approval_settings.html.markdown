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
subcategory: "Access Approval"
description: |-
  Access Approval enables you to require your explicit approval whenever Google support and engineering need to access your customer content.
---

# googleFolderAccessApprovalSettings

Access Approval enables you to require your explicit approval whenever Google support and engineering need to access your customer content.

To get more information about FolderSettings, see:

* [API documentation](https://cloud.google.com/access-approval/docs/reference/rest/v1/folders)

## Example Usage - Folder Access Approval Full

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleFolderMyFolder = new google.folder.Folder(this, "my_folder", {
  display_name: "my-folder",
  parent: "organizations/123456789",
});
new google.folderAccessApprovalSettings.FolderAccessApprovalSettings(
  this,
  "folder_access_approval",
  {
    enrolled_services: [
      {
        cloud_product: "all",
      },
    ],
    folder_id: googleFolderMyFolder.folderId,
    notification_emails: ["testuser@example.com", "example.user@example.com"],
  }
);

```

## Example Usage - Folder Access Approval Active Key Version

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleFolderMyFolder = new google.folder.Folder(this, "my_folder", {
  display_name: "my-folder",
  parent: "organizations/123456789",
});
const googleProjectMyProject = new google.project.Project(this, "my_project", {
  folder_id: googleFolderMyFolder.name,
  name: "My Project",
  project_id: "your-project-id",
});
const dataGoogleAccessApprovalFolderServiceAccountServiceAccount =
  new google.dataGoogleAccessApprovalFolderServiceAccount.DataGoogleAccessApprovalFolderServiceAccount(
    this,
    "service_account",
    {
      folder_id: googleFolderMyFolder.folderId,
    }
  );
const googleKmsKeyRingKeyRing = new google.kmsKeyRing.KmsKeyRing(
  this,
  "key_ring",
  {
    location: "global",
    name: "key-ring",
    project: googleProjectMyProject.projectId,
  }
);
const googleKmsCryptoKeyCryptoKey = new google.kmsCryptoKey.KmsCryptoKey(
  this,
  "crypto_key",
  {
    key_ring: googleKmsKeyRingKeyRing.id,
    name: "crypto-key",
    purpose: "ASYMMETRIC_SIGN",
    version_template: [
      {
        algorithm: "EC_SIGN_P384_SHA384",
      },
    ],
  }
);
const googleKmsCryptoKeyIamMemberIam =
  new google.kmsCryptoKeyIamMember.KmsCryptoKeyIamMember(this, "iam", {
    crypto_key_id: googleKmsCryptoKeyCryptoKey.id,
    member: `serviceAccount:\${${dataGoogleAccessApprovalFolderServiceAccountServiceAccount.accountEmail}}`,
    role: "roles/cloudkms.signerVerifier",
  });
const dataGoogleKmsCryptoKeyVersionCryptoKeyVersion =
  new google.dataGoogleKmsCryptoKeyVersion.DataGoogleKmsCryptoKeyVersion(
    this,
    "crypto_key_version",
    {
      crypto_key: googleKmsCryptoKeyCryptoKey.id,
    }
  );
new google.folderAccessApprovalSettings.FolderAccessApprovalSettings(
  this,
  "folder_access_approval",
  {
    active_key_version: dataGoogleKmsCryptoKeyVersionCryptoKeyVersion.name,
    depends_on: [`\${${googleKmsCryptoKeyIamMemberIam.fqn}}`],
    enrolled_services: [
      {
        cloud_product: "all",
      },
    ],
    folder_id: googleFolderMyFolder.folderId,
  }
);

```

## Argument Reference

The following arguments are supported:

*   `enrolledServices` -
    (Required)
    A list of Google Cloud Services for which the given resource has Access Approval enrolled.
    Access requests for the resource given by name against any of these services contained here will be required
    to have explicit approval. Enrollment can only be done on an all or nothing basis.
    A maximum of 10 enrolled services will be enforced, to be expanded as the set of supported services is expanded.
    Structure is [documented below](#nested_enrolled_services).

*   `folderId` -
    (Required)
    ID of the folder of the access approval settings.

<a name="nested_enrolled_services"></a>The `enrolledServices` block supports:

*   `cloudProduct` -
    (Required)
    The product for which Access Approval will be enrolled. Allowed values are listed (case-sensitive):
    * all
    * App Engine
    * BigQuery
    * Cloud Bigtable
    * Cloud Key Management Service
    * Compute Engine
    * Cloud Dataflow
    * Cloud Identity and Access Management
    * Cloud Pub/Sub
    * Cloud Storage
    * Persistent Disk
      Note: These values are supported as input, but considered a legacy format:
    * all
    * appengine.googleapis.com
    * bigquery.googleapis.com
    * bigtable.googleapis.com
    * cloudkms.googleapis.com
    * compute.googleapis.com
    * dataflow.googleapis.com
    * iam.googleapis.com
    * pubsub.googleapis.com
    * storage.googleapis.com

*   `enrollmentLevel` -
    (Optional)
    The enrollment level of the service.
    Default value is `blockAll`.
    Possible values are `blockAll`.

***

*   `notificationEmails` -
    (Optional)
    A list of email addresses to which notifications relating to approval requests should be sent.
    Notifications relating to a resource will be sent to all emails in the settings of ancestor
    resources of that resource. A maximum of 50 email addresses are allowed.

*   `activeKeyVersion` -
    (Optional)
    The asymmetric crypto key version to use for signing approval requests.
    Empty active\_key\_version indicates that a Google-managed key should be used for signing.
    This property will be ignored if set by an ancestor of the resource, and new non-empty values may not be set.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `folders/{{folderId}}/accessApprovalSettings`

*   `name` -
    The resource name of the settings. Format is "folders/{folder\_id}/accessApprovalSettings"

*   `enrolledAncestor` -
    If the field is true, that indicates that at least one service is enrolled for Access Approval in one or more ancestors of the Folder.

*   `ancestorHasActiveKeyVersion` -
    If the field is true, that indicates that an ancestor of this Folder has set active\_key\_version.

*   `invalidKeyVersion` -
    If the field is true, that indicates that there is some configuration issue with the active\_key\_version
    configured on this Folder (e.g. it doesn't exist or the Access Approval service account doesn't have the
    correct permissions on it, etc.) This key version is not necessarily the effective key version at this level,
    as key versions are inherited top-down.

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `update` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

FolderSettings can be imported using any of these accepted formats:

```console
$ terraform import google_folder_access_approval_settings.default folders/{{folder_id}}/accessApprovalSettings
$ terraform import google_folder_access_approval_settings.default {{folder_id}}
```
