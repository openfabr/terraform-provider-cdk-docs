---
page_title: "Terraform Google Provider 2.0.0 Upgrade Guide"
description: |-
  Terraform Google Provider 2.0.0 Upgrade Guide
---

# Terraform Google Provider 2.0.0 Upgrade Guide

Version `200` of the Google provider for Terraform is a major release and
includes some changes that you will need to consider when upgrading. This guide
is intended to help with that process and focuses only on the changes necessary
to upgrade from version `1200` to `200`.

\-> The "Google provider" refers to both `google` and `googleBeta`; each will
have released `200` at around the same time, and this guide is for both
variants of the Google provider. See [Provider Versions](https://terraform.io/docs/providers/google/guides/provider_versions.html)
for details if you're new to using `googleBeta`.

Most of the changes outlined in this guide have been previously marked as
deprecated in the Terraform `plan`/`apply` output throughout previous provider
releases, up to and including 1.20.0. These changes, such as deprecation notices,
can always be found in the [CHANGELOG](https://github.com/hashicorp/terraform-provider-google/blob/main/CHANGELOG.md).

## Why version 2.0.0?

We introduced version `200` of the Google provider in order to split the
provider into 2 distinct variants; `google`, the provider for the generally
available (GA) GCP APIs, and `googleBeta`, the provider for Beta GCP APIs.

In addition, we made small breaking changes across the provider to enable import
for older resources, enable some new use cases, align field naming / formats
with your expectations based on other GCP tooling, and to facilitate generating
more resources with [Magic Modules](https://github.com/GoogleCloudPlatform/magic-modules).

While you should see some small changes in your configurations as a result of
these changes, we don't expect you'll need to make any major refactorings. As we
develop the provider, we hope to continue to use Magic Modules to provide a
consistent experience across the provider including features like configurable
timeouts, import, and more.

## I accidentally upgraded to 2.0.0, how do I downgrade to `1X`?

If you've inadvertently upgraded to `200`, first see the
[Provider Version Configuration Guide](#provider-version-configuration) to lock
your provider version; if you've constrained the provider to a lower version
such as shown in the previous version example in that guide, Terraform will pull
in a `1X` series release on `terraformInit`.

If you've only ran `terraformInit` or `terraformPlan`, your state will not
have been modified and downgrading your provider is sufficient.

If you've ran `terraformRefresh` or `terraformApply`, Terraform may have made
state changes in the meantime.

*   If you're using a *local* state, `terraformRefresh` with a downgraded
    provider is likely sufficient to revert your state. The Google provider
    generally refreshes most state information from the API, and the properties
    necessary to do so have been left unchanged.

*   If you're using a *remote* state backend

    *   That does not support versioning, see the local state instructions above

    *   That supports *versioning* such as [Google Cloud Storage](https://www.terraform.io/docs/backends/types/gcs.html)
        you can revert the Terraform state file to a previous version by hand. If you do
        so and Terraform created resources as part of a `terraformApply`, you'll need
        to either `terraformImport` them or delete them by hand.

## Upgrade Topics

<!-- TOC depthFrom:2 depthTo:2 -->

* [Provider Version Configuration](#provider-version-configuration)
* [`googleBeta` provider](#google-beta-provider)
* [Data Sources](#data-sources)
* [Resource: `googleBigqueryDataset`](#resource-google_bigquery_dataset)
* [Resource: `googleBigtableInstance`](#resource-google_bigtable_instance)
* [Resource: `googleBinaryAuthorizationAttestor`](#resource-google_binary_authorization_attestor)
* [Resource: `googleBinaryAuthorizationPolicy`](#resource-google_binary_authorization_policy)
* [Resource: `googleCloudbuildTrigger`](#resource-google_cloudbuild_trigger)
* [Resource: `googleCloudfunctionsFunction`](#resource-google_cloudfunctions_function)
* [Resource: `googleComputeBackendService`](#resource-google_compute_backend_service)
* [Resource: `googleComputeDisk`](#resource-google_compute_disk)
* [Resource: `googleComputeGlobalForwardingRule`](#resource-google_compute_global_forwarding_rule)
* [Resource: `googleComputeImage`](#resource-google_compute_image)
* [Resource: `googleComputeInstance`](#resource-google_compute_instance)
* [Resource: `googleComputeInstanceFromTemplate`](#resource-google_compute_instance_from_template)
* [Resource: `googleComputeInstanceGroupManager`](#resource-google_compute_instance_group_manager)
* [Resource: `googleComputeInstanceTemplate`](#resource-google_compute_instance_template)
* [Resource: `googleComputeProjectMetadata`](#resource-google_compute_project_metadata)
* [Resource: `googleComputeRegionInstanceGroupManager`](#resource-google_compute_region_instance_group_manager)
* [Resource: `googleComputeSnapshot`](#resource-google_compute_snapshot)
* [Resource: `googleComputeSubnetworkIam_*`](#resource-google_compute_subnetwork_iam_*)
* [Resource: `googleComputeTargetPool`](#resource-google_compute_target_pool)
* [Resource: `googleComputeUrlMap`](#resource-google_compute_url_map)
* [Resource: `googleContainerAnalysisNote`](#resource-google_container_analysis_note)
* [Resource: `googleContainerCluster`](#resource-google_container_cluster)
* [Resource: `googleContainerNodePool`](#resource-google_container_node_pool)
* [Resource: `googleDataprocCluster`](#resource-google_dataproc_cluster)
* [Resource: `googleEndpointsService`](#resource-google_endpoints_service)
* [Resource: `googleFilestoreInstance`](#resource-google_filestore_instance)
* [Resource: `googleOrganizationCustomRole`](#resource-google_organization_custom_role)
* [Resource: `googleProject`](#resource-google_project)
* [Resource: `googleProjectCustomRole`](#resource-google_project_custom_role)
* [Resource: `googleProjectIamPolicy`](#resource-google_project_iam_policy)
* [Resource: `googleServiceAccount`](#resource-google_service_account)
* [Resource: `googleSqlDatabaseInstance`](#resource-google_sql_database_instance)
* [Resource: `googleStorageDefaultObjectAcl`](#resource-google_storage_default_object_acl)
* [Resource: `googleStorageObjectAcl`](#resource-google_storage_object_acl)
* [Resource: `google_*IamBinding`](#google_*_iam_binding)

<!-- /TOC -->

## Provider Version Configuration

\-> Before upgrading to version 2.0.0, it is recommended to upgrade to the most
recent version of the provider (1.20.0) and ensure that your environment
successfully runs [`terraformPlan`](https://www.terraform.io/docs/commands/plan.html)
without unexpected changes or deprecation notices.

It is recommended to use [version constraints](https://www.terraform.io/docs/configuration/providers.html#provider-versions)
when configuring Terraform providers. If you are following that recommendation,
update the version constraints in your Terraform configuration and run
[`terraformInit`](https://www.terraform.io/docs/commands/init.html) to download
the new version.

If you aren't using version constraints, you can use `terraformInitUpgrade`
in order to upgrade your provider to the latest released version.

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.provider.GoogleProvider(this, "google", {});

```

An updated configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.provider.GoogleProvider(this, "google", {});

```

## The `googleBeta` provider

The `googleBeta` variant of the Google provider is now necessary to be able to
configure products and features that are in beta. The `googleBeta` provider
enables full import support of beta features and gives users who wish to use
only the most stable APIs and features more confidence that they are doing so
by continuing to use the `google` provider, which now exclusively uses generally
available (GA) products and features.

Beta GCP features have no deprecation policy and no SLA, but are otherwise considered to be feature-complete
with only minor outstanding issues after their Alpha period. Beta is when GCP
features are publicly announced, and is when they generally become publicly
available. For more information see [the official documentation on GCP launch stages](https://cloud.google.com/terms/launch-stages).

Because the API for beta features can change before their GA launch, there may
be breaking changes in the `googleBeta` provider in minor release versions.
These changes will be announced in the [`googleBeta` CHANGELOG](https://github.com/hashicorp/terraform-provider-google-beta/blob/main/CHANGELOG.md).

To have resources at different API versions, set up provider blocks for each version:

```hcl
provider "google" {
  project     = "my-project-id"
  region      = "us-central1"
}

provider "google-beta" {
  project     = "my-project-id"
  region      = "us-central1"
}
```

In each resource, explicitly state which provider that resource should be used
with:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.computeInstance.ComputeInstance(this, "beta-instance", {
  provider: "google-beta",
});
new google.computeInstance.ComputeInstance(this, "ga-instance", {
  provider: "google",
});

```

See [Provider Versions](https://terraform.io/docs/providers/google/guides/provider_versions.html)
for more details on how to use `googleBeta`.

## Data Sources

See the `resource` sections in this document for properties that may have been
removed.

## Resource: `googleBigqueryDataset`

### `access` is now a Set

The order of entries in `access` no longer matters. Any configurations that
interpolate based on an item at a specific index will need to be updated, as items
may have been reordered.

## Resource: `googleBigtableInstance`

### `clusterId`, `zone`, `numNodes`, and `storageType` have moved into a `cluster` block

Example previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.bigtableInstance.BigtableInstance(this, "instance", {
  cluster_id: "tf-instance-cluster",
  name: "tf-instance",
  num_nodes: 3,
  storage_type: "HDD",
  zone: "us-central1-b",
});

```

Example updated configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.bigtableInstance.BigtableInstance(this, "instance", {
  cluster: [
    {
      cluster_id: "tf-instance-cluster",
      num_nodes: 3,
      storage_type: "HDD",
      zone: "us-central1-b",
    },
  ],
  name: "tf-instance",
});

```

### `zone` is no longer inferred from the provider

`clusterZone` is now required, even if the provider block has a zone set.

### `clusterFamily` has a diff

If you see

```console
-/+ google_bigtable_table.my_table (new resource required)
      id:                              "foo" => <computed> (forces new resource)
      column_family.#:                 "1" => "0" (forces new resource)
      column_family.123456789.family:  "my-family" => ""
      instance_name:                   "bar" => "bar"
      name:                            "foo" => "foo"
      project:                         "my-project" => <computed>
```

Add an appropriate `columnFamily` block to your config, eg:

```diff
+ column_family {
+   family = "my-family"
+ }
```

## Resource: `googleBinaryAuthorizationAttestor`

### binary authorization resources have been removed from the GA provider

Use the [`googleBeta` provider](#google-beta-provider) to use these resources.

## Resource: `googleBinaryAuthorizationPolicy`

### binary authorization resources have been removed from the GA provider

Use the [`googleBeta` provider](#google-beta-provider) to use these resources.

## Resource: `googleCloudbuildTrigger`

### `buildStepArgs` is now a list instead of space separated strings.

Example updated configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.cloudbuildTrigger.CloudbuildTrigger(this, "build_trigger", {
  build: [
    {
      images: ["gcr.io/$PROJECT_ID/$REPO_NAME:$SHORT_SHA"],
      step: [
        {
          args: ["cp", "gs://mybucket/remotefile.zip", "localfile-updated.zip"],
          name: "gcr.io/cloud-builders/gsutil",
        },
        {
          args: ["build", "my_package_updated"],
          name: "gcr.io/cloud-builders/go",
        },
        {
          args: [
            "build",
            "-t",
            "gcr.io/$PROJECT_ID/$REPO_NAME:$SHORT_SHA",
            "-f",
            "Dockerfile",
            ".",
          ],
          name: "gcr.io/cloud-builders/docker",
        },
        {
          args: ["test"],
          name: "gcr.io/$PROJECT_ID/$REPO_NAME:$SHORT_SHA",
        },
      ],
      tags: ["team-a", "service-b", "updated"],
    },
  ],
  trigger_template: [
    {
      branch_name: "main-updated",
      repo_name: "some-repo-updated",
    },
  ],
});

```

## Resource: `googleCloudfunctionsFunction`

### `triggerBucket`, `triggerTopic`, and `retryOnFailure` have been removed

Use the `eventTrigger` block instead.

Example updated configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleStorageBucketBucket = new google.storageBucket.StorageBucket(
  this,
  "bucket",
  {
    name: "example-bucket",
  }
);
const googleStorageBucketObjectArchive =
  new google.storageBucketObject.StorageBucketObject(this, "archive", {
    bucket: googleStorageBucketBucket.name,
    name: "index.zip",
    source: "path/to/source.zip",
  });
new google.cloudfunctionsFunction.CloudfunctionsFunction(this, "function", {
  available_memory_mb: 128,
  entry_point: "helloGCS",
  event_trigger: [
    {
      event_type: "providers/cloud.storage/eventTypes/object.change",
      failure_policy: [
        {
          retry: true,
        },
      ],
      resource: googleStorageBucketBucket.name,
    },
  ],
  name: "example-function",
  source_archive_bucket: googleStorageBucketBucket.name,
  source_archive_object: googleStorageBucketObjectArchive.name,
  timeout: 61,
});

```

See the documentation at
[`googleCloudfunctionsFunction`](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function)
for more details.

## Resource: `googleComputeBackendService`

### `customRequestHeaders` has been removed from the GA provider

Use the [`googleBeta` provider](#google-beta-provider) to set this field.

### `iap` may cause spurious updates

Due to technical limitations around how Terraform can diff fields, you may see a
spurious update where the client secret in your config replaces an incorrect
value that was recorded in state, the SHA256 hash of the secret's value.

You may also encounter the same behaviour on import.

## Resource: `googleComputeDisk`

### `diskEncryptionKeyRaw` and `diskEncryptionKeySha256` have been removed.

Use the `diskEncryptionKey` block instead:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const dataGoogleComputeImageMyImage =
  new google.dataGoogleComputeImage.DataGoogleComputeImage(this, "my_image", {
    family: "debian-11",
    project: "debian-cloud",
  });
new google.computeDisk.ComputeDisk(this, "foobar", {
  disk_encryption_key: [
    {
      raw_key: "SGVsbG8gZnJvbSBHb29nbGUgQ2xvdWQgUGxhdGZvcm0=",
    },
  ],
  image: dataGoogleComputeImageMyImage.selfLink,
  name: "example-disk",
  size: 50,
  type: "pd-ssd",
  zone: "us-central1-a",
});

```

## Resource: `googleComputeGlobalForwardingRule`

### `labels` has been removed from the GA provider

Use the [`googleBeta` provider](#google-beta-provider) to set this field.

## Resource: `googleComputeImage`

### `createTimeout` has been removed

Use the standard [timeouts](https://www.terraform.io/docs/configuration/resources.html#timeouts)
block instead.

## Resource: `googleComputeInstance`

### `createTimeout` has been removed

Use the standard [timeouts](https://www.terraform.io/docs/configuration/resources.html#timeouts)
block instead.

### `metadata` is now authoritative

Terraform will remove values not explicitly set in this field. Any `metadata` values
that were added outside of Terraform should be added to the config.

### `network` has been removed

Use `networkInterface` instead.

### `networkInterface.*Address` has been removed

Use `networkInterface.*NetworkIp` instead.

## Resource: `googleComputeInstanceFromTemplate`

### `metadata` is now authoritative

Terraform will remove values not explicitly set in this field. Any `metadata` values
that were added outside of Terraform should be added to the config.

### `networkInterface.*Address` has been removed

Use `networkInterface.*NetworkIp` instead.

## Resource: `googleComputeInstanceGroupManager`

### `version`, `autoHealingPolicies`, `rollingUpdatePolicy` have been removed from the GA provider

Use the [`googleBeta` provider](#google-beta-provider) to use these fields.
`rollingUpdatePolicy` has been renamed to `updatePolicy` in `googleBeta`.

## Resource: `googleComputeInstanceTemplate`

### `networkInterface.*Address` has been removed

Use `networkInterface.*NetworkIp` instead.

## Resource: `googleComputeProjectMetadata`

### `metadata` is now authoritative

Terraform will remove values not explicitly set in this field. Any `metadata` values
that were added outside of Terraform should be added to the config.

## Resource: `googleComputeRegionInstanceGroupManager`

### `version`, `autoHealingPolicies`, `rollingUpdatePolicy` have been removed from the GA provider

Use the [`googleBeta` provider](#google-beta-provider) to use these fields.
`rollingUpdatePolicy` has been renamed to `updatePolicy` in `googleBeta`.

### `updateStrategy` no longer has any effect and is removed

With `rollingUpdatePolicy` removed, `updateStrategy` has no effect anymore.
Before updating, remove it from your config.

## Resource: `googleComputeSnapshot`

### `snapshotEncryptionKeyRaw` and `snapshotEncryptionKeySha256` have been removed.

Use the `snapshotEncryptionKey` block instead:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const dataGoogleComputeImageMyImage =
  new google.dataGoogleComputeImage.DataGoogleComputeImage(this, "my_image", {
    family: "debian-11",
    project: "debian-cloud",
  });
const googleComputeDiskMyDisk = new google.computeDisk.ComputeDisk(
  this,
  "my_disk",
  {
    image: dataGoogleComputeImageMyImage.selfLink,
    name: "my-disk",
    size: 10,
    type: "pd-ssd",
    zone: "us-central1-a",
  }
);
new google.computeSnapshot.ComputeSnapshot(this, "my_snapshot", {
  name: "my-snapshot",
  snapshot_encryption_key: [
    {
      raw_key: "SGVsbG8gZnJvbSBHb29nbGUgQ2xvdWQgUGxhdGZvcm0=",
    },
  ],
  source_disk: googleComputeDiskMyDisk.name,
  zone: "us-central1-a",
});

```

### `sourceDiskEncryptionKeyRaw` and `sourceDiskEncryptionKeySha256` have been removed.

Use the `sourceDiskEncryptionKey` block instead:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const dataGoogleComputeImageMyImage =
  new google.dataGoogleComputeImage.DataGoogleComputeImage(this, "my_image", {
    family: "debian-11",
    project: "debian-cloud",
  });
const googleComputeDiskMyDisk = new google.computeDisk.ComputeDisk(
  this,
  "my_disk",
  {
    disk_encryption_key: [
      {
        raw_key: "SGVsbG8gZnJvbSBHb29nbGUgQ2xvdWQgUGxhdGZvcm0=",
      },
    ],
    image: dataGoogleComputeImageMyImage.selfLink,
    name: "my-disk",
    size: 10,
    type: "pd-ssd",
    zone: "us-central1-a",
  }
);
new google.computeSnapshot.ComputeSnapshot(this, "my_snapshot", {
  name: "my-snapshot",
  source_disk: googleComputeDiskMyDisk.name,
  source_disk_encryption_key: [
    {
      raw_key: "SGVsbG8gZnJvbSBHb29nbGUgQ2xvdWQgUGxhdGZvcm0=",
    },
  ],
  zone: "us-central1-a",
});

```

## Resource: `googleComputeSubnetworkIam_*`

### subnetwork IAM resources have been removed from the GA provider

Use the [`googleBeta` provider](#google-beta-provider) to use these resources.

## Resource: `googleComputeTargetPool`

### `instances` is now a Set

The order of entries in `instances` no longer matters. Any configurations that
interpolate based on an item at a specific index will need to be updated, as items
may have been reordered.

## Resource: `googleComputeUrlMap`

### `hostRule`, `pathMatcher`, and `test` are now authoritative

Terraform will remove values not explicitly set in these fields. Any `hostRule`, `pathMatcher`, or `test`
values that were added outside of Terraform should be added to the config.

## Resource: `googleContainerAnalysisNote`

### container analysis resources have been removed from the GA provider

Use the [`googleBeta` provider](#google-beta-provider) to use these resources.

## Resource: `googleContainerCluster`

### `enableBinaryAuthorization`, `enableTpu`, `podSecurityPolicyConfig`, `nodeConfigTaints`, `nodeConfigWorkloadMetadataConfig` have been removed from the GA provider

Use the [`googleBeta` provider](#google-beta-provider) to set these fields.

### `privateCluster`, `masterIpv4CidrBlock` are removed.

Use `privateClusterConfig` and `privateClusterConfigMasterIpv4CidrBlock` instead.

## Resource: `googleContainerNodePool`

### `maxPodsPerNode`, `nodeConfigTaints`, `nodeConfigWorkloadMetadataConfig` have been removed from the GA provider

Use the [`googleBeta` provider](#google-beta-provider) to set these fields.

### `namePrefix` has been removed

Use the `name` field along with the `random` provider instead.

Sample config:

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
import * as random from "./.gen/providers/random";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google, random.
For a more precise conversion please use the --provider flag in convert.*/
/*Terraform Variables are not always the best fit for getting inputs in the context of Terraform CDK.
You can read more about this at https://cdk.tf/variables*/
const machineType = new cdktf.TerraformVariable(this, "machine_type", {});
const googleContainerClusterExample =
  new google.containerCluster.ContainerCluster(this, "example", {
    initial_node_count: 1,
    name: "example-cluster",
    remove_default_node_pool: true,
    zone: "us-central1-a",
  });
const randomIdNp = new random.id.Id(this, "np", {
  byte_length: 11,
  keepers: [
    {
      machine_type: machineType.value,
    },
  ],
  prefix: "example-np-",
});
const googleContainerNodePoolExample =
  new google.containerNodePool.ContainerNodePool(this, "example_3", {
    cluster: googleContainerClusterExample.name,
    name: randomIdNp.dec,
    node_config: [
      {
        machine_type: machineType.value,
      },
    ],
    node_count: 1,
    zone: "us-central1-a",
  });
googleContainerNodePoolExample.addOverride("lifecycle", [
  {
    create_before_destroy: true,
  },
]);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
googleContainerNodePoolExample.overrideLogicalId("example");

```

The `keepers` parameter in `randomId` takes a map of values that cause the random id to be regenerated.
By tying it to attributes that might change, it makes sure the random id changes too.

To make sure the node pool keeps its old name, figure out what the suffix was by running `terraformShow`:

```console
google_container_node_pool.example:
  ...
  name = example-np-20180329213336514500000001
```

Determine the base64 encoding of that value by running [this script](https://play.golang.org/p/9KrkDoxRTOw).
Then, import that suffix as the value of `randomId`:

```console
terraform import random_id.np example-np-,ELFZ1rbrAThoeQE
```

For more details, see [terraform-provider-google#1054](https://github.com/hashicorp/terraform-provider-google/issues/1054).

## Resource: `googleEndpointsService`

### `protocOutput` has been removed

Use `protocOutputBase64` instead.

Example previous configuration:

```hcl
resource "google_endpoints_service" "grpc_service" {
  service_name  = "api-name.endpoints.project-id.cloud.goog"
  grpc_config   = "${file("service_spec.yml")}"
  protoc_output = "${file("compiled_descriptor_file.pb")}"
```

Example updated configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.endpointsService.EndpointsService(this, "grpc_service", {
  grpc_config: '${file("service_spec.yml")}',
  protoc_output_base64: '${base64encode(file("compiled_descriptor_file.pb"))}',
  service_name: "api-name.endpoints.project-id.cloud.goog",
});

```

## Resource: `googleDataprocCluster`

### `clusterConfig0DeleteAutogenBucket` has been removed

Autogenerated buckets are shared by all clusters in the same region, so deleting
this bucket could adversely harm other dataproc clusters. If you need a bucket
that can be deleted, please create a new one and set the `stagingBucket` field.

### `clusterConfig0GceClusterConfig0Tags` is now a Set

The order of entries in `tags` no longer matters. Any configurations that
interpolate based on an item at a specific index will need to be updated, as items
may have been reordered.

## Resource: `googleFilestoreInstance`

### filestore resources have been removed from the GA provider

Use the [`googleBeta` provider](#google-beta-provider) to use these resources.

## Resource: `googleOrganizationCustomRole`

### `deleted` field is now an output-only attribute

Use `terraformDestroy`, or remove the resource from your config instead.

## Resource: `googleProject`

### `appEngine` has been removed

Use the
[`googleAppEngineApplication` resource](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/app_engine_application) instead.

To avoid errors trying to recreate the resource, import it into your state first by running:

```console
terraform import google_app_engine_application.app your-project-id
```

## Resource: `googleProjectCustomRole`

### `deleted` field is now an output-only attribute

Use `terraformDestroy`, or remove the resource from your config instead.

## Resource: `googleProjectIamPolicy`

### `policyData` is now authoritative

Terraform will remove values not explicitly set in this field. Any `policyData`
values that were added outside of Terraform should be added to the config.

### `authoritative`, `restorePolicy`, and `disableProject` have been removed

Remove these fields from your config. Ensure that `policyData` contains all
policy values that exist on the project.

This resource is very dangerous. Consider using `googleProjectIamBinding` or
`googleProjectIamMember` instead.

## Resource: `googleServiceAccount`

### `policyData` has been removed

Use one of the other
[service account IAM resources](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam) instead.

## Resource: `googleSqlDatabaseInstance`

### `settings` is now authoritative

Terraform will remove values not explicitly set in this field. Any settings
values that were added outside of Terraform should be added to the config.

## Resource: `googleStorageDefaultObjectAcl`

### `roleEntity` is now authoritative

Terraform will remove values not explicitly set in this field. Any `roleEntity`
values that were added outside of Terraform should be added to the config.

## Resource: `googleStorageObjectAcl`

### `roleEntity` is now authoritative

Terraform will remove values not explicitly set in this field. Any `roleEntity`
values that were added outside of Terraform should be added to the config.
For fine-grained management, use `googleStorageObjectAccessControl`.

## Resource: `google_*IamBinding`

### Create is now authoritative

Every `iamBinding` resource will overwrite the existing member list for a given
role on Create. Running `terraformPlan` for the first time will not show members
that have been added via other tools. *To ensure existing `members` are preserved
use `terraformImport` instead of creating the resource.*

Previous versions of `google_*IamBinding` resources would merge the existing
members of a role with the members defined in the terraform config. If there was
a difference between the members defined in the config and the existing members
defined for an existing role it would show a diff if `terraformPlan` was run
immediately after create had succeeded.

Affected resources:

* `googleBillingAccountIamBinding`
* `googleFolderIamBinding`
* `googleKmsKeyRingIamBinding`
* `googleKmsCryptoKeyIamBinding`
* `googleSpannerInstanceIamBinding`
* `googleSpannerDatabaseIamBinding`
* `googleOrganizationIamBinding`
* `googleProjectIamBinding`
* `googlePubsubTopicIamBinding`
* `googlePubsubSubscriptionIamBinding`
* `googleServiceAccountIamBinding`
