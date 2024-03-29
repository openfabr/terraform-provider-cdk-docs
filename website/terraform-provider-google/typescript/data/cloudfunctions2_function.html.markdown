---
subcategory: "Cloud Functions (2nd gen)"
description: |-
  Get information about a Google Cloud Function (2nd gen).
---

# googleCloudfunctions2Function

Get information about a Google Cloud Function (2nd gen). For more information see:

* [API documentation](https://cloud.google.com/functions/docs/reference/rest/v2beta/projects.locations.functions).

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.dataGoogleCloudfunctions2Function.DataGoogleCloudfunctions2Function(
  this,
  "my-function",
  {
    location: "us-central1",
    name: "function",
  }
);

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of a Cloud Function (2nd gen).

*   `location` - (Required) The location in which the resource belongs.

***

* `project` - (Optional) The project in which the resource belongs. If it
  is not provided, the provider project is used.

## Attributes Reference

See [google\_cloudfunctions2\_function](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function) resource for details of all the available attributes.
