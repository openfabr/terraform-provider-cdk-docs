---
subcategory: "ECS (Elastic Container)"
layout: "aws"
page_title: "AWS: aws_ecs_task_definition"
description: |-
    Provides details about an ecs task definition
---

# Data Source: awsEcsTaskDefinition

The ECS task definition data source allows access to details of
a specific AWS ECS task definition.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsEcsClusterFoo = new aws.ecsCluster.EcsCluster(this, "foo", {
  name: "foo",
});
const awsEcsTaskDefinitionMongo = new aws.ecsTaskDefinition.EcsTaskDefinition(
  this,
  "mongo",
  {
    containerDefinitions:
      '[\n  {\n    "cpu": 128,\n    "environment": [{\n      "name": "SECRET",\n      "value": "KEY"\n    }],\n    "essential": true,\n    "image": "mongo:latest",\n    "memory": 128,\n    "memoryReservation": 64,\n    "name": "mongodb"\n  }\n]\n',
    family: "mongodb",
  }
);
const dataAwsEcsTaskDefinitionMongo =
  new aws.dataAwsEcsTaskDefinition.DataAwsEcsTaskDefinition(this, "mongo_2", {
    taskDefinition: awsEcsTaskDefinitionMongo.family,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAwsEcsTaskDefinitionMongo.overrideLogicalId("mongo");
const awsEcsServiceMongo = new aws.ecsService.EcsService(this, "mongo_3", {
  cluster: awsEcsClusterFoo.id,
  desiredCount: 2,
  name: "mongo",
  taskDefinition: dataAwsEcsTaskDefinitionMongo.arn,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsEcsServiceMongo.overrideLogicalId("mongo");

```

## Argument Reference

The following arguments are supported:

* `taskDefinition` - (Required) Family for the latest ACTIVE revision, family and revision (family:revision) for a specific revision in the family, the ARN of the task definition to access to.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - ARN of the task definition.
* `arn` - ARN of the task definition.
* `arnWithoutRevision` - ARN of the Task Definition with the trailing `revision` removed. This may be useful for situations where the latest task definition is always desired. If a revision isn't specified, the latest ACTIVE revision is used. See the [AWS documentation](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_StartTask.html#ECS-StartTask-request-taskDefinition) for details.
* `family` - Family of this task definition.
* `networkMode` - Docker networking mode to use for the containers in this task.
* `revision` - Revision of this task definition.
* `status` - Status of this task definition.
* `taskRoleArn` - ARN of the IAM role that containers in this task can assume.
