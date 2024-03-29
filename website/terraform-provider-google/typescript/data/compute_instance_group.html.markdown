---
subcategory: "Compute Engine"
description: |-
  Get a Compute Instance Group within GCE.
---

# googleComputeInstanceGroup

Get a Compute Instance Group within GCE.
For more information, see [the official documentation](https://cloud.google.com/compute/docs/instance-groups/#unmanaged_instance_groups)
and [API](https://cloud.google.com/compute/docs/reference/latest/instanceGroups)

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.dataGoogleComputeInstanceGroup.DataGoogleComputeInstanceGroup(
  this,
  "all",
  {
    name: "instance-group-name",
    zone: "us-central1-a",
  }
);

```

## Argument Reference

The following arguments are supported:

*   `name` - (Optional) The name of the instance group. Either `name` or `selfLink` must be provided.

*   `project` - (Optional) The ID of the project in which the resource belongs. If it
    is not provided, the provider project is used.

*   `selfLink` - (Optional) The self link of the instance group. Either `name` or `selfLink` must be provided.

*   `zone` - (Optional) The zone of the instance group. If referencing the instance group by name
    and `zone` is not provided, the provider zone is used.

## Attributes Reference

The following arguments are exported:

*   `description` - Textual description of the instance group.

*   `instances` - List of instances in the group.

*   `namedPort` - List of named ports in the group.

*   `network` - The URL of the network the instance group is in.

*   `selfLink` - The URI of the resource.

*   `size` - The number of instances in the group.
