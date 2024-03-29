---
subcategory: "Neptune"
layout: "aws"
page_title: "AWS: aws_neptune_cluster_endpoint"
description: |-
  Provides an Neptune Cluster Endpoint Resource
---

# Resource: awsNeptuneClusterEndpoint

Provides an Neptune Cluster Endpoint Resource.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.neptuneClusterEndpoint.NeptuneClusterEndpoint(this, "example", {
  clusterEndpointIdentifier: "example",
  clusterIdentifier: "${aws_neptune_cluster.test.cluster_identifier}",
  endpointType: "READER",
});

```

## Argument Reference

The following arguments are supported:

* `clusterIdentifier` - (Required, Forces new resources) The DB cluster identifier of the DB cluster associated with the endpoint.
* `clusterEndpointIdentifier` - (Required, Forces new resources) The identifier of the endpoint.
* `endpointType` - (Required) The type of the endpoint. One of: `reader`, `writer`, `any`.
* `excludedMembers` - (Optional) List of DB instance identifiers that aren't part of the custom endpoint group. All other eligible instances are reachable through the custom endpoint. Only relevant if the list of static members is empty.
* `staticMembers` - (Optional) List of DB instance identifiers that are part of the custom endpoint group.
* `tags` - (Optional) A map of tags to assign to the Neptune cluster. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The Neptune Cluster Endpoint Amazon Resource Name (ARN).
* `endpoint` - The DNS address of the endpoint.
* `id` - The Neptune Cluster Endpoint Identifier.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsNeptuneClusterEndpoint` can be imported by using the `clusterIdentifier:endpointIdentfier`, e.g.,

```console
$ terraform import aws_neptune_cluster_endpoint.example my-cluster:my-endpoint
```
