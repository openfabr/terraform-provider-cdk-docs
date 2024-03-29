---
# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    Type: DCL     ***
#
# ----------------------------------------------------------------------------
#
#     This file is managed by Magic Modules (https:#github.com/GoogleCloudPlatform/magic-modules)
#     and is based on the DCL (https:#github.com/GoogleCloudPlatform/declarative-resource-client-library).
#     Changes will need to be made to the DCL or Magic Modules instead of here.
#
#     We are not currently able to accept contributions to this file. If changes
#     are required, please file an issue at https:#github.com/hashicorp/terraform-provider-google/issues/new/choose
#
# ----------------------------------------------------------------------------
subcategory: "Eventarc"
description: |-
  The Eventarc Trigger resource
---

# googleEventarcTrigger

The Eventarc Trigger resource

## Example Usage - basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleCloudRunServiceDefault = new google.cloudRunService.CloudRunService(
  this,
  "default",
  {
    location: "europe-west1",
    metadata: [
      {
        namespace: "my-project-name",
      },
    ],
    name: "eventarc-service",
    template: [
      {
        spec: [
          {
            container_concurrency: 50,
            containers: [
              {
                image: "gcr.io/cloudrun/hello",
                ports: [
                  {
                    container_port: 8080,
                  },
                ],
              },
            ],
            timeout_seconds: 100,
          },
        ],
      },
    ],
    traffic: [
      {
        latest_revision: true,
        percent: 100,
      },
    ],
  }
);
new google.eventarcTrigger.EventarcTrigger(this, "primary", {
  destination: [
    {
      cloud_run_service: [
        {
          region: "europe-west1",
          service: googleCloudRunServiceDefault.name,
        },
      ],
    },
  ],
  labels: [
    {
      foo: "bar",
    },
  ],
  location: "europe-west1",
  matching_criteria: [
    {
      attribute: "type",
      value: "google.cloud.pubsub.topic.v1.messagePublished",
    },
  ],
  name: "name",
});
new google.pubsubTopic.PubsubTopic(this, "foo", {
  name: "topic",
});

