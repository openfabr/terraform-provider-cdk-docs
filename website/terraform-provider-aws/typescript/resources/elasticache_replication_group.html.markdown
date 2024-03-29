---
subcategory: "ElastiCache"
layout: "aws"
page_title: "AWS: aws_elasticache_replication_group"
description: |-
  Provides an ElastiCache Replication Group resource.
---

# Resource: awsElasticacheReplicationGroup

Provides an ElastiCache Replication Group resource.

For working with a [Memcached cluster](https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/WhatIs.html) or a
[single-node Redis instance (Cluster Mode Disabled)](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/WhatIs.html),
see the [`awsElasticacheCluster` resource](/docs/providers/aws/r/elasticache_cluster.html).

\~> **Note:** When you change an attribute, such as `engineVersion`, by
default the ElastiCache API applies it in the next maintenance window. Because
of this, Terraform may report a difference in its planning phase because the
actual modification has not yet taken place. You can use the
`applyImmediately` flag to instruct the service to apply the change
immediately. Using `applyImmediately` can result in a brief downtime as
servers reboots.
See the AWS Documentation on
[Modifying an ElastiCache Cache Cluster](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Clusters.Modify.html)
for more information.

\~> **Note:** Any attribute changes that re-create the resource will be applied immediately, regardless of the value of `applyImmediately`.

