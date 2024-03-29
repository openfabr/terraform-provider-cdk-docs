---
subcategory: "Compute Engine"
description: |-
  Manages a VM instance resource within GCE.
---

\~> **Warning:** This resource is in beta, and should be used with the terraform-provider-google-beta provider.
See [Provider Versions](https://terraform.io/docs/providers/google/guides/provider_versions.html) for more details on beta resources.

# googleComputeInstanceFromMachineImage

Manages a VM instance resource within GCE. For more information see
[the official documentation](https://cloud.google.com/compute/docs/instances)
and
[API](https://cloud.google.com/compute/docs/reference/latest/instances).

This resource is specifically to create a compute instance from a given
`sourceMachineImage`. To create an instance without a machine image, use the
`googleComputeInstance` resource.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.computeInstanceFromMachineImage.ComputeInstanceFromMachineImage(
  this,
  "tpl",
  {
    can_ip_forward: false,
    labels: [
      {
        my_key: "my_value",
      },
    ],
    name: "instance-from-machine-image",
    provider: "${google-beta}",
    source_machine_image: "projects/PROJECT-ID/global/machineImages/NAME",
    zone: "us-central1-a",
  }
);

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) A unique name for the resource, required by GCE.
    Changing this forces a new resource to be created.

*   `sourceMachineImage` - (Required) Name or self link of a machine
    image to create the instance based on.

***

* `zone` - (Optional) The zone that the machine should be created in. If not
  set, the provider zone is used.

In addition to these, most\* arguments from `googleComputeInstance` are supported
as a way to override the properties in the machine image. All exported attributes
from `googleComputeInstance` are likewise exported here.

\~> **Warning:** \*Due to API limitations, disk overrides are currently disabled. This includes the "boot\_disk", "attached\_disk", and "scratch\_disk" fields.

## Attributes Reference

All exported attributes from `googleComputeInstance` are exported here.
See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute\_instance#attributes-reference
for details.

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options: configuration options:

* `create` - Default is 6 minutes.
* `update` - Default is 6 minutes.
* `delete` - Default is 6 minutes.
