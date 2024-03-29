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
subcategory: "Firebase"
description: |-
  A Google Cloud Firebase Android application instance
---

# googleFirebaseAndroidApp

A Google Cloud Firebase Android application instance

\~> **Warning:** This resource is in beta, and should be used with the terraform-provider-google-beta provider.
See [Provider Versions](https://terraform.io/docs/providers/google/guides/provider_versions.html) for more details on beta resources.

To get more information about AndroidApp, see:

* [API documentation](https://firebase.google.com/docs/reference/firebase-management/rest/v1beta1/projects.androidApps)
* How-to Guides
  * [Official Documentation](https://firebase.google.com/docs/android/setup)

## Example Usage - Firebase Android App Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.firebaseAndroidApp.FirebaseAndroidApp(this, "basic", {
  display_name: "Display Name Basic",
  package_name: "",
  project: "my-project-name",
  provider: "${google-beta}",
  sha1_hashes: ["2145bdf698b8715039bd0e83f2069bed435ac21c"],
  sha256_hashes: [
    "2145bdf698b8715039bd0e83f2069bed435ac21ca1b2c3d4e5f6123456789abc",
  ],
});

```

## Argument Reference

The following arguments are supported:

* `displayName` -
  (Required)
  The user-assigned display name of the AndroidApp.

***

*   `packageName` -
    (Optional)
    Immutable. The canonical package name of the Android app as would appear in the Google Play
    Developer Console.

*   `sha1Hashes` -
    (Optional)
    The SHA1 certificate hashes for the AndroidApp.

*   `sha256Hashes` -
    (Optional)
    The SHA256 certificate hashes for the AndroidApp.

*   `project` - (Optional) The ID of the project in which the resource belongs.
    If it is not provided, the provider project is used.

*   `deletionPolicy` - (Optional) (Optional) Set to `abandon` to allow the AndroidApp to be untracked from terraform state
    rather than deleted upon `terraformDestroy`. This is useful because the AndroidApp may be
    serving traffic. Set to `delete` to delete the AndroidApp. Defaults to `delete`.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `{{name}}`

*   `name` -
    The fully qualified resource name of the AndroidApp, for example:
    projects/projectId/androidApps/appId

*   `appId` -
    The globally unique, Firebase-assigned identifier of the AndroidApp.
    This identifier should be treated as an opaque token, as the data format is not specified.

*   `etag` -
    This checksum is computed by the server based on the value of other fields, and it may be sent
    with update requests to ensure the client has an up-to-date value before proceeding.

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `update` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

AndroidApp can be imported using any of these accepted formats:

```console
$ terraform import google_firebase_android_app.default projects/{{project}}/androidApps/{{appId}}
$ terraform import google_firebase_android_app.default {{project}}/{{appId}}
$ terraform import google_firebase_android_app.default androidApps/{{appId}}
$ terraform import google_firebase_android_app.default {{appId}}
```

## User Project Overrides

This resource supports [User Project Overrides](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#user_project_override).
