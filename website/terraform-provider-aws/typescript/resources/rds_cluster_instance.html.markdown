---
subcategory: "RDS (Relational Database)"
layout: "aws"
page_title: "AWS: aws_rds_cluster_instance"
description: |-
  Provides an RDS Cluster Resource Instance
---

# Resource: awsRdsClusterInstance

Provides an RDS Cluster Instance Resource. A Cluster Instance Resource defines
attributes that are specific to a single instance in a [RDS Cluster][3],
specifically running Amazon Aurora.

Unlike other RDS resources that support replication, with Amazon Aurora you do
not designate a primary and subsequent replicas. Instead, you simply add RDS
Instances and Aurora manages the replication. You can use the [count][5]
meta-parameter to make multiple instances and join them all to the same RDS
Cluster, or you may specify different Cluster Instance resources with various
`instanceClass` sizes.

For more information on Amazon Aurora, see [Aurora on Amazon RDS][2] in the Amazon RDS User Guide.

\~> **NOTE:** Deletion Protection from the RDS service can only be enabled at the cluster level, not for individual cluster instances. You can still add the [`preventDestroy` lifecycle behavior](https://www.terraform.io/language/meta-arguments/lifecycle#prevent_destroy) to your Terraform resource configuration if you desire protection from accidental deletion.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsRdsClusterDefault = new aws.rdsCluster.RdsCluster(this, "default", {
  availabilityZones: ["us-west-2a", "us-west-2b", "us-west-2c"],
  clusterIdentifier: "aurora-cluster-demo",
  databaseName: "mydb",
  masterPassword: "barbut8chars",
  masterUsername: "foo",
});
const awsRdsClusterInstanceClusterInstances =
  new aws.rdsClusterInstance.RdsClusterInstance(this, "cluster_instances", {
    clusterIdentifier: awsRdsClusterDefault.id,
    engine: awsRdsClusterDefault.engine,
    engineVersion: awsRdsClusterDefault.engineVersion,
    identifier: "aurora-cluster-demo-${count.index}",
    instanceClass: "db.r4.large",
  });
/*In most cases loops should be handled in the programming language context and 
not inside of the Terraform context. If you are looping over something external, e.g. a variable or a file input
you should consider using a for loop. If you are looping over something only known to Terraform, e.g. a result of a data source
you need to keep this like it is.*/
awsRdsClusterInstanceClusterInstances.addOverride("count", 2);

