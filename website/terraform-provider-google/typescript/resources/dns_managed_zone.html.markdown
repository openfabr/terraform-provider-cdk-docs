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
subcategory: "Cloud DNS"
description: |-
  A zone is a subtree of the DNS namespace under one administrative
  responsibility.
---

# googleDnsManagedZone

A zone is a subtree of the DNS namespace under one administrative
responsibility. A ManagedZone is a resource that represents a DNS zone
hosted by the Cloud DNS service.

To get more information about ManagedZone, see:

* [API documentation](https://cloud.google.com/dns/api/v1/managedZones)
* How-to Guides
  * [Managing Zones](https://cloud.google.com/dns/zones/)

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=dns_managed_zone_basic&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Dns Managed Zone Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
import * as random from "./.gen/providers/random";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google, random.
For a more precise conversion please use the --provider flag in convert.*/
const randomIdRnd = new random.id.Id(this, "rnd", {
  byte_length: 4,
});
new google.dnsManagedZone.DnsManagedZone(this, "example-zone", {
  description: "Example DNS zone",
  dns_name: `example-\${${randomIdRnd.hex}}.com.`,
  labels: [
    {
      foo: "bar",
    },
  ],
  name: "example-zone",
});

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=dns_managed_zone_private&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Dns Managed Zone Private

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleComputeNetworkNetwork1 = new google.computeNetwork.ComputeNetwork(
  this,
  "network-1",
  {
    auto_create_subnetworks: false,
    name: "network-1",
  }
);
const googleComputeNetworkNetwork2 = new google.computeNetwork.ComputeNetwork(
  this,
  "network-2",
  {
    auto_create_subnetworks: false,
    name: "network-2",
  }
);
new google.dnsManagedZone.DnsManagedZone(this, "private-zone", {
  description: "Example private DNS zone",
  dns_name: "private.example.com.",
  labels: [
    {
      foo: "bar",
    },
  ],
  name: "private-zone",
  private_visibility_config: [
    {
      networks: [
        {
          network_url: googleComputeNetworkNetwork1.id,
        },
        {
          network_url: googleComputeNetworkNetwork2.id,
        },
      ],
    },
  ],
  visibility: "private",
});

```

## Example Usage - Dns Managed Zone Private Forwarding

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleComputeNetworkNetwork1 = new google.computeNetwork.ComputeNetwork(
  this,
  "network-1",
  {
    auto_create_subnetworks: false,
    name: "network-1",
  }
);
const googleComputeNetworkNetwork2 = new google.computeNetwork.ComputeNetwork(
  this,
  "network-2",
  {
    auto_create_subnetworks: false,
    name: "network-2",
  }
);
new google.dnsManagedZone.DnsManagedZone(this, "private-zone", {
  description: "Example private DNS zone",
  dns_name: "private.example.com.",
  forwarding_config: [
    {
      target_name_servers: [
        {
          ipv4_address: "172.16.1.10",
        },
        {
          ipv4_address: "172.16.1.20",
        },
      ],
    },
  ],
  labels: [
    {
      foo: "bar",
    },
  ],
  name: "private-zone",
  private_visibility_config: [
    {
      networks: [
        {
          network_url: googleComputeNetworkNetwork1.id,
        },
        {
          network_url: googleComputeNetworkNetwork2.id,
        },
      ],
    },
  ],
  visibility: "private",
});

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=dns_managed_zone_private_gke&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Dns Managed Zone Private Gke

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleComputeNetworkNetwork1 = new google.computeNetwork.ComputeNetwork(
  this,
  "network-1",
  {
    auto_create_subnetworks: false,
    name: "network-1",
  }
);
const googleComputeSubnetworkSubnetwork1 =
  new google.computeSubnetwork.ComputeSubnetwork(this, "subnetwork-1", {
    ip_cidr_range: "10.0.36.0/24",
    name: googleComputeNetworkNetwork1.name,
    network: googleComputeNetworkNetwork1.name,
    private_ip_google_access: true,
    region: "us-central1",
    secondary_ip_range: [
      {
        ip_cidr_range: "10.0.0.0/19",
        range_name: "pod",
      },
      {
        ip_cidr_range: "10.0.32.0/22",
        range_name: "svc",
      },
    ],
  });
const googleContainerClusterCluster1 =
  new google.containerCluster.ContainerCluster(this, "cluster-1", {
    default_snat_status: [
      {
        disabled: true,
      },
    ],
    initial_node_count: 1,
    ip_allocation_policy: [
      {
        cluster_secondary_range_name: `\${${googleComputeSubnetworkSubnetwork1.secondaryIpRange.fqn}[0].range_name}`,
        services_secondary_range_name: `\${${googleComputeSubnetworkSubnetwork1.secondaryIpRange.fqn}[1].range_name}`,
      },
    ],
    location: "us-central1-c",
    master_authorized_networks_config: [{}],
    name: "cluster-1",
    network: googleComputeNetworkNetwork1.name,
    networking_mode: "VPC_NATIVE",
    private_cluster_config: [
      {
        enable_private_endpoint: true,
        enable_private_nodes: true,
        master_global_access_config: [
          {
            enabled: true,
          },
        ],
        master_ipv4_cidr_block: "10.42.0.0/28",
      },
    ],
    subnetwork: googleComputeSubnetworkSubnetwork1.name,
  });
new google.dnsManagedZone.DnsManagedZone(this, "private-zone-gke", {
  description: "Example private DNS zone",
  dns_name: "private.example.com.",
  labels: [
    {
      foo: "bar",
    },
  ],
  name: "private-zone",
  private_visibility_config: [
    {
      gke_clusters: [
        {
          gke_cluster_name: googleContainerClusterCluster1.id,
        },
      ],
      networks: [
        {
          network_url: googleComputeNetworkNetwork1.id,
        },
      ],
    },
  ],
  visibility: "private",
});

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=dns_managed_zone_private_peering&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Dns Managed Zone Private Peering

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleComputeNetworkNetworkSource =
  new google.computeNetwork.ComputeNetwork(this, "network-source", {
    auto_create_subnetworks: false,
    name: "network-source",
  });
const googleComputeNetworkNetworkTarget =
  new google.computeNetwork.ComputeNetwork(this, "network-target", {
    auto_create_subnetworks: false,
    name: "network-target",
  });
new google.dnsManagedZone.DnsManagedZone(this, "peering-zone", {
  description: "Example private DNS peering zone",
  dns_name: "peering.example.com.",
  name: "peering-zone",
  peering_config: [
    {
      target_network: [
        {
          network_url: googleComputeNetworkNetworkTarget.id,
        },
      ],
    },
  ],
  private_visibility_config: [
    {
      networks: [
        {
          network_url: googleComputeNetworkNetworkSource.id,
        },
      ],
    },
  ],
  visibility: "private",
});

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=dns_managed_zone_service_directory&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Dns Managed Zone Service Directory

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.computeNetwork.ComputeNetwork(this, "network", {
  auto_create_subnetworks: false,
  name: "network",
  provider: "${google-beta}",
});
const googleServiceDirectoryNamespaceExample =
  new google.serviceDirectoryNamespace.ServiceDirectoryNamespace(
    this,
    "example",
    {
      location: "us-central1",
      namespace_id: "example",
      provider: "${google-beta}",
    }
  );
new google.dnsManagedZone.DnsManagedZone(this, "sd-zone", {
  description: "Example private DNS Service Directory zone",
  dns_name: "services.example.com.",
  name: "peering-zone",
  provider: "${google-beta}",
  service_directory_config: [
    {
      namespace: [
        {
          namespace_url: googleServiceDirectoryNamespaceExample.id,
        },
      ],
    },
  ],
  visibility: "private",
});

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=dns_managed_zone_cloud_logging&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Dns Managed Zone Cloud Logging

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.dnsManagedZone.DnsManagedZone(this, "cloud-logging-enabled-zone", {
  cloud_logging_config: [
    {
      enable_logging: true,
    },
  ],
  description: "Example cloud logging enabled DNS zone",
  dns_name: "services.example.com.",
  labels: [
    {
      foo: "bar",
    },
  ],
  name: "cloud-logging-enabled-zone",
});

```

## Argument Reference

The following arguments are supported:

*   `dnsName` -
    (Required)
    The DNS name of this managed zone, for instance "example.com.".

*   `name` -
    (Required)
    User assigned name for this resource.
    Must be unique within the project.

***

*   `description` -
    (Optional)
    A textual description field. Defaults to 'Managed by Terraform'.

*   `dnssecConfig` -
    (Optional)
    DNSSEC configuration
    Structure is [documented below](#nested_dnssec_config).

*   `labels` -
    (Optional)
    A set of key/value label pairs to assign to this ManagedZone.

*   `visibility` -
    (Optional)
    The zone's visibility: public zones are exposed to the Internet,
    while private zones are visible only to Virtual Private Cloud resources.
    Default value is `public`.
    Possible values are `private` and `public`.

*   `privateVisibilityConfig` -
    (Optional)
    For privately visible zones, the set of Virtual Private Cloud
    resources that the zone is visible from.
    Structure is [documented below](#nested_private_visibility_config).

*   `forwardingConfig` -
    (Optional)
    The presence for this field indicates that outbound forwarding is enabled
    for this zone. The value of this field contains the set of destinations
    to forward to.
    Structure is [documented below](#nested_forwarding_config).

*   `peeringConfig` -
    (Optional)
    The presence of this field indicates that DNS Peering is enabled for this
    zone. The value of this field contains the network to peer with.
    Structure is [documented below](#nested_peering_config).

*   `reverseLookup` -
    (Optional, [Beta](https://terraform.io/docs/providers/google/guides/provider_versions.html))
    Specifies if this is a managed reverse lookup zone. If true, Cloud DNS will resolve reverse
    lookup queries using automatically configured records for VPC resources. This only applies
    to networks listed under `privateVisibilityConfig`.

*   `serviceDirectoryConfig` -
    (Optional, [Beta](https://terraform.io/docs/providers/google/guides/provider_versions.html))
    The presence of this field indicates that this zone is backed by Service Directory. The value of this field contains information related to the namespace associated with the zone.
    Structure is [documented below](#nested_service_directory_config).

*   `cloudLoggingConfig` -
    (Optional)
    Cloud logging configuration
    Structure is [documented below](#nested_cloud_logging_config).

*   `project` - (Optional) The ID of the project in which the resource belongs.
    If it is not provided, the provider project is used.

*   `forceDestroy` - (Optional) Set this true to delete all records in the zone.

<a name="nested_dnssec_config"></a>The `dnssecConfig` block supports:

*   `kind` -
    (Optional)
    Identifies what kind of resource this is

*   `nonExistence` -
    (Optional)
    Specifies the mechanism used to provide authenticated denial-of-existence responses.
    non\_existence can only be updated when the state is `off`.
    Possible values are `nsec` and `nsec3`.

*   `state` -
    (Optional)
    Specifies whether DNSSEC is enabled, and what mode it is in
    Possible values are `off`, `on`, and `transfer`.

*   `defaultKeySpecs` -
    (Optional)
    Specifies parameters that will be used for generating initial DnsKeys
    for this ManagedZone. If you provide a spec for keySigning or zoneSigning,
    you must also provide one for the other.
    default\_key\_specs can only be updated when the state is `off`.
    Structure is [documented below](#nested_default_key_specs).

<a name="nested_default_key_specs"></a>The `defaultKeySpecs` block supports:

*   `algorithm` -
    (Optional)
    String mnemonic specifying the DNSSEC algorithm of this key
    Possible values are `ecdsap256Sha256`, `ecdsap384Sha384`, `rsasha1`, `rsasha256`, and `rsasha512`.

*   `keyLength` -
    (Optional)
    Length of the keys in bits

*   `keyType` -
    (Optional)
    Specifies whether this is a key signing key (KSK) or a zone
    signing key (ZSK). Key signing keys have the Secure Entry
    Point flag set and, when active, will only be used to sign
    resource record sets of type DNSKEY. Zone signing keys do
    not have the Secure Entry Point flag set and will be used
    to sign all other types of resource record sets.
    Possible values are `keySigning` and `zoneSigning`.

*   `kind` -
    (Optional)
    Identifies what kind of resource this is

<a name="nested_private_visibility_config"></a>The `privateVisibilityConfig` block supports:

*   `gkeClusters` -
    (Optional)
    The list of Google Kubernetes Engine clusters that can see this zone.
    Structure is [documented below](#nested_gke_clusters).

*   `networks` -
    (Required)
    The list of VPC networks that can see this zone. Until the provider updates to use the Terraform 0.12 SDK in a future release, you
    may experience issues with this resource while updating. If you've defined a `networks` block and
    add another `networks` block while keeping the old block, Terraform will see an incorrect diff
    and apply an incorrect update to the resource. If you encounter this issue, remove all `networks`
    blocks in an update and then apply another update adding all of them back simultaneously.
    Structure is [documented below](#nested_networks).

<a name="nested_gke_clusters"></a>The `gkeClusters` block supports:

* `gkeClusterName` -
  (Required)
  The resource name of the cluster to bind this ManagedZone to.\
  This should be specified in the format like\
  `projects/*/locations/*/clusters/*`

<a name="nested_networks"></a>The `networks` block supports:

* `networkUrl` -
  (Required)
  The id or fully qualified URL of the VPC network to bind to.
  This should be formatted like `projects/{project}/global/networks/{network}` or
  `https://wwwGoogleapisCom/compute/v1/projects/{project}/global/networks/{network}`

<a name="nested_forwarding_config"></a>The `forwardingConfig` block supports:

* `targetNameServers` -
  (Required)
  List of target name servers to forward to. Cloud DNS will
  select the best available name server if more than
  one target is given.
  Structure is [documented below](#nested_target_name_servers).

<a name="nested_target_name_servers"></a>The `targetNameServers` block supports:

*   `ipv4Address` -
    (Required)
    IPv4 address of a target name server.

*   `forwardingPath` -
    (Optional)
    Forwarding path for this TargetNameServer. If unset or `default` Cloud DNS will make forwarding
    decision based on address ranges, i.e. RFC1918 addresses go to the VPC, Non-RFC1918 addresses go
    to the Internet. When set to `private`, Cloud DNS will always send queries through VPC for this target
    Possible values are `default` and `private`.

<a name="nested_peering_config"></a>The `peeringConfig` block supports:

* `targetNetwork` -
  (Required)
  The network with which to peer.
  Structure is [documented below](#nested_target_network).

<a name="nested_target_network"></a>The `targetNetwork` block supports:

* `networkUrl` -
  (Required)
  The id or fully qualified URL of the VPC network to forward queries to.
  This should be formatted like `projects/{project}/global/networks/{network}` or
  `https://wwwGoogleapisCom/compute/v1/projects/{project}/global/networks/{network}`

<a name="nested_service_directory_config"></a>The `serviceDirectoryConfig` block supports:

* `namespace` -
  (Required)
  The namespace associated with the zone.
  Structure is [documented below](#nested_namespace).

<a name="nested_namespace"></a>The `namespace` block supports:

* `namespaceUrl` -
  (Required)
  The fully qualified or partial URL of the service directory namespace that should be
  associated with the zone. This should be formatted like
  `https://servicedirectoryGoogleapisCom/v1/projects/{project}/locations/{location}/namespaces/{namespaceId}`
  or simply `projects/{project}/locations/{location}/namespaces/{namespaceId}`
  Ignored for `public` visibility zones.

<a name="nested_cloud_logging_config"></a>The `cloudLoggingConfig` block supports:

* `enableLogging` -
  (Required)
  If set, enable query logging for this ManagedZone. False by default, making logging opt-in.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `projects/{{project}}/managedZones/{{name}}`

*   `managedZoneId` -
    Unique identifier for the resource; defined by the server.

*   `nameServers` -
    Delegate your managed\_zone to these virtual name servers;
    defined by the server

*   `creationTime` -
    The time that this resource was created on the server.
    This is in RFC3339 text format.

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `update` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

ManagedZone can be imported using any of these accepted formats:

```console
$ terraform import google_dns_managed_zone.default projects/{{project}}/managedZones/{{name}}
$ terraform import google_dns_managed_zone.default {{project}}/{{name}}
$ terraform import google_dns_managed_zone.default {{name}}
```

## User Project Overrides

This resource supports [User Project Overrides](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#user_project_override).
