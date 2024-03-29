---
subcategory: "Cloud Pub/Sub"
description: |-
  Get information about a Google Cloud Pub/Sub Topic.
---

# googlePubsubTopic

Get information about a Google Cloud Pub/Sub Topic. For more information see
the [official documentation](https://cloud.google.com/pubsub/docs/)
and [API](https://cloud.google.com/pubsub/docs/apis).

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.dataGooglePubsubTopic.DataGooglePubsubTopic(
  this,
  "my-pubsub-topic",
  {
    name: "my-pubsub-topic",
  }
);

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the Cloud Pub/Sub Topic.

***

* `project` - (Optional) The project in which the resource belongs. If it
  is not provided, the provider project is used.

## Attributes Reference

See [google\_pubsub\_topic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic#argument-reference) resource for details of the available attributes.
