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
description: |-
  Apigee Endpoint Attachment.
---

# googleApigeeEndpointAttachment

Apigee Endpoint Attachment.

To get more information about EndpointAttachment, see:

* [API documentation](https://cloud.google.com/apigee/docs/reference/apis/apigee/rest/v1/organizations.endpointAttachments/create)
* How-to Guides
  * [Creating an environment](https://cloud.google.com/apigee/docs/api-platform/get-started/create-environment)

## Example Usage - Apigee Endpoint Attachment Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleComputeNetworkApigeeNetwork =
  new google.computeNetwork.ComputeNetwork(this, "apigee_network", {
    name: "apigee-network",
  });
const dataGoogleClientConfigCurrent =
  new google.dataGoogleClientConfig.DataGoogleClientConfig(this, "current", {});
const googleComputeGlobalAddressApigeeRange =
  new google.computeGlobalAddress.ComputeGlobalAddress(this, "apigee_range", {
    address_type: "INTERNAL",
    name: "apigee-range",
    network: googleComputeNetworkApigeeNetwork.id,
    prefix_length: 16,
    purpose: "VPC_PEERING",
  });
const googleServiceNetworkingConnectionApigeeVpcConnection =
  new google.serviceNetworkingConnection.ServiceNetworkingConnection(
    this,
    "apigee_vpc_connection",
    {
      network: googleComputeNetworkApigeeNetwork.id,
      reserved_peering_ranges: [googleComputeGlobalAddressApigeeRange.name],
      service: "servicenetworking.googleapis.com",
    }
  );
const googleApigeeOrganizationApigeeOrg =
  new google.apigeeOrganization.ApigeeOrganization(this, "apigee_org", {
    analytics_region: "us-central1",
    authorized_network: googleComputeNetworkApigeeNetwork.id,
    depends_on: [
      `\${${googleServiceNetworkingConnectionApigeeVpcConnection.fqn}}`,
    ],
    project_id: dataGoogleClientConfigCurrent.project,
  });
new google.apigeeEndpointAttachment.ApigeeEndpointAttachment(
  this,
  "apigee_endpoint_attachment",
  {
    endpoint_attachment_id: "test1",
    location: "{google_compute_service_attachment location}",
    org_id: googleApigeeOrganizationApigeeOrg.id,
    service_attachment: "{google_compute_service_attachment id}",
  }
);

```

## Argument Reference

The following arguments are supported:

*   `location` -
    (Required)
    Location of the endpoint attachment.

*   `serviceAttachment` -
    (Required)
    Format: projects/*/regions/*/serviceAttachments/\*

*   `orgId` -
    (Required)
    The Apigee Organization associated with the Apigee instance,
    in the format `organizations/{{orgName}}`.

*   `endpointAttachmentId` -
    (Required)
    ID of the endpoint attachment.

***

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `{{orgId}}/endpointAttachments/{{endpointAttachmentId}}`

*   `name` -
    Name of the Endpoint Attachment in the following format:
    organizations/{organization}/endpointAttachments/{endpointAttachment}.

*   `host` -
    Host that can be used in either HTTP Target Endpoint directly, or as the host in Target Server.

*   `connectionState` -
    State of the endpoint attachment connection to the service attachment.

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 30 minutes.
* `delete` - Default is 30 minutes.

## Import

EndpointAttachment can be imported using any of these accepted formats:

```console
$ terraform import google_apigee_endpoint_attachment.default {{org_id}}/endpointAttachments/{{endpoint_attachment_id}}
$ terraform import google_apigee_endpoint_attachment.default {{org_id}}/{{endpoint_attachment_id}}
```