\~> **Note:** Be aware of the terminology collision around "cluster" for `awsElasticacheReplicationGroup`. For example, it is possible to create a ["Cluster Mode Disabled \[Redis\] Cluster"](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Clusters.Create.CON.Redis.html). With "Cluster Mode Enabled", the data will be stored in shards (called "node groups"). See [Redis Cluster Configuration](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/cluster-create-determine-requirements.html#redis-cluster-configuration) for a diagram of the differences. To enable cluster mode, use a parameter group that has cluster mode enabled. The default parameter groups provided by AWS end with ".cluster.on", for example `defaultRedis6XClusterOn`.

## Example Usage

### Redis Cluster Mode Disabled

To create a single shard primary with single read replica:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.elasticacheReplicationGroup.ElasticacheReplicationGroup(
  this,
  "example",
  {
    automaticFailoverEnabled: true,
    description: "example description",
    nodeType: "cache.m4.large",
    numCacheClusters: 2,
    parameterGroupName: "default.redis3.2",
    port: 6379,
    preferredCacheClusterAzs: ["us-west-2a", "us-west-2b"],
    replicationGroupId: "tf-rep-group-1",
  }
);

```

You have two options for adjusting the number of replicas:

* Adjusting `numCacheClusters` directly. This will attempt to automatically add or remove replicas, but provides no granular control (e.g., preferred availability zone, cache cluster ID) for the added or removed replicas. This also currently expects cache cluster IDs in the form of `replicationGroupId00#`.
* Otherwise for fine grained control of the underlying cache clusters, they can be added or removed with the [`awsElasticacheCluster` resource](/docs/providers/aws/r/elasticache_cluster.html) and its `replicationGroupId` attribute. In this situation, you will need to utilize the [lifecycle configuration block](https://www.terraform.io/docs/configuration/meta-arguments/lifecycle.html) with `ignoreChanges` to prevent perpetual differences during Terraform plan with the `numCacheCluster` attribute.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsElasticacheReplicationGroupExample =
  new aws.elasticacheReplicationGroup.ElasticacheReplicationGroup(
    this,
    "example",
    {
      automaticFailoverEnabled: true,
      description: "example description",
      nodeType: "cache.m4.large",
      numCacheClusters: 2,
      parameterGroupName: "default.redis3.2",
      port: 6379,
      preferredCacheClusterAzs: ["us-west-2a", "us-west-2b"],
      replicationGroupId: "tf-rep-group-1",
    }
  );
awsElasticacheReplicationGroupExample.addOverride("lifecycle", [
  {
    ignore_changes: ["${num_cache_clusters}"],
  },
]);
const awsElasticacheClusterReplica =
  new aws.elasticacheCluster.ElasticacheCluster(this, "replica", {
    clusterId: "tf-rep-group-1-${count.index}",
    replicationGroupId: awsElasticacheReplicationGroupExample.id,
  });
/*In most cases loops should be handled in the programming language context and 
not inside of the Terraform context. If you are looping over something external, e.g. a variable or a file input
you should consider using a for loop. If you are looping over something only known to Terraform, e.g. a result of a data source
you need to keep this like it is.*/
awsElasticacheClusterReplica.addOverride("count", 1);

```

### Redis Cluster Mode Enabled

To create two shards with a primary and a single read replica each:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.elasticacheReplicationGroup.ElasticacheReplicationGroup(this, "baz", {
  automaticFailoverEnabled: true,
  description: "example description",
  nodeType: "cache.t2.small",
  numNodeGroups: 2,
  parameterGroupName: "default.redis3.2.cluster.on",
  port: 6379,
  replicasPerNodeGroup: 1,
  replicationGroupId: "tf-redis-cluster",
});

```

### Redis Log Delivery configuration

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.elasticacheReplicationGroup.ElasticacheReplicationGroup(this, "test", {
  applyImmediately: true,
  autoMinorVersionUpgrade: false,
  description: "test description",
  logDeliveryConfiguration: [
    {
      destination: "${aws_cloudwatch_log_group.example.name}",
      destinationType: "cloudwatch-logs",
      logFormat: "text",
      logType: "slow-log",
    },
    {
      destination: "${aws_kinesis_firehose_delivery_stream.example.name}",
      destinationType: "kinesis-firehose",
      logFormat: "json",
      logType: "engine-log",
    },
  ],
  maintenanceWindow: "tue:06:30-tue:07:30",
  nodeType: "cache.t3.small",
  port: 6379,
  replicationGroupId: "myreplicaciongroup",
  snapshotWindow: "01:00-02:00",
});

```

\~> **Note:** We currently do not support passing a `primaryClusterId` in order to create the Replication Group.

\~> **Note:** Automatic Failover is unavailable for Redis versions earlier than 2.8.6,
and unavailable on T1 node types. For T2 node types, it is only available on Redis version 3.2.4 or later with cluster mode enabled. See the [High Availability Using Replication Groups](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Replication.html) guide
for full details on using Replication Groups.

### Creating a secondary replication group for a global replication group

A Global Replication Group can have one one two secondary Replication Groups in different regions. These are added to an existing Global Replication Group.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsElasticacheReplicationGroupPrimary =
  new aws.elasticacheReplicationGroup.ElasticacheReplicationGroup(
    this,
    "primary",
    {
      description: "primary replication group",
      engine: "redis",
      engineVersion: "5.0.6",
      nodeType: "cache.m5.large",
      numCacheClusters: 1,
      provider: "${aws.other_region}",
      replicationGroupId: "example-primary",
    }
  );
const awsElasticacheGlobalReplicationGroupExample =
  new aws.elasticacheGlobalReplicationGroup.ElasticacheGlobalReplicationGroup(
    this,
    "example",
    {
      globalReplicationGroupIdSuffix: "example",
      primaryReplicationGroupId: awsElasticacheReplicationGroupPrimary.id,
      provider: "${aws.other_region}",
    }
  );
new aws.elasticacheReplicationGroup.ElasticacheReplicationGroup(
  this,
  "secondary",
  {
    description: "secondary replication group",
    globalReplicationGroupId:
      awsElasticacheGlobalReplicationGroupExample.globalReplicationGroupId,
    numCacheClusters: 1,
    replicationGroupId: "example-secondary",
  }
);

```

## Argument Reference

The following arguments are required:

* `description` – (Required) User-created description for the replication group. Must not be empty.
* `replicationGroupId` – (Required) Replication group identifier. This parameter is stored as a lowercase string.
* `replicationGroupDescription` – (**Deprecated** use `description` instead) User-created description for the replication group. Must not be empty.

The following arguments are optional:

* `applyImmediately` - (Optional) Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is `false`.
* `atRestEncryptionEnabled` - (Optional) Whether to enable encryption at rest.
* `authToken` - (Optional) Password used to access a password protected server. Can be specified only if `transitEncryptionEnabled =True`.
* `autoMinorVersionUpgrade` - (Optional) Specifies whether minor version engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window.
  Only supported for engine type `"redis"` and if the engine version is 6 or higher.
  Defaults to `true`.
* `automaticFailoverEnabled` - (Optional) Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If enabled, `numCacheClusters` must be greater than 1. Must be enabled for Redis (cluster mode enabled) replication groups. Defaults to `false`.
* `availabilityZones` - (Optional, **Deprecated** use `preferredCacheClusterAzs` instead) List of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is not considered.
* `clusterMode` - (Optional, **Deprecated** use root-level `numNodeGroups` and `replicasPerNodeGroup` instead) Create a native Redis cluster. `automaticFailoverEnabled` must be set to true. Cluster Mode documented below. Only 1 `clusterMode` block is allowed. Note that configuring this block does not enable cluster mode, i.e., data sharding, this requires using a parameter group that has the parameter `clusterEnabled` set to true.
* `dataTieringEnabled` - (Optional) Enables data tiering. Data tiering is only supported for replication groups using the r6gd node type. This parameter must be set to `true` when using r6gd nodes.
* `engine` - (Optional) Name of the cache engine to be used for the clusters in this replication group. The only valid value is `redis`.
* `engineVersion` - (Optional) Version number of the cache engine to be used for the cache clusters in this replication group.
  If the version is 6 or higher, the major and minor version can be set, e.g., `62`,
  or the minor version can be unspecified which will use the latest version at creation time, e.g., `6X`.
  Otherwise, specify the full version desired, e.g., `506`.
  The actual engine version used is returned in the attribute `engineVersionActual`, see [Attributes Reference](#attributes-reference) below.
* `finalSnapshotIdentifier` - (Optional) The name of your final node group (shard) snapshot. ElastiCache creates the snapshot from the primary node in the cluster. If omitted, no final snapshot will be made.
* `globalReplicationGroupId` - (Optional) The ID of the global replication group to which this replication group should belong. If this parameter is specified, the replication group is added to the specified global replication group as a secondary replication group; otherwise, the replication group is not part of any global replication group. If `globalReplicationGroupId` is set, the `numNodeGroups` parameter (or the `numNodeGroups` parameter of the deprecated `clusterMode` block) cannot be set.
* `kmsKeyId` - (Optional) The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if `atRestEncryptionEnabled =True`.
* `logDeliveryConfiguration` - (Optional, Redis only) Specifies the destination and format of Redis [SLOWLOG](https://redis.io/commands/slowlog) or Redis [Engine Log](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Log_Delivery.html#Log_contents-engine-log). See the documentation on [Amazon ElastiCache](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Log_Delivery.html#Log_contents-engine-log). See [Log Delivery Configuration](#log-delivery-configuration) below for more details.
* `maintenanceWindow` – (Optional) Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is `ddd:hh24:miDdd:hh24:mi` (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: `sun:05:00Sun:09:00`
* `multiAzEnabled` - (Optional) Specifies whether to enable Multi-AZ Support for the replication group. If `true`, `automaticFailoverEnabled` must also be enabled. Defaults to `false`.
* `nodeType` - (Optional) Instance class to be used. See AWS documentation for information on [supported node types](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/CacheNodes.SupportedTypes.html) and [guidance on selecting node types](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/nodes-select-size.html). Required unless `globalReplicationGroupId` is set. Cannot be set if `globalReplicationGroupId` is set.
* `notificationTopicArn` – (Optional) ARN of an SNS topic to send ElastiCache notifications to. Example: `arn:aws:sns:usEast1:012345678999:mySnsTopic`
* `numberCacheClusters` - (Optional, **Deprecated** use `numCacheClusters` instead) Number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. Conflicts with `numCacheClusters`, `numNodeGroups`, or the deprecated `clusterMode`. Defaults to `1`.
* `numCacheClusters` - (Optional) Number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. Conflicts with `numNodeGroups`, the deprecated`numberCacheClusters`, or the deprecated `clusterMode`. Defaults to `1`.
* `numNodeGroups` - (Optional) Number of node groups (shards) for this Redis replication group.
  Changing this number will trigger a resizing operation before other settings modifications.
* `parameterGroupName` - (Optional) Name of the parameter group to associate with this replication group. If this argument is omitted, the default cache parameter group for the specified engine is used. To enable "cluster mode", i.e., data sharding, use a parameter group that has the parameter `clusterEnabled` set to true.
* `port` – (Optional) Port number on which each of the cache nodes will accept connections. For Memcache the default is 11211, and for Redis the default port is 6379.
* `preferredCacheClusterAzs` - (Optional) List of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is considered. The first item in the list will be the primary node. Ignored when updating.
* `replicasPerNodeGroup` - (Optional) Number of replica nodes in each node group.
  Changing this number will trigger a resizing operation before other settings modifications.
  Valid values are 0 to 5.
* `securityGroupIds` - (Optional) One or more Amazon VPC security groups associated with this replication group. Use this parameter only when you are creating a replication group in an Amazon Virtual Private Cloud
* `securityGroupNames` - (Optional) List of cache security group names to associate with this replication group.
* `snapshotArns` – (Optional) List of ARNs that identify Redis RDB snapshot files stored in Amazon S3. The names object names cannot contain any commas.
* `snapshotName` - (Optional) Name of a snapshot from which to restore data into the new node group. Changing the `snapshotName` forces a new resource.
* `snapshotRetentionLimit` - (Optional, Redis only) Number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of `snapshotRetentionLimit` is set to zero (0), backups are turned off. Please note that setting a `snapshotRetentionLimit` is not supported on cache.t1.micro cache nodes
* `snapshotWindow` - (Optional, Redis only) Daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum snapshot window is a 60 minute period. Example: `05:0009:00`
* `subnetGroupName` - (Optional) Name of the cache subnet group to be used for the replication group.
* `tags` - (Optional) Map of tags to assign to the resource. Adding tags to this resource will add or overwrite any existing tags on the clusters in the replication group and not to the group itself. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `transitEncryptionEnabled` - (Optional) Whether to enable encryption in transit.
* `userGroupIds` - (Optional) User Group ID to associate with the replication group. Only a maximum of one (1) user group ID is valid. **NOTE:** This argument *is* a set because the AWS specification allows for multiple IDs. However, in practice, AWS only allows a maximum size of one.

### cluster\_mode (**DEPRECATED**)

* `numNodeGroups` - (Optional, **Deprecated** use root-level `numNodeGroups` instead) Number of node groups (shards) for this Redis replication group. Changing this number will trigger an online resizing operation before other settings modifications. Required unless `globalReplicationGroupId` is set.
* `replicasPerNodeGroup` - (Optional, Required with `clusterMode` `numNodeGroups`, **Deprecated** use root-level `replicasPerNodeGroup` instead) Number of replica nodes in each node group. Valid values are 0 to 5. Changing this number will trigger an online resizing operation before other settings modifications.

### Log Delivery Configuration

The `logDeliveryConfiguration` block allows the streaming of Redis [SLOWLOG](https://redis.io/commands/slowlog) or Redis [Engine Log](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Log_Delivery.html#Log_contents-engine-log) to CloudWatch Logs or Kinesis Data Firehose. Max of 2 blocks.

* `destination` - Name of either the CloudWatch Logs LogGroup or Kinesis Data Firehose resource.
* `destinationType` - For CloudWatch Logs use `cloudwatchLogs` or for Kinesis Data Firehose use `kinesisFirehose`.
* `logFormat` - Valid values are `json` or `text`
* `logType` - Valid values are  `slowLog` or `engineLog`. Max 1 of each.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the created ElastiCache Replication Group.
* `engineVersionActual` - Because ElastiCache pulls the latest minor or patch for a version, this attribute returns the running version of the cache engine.
* `clusterEnabled` - Indicates if cluster mode is enabled.
* `configurationEndpointAddress` - Address of the replication group configuration endpoint when cluster mode is enabled.
* `id` - ID of the ElastiCache Replication Group.
* `memberClusters` - Identifiers of all the nodes that are part of this replication group.
* `primaryEndpointAddress` - (Redis only) Address of the endpoint for the primary node in the replication group, if the cluster mode is disabled.
* `readerEndpointAddress` - (Redis only) Address of the endpoint for the reader node in the replication group, if the cluster mode is disabled.
* `tagsAll` - Map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `60M`)
* `delete` - (Default `40M`)
* `update` - (Default `40M`)

## Import

ElastiCache Replication Groups can be imported using the `replicationGroupId`, e.g.,

```console
$ terraform import aws_elasticache_replication_group.my_replication_group replication-group-1
```
