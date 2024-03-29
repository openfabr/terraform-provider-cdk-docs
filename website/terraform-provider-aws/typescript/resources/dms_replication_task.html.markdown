---
subcategory: "DMS (Database Migration)"
layout: "aws"
page_title: "AWS: aws_dms_replication_task"
description: |-
  Provides a DMS (Data Migration Service) replication task resource.
---

# Resource: awsDmsReplicationTask

Provides a DMS (Data Migration Service) replication task resource. DMS replication tasks can be created, updated, deleted, and imported.

\~> **NOTE:** Changing most arguments will stop the task if it is running. You can set `startReplicationTask` to resume the task afterwards.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dmsReplicationTask.DmsReplicationTask(this, "test", {
  cdcStartTime: 1484346880,
  migrationType: "full-load",
  replicationInstanceArn:
    "${aws_dms_replication_instance.test-dms-replication-instance-tf.replication_instance_arn}",
  replicationTaskId: "test-dms-replication-task-tf",
  replicationTaskSettings: "...",
  sourceEndpointArn:
    "${aws_dms_endpoint.test-dms-source-endpoint-tf.endpoint_arn}",
  tableMappings:
    '{"rules":[{"rule-type":"selection","rule-id":"1","rule-name":"1","object-locator":{"schema-name":"%","table-name":"%"},"rule-action":"include"}]}',
  tags: {
    Name: "test",
  },
  targetEndpointArn:
    "${aws_dms_endpoint.test-dms-target-endpoint-tf.endpoint_arn}",
});

```

## Argument Reference

The following arguments are supported:

*   `cdcStartPosition` - (Optional, Conflicts with `cdcStartTime`) Indicates when you want a change data capture (CDC) operation to start. The value can be in date, checkpoint, or LSN/SCN format depending on the source engine. For more information, see [Determining a CDC native start point](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Task.CDC.html#CHAP_Task.CDC.StartPoint.Native).

*   `cdcStartTime` - (Optional, Conflicts with `cdcStartPosition`) The Unix timestamp integer for the start of the Change Data Capture (CDC) operation.

*   `migrationType` - (Required) The migration type. Can be one of `fullLoad |Cdc |FullLoadAndCdc`.

*   `replicationInstanceArn` - (Required) The Amazon Resource Name (ARN) of the replication instance.

*   `replicationTaskId` - (Required) The replication task identifier.

    * Must contain from 1 to 255 alphanumeric characters or hyphens.
    * First character must be a letter.
    * Cannot end with a hyphen.
    * Cannot contain two consecutive hyphens.

*   `replicationTaskSettings` - (Optional) An escaped JSON string that contains the task settings. For a complete list of task settings, see [Task Settings for AWS Database Migration Service Tasks](http://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.CustomizingTasks.TaskSettings.html).

*   `sourceEndpointArn` - (Required) The Amazon Resource Name (ARN) string that uniquely identifies the source endpoint.

*   `startReplicationTask` - (Optional) Whether to run or stop the replication task.

*   `status` - Replication Task status.

*   `tableMappings` - (Required) An escaped JSON string that contains the table mappings. For information on table mapping see [Using Table Mapping with an AWS Database Migration Service Task to Select and Filter Data](http://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.CustomizingTasks.TableMapping.html)

*   `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

*   `targetEndpointArn` - (Required) The Amazon Resource Name (ARN) string that uniquely identifies the target endpoint.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `replicationTaskArn` - The Amazon Resource Name (ARN) for the replication task.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Replication tasks can be imported using the `replicationTaskId`, e.g.,

```console
$ terraform import aws_dms_replication_task.test test-dms-replication-task-tf
```
