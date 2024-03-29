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
subcategory: "Serverless VPC Access"
description: |-
  Serverless VPC Access connector resource.
---

# googleVpcAccessConnector

Serverless VPC Access connector resource.

To get more information about Connector, see:

* [API documentation](https://cloud.google.com/vpc/docs/reference/vpcaccess/rest/v1/projects.locations.connectors)
* How-to Guides
  * [Configuring Serverless VPC Access](https://cloud.google.com/vpc/docs/configure-serverless-vpc-access)

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=vpc_access_connector&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - VPC Access Connector

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.vpcAccessConnector.VpcAccessConnector(this, "connector", {
  ip_cidr_range: "10.8.0.0/28",
  name: "vpc-con",
  network: "default",
});

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=vpc_access_connector_shared_vpc&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - VPC Access Connector Shared VPC

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleComputeNetworkCustomTest = new google.computeNetwork.ComputeNetwork(
  this,
  "custom_test",
  {
    auto_create_subnetworks: false,
    name: "vpc-con",
  }
);
const googleComputeSubnetworkCustomTest =
  new google.computeSubnetwork.ComputeSubnetwork(this, "custom_test_1", {
    ip_cidr_range: "10.2.0.0/28",
    name: "vpc-con",
    network: googleComputeNetworkCustomTest.id,
    region: "us-central1",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
googleComputeSubnetworkCustomTest.overrideLogicalId("custom_test");
new google.vpcAccessConnector.VpcAccessConnector(this, "connector", {
  machine_type: "e2-standard-4",
  name: "vpc-con",
  subnet: [
    {
      name: googleComputeSubnetworkCustomTest.name,
    },
  ],
});

```

## Argument Reference

The following arguments are supported:

* `name` -
  (Required)
  The name of the resource (Max 25 characters).

***

*   `network` -
    (Optional)
    Name or self\_link of the VPC network. Required if `ipCidrRange` is set.

*   `ipCidrRange` -
    (Optional)
    The range of internal addresses that follows RFC 4632 notation. Example: `1013200/28`.

*   `machineType` -
    (Optional)
    Machine type of VM Instance underlying connector. Default is e2-micro

*   `minThroughput` -
    (Optional)
    Minimum throughput of the connector in Mbps. Default and min is 200.

*   `minInstances` -
    (Optional)
    Minimum value of instances in autoscaling group underlying the connector.

*   `maxInstances` -
    (Optional)
    Maximum value of instances in autoscaling group underlying the connector.

*   `maxThroughput` -
    (Optional)
    Maximum throughput of the connector in Mbps, must be greater than `minThroughput`. Default is 300.

*   `subnet` -
    (Optional)
    The subnet in which to house the connector
    Structure is [documented below](#nested_subnet).

*   `region` -
    (Optional)
    Region where the VPC Access connector resides. If it is not provided, the provider region is used.

*   `project` - (Optional) The ID of the project in which the resource belongs.
    If it is not provided, the provider project is used.

<a name="nested_subnet"></a>The `subnet` block supports:

*   `name` -
    (Optional)
    Subnet name (relative, not fully qualified). E.g. if the full subnet selfLink is
    https://compute.googleapis.com/compute/v1/projects/{project}/regions/{region}/subnetworks/{subnetName} the correct input for this field would be {subnetName}"

*   `projectId` -
    (Optional)
    Project in which the subnet exists. If not set, this project is assumed to be the project for which the connector create request was issued.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `projects/{{project}}/locations/{{region}}/connectors/{{name}}`

*   `state` -
    State of the VPC access connector.

*   `selfLink` -
    The fully qualified name of this VPC connector

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

Connector can be imported using any of these accepted formats:

```console
$ terraform import google_vpc_access_connector.default projects/{{project}}/locations/{{region}}/connectors/{{name}}
$ terraform import google_vpc_access_connector.default {{project}}/{{region}}/{{name}}
$ terraform import google_vpc_access_connector.default {{region}}/{{name}}
$ terraform import google_vpc_access_connector.default {{name}}
```

## User Project Overrides

This resource supports [User Project Overrides](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#user_project_override).
