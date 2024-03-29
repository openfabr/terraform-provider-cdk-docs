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
subcategory: "Cloud Data Fusion"
description: |-
  Represents a Data Fusion instance.
---

# googleDataFusionInstance

Represents a Data Fusion instance.

To get more information about Instance, see:

* [API documentation](https://cloud.google.com/data-fusion/docs/reference/rest/v1beta1/projects.locations.instances)
* How-to Guides
  * [Official Documentation](https://cloud.google.com/data-fusion/docs/)

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=data_fusion_instance_basic&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Data Fusion Instance Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.dataFusionInstance.DataFusionInstance(this, "basic_instance", {
  name: "my-instance",
  region: "us-central1",
  type: "BASIC",
});

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=data_fusion_instance_full&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Data Fusion Instance Full

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleComputeNetworkNetwork = new google.computeNetwork.ComputeNetwork(
  this,
  "network",
  {
    name: "datafusion-full-network",
  }
);
const dataGoogleAppEngineDefaultServiceAccountDefault =
  new google.dataGoogleAppEngineDefaultServiceAccount.DataGoogleAppEngineDefaultServiceAccount(
    this,
    "default",
    {}
  );
const googleComputeGlobalAddressPrivateIpAlloc =
  new google.computeGlobalAddress.ComputeGlobalAddress(
    this,
    "private_ip_alloc",
    {
      address_type: "INTERNAL",
      name: "datafusion-ip-alloc",
      network: googleComputeNetworkNetwork.id,
      prefix_length: 22,
      purpose: "VPC_PEERING",
    }
  );
new google.dataFusionInstance.DataFusionInstance(this, "extended_instance", {
  accelerators: [
    {
      accelerator_type: "CDC",
      state: "ENABLED",
    },
  ],
  dataproc_service_account:
    dataGoogleAppEngineDefaultServiceAccountDefault.email,
  description: "My Data Fusion instance",
  display_name: "My Data Fusion instance",
  enable_stackdriver_logging: true,
  enable_stackdriver_monitoring: true,
  labels: [
    {
      example_key: "example_value",
    },
  ],
  name: "my-instance",
  network_config: [
    {
      ip_allocation: `\${${googleComputeGlobalAddressPrivateIpAlloc.address}}/\${${googleComputeGlobalAddressPrivateIpAlloc.prefixLength}}`,
      network: "default",
    },
  ],
  private_instance: true,
  region: "us-central1",
  type: "BASIC",
});

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=data_fusion_instance_cmek&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Data Fusion Instance Cmek

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleKmsKeyRingKeyRing = new google.kmsKeyRing.KmsKeyRing(
  this,
  "key_ring",
  {
    location: "us-central1",
    name: "my-instance",
  }
);
const dataGoogleProjectProject = new google.dataGoogleProject.DataGoogleProject(
  this,
  "project",
  {}
);
const googleKmsCryptoKeyCryptoKey = new google.kmsCryptoKey.KmsCryptoKey(
  this,
  "crypto_key",
  {
    key_ring: googleKmsKeyRingKeyRing.id,
    name: "my-instance",
  }
);
const googleKmsCryptoKeyIamBindingCryptoKeyBinding =
  new google.kmsCryptoKeyIamBinding.KmsCryptoKeyIamBinding(
    this,
    "crypto_key_binding",
    {
      crypto_key_id: googleKmsCryptoKeyCryptoKey.id,
      members: [
        `serviceAccount:service-\${${dataGoogleProjectProject.number}}@gcp-sa-datafusion.iam.gserviceaccount.com`,
      ],
      role: "roles/cloudkms.cryptoKeyEncrypterDecrypter",
    }
  );
new google.dataFusionInstance.DataFusionInstance(this, "cmek", {
  crypto_key_config: [
    {
      key_reference: googleKmsCryptoKeyCryptoKey.id,
    },
  ],
  depends_on: [`\${${googleKmsCryptoKeyIamBindingCryptoKeyBinding.fqn}}`],
  name: "my-instance",
  region: "us-central1",
  type: "BASIC",
});

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=data_fusion_instance_enterprise&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Data Fusion Instance Enterprise

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.dataFusionInstance.DataFusionInstance(this, "enterprise_instance", {
  enable_rbac: true,
  name: "my-instance",
  region: "us-central1",
  type: "ENTERPRISE",
});

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=data_fusion_instance_event&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Data Fusion Instance Event

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googlePubsubTopicEvent = new google.pubsubTopic.PubsubTopic(
  this,
  "event",
  {
    name: "my-instance",
  }
);
const googleDataFusionInstanceEvent =
  new google.dataFusionInstance.DataFusionInstance(this, "event_1", {
    event_publish_config: [
      {
        enabled: true,
        topic: googlePubsubTopicEvent.id,
      },
    ],
    name: "my-instance",
    region: "us-central1",
    type: "BASIC",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
googleDataFusionInstanceEvent.overrideLogicalId("event");

```

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=data_fusion_instance_zone&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Data Fusion Instance Zone

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.dataFusionInstance.DataFusionInstance(this, "zone", {
  name: "my-instance",
  region: "us-central1",
  type: "DEVELOPER",
  zone: "us-central1-a",
});

```

## Argument Reference

The following arguments are supported:

*   `name` -
    (Required)
    The ID of the instance or a fully qualified identifier for the instance.

*   `type` -
    (Required)
    Represents the type of Data Fusion instance. Each type is configured with
    the default settings for processing and memory.
    * BASIC: Basic Data Fusion instance. In Basic type, the user will be able to create data pipelines
      using point and click UI. However, there are certain limitations, such as fewer number
      of concurrent pipelines, no support for streaming pipelines, etc.
    * ENTERPRISE: Enterprise Data Fusion instance. In Enterprise type, the user will have more features
      available, such as support for streaming pipelines, higher number of concurrent pipelines, etc.
    * DEVELOPER: Developer Data Fusion instance. In Developer type, the user will have all features available but
      with restrictive capabilities. This is to help enterprises design and develop their data ingestion and integration
      pipelines at low cost.
      Possible values are `basic`, `enterprise`, and `developer`.

***

*   `description` -
    (Optional)
    An optional description of the instance.

*   `enableStackdriverLogging` -
    (Optional)
    Option to enable Stackdriver Logging.

*   `enableStackdriverMonitoring` -
    (Optional)
    Option to enable Stackdriver Monitoring.

*   `enableRbac` -
    (Optional)
    Option to enable granular role-based access control.

*   `labels` -
    (Optional)
    The resource labels for instance to use to annotate any related underlying resources,
    such as Compute Engine VMs.

*   `options` -
    (Optional)
    Map of additional options used to configure the behavior of Data Fusion instance.

*   `version` -
    (Optional)
    Current version of the Data Fusion.

*   `privateInstance` -
    (Optional)
    Specifies whether the Data Fusion instance should be private. If set to
    true, all Data Fusion nodes will have private IP addresses and will not be
    able to access the public internet.

*   `dataprocServiceAccount` -
    (Optional)
    User-managed service account to set on Dataproc when Cloud Data Fusion creates Dataproc to run data processing pipelines.

*   `networkConfig` -
    (Optional)
    Network configuration options. These are required when a private Data Fusion instance is to be created.
    Structure is [documented below](#nested_network_config).

*   `zone` -
    (Optional)
    Name of the zone in which the Data Fusion instance will be created. Only DEVELOPER instances use this field.

*   `displayName` -
    (Optional)
    Display name for an instance.

*   `cryptoKeyConfig` -
    (Optional)
    The crypto key configuration. This field is used by the Customer-Managed Encryption Keys (CMEK) feature.
    Structure is [documented below](#nested_crypto_key_config).

*   `eventPublishConfig` -
    (Optional)
    Option to enable and pass metadata for event publishing.
    Structure is [documented below](#nested_event_publish_config).

*   `accelerators` -
    (Optional)
    List of accelerators enabled for this CDF instance.
    If accelerators are enabled it is possible a permadiff will be created with the Options field.
    Users will need to either manually update their state file to include these diffed options, or include the field in a [lifecycle ignore changes block](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#ignore_changes).
    Structure is [documented below](#nested_accelerators).

*   `region` -
    (Optional)
    The region of the Data Fusion instance.

*   `project` - (Optional) The ID of the project in which the resource belongs.
    If it is not provided, the provider project is used.

<a name="nested_network_config"></a>The `networkConfig` block supports:

*   `ipAllocation` -
    (Required)
    The IP range in CIDR notation to use for the managed Data Fusion instance
    nodes. This range must not overlap with any other ranges used in the Data Fusion instance network.

*   `network` -
    (Required)
    Name of the network in the project with which the tenant project
    will be peered for executing pipelines. In case of shared VPC where the network resides in another host
    project the network should specified in the form of projects/{host-project-id}/global/networks/{network}

<a name="nested_crypto_key_config"></a>The `cryptoKeyConfig` block supports:

* `keyReference` -
  (Required)
  The name of the key which is used to encrypt/decrypt customer data. For key in Cloud KMS, the key should be in the format of projects/*/locations/*/keyRings/*/cryptoKeys/*.

<a name="nested_event_publish_config"></a>The `eventPublishConfig` block supports:

*   `enabled` -
    (Required)
    Option to enable Event Publishing.

*   `topic` -
    (Required)
    The resource name of the Pub/Sub topic. Format: projects/{projectId}/topics/{topic\_id}

<a name="nested_accelerators"></a>The `accelerators` block supports:

*   `acceleratorType` -
    (Required)
    The type of an accelator for a CDF instance.
    Possible values are `cdc`, `healthcare`, and `ccaiInsights`.

*   `state` -
    (Required)
    The type of an accelator for a CDF instance.
    Possible values are `enabled` and `disabled`.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `projects/{{project}}/locations/{{region}}/instances/{{name}}`

*   `createTime` -
    The time the instance was created in RFC3339 UTC "Zulu" format, accurate to nanoseconds.

*   `updateTime` -
    The time the instance was last updated in RFC3339 UTC "Zulu" format, accurate to nanoseconds.

*   `state` -
    The current state of this Data Fusion instance.
    * CREATING: Instance is being created
    * RUNNING: Instance is running and ready for requests
    * FAILED: Instance creation failed
    * DELETING: Instance is being deleted
    * UPGRADING: Instance is being upgraded
    * RESTARTING: Instance is being restarted

*   `stateMessage` -
    Additional information about the current state of this Data Fusion instance if available.

*   `serviceEndpoint` -
    Endpoint on which the Data Fusion UI and REST APIs are accessible.

*   `serviceAccount` -
    ([Beta](https://terraform.io/docs/providers/google/guides/provider_versions.html))
    Deprecated. Use `tenantProjectId` instead to extract the tenant project ID.

*   `tenantProjectId` -
    The name of the tenant project.

*   `gcsBucket` -
    Cloud Storage bucket generated by Data Fusion in the customer project.

*   `apiEndpoint` -
    Endpoint on which the REST APIs is accessible.

*   `p4ServiceAccount` -
    P4 service account for the customer project.

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 90 minutes.
* `update` - Default is 25 minutes.
* `delete` - Default is 50 minutes.

## Import

Instance can be imported using any of these accepted formats:

```console
$ terraform import google_data_fusion_instance.default projects/{{project}}/locations/{{region}}/instances/{{name}}
$ terraform import google_data_fusion_instance.default {{project}}/{{region}}/{{name}}
$ terraform import google_data_fusion_instance.default {{region}}/{{name}}
$ terraform import google_data_fusion_instance.default {{name}}
```

## User Project Overrides

This resource supports [User Project Overrides](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#user_project_override).
