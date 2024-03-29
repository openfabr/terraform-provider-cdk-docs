---
subcategory: "Redshift"
layout: "aws"
page_title: "AWS: aws_redshift_snapshot_schedule"
description: |-
  Provides an Redshift Snapshot Schedule resource.
---

# Resource: awsRedshiftSnapshotSchedule

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.redshiftSnapshotSchedule.RedshiftSnapshotSchedule(this, "default", {
  definitions: ["rate(12 hours)"],
  identifier: "tf-redshift-snapshot-schedule",
});

```

## Argument Reference

The following arguments are supported:

* `identifier` - (Optional, Forces new resource) The snapshot schedule identifier. If omitted, Terraform will assign a random, unique identifier.
* `identifierPrefix` - (Optional, Forces new resource) Creates a unique
  identifier beginning with the specified prefix. Conflicts with `identifier`.
* `description` - (Optional) The description of the snapshot schedule.
* `definitions` - (Optional) The definition of the snapshot schedule. The definition is made up of schedule expressions, for example `cron(3012 *)` or `rate(12Hours)`.
* `forceDestroy` - (Optional) Whether to destroy all associated clusters with this snapshot schedule on deletion. Must be enabled and applied before attempting deletion.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the Redshift Snapshot Schedule.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Redshift Snapshot Schedule can be imported using the `identifier`, e.g.,

```console
$ terraform import aws_redshift_snapshot_schedule.default tf-redshift-snapshot-schedule
```
