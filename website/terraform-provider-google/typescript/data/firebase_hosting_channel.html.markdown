---
subcategory: "Firebase"
page_title: "Google: google_firebase_hosting_channel"
description: |-
  A Google Cloud Firebase Hosting Channel instance
---

# googleFirebaseHostingChannel

A Google Cloud Firebase Hosting Channel instance

\~> **Warning:** This resource is in beta, and should be used with the terraform-provider-google-beta provider.
See [Provider Versions](https://terraform.io/docs/providers/google/guides/provider_versions.html) for more details on beta resources.

## Argument Reference

The following arguments are supported:

*   `siteId` -
    (Required)
    The ID of the site this channel belongs to.

*   `channelId` -
    (Required)
    The ID of the channel. Use `channelId = "live"` for the default channel of a site.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - An identifier for the resource with format `sites/{{siteId}}/channels/{{channelId}}`. Same as `name`

*   `name` - The fully-qualified resource name for the channel, in the format: `sites/{{siteId}}/channels/{{channelId}}`.
