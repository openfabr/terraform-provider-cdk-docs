---
subcategory: "Compute Engine"
description: |-
  Get information about a HealthCheck.
---

# googleComputeHealthCheck

Get information about a HealthCheck.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.dataGoogleComputeHealthCheck.DataGoogleComputeHealthCheck(
  this,
  "health_check",
  {
    name: "my-hc",
  }
);

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) Name of the resource.

***

* `project` - (Optional) The ID of the project in which the resource belongs. If it
  is not provided, the provider project is used.

## Attributes Reference

See [google\_compute\_health\_check](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check) resource for details of the available attributes.