```

## Argument Reference

The following arguments are supported:

*   `destination` -
    (Required)
    Required. Destination specifies where the events should be sent to.

*   `location` -
    (Required)
    The location for the resource

*   `matchingCriteria` -
    (Required)
    Required. null The list of filters that applies to event attributes. Only events that match all the provided filters will be sent to the destination.

*   `name` -
    (Required)
    Required. The resource name of the trigger. Must be unique within the location on the project.

The `destination` block supports:

*   `cloudFunction` -
    (Optional)
    \[WARNING] Configuring a Cloud Function in Trigger is not supported as of today. The Cloud Function resource name. Format: projects/{project}/locations/{location}/functions/{function}

*   `cloudRunService` -
    (Optional)
    Cloud Run fully-managed service that receives the events. The service should be running in the same project of the trigger.

*   `gke` -
    (Optional)
    A GKE service capable of receiving events. The service should be running in the same project as the trigger.

*   `workflow` -
    (Optional)
    The resource name of the Workflow whose Executions are triggered by the events. The Workflow resource should be deployed in the same project as the trigger. Format: `projects/{project}/locations/{location}/workflows/{workflow}`

The `matchingCriteria` block supports:

*   `attribute` -
    (Required)
    Required. The name of a CloudEvents attribute. Currently, only a subset of attributes are supported for filtering. All triggers MUST provide a filter for the 'type' attribute.

*   `operator` -
    (Optional)
    Optional. The operator used for matching the events with the value of the filter. If not specified, only events that have an exact key-value pair specified in the filter are matched. The only allowed value is `matchPathPattern`.

*   `value` -
    (Required)
    Required. The value for the attribute. See https://cloud.google.com/eventarc/docs/creating-triggers#trigger-gcloud for available values.

***

*   `channel` -
    (Optional)
    Optional. The name of the channel associated with the trigger in `projects/{project}/locations/{location}/channels/{channel}` format. You must provide a channel to receive events from Eventarc SaaS partners.

*   `labels` -
    (Optional)
    Optional. User labels attached to the triggers that can be used to group resources.

*   `project` -
    (Optional)
    The project for the resource

*   `serviceAccount` -
    (Optional)
    Optional. The IAM service account email associated with the trigger. The service account represents the identity of the trigger. The principal who calls this API must have `iamServiceAccountsActAs` permission in the service account. See https://cloud.google.com/iam/docs/understanding-service-accounts#sa\_common for more information. For Cloud Run destinations, this service account is used to generate identity tokens when invoking the service. See https://cloud.google.com/run/docs/triggering/pubsub-push#create-service-account for information on how to invoke authenticated Cloud Run services. In order to create Audit Log triggers, the service account should also have `roles/eventarcEventReceiver` IAM role.

*   `transport` -
    (Optional)
    Optional. In order to deliver messages, Eventarc may use other GCP products as transport intermediary. This field contains a reference to that transport intermediary. This information can be used for debugging purposes.

The `cloudRunService` block supports:

*   `path` -
    (Optional)
    Optional. The relative path on the Cloud Run service the events should be sent to. The value must conform to the definition of URI path segment (section 3.3 of RFC2396). Examples: "/route", "route", "route/subroute".

*   `region` -
    (Optional)
    Required. The region the Cloud Run service is deployed in.

*   `service` -
    (Required)
    Required. The name of the Cloud Run service being addressed. See https://cloud.google.com/run/docs/reference/rest/v1/namespaces.services. Only services located in the same project of the trigger object can be addressed.

The `gke` block supports:

*   `cluster` -
    (Required)
    Required. The name of the cluster the GKE service is running in. The cluster must be running in the same project as the trigger being created.

*   `location` -
    (Required)
    Required. The name of the Google Compute Engine in which the cluster resides, which can either be compute zone (for example, us-central1-a) for the zonal clusters or region (for example, us-central1) for regional clusters.

*   `namespace` -
    (Required)
    Required. The namespace the GKE service is running in.

*   `path` -
    (Optional)
    Optional. The relative path on the GKE service the events should be sent to. The value must conform to the definition of a URI path segment (section 3.3 of RFC2396). Examples: "/route", "route", "route/subroute".

*   `service` -
    (Required)
    Required. Name of the GKE service.

The `transport` block supports:

* `pubsub` -
  (Optional)
  The Pub/Sub topic and subscription used by Eventarc as delivery intermediary.

The `pubsub` block supports:

*   `subscription` -
    Output only. The name of the Pub/Sub subscription created and managed by Eventarc system as a transport for the event delivery. Format: `projects/{projectId}/subscriptions/{subscriptionName}`.

*   `topic` -
    (Optional)
    Optional. The name of the Pub/Sub topic created and managed by Eventarc system as a transport for the event delivery. Format: `projects/{projectId}/topics/{topicName}YouMaySetAnExistingTopicForTriggersOfTheTypeGoogleCloudPubsubTopicV1MessagePublished` only. The topic you provide here will not be deleted by Eventarc at trigger deletion.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `projects/{{project}}/locations/{{location}}/triggers/{{name}}`

*   `conditions` -
    Output only. The reason(s) why a trigger is in FAILED state.

*   `createTime` -
    Output only. The creation time.

*   `etag` -
    Output only. This checksum is computed by the server based on the value of other fields, and may be sent only on create requests to ensure the client has an up-to-date value before proceeding.

*   `uid` -
    Output only. Server assigned unique identifier for the trigger. The value is a UUID4 string and guaranteed to remain unchanged until the resource is deleted.

*   `updateTime` -
    Output only. The last-modified time.

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `update` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

Trigger can be imported using any of these accepted formats:

```console
$ terraform import google_eventarc_trigger.default projects/{{project}}/locations/{{location}}/triggers/{{name}}
$ terraform import google_eventarc_trigger.default {{project}}/{{location}}/{{name}}
$ terraform import google_eventarc_trigger.default {{location}}/{{name}}
```
