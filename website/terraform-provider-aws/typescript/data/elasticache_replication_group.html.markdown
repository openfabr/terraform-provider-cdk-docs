---
subcategory: "ElastiCache"
layout: "aws"
page_title: "AWS: aws_elasticache_replication_group"
description: |-
  Get information on an ElastiCache Replication Group resource.
---

# Data Source: awsElasticacheReplicationGroup

Use this data source to get information about an ElastiCache Replication Group.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsElasticacheReplicationGroup.DataAwsElasticacheReplicationGroup(
  this,
  "bar",
  {
    replicationGroupId: "example",
  }
);

```

## Argument Reference

The following arguments are supported:

* `replicationGroupId` – (Required) Identifier for the replication group.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `description` - Description of the replication group.
* `arn` - ARN of the created ElastiCache Replication Group.
* `authTokenEnabled` - Whether an AuthToken (password) is enabled.
* `automaticFailoverEnabled` - A flag whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails.
* `nodeType` – The cluster node type.
* `numCacheClusters` – The number of cache clusters that the replication group has.
* `numNodeGroups` - Number of node groups (shards) for the replication group.
* `numberCacheClusters` – (**Deprecated** use `numCacheClusters` instead) Number of cache clusters that the replication group has.
* `memberClusters` - Identifiers of all the nodes that are part of this replication group.
* `multiAzEnabled` - Whether Multi-AZ Support is enabled for the replication group.
* `replicasPerNodeGroup` - Number of replica nodes in each node group.
* `replicationGroupDescription` - (**Deprecated** use `description` instead) Description of the replication group.
* `logDeliveryConfiguration` - Redis [SLOWLOG](https://redis.io/commands/slowlog) or Redis [Engine Log](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Log_Delivery.html#Log_contents-engine-log) delivery settings.
* `snapshotWindow` - Daily time range (in UTC) during which ElastiCache begins taking a daily snapshot of your node group (shard).
* `snapshotRetentionLimit` - The number of days for which ElastiCache retains automatic cache cluster snapshots before deleting them.
* `port` – The port number on which the configuration endpoint will accept connections.
* `configurationEndpointAddress` - The configuration endpoint address to allow host discovery.
* `primaryEndpointAddress` - The endpoint of the primary node in this node group (shard).
* `readerEndpointAddress` - The endpoint of the reader node in this node group (shard).
