---
subcategory: "Kubernetes (Container) Engine"
description: |-
  Provides lists of available Google Kubernetes Engine versions for masters and nodes.
---

# googleContainerEngineVersions

Provides access to available Google Kubernetes Engine versions in a zone or region for a given project.

\-> If you are using the `googleContainerEngineVersions` datasource with a
regional cluster, ensure that you have provided a region as the `location` to
the datasource. A region can have a different set of supported versions than
its component zones, and not all zones in a region are guaranteed to
support the same version.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const dataGoogleContainerEngineVersionsCentral1B =
  new google.dataGoogleContainerEngineVersions.DataGoogleContainerEngineVersions(
    this,
    "central1b",
    {
      location: "us-central1-b",
      provider: "${google-beta}",
      version_prefix: "1.12.",
    }
  );
new cdktf.TerraformOutput(this, "stable_channel_default_version", {
  value: `\${${dataGoogleContainerEngineVersionsCentral1B.releaseChannelDefaultVersion.fqn}["STABLE"]}`,
});
new cdktf.TerraformOutput(this, "stable_channel_latest_version", {
  value: `\${${dataGoogleContainerEngineVersionsCentral1B.releaseChannelLatestVersion.fqn}["STABLE"]}`,
});
new google.containerCluster.ContainerCluster(this, "foo", {
  initial_node_count: 1,
  location: "us-central1-b",
  name: "terraform-test-cluster",
  node_version: dataGoogleContainerEngineVersionsCentral1B.latestNodeVersion,
});

```

## Argument Reference

The following arguments are supported:

*   `location` (Optional) - The location (region or zone) to list versions for.
    Must exactly match the location the cluster will be deployed in, or listed
    versions may not be available. If `location`, `region`, and `zone` are not
    specified, the provider-level zone must be set and is used instead.

*   `project` (Optional) - ID of the project to list available cluster versions for. Should match the project the cluster will be deployed to.
    Defaults to the project that the provider is authenticated with.

*   `versionPrefix` (Optional) - If provided, Terraform will only return versions
    that match the string prefix. For example, `111` will match all `111` series
    releases. Since this is just a string match, it's recommended that you append a
    `.` after minor versions to ensure that prefixes such as `11` don't match
    versions like `1125Gke10` accidentally. See [the docs on versioning schema](https://cloud.google.com/kubernetes-engine/versioning-and-upgrades#versioning_scheme)
    for full details on how version strings are formatted.

## Attributes Reference

The following attributes are exported:

* `validMasterVersions` - A list of versions available in the given zone for use with master instances.
* `validNodeVersions` - A list of versions available in the given zone for use with node instances.
* `latestMasterVersion` - The latest version available in the given zone for use with master instances.
* `latestNodeVersion` - The latest version available in the given zone for use with node instances.
* `defaultClusterVersion` - Version of Kubernetes the service deploys by default.
* `releaseChannelDefaultVersion` - A map from a release channel name to the channel's default version.
* `releaseChannelLatestVersion` - A map from a release channel name to the channel's latest version.
