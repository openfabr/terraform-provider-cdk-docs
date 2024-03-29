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
subcategory: "Apigee"
page_title: "Google: google_apigee_shared_flow"
description: |-
  You can combine policies and resources into a shared flow that you can consume from multiple API proxies, and even from other shared flows.
---

# googleApigeeSharedFlow

You can combine policies and resources into a shared flow that you can consume from multiple API proxies, and even from other shared flows. Although it's like a proxy, a shared flow has no endpoint. It can be used only from an API proxy or shared flow that's in the same organization as the shared flow itself.

To get more information about SharedFlow, see:

* [API documentation](https://cloud.google.com/apigee/docs/reference/apis/apigee/rest/v1/organizations.sharedflows)
* How-to Guides
  * [Sharedflows](https://cloud.google.com/apigee/docs/resources)

## Argument Reference

The following arguments are supported:

*   `name` -
    (Required)
    The ID of the shared flow.

*   `orgId` -
    (Required)
    The Apigee Organization associated with the Apigee instance,
    in the format `organizations/{{orgName}}`.

***

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `organizations/{{orgId}}/sharedflows/{{name}}`

*   `metaData` -
    Metadata describing the shared flow.
    Structure is [documented below](#nested_meta_data).

*   `revision` -
    A list of revisions of this shared flow.

*   `latestRevisionId` -
    The id of the most recently created revision for this shared flow.

*   `md5Hash` -
    (Computed) Base 64 MD5 hash of the uploaded data. It is speculative as remote does not return hash of the bundle. Remote changes are detected using returned last\_modified timestamp.

*   `detectMd5Hash` -
    (Optional) Detect changes to local config bundle file or changes made outside of Terraform. MD5 hash of the data, encoded using base64. Hash is automatically computed without need for user input.

<a name="nested_meta_data"></a>The `metaData` block contains:

*   `createdAt` -
    (Optional)
    Time at which the API proxy was created, in milliseconds since epoch.

*   `lastModifiedAt` -
    (Optional)
    Time at which the API proxy was most recently modified, in milliseconds since epoch.

*   `subType` -
    (Optional)
    The type of entity described

## Timeouts

This resource provides the following
[Timeouts](/docs/configuration/resources.html#timeouts) configuration options:

* `create` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

SharedFlow can be imported using any of these accepted formats:

```console
$ terraform import google_apigee_shared_flow.default {{org_id}}/sharedflows/{{name}}
$ terraform import google_apigee_sharedflow.default {{org_id}}/{{name}}
```
