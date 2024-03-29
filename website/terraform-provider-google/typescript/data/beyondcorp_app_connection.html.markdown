---
subcategory: "BeyondCorp"
description: |-
  Get information about a Google BeyondCorp App Connection.
---

# googleBeyondcorpAppConnection

Get information about a Google BeyondCorp App Connection.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.dataGoogleBeyondcorpAppConnection.DataGoogleBeyondcorpAppConnection(
  this,
  "my-beyondcorp-app-connection",
  {
    name: "my-beyondcorp-app-connection",
  }
);

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the App Connection.

***

*   `project` - (Optional) The project in which the resource belongs. If it
    is not provided, the provider project is used.

*   `region` - (Optional) The region in which the resource belongs. If it
    is not provided, the provider region is used.

## Attributes Reference

See [google\_beyondcorp\_app\_connection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/beyondcorp_app_connection) resource for details of the available attributes.
