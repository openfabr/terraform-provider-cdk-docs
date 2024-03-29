---
subcategory: "Cloud Composer"
description: |-
  Provides available Cloud Composer versions.
---

# googleComposerImageVersions

Provides access to available Cloud Composer versions in a region for a given project.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const dataGoogleComposerImageVersionsAll =
  new google.dataGoogleComposerImageVersions.DataGoogleComposerImageVersions(
    this,
    "all",
    {}
  );
new google.composerEnvironment.ComposerEnvironment(this, "test", {
  config: [
    {
      software_config: [
        {
          image_version: `\${${dataGoogleComposerImageVersionsAll.imageVersions.fqn}[0].image_version_id}`,
        },
      ],
    },
  ],
  name: "test-env",
  region: "us-central1",
});

```

## Argument Reference

The following arguments are supported:

*   `project` - (Optional) The ID of the project to list versions in.
    If it is not provided, the provider project is used.

*   `region` - (Optional) The location to list versions in.
    If it is not provider, the provider region is used.

## Attributes Reference

The following attributes are exported:

* `imageVersions` - A list of composer image versions available in the given project and location. Each `imageVersion` contains:
  * `imageVersionId` - The string identifier of the image version, in the form: "composer-x.y.z-airflow-a.b.c"
  * `supportedPythonVersions` - Supported python versions for this image version
