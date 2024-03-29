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
subcategory: "Compute Engine"
description: |-
  A Global Network endpoint represents a IP address and port combination that exists outside of GCP.
---

# googleComputeGlobalNetworkEndpoint

A Global Network endpoint represents a IP address and port combination that exists outside of GCP.
**NOTE**: Global network endpoints cannot be created outside of a
global network endpoint group.

To get more information about GlobalNetworkEndpoint, see:

* [API documentation](https://cloud.google.com/compute/docs/reference/rest/beta/networkEndpointGroups)
* How-to Guides
  * [Official Documentation](https://cloud.google.com/load-balancing/docs/negs/)

## Example Usage - Global Network Endpoint

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleComputeGlobalNetworkEndpointGroupNeg =
  new google.computeGlobalNetworkEndpointGroup.ComputeGlobalNetworkEndpointGroup(
    this,
    "neg",
    {
      default_port: "90",
      name: "my-lb-neg",
      network_endpoint_type: "INTERNET_FQDN_PORT",
    }
  );
new google.computeGlobalNetworkEndpoint.ComputeGlobalNetworkEndpoint(
  this,
  "default-endpoint",
  {
    fqdn: "www.example.com",
    global_network_endpoint_group:
      googleComputeGlobalNetworkEndpointGroupNeg.name,
    port: 90,
  }
);

```

## Argument Reference

The following arguments are supported:

*   `port` -
    (Required)
    Port number of the external endpoint.

*   `globalNetworkEndpointGroup` -
    (Required)
    The global network endpoint group this endpoint is part of.

***

*   `ipAddress` -
    (Optional)
    IPv4 address external endpoint.

*   `fqdn` -
    (Optional)
    Fully qualified domain name of network endpoint.
    This can only be specified when network\_endpoint\_type of the NEG is INTERNET\_FQDN\_PORT.

*   `project` - (Optional) The ID of the project in which the resource belongs.
    If it is not provided, the provider project is used.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

* `id` - an identifier for the resource with format `{{project}}/{{globalNetworkEndpointGroup}}/{{ipAddress}}/{{fqdn}}/{{port}}`

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

GlobalNetworkEndpoint can be imported using any of these accepted formats:

```console
$ terraform import google_compute_global_network_endpoint.default projects/{{project}}/global/networkEndpointGroups/{{global_network_endpoint_group}}/{{ip_address}}/{{fqdn}}/{{port}}
$ terraform import google_compute_global_network_endpoint.default {{project}}/{{global_network_endpoint_group}}/{{ip_address}}/{{fqdn}}/{{port}}
$ terraform import google_compute_global_network_endpoint.default {{global_network_endpoint_group}}/{{ip_address}}/{{fqdn}}/{{port}}
```

## User Project Overrides

This resource supports [User Project Overrides](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#user_project_override).
