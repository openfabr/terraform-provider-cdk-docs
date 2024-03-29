---
subcategory: "Cloud Platform"
description: |-
  Get information about a Google Cloud Folder.
---

# googleFolder

Use this data source to get information about a Google Cloud Folder.

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const dataGoogleFolderMyFolder1 = new google.dataGoogleFolder.DataGoogleFolder(
  this,
  "my_folder_1",
  {
    folder: "folders/12345",
    lookup_organization: true,
  }
);
const dataGoogleFolderMyFolder2 = new google.dataGoogleFolder.DataGoogleFolder(
  this,
  "my_folder_2",
  {
    folder: "folders/23456",
  }
);
new cdktf.TerraformOutput(this, "my_folder_1_organization", {
  value: dataGoogleFolderMyFolder1.organization,
});
new cdktf.TerraformOutput(this, "my_folder_2_parent", {
  value: dataGoogleFolderMyFolder2.parent,
});

```

## Argument Reference

The following arguments are supported:

* `folder` (Required) - The name of the Folder in the form `{folderId}` or `folders/{folderId}`.
* `lookupOrganization` (Optional) - `true` to find the organization that the folder belongs, `false` to avoid the lookup. It searches up the tree. (defaults to `false`)

## Attributes Reference

The following attributes are exported:

* `id` - The Folder ID.
* `name` - The resource name of the Folder in the form `folders/{folderId}`.
* `parent` - The resource name of the parent Folder or Organization.
* `displayName` - The folder's display name.
* `createTime` - Timestamp when the Organization was created. A timestamp in RFC3339 UTC "Zulu" format, accurate to nanoseconds. Example: "2014-10-02T15:01:23.045123456Z".
* `lifecycleState` - The Folder's current lifecycle state.
* `organization` - If `lookupOrganization` is enable, the resource name of the Organization that the folder belongs.
