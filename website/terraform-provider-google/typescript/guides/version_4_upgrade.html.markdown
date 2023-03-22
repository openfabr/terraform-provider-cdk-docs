---
page_title: "Terraform Google Provider 4.0.0 Upgrade Guide"
description: |-
  Terraform Google Provider 4.0.0 Upgrade Guide
---

# Terraform Google Provider 4.0.0 Upgrade Guide

The `400` release of the Google provider for Terraform is a major version and
includes some changes that you will need to consider when upgrading. This guide
is intended to help with that process and focuses only on the changes necessary
to upgrade from the final `3X` series release to `400`.

Most of the changes outlined in this guide have been previously marked as
deprecated in the Terraform `plan`/`apply` output throughout previous provider
releases, up to and including the final `3X` series release. These changes,
such as deprecation notices, can always be found in the CHANGELOG of the
affected providers. [google](https://github.com/hashicorp/terraform-provider-google/blob/main/CHANGELOG.md)
[google-beta](https://github.com/hashicorp/terraform-provider-google-beta/blob/main/CHANGELOG.md)

## I accidentally upgraded to 4.0.0, how do I downgrade to `3X`?

If you've inadvertently upgraded to `400`, first see the
[Provider Version Configuration Guide](#provider-version-configuration) to lock
your provider version; if you've constrained the provider to a lower version
such as shown in the previous version example in that guide, Terraform will pull
in a `3X` series release on `terraformInit`.

If you've only ran `terraformInit` or `terraformPlan`, your state will not
have been modified and downgrading your provider is sufficient.

If you've ran `terraformRefresh` or `terraformApply`, Terraform may have made
state changes in the meantime.

*   If you're using a local state, or a remote state backend that does not support
    versioning, `terraformRefresh` with a downgraded provider is likely sufficient
    to revert your state. The Google provider generally refreshes most state
    information from the API, and the properties necessary to do so have been left
    unchanged.

*   If you're using a remote state backend that supports versioning such as
    [Google Cloud Storage](https://www.terraform.io/docs/backends/types/gcs.html),
    you can revert the Terraform state file to a previous version. If you do
    so and Terraform had created resources as part of a `terraformApply` in the
    meantime, you'll need to either delete them by hand or `terraformImport` them
    so Terraform knows to manage them.

## Provider Version Configuration

\-> Before upgrading to version 4.0.0, it is recommended to upgrade to the most
recent `3X` series release of the provider, make the changes noted in this guide,
and ensure that your environment successfully runs
[`terraformPlan`](https://www.terraform.io/docs/commands/plan.html)
without unexpected changes or deprecation notices.

It is recommended to use [version constraints](https://www.terraform.io/docs/language/providers/requirements.html#requiring-providers)
when configuring Terraform providers. If you are following that recommendation,
update the version constraints in your Terraform configuration and run
[`terraformInit`](https://www.terraform.io/docs/commands/init.html) to download
the new version.

If you aren't using version constraints, you can use `terraformInitUpgrade`
in order to upgrade your provider to the latest released version.

For example, given this previous configuration:

```typescript
```

An updated configuration:

```typescript
```

## Provider

### `credentials`, `accessToken` precedence has changed

Terraform can draw values for both the `credentials` and `accessToken` from the
config directly or from environment variables.

In earlier versions of the provider, `accessToken` values specified through
environment variables took precedence over `credentials` values specified in
config. From `400` onwards, config takes precedence over environment variables,
and the `accessToken` environment variable takes precedence over the
`credential` environment variable.

Service account impersonation is unchanged. Terraform will continue to use
the service account if it is specified through an environment variable, even
if `credentials` or `accessToken` are specified in config.

### Redundant default scopes are removed

Several default scopes are removed from the provider:

* "https://www.googleapis.com/auth/compute"
* "https://www.googleapis.com/auth/ndev.clouddns.readwrite"
* "https://www.googleapis.com/auth/devstorage.full\_control"
* "https://www.googleapis.com/auth/cloud-identity"

They are redundant with the "https://www.googleapis.com/auth/cloud-platform"
scope per [Access scopes](https://cloud.google.com/compute/docs/access/service-accounts#accesscopesiam).
After this change the following scopes are enabled, in line with `gcloud`'s
[list of scopes](https://cloud.google.com/sdk/gcloud/reference/auth/application-default/login):

* "https://www.googleapis.com/auth/cloud-platform"
* "https://www.googleapis.com/auth/userinfo.email"

This change is believed to have no user impact. If you find that Terraform
behaves incorrectly as a result of this change, please report a [bug](https://github.com/hashicorp/terraform-provider-google/issues/new?assignees=\&labels=bug\&template=bug.md).

### Runtime Configurator (`runtimeconfig`) resources have been removed from the GA provider

Earlier versions of the provider accidentally included the Runtime Configurator
service at GA. `400` has corrected that error, and Runtime Configurator is
only available in `googleBeta`.

Affected Resources:

```console
* `google_runtimeconfig_config`
* `google_runtimeconfig_variable`
* `google_runtimeconfig_config_iam_policy`
* `google_runtimeconfig_config_iam_binding`
* `google_runtimeconfig_config_iam_member`
```

Affected Datasources:

```console
* `google_runtimeconfig_config`
```

If you have a configuration using the `google` provider like the following:

```console
resource "google_runtimeconfig_config" "my-runtime-config" {
  name        = "my-service-runtime-config"
  description = "Runtime configuration values for my service"
}
```

Add the `googleBeta` provider to your configuration:

```console
resource "google_runtimeconfig_config" "my-runtime-config" {
  provider = google-beta

  name        = "my-service-runtime-config"
  description = "Runtime configuration values for my service"
}
```

### Service account scopes no longer accept `traceAppend` or `traceRo`, use `trace` instead

Previously users could specify `traceAppend` or `traceRo` as scopes for a given service account.
However, to better align with [Google documentation](https://cloud.google.com/sdk/gcloud/reference/alpha/compute/instances/set-scopes#--scopes), `trace` will now be the only valid scope, as it's an alias for `traceAppend` and
`traceRo` is no longer a documented option.

## Datasources

## Datasource: `googleKmsKeyRing`

### `id` now matches the `googleKmsKeyRing` id format

The format has changed to better match the resource's ID format.

Interpolations based on the `id` of the datasource may require updates.

## Resources

## Resource: `googleAppEngineStandardAppVersion`

### `entrypoint` is now required

This resource would fail to deploy without this field defined. Specify the
`entrypoint` block to fix any issues

## Resource: `googleBigqueryJob`

### Exactly one of `query`, `load`, `copy` or `extract` is required

The provider will now enforce at plan time that one of these fields be set.

### At least one of `query0ScriptOptions0StatementTimeoutMs`, `query0ScriptOptions0StatementByteBudget`, or `query0ScriptOptions0KeyResultStatement` is required

The provider will now enforce at plan time that one of these fields be set.

### Exactly one of `extract0SourceTable` or `extract0SourceModel` is required

The provider will now enforce at plan time that one of these fields be set.

## Resource: `googleCloudbuildTrigger`

### Exactly one of `build0Source0RepoSource0BranchName`, `build0Source0RepoSource0CommitSha` or `build0Source0RepoSource0TagName` is required

The provider will now enforce at plan time that one of these fields be set.

## Resource: `googleComputeAutoscaler`

### At least one of `autoscalingPolicy0ScaleDownControl0MaxScaledDownReplicas` or `autoscalingPolicy0ScaleDownControl0TimeWindowSec` is required

The provider will now enforce at plan time that one of these fields be set.

### At least one of `autoscalingPolicy0ScaleDownControl0MaxScaledDownReplicas0Fixed` or `autoscalingPolicy0ScaleDownControl0MaxScaledDownReplicas0Percent` is required

The provider will now enforce at plan time that one of these fields be set.

### At least one of `autoscalingPolicy0ScaleInControl0MaxScaledInReplicas` or `autoscalingPolicy0ScaleInControl0TimeWindowSec` is required

The provider will now enforce at plan time that one of these fields be set.

### At least one of `autoscalingPolicy0ScaleInControl0MaxScaledInReplicas0Fixed` or `autoscalingPolicy0ScaleInControl0MaxScaledInReplicas0Percent` is required

The provider will now enforce at plan time that one of these fields be set.

## Resource: `googleComputeRegionAutoscaler`

### At least one of `autoscalingPolicy0ScaleDownControl0MaxScaledDownReplicas` or `autoscalingPolicy0ScaleDownControl0TimeWindowSec` is required

The provider will now enforce at plan time that one of these fields be set.

### At least one of `autoscalingPolicy0ScaleDownControl0MaxScaledDownReplicas0Fixed` or `autoscalingPolicy0ScaleDownControl0MaxScaledDownReplicas0Percent` is required

The provider will now enforce at plan time that one of these fields be set.

### At least one of `autoscalingPolicy0ScaleInControl0MaxScaledInReplicas` or `autoscalingPolicy0ScaleInControl0TimeWindowSec` is required

The provider will now enforce at plan time that one of these fields be set.

### At least one of `autoscalingPolicy0ScaleInControl0MaxScaledInReplicas0Fixed` or `autoscalingPolicy0ScaleInControl0MaxScaledInReplicas0Percent` is required

The provider will now enforce at plan time that one of these fields be set.

## Resource: `googleComputeFirewall`

### One of `sourceTags`, `sourceRanges` or `sourceServiceAccounts` are required on INGRESS firewalls

Previously, if all of these fields were left empty, the firewall defaulted to allowing traffic from 0.0.0.0/0, which is a suboptimal default.

### `sourceRanges` will track changes when unspecified in a config

In `3X`, `sourceRanges` wouldn't cause a diff if it was undefined in
config but was set on the firewall itself. With 4.0.0 Terraform will now
track changes on the block when it is not specified in a user's config.

## Resource: `googleComputeInstance`

### `metadataStartupScript` is no longer set on import

Earlier versions of the provider set the `metadataStartupScript` value on
import, omitting the value of `metadataStartupScript` for historical backwards
compatibility. This was dangerous in practice, as `metadataStartupScript`
would flag an instance for recreation if the values differed rather than for
just an update.

In `400` the behaviour has been flipped, and `metadataStartupScript` is the
default value that gets written. Users who want `metadataStartupScript` set
on an imported instance will need to modify their state manually. This is more
consistent with our expectations for the field, that a user who manages an
instance **only** through Terraform uses it but that most users should prefer
the `metadata` block.

No action is required for user configs with instances already imported. If you
have a config or module where neither is specified- where `import` will be run,
or an old config that is not reconciled with the API- the value that gets set
will change.

## Resource: `googleComputeInstanceGroupManager`

### `updatePolicyMinReadySec` is removed from the GA provider

This field was incorrectly included in the GA `google` provider in past releases.
In order to continue to use the feature, add `provider =GoogleBeta` to your
resource definition.

## Resource: `googleComputeRegionInstanceGroupManager`

### `updatePolicyMinReadySec` is removed from the GA provider

This field was incorrectly included in the GA `google` provider in past releases.
In order to continue to use the feature, add `provider =GoogleBeta` to your
resource definition.

## Resource: `googleComputeInstanceTemplate`

### `enableDisplay` is removed from the GA provider

This field was incorrectly included in the GA `google` provider in past releases.
In order to continue to use the feature, add `provider =GoogleBeta` to your
resource definition.

### `advancedMachineFeatures` will track changes when unspecified in a config

In `3X`, `advancedMachineFeatures` wouldn't cause a diff if it was undefined in
config but was set on the instance template itself. With 4.0.0 Terraform will now
track changes on the block when it is not specified in a user's config.

## Resource: `googleComputeUrlMap`

### At least one of `defaultRouteAction0FaultInjectionPolicy0Delay0FixedDelay` or `defaultRouteAction0FaultInjectionPolicy0Delay0Percentage` is required

The provider will now enforce at plan time that one of these fields be set.

## Resource: `googleContainerCluster`

### `enableShieldedNodes` now defaults to `true`

Previously the provider defaulted `enableShieldedNodes` to false, despite the API default of `true`.
Unless explicitly configured, users may see a diff changing `enableShieldedNodes` to `true`.

### `instanceGroupUrls` is now removed

`instanceGroupUrls` has been removed in favor of `nodePoolManagedInstanceGroupUrls`

### `masterAuthUsername` and `masterAuthPassword` are now removed

`masterAuthUsername` and `masterAuthPassword` have been removed.
Basic authentication was removed for GKE cluster versions >= 1.19. The cluster cannot be created with basic authentication enabled. Instructions for choosing an alternative authentication method can be found at: cloud.google.com/kubernetes-engine/docs/how-to/api-server-authentication.

### `masterAuthClientCertificateConfig` is now required

With the removal of `masterAuthUsername` and `masterAuthPassword`, `masterAuthClientCertificateConfig` is now
the only configurable field in `masterAuth`. If you do not wish to configure `masterAuthClientCertificateConfig`,
remove the `masterAuth` block from your configuration entirely. You will still be able to reference the outputted fields under `masterAuth` without the block defined.

### `nodeConfigWorkloadMetadataConfigNodeMetadata` is now removed

Removed in favor of `nodeConfigWorkloadMetadataConfigMode`.

### `workloadIdentityConfig0IdentityNamespace` is now removed

Removed in favor of `workloadIdentityConfig0WorkloadPool`. Switching your
configuration from one value to the other will trigger a diff at plan time, and
a spurious update.

```diff
resource "google_container_cluster" "cluster" {
  name               = "your-cluster"
  location           = "us-central1-a"
  initial_node_count = 1

  workload_identity_config {
-    identity_namespace = "your-project.svc.id.goog"
+   workload_pool = "your-project.svc.id.goog"
  }
```

### `podSecurityPolicyConfig` is removed from the GA provider

This field was incorrectly included in the GA `google` provider in past releases.
In order to continue to use the feature, add `provider =GoogleBeta` to your
resource definition.

## Resource: `googleComputeSnapshot`

### `sourceDiskLink` is now removed

Removed, as the information available was redundant. You can reconstruct a
compatible value based on `sourceDisk` and `zone`. With a reference such as the
following:

```console
google_compute_snapshot.my_snapshot.source_disk_link
```

Substitute the following:

```console
"projects/${google_compute_snapshot.my_snapshot.project}/zones/${google_compute_snapshot.my_snapshot.zone}/disks/${google_compute_snapshot.my_snapshot.source_disk}"
```

## Resource: `googleDataLossPreventionTrigger`

### Exactly one of `inspectJob0StorageConfig0CloudStorageOptions0FileSet0Url` or `inspectJob0StorageConfig0CloudStorageOptions0FileSet0RegexFileSet` is required

The provider will now enforce at plan time that one of these fields be set.

### At least one of `inspectJob0StorageConfig0TimespanConfig0StartTime` or `inspectJob0StorageConfig0TimespanConfig0EndTime` is required

The provider will now enforce at plan time that one of these fields be set.

## Resource: `googleOsConfigPatchDeployment`

### At least one of `patchConfig0RebootConfig`, `patchConfig0Apt`, `patchConfig0Yum`, `patchConfig0Goo` `patchConfig0Zypper`, `patchConfig0WindowsUpdate`, `patchConfig0PreStep` or `patchConfig0PreStep` is required

The provider will now enforce at plan time that one of these fields be set.

### At least one of `patchConfig0Apt0Type`, `patchConfig0Apt0Excludes` or `patchConfig0Apt0ExclusivePackages` is required

The provider will now enforce at plan time that one of these fields be set.

### At least one of `patchConfig0Yum0Security`, `patchConfig0Yum0Minimal`, `patchConfig0Yum0Excludes` or `patchConfig0Yum0ExclusivePackages` is required

The provider will now enforce at plan time that one of these fields be set.

### At least one of `patchConfig0Zypper0WithOptional`, `patchConfig0Zypper0WithUpdate`, `patchConfig0Zypper0Categories`, `patchConfig0Zypper0Severities`, `patchConfig0Zypper0Excludes` or `patchConfig0Zypper0ExclusivePatches` is required

The provider will now enforce at plan time that one of these fields be set.

### Exactly one of `patchConfig0WindowsUpdate0Classifications`, `patchConfig0WindowsUpdate0Excludes` or `patchConfig0WindowsUpdate0ExclusivePatches` is required

The provider will now enforce at plan time that one of these fields be set.

### At least one of `patchConfig0PreStep0LinuxExecStepConfig` or `patchConfig0PreStep0WindowsExecStepConfig` is required

The provider will now enforce at plan time that one of these fields be set.

### At least one of `patchConfig0PostStep0LinuxExecStepConfig` or `patchConfig0PostStep0WindowsExecStepConfig` is required

The provider will now enforce at plan time that one of these fields be set.

## Resource: `googleKmsCryptoKey`

### `selfLink` is now removed

Removed in favor of `id`.

## Resource: `googleKmsKeyRing`

### `selfLink` is now removed

Removed in favor of `id`.

## Resource: `googleProject`

### `orgId`, `folderId` now conflict at plan time

Previously, they were only checked for conflicts at apply time. Terraform will
now report an error at plan time.

### `orgId`, `folderId` are unset when removed from config

Previously, these fields kept their old value in state when they were removed
from config, changing the value on next refresh. Going forward, removing one of
the values or switching values will generate a correct plan that removes the
value.

## Resource: `googleProjectIam`

### `project` field is now required

The `project` field is now required for all `googleProjectIam_*` resources.
Previously, it was only required for `googleProjectIamPolicy`. This will make
configuration of the project IAM resources more explicit, given that the project
is the targeted resource.

`terraformPlan` will indicate any project IAM resources that had drawn a value
with a provider, and you are able to specify the project explicitly to remove
the proposed diff.

## Resource: `googleProjectService`

### `bigqueryJsonGoogleapisCom` is no longer a valid service name

`bigqueryJsonGoogleapisCom` was deprecated in the `300` release, however, at that point the provider
converted it while the upstream API migration was in progress. Now that the API migration has finished,
the provider will no longer convert the service name. Use `bigqueryGoogleapisCom` instead.

## Resource: `googlePubsubSubscription`

### `path` is now removed

`path` has been removed in favor of `id` which has an identical value.

## Resource: `googleSpannerInstance`

### Exactly one of `numNodes` or `processingUnits` is required

The provider will now enforce that you've set one of these fields at plan time.
Earlier versions of the provider set a default value of `1` for `numNodes`. If
neither field is present in your config, it's likely you can add `numNodes =1`
to resolve this change. If that is incorrect, `terraformPlan` should inform you
of the correct value.

For example, for a configuration like the following:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.spannerInstance.SpannerInstance(this, "default", {
  config: "regional-europe-west1",
  display_name: "main-instance",
});

```

You would amend it to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.spannerInstance.SpannerInstance(this, "default", {
  config: "regional-europe-west1",
  display_name: "main-instance",
  num_nodes: 1,
});

```

## Resource: `googleSqlDatabaseInstance`

### First-generation fields have been removed

Removed fields specific to first-generation SQL instances:
`authorizedGaeApplications`, `crashSafeReplication`, `replicationType`

### `databaseVersion` field is now required

The `databaseVersion` field is now required.
Previously, it was an optional field and the default value was `mysql56`.
Description of the change and how users should adjust their configuration (if needed).

### Drift detection and defaults enabled on fields

Added drift detection and plan-time defaults to several fields used to configure
second-generation SQL instances. If you see changes flagged by Terraform after
running `terraformPlan`, amend your config to resolve them.

The affected fields are:

*   `activationPolicy` will now default to `always` at plan time, and detect
    drift even when unset. Previously, Terraform only detected drift when the field
    had been set in config explicitly.

*   `availabilityType` will now default to `zonal` at plan time, and detect
    drift even when unset. Previously, Terraform only detected drift when the field
    had been set in config explicitly.

*   `diskType` will now default to `pdSsd` at plan time, and detect
    drift even when unset. Previously, Terraform only detected drift when the field
    had been set in config explicitly.

*   `encryptionKeyName` will now detect drift even when unset. Previously,
    Terraform only detected drift when the field had been set in config explicitly.

## Resource: `googleStorageBucket`

### `bucketPolicyOnly` field is now removed

`bucketPolicyOnly` field is now removed in favor of `uniformBucketLevelAccess`.

### `location` field is now required.

Previously, the default value of `location` was `us`. In an attempt to avoid allowing invalid
conbination of `storageClass` value and default `location` value, `location` field is now required.