```

## Argument Reference

For more detailed documentation about each argument, refer to
the [AWS official documentation](https://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html).

The following arguments are supported:

* `identifier` - (Optional, Forces new resource) The identifier for the RDS instance, if omitted, Terraform will assign a random, unique identifier.
* `identifierPrefix` - (Optional, Forces new resource) Creates a unique identifier beginning with the specified prefix. Conflicts with `identifier`.
* `clusterIdentifier` - (Required, Forces new resource) The identifier of the [`awsRdsCluster`](/docs/providers/aws/r/rds_cluster.html) in which to launch this instance.
* `engine` - (Optional, Forces new resource) The name of the database engine to be used for the RDS instance. Defaults to `aurora`. Valid Values: `aurora`, `auroraMysql`, `auroraPostgresql`.
  For information on the difference between the available Aurora MySQL engines
  see [Comparison between Aurora MySQL 1 and Aurora MySQL 2](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/AuroraMySQL.Updates.20180206.html)
  in the Amazon RDS User Guide.
* `engineVersion` - (Optional) The database engine version.
* `instanceClass` - (Required) The instance class to use. For details on CPU
  and memory, see [Scaling Aurora DB Instances][4]. Aurora uses `db.*` instance classes/types. Please see [AWS Documentation][7] for currently available instance classes and complete details.
* `publiclyAccessible` - (Optional) Bool to control if instance is publicly accessible.
  Default `false`. See the documentation on [Creating DB Instances][6] for more
  details on controlling this property.
* `dbSubnetGroupName` - (Required if `publiclyAccessible =False`, Optional otherwise, Forces new resource) A DB subnet group to associate with this DB instance. **NOTE:** This must match the `dbSubnetGroupName` of the attached [`awsRdsCluster`](/docs/providers/aws/r/rds_cluster.html).
* `dbParameterGroupName` - (Optional) The name of the DB parameter group to associate with this instance.
* `applyImmediately` - (Optional) Specifies whether any database modifications
  are applied immediately, or during the next maintenance window. Default is`false`.
* `monitoringRoleArn` - (Optional) The ARN for the IAM role that permits RDS to send
  enhanced monitoring metrics to CloudWatch Logs. You can find more information on the [AWS Documentation](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.html)
  what IAM permissions are needed to allow Enhanced Monitoring for RDS Instances.
* `monitoringInterval` - (Optional) The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60.
* `promotionTier` - (Optional) Default 0. Failover Priority setting on instance level. The reader who has lower tier has higher priority to get promoted to writer.
* `availabilityZone` - (Optional, Computed, Forces new resource) The EC2 Availability Zone that the DB instance is created in. See [docs](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html) about the details.
* `preferredBackupWindow` - (Optional) The daily time range during which automated backups are created if automated backups are enabled. Eg: "04:00-09:00". **NOTE:** If `preferredBackupWindow` is set at the cluster level, this argument **must** be omitted.
* `preferredMaintenanceWindow` - (Optional) The window to perform maintenance in.
  Syntax: "ddd:hh24:mi-ddd:hh24:mi". Eg: "Mon:00:00-Mon:03:00".
* `autoMinorVersionUpgrade` - (Optional) Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Default `true`.
* `performanceInsightsEnabled` - (Optional) Specifies whether Performance Insights is enabled or not.
* `performanceInsightsKmsKeyId` - (Optional) ARN for the KMS key to encrypt Performance Insights data. When specifying `performanceInsightsKmsKeyId`, `performanceInsightsEnabled` needs to be set to true.
* `performanceInsightsRetentionPeriod` - (Optional) Amount of time in days to retain Performance Insights data. Valid values are `7`, `731` (2 years) or a multiple of `31`. When specifying `performanceInsightsRetentionPeriod`, `performanceInsightsEnabled` needs to be set to true. Defaults to '7'.
* `copyTagsToSnapshot` – (Optional, boolean) Indicates whether to copy all of the user-defined tags from the DB instance to snapshots of the DB instance. Default `false`.
* `caCertIdentifier` - (Optional) The identifier of the CA certificate for the DB instance.
* `tags` - (Optional) A map of tags to assign to the instance. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of cluster instance
* `clusterIdentifier` - The RDS Cluster Identifier
* `identifier` - The Instance identifier
* `id` - The Instance identifier
* `writer` – Boolean indicating if this instance is writable. `false` indicates this instance is a read replica.
* `availabilityZone` - The availability zone of the instance
* `endpoint` - The DNS address for this instance. May not be writable
* `engine` - The database engine
* `engineVersionActual` - The database engine version
* `port` - The database port
* `storageEncrypted` - Specifies whether the DB cluster is encrypted.
* `kmsKeyId` - The ARN for the KMS encryption key if one is set to the cluster.
* `networkType` - The network type of the DB instance.
* `dbiResourceId` - The region-unique, immutable identifier for the DB instance.
* `performanceInsightsEnabled` - Specifies whether Performance Insights is enabled or not.
* `performanceInsightsKmsKeyId` - The ARN for the KMS encryption key used by Performance Insights.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

[2]: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html

[3]: /docs/providers/aws/r/rds_cluster.html

[4]: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Aurora.Managing.html

[5]: https://www.terraform.io/docs/configuration/meta-arguments/count.html

[6]: https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html

[7]: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `90M`)
* `update` - (Default `90M`)
* `delete` - (Default `90M`)

## Import

RDS Cluster Instances can be imported using the `identifier`, e.g.,

```console
$ terraform import aws_rds_cluster_instance.prod_instance_1 aurora-cluster-instance-1
```
