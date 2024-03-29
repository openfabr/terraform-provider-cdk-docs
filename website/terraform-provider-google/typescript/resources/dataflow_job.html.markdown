---
subcategory: "Dataflow"
description: |-
  Creates a job in Dataflow according to a provided config file.
---

# googleDataflowJob

Creates a job on Dataflow, which is an implementation of Apache Beam running on Google Compute Engine. For more information see
the official documentation for
[Beam](https://beam.apache.org) and [Dataflow](https://cloud.google.com/dataflow/).

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.dataflowJob.DataflowJob(this, "big_data_job", {
  name: "dataflow-job",
  parameters: [
    {
      baz: "qux",
      foo: "bar",
    },
  ],
  temp_gcs_location: "gs://my-bucket/tmp_dir",
  template_gcs_path: "gs://my-bucket/templates/template_file",
});

```

## Example Usage - Streaming Job

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googlePubsubTopicTopic = new google.pubsubTopic.PubsubTopic(
  this,
  "topic",
  {
    name: "dataflow-job1",
  }
);
const googleStorageBucketBucket1 = new google.storageBucket.StorageBucket(
  this,
  "bucket1",
  {
    force_destroy: true,
    location: "US",
    name: "tf-test-bucket1",
  }
);
new google.storageBucket.StorageBucket(this, "bucket2", {
  force_destroy: true,
  location: "US",
  name: "tf-test-bucket2",
});
new google.dataflowJob.DataflowJob(this, "pubsub_stream", {
  enable_streaming_engine: true,
  name: "tf-test-dataflow-job1",
  on_delete: "cancel",
  parameters: [
    {
      inputFilePattern: `\${${googleStorageBucketBucket1.url}}/*.json`,
      outputTopic: googlePubsubTopicTopic.id,
    },
  ],
  temp_gcs_location: "gs://my-bucket/tmp_dir",
  template_gcs_path: "gs://my-bucket/templates/template_file",
  transform_name_mapping: [
    {
      env: "test",
      name: "test_job",
    },
  ],
});

```

## Note on "destroy" / "apply"

There are many types of Dataflow jobs.  Some Dataflow jobs run constantly, getting new data from (e.g.) a GCS bucket, and outputting data continuously.  Some jobs process a set amount of data then terminate.  All jobs can fail while running due to programming errors or other issues.  In this way, Dataflow jobs are different from most other Terraform / Google resources.

The Dataflow resource is considered 'existing' while it is in a nonterminal state.  If it reaches a terminal state (e.g. 'FAILED', 'COMPLETE', 'CANCELLED'), it will be recreated on the next 'apply'.  This is as expected for jobs which run continuously, but may surprise users who use this resource for other kinds of Dataflow jobs.

A Dataflow job which is 'destroyed' may be "cancelled" or "drained".  If "cancelled", the job terminates - any data written remains where it is, but no new data will be processed.  If "drained", no new data will enter the pipeline, but any data currently in the pipeline will finish being processed.  The default is "drain". When `onDelete` is set to `"drain"` in the configuration, you may experience a long wait for your `terraformDestroy` to complete.

You can potentially short-circuit the wait by setting `skipWaitOnJobTermination` to `true`, but beware that unless you take active steps to ensure that the job `name` parameter changes between instances, the name will conflict and the launch of the new job will fail. One way to do this is with a [random\_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) resource, for example:

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
const bigDataJobSubscriptionId = new cdktf.TerraformVariable(
  this,
  "big_data_job_subscription_id",
  {
    default: "projects/myproject/subscriptions/messages",
  }
);
const randomIdBigDataJobNameSuffix = new random.id.Id(
  this,
  "big_data_job_name_suffix",
  {
    byte_length: 4,
    keepers: [
      {
        region: "${var.region}",
        subscription_id: bigDataJobSubscriptionId.value,
      },
    ],
  }
);
new google.dataflowFlexTemplateJob.DataflowFlexTemplateJob(
  this,
  "big_data_job",
  {
    container_spec_gcs_path: "gs://my-bucket/templates/template.json",
    name: `dataflow-flextemplates-job-\${${randomIdBigDataJobNameSuffix.dec}}`,
    parameters: [
      {
        inputSubscription: bigDataJobSubscriptionId.value,
      },
    ],
    provider: "${google-beta}",
    region: "${var.region}",
    skip_wait_on_job_termination: true,
  }
);

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) A unique name for the resource, required by Dataflow.
* `templateGcsPath` - (Required) The GCS path to the Dataflow job template.
* `tempGcsLocation` - (Required) A writeable location on GCS for the Dataflow job to dump its temporary data.

***

* `parameters` - (Optional) Key/Value pairs to be passed to the Dataflow job (as used in the template).
* `labels` - (Optional) User labels to be specified for the job. Keys and values should follow the restrictions
  specified in the [labeling restrictions](https://cloud.google.com/compute/docs/labeling-resources#restrictions) page.
  **NOTE**: Google-provided Dataflow templates often provide default labels that begin with `googDataflowProvided`.
  Unless explicitly set in config, these labels will be ignored to prevent diffs on re-apply.
* `transformNameMapping` - (Optional) Only applicable when updating a pipeline. Map of transform name prefixes of the job to be replaced with the corresponding name prefixes of the new job. This field is not used outside of update.
* `maxWorkers` - (Optional) The number of workers permitted to work on the job.  More workers may improve processing speed at additional cost.
* `onDelete` - (Optional) One of "drain" or "cancel".  Specifies behavior of deletion during `terraformDestroy`.  See above note.
* `skipWaitOnJobTermination` - (Optional)  If set to `true`, terraform will treat `draining` and `cancelling` as terminal states when deleting the resource, and will remove the resource from terraform state and move on.  See above note.
* `project` - (Optional) The project in which the resource belongs. If it is not provided, the provider project is used.
* `zone` - (Optional) The zone in which the created job should run. If it is not provided, the provider zone is used.
* `region` - (Optional) The region in which the created job should run.
* `serviceAccountEmail` - (Optional) The Service Account email used to create the job.
* `network` - (Optional) The network to which VMs will be assigned. If it is not provided, "default" will be used.
* `subnetwork` - (Optional) The subnetwork to which VMs will be assigned. Should be of the form "regions/REGION/subnetworks/SUBNETWORK". If the [subnetwork is located in a Shared VPC network](https://cloud.google.com/dataflow/docs/guides/specifying-networks#shared), you must use the complete URL. For example `"googleapisCom/compute/v1/projects/projectId/regions/region/subnetworks/subnetName"`
* `machineType` - (Optional) The machine type to use for the job.
* `kmsKeyName` - (Optional) The name for the Cloud KMS key for the job. Key format is: `projects/projectId/locations/location/keyRings/keyRing/cryptoKeys/key`
* `ipConfiguration` - (Optional) The configuration for VM IPs.  Options are `"workerIpPublic"` or `"workerIpPrivate"`.
* `additionalExperiments` - (Optional) List of experiments that should be used by the job. An example value is `["enableStackdriverAgentMetrics"]`.
* `enableStreamingEngine` - (Optional) Enable/disable the use of [Streaming Engine](https://cloud.google.com/dataflow/docs/guides/deploying-a-pipeline#streaming-engine) for the job. Note that Streaming Engine is enabled by default for pipelines developed against the Beam SDK for Python v2.21.0 or later when using Python 3.

## Attributes Reference

* `jobId` - The unique ID of this job.
* `type` - The type of this job, selected from the [JobType enum](https://cloud.google.com/dataflow/docs/reference/rest/v1b3/projects.jobs#Job.JobType)
* `state` - The current state of the resource, selected from the [JobState enum](https://cloud.google.com/dataflow/docs/reference/rest/v1b3/projects.jobs#Job.JobState)

## Import

Dataflow jobs can be imported using the job `id` e.g.

```console
$ terraform import google_dataflow_job.example 2022-07-31_06_25_42-11926927532632678660
```
