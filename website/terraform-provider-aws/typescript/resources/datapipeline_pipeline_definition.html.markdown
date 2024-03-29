---
subcategory: "Data Pipeline"
layout: "aws"
page_title: "AWS: aws_datapipeline_pipeline_definition"
description: |-
  Provides a DataPipeline Definition.
---

# Resource: awsDatapipelinePipelineDefinition

Provides a DataPipeline Pipeline Definition resource.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsDatapipelinePipelineDefault =
  new aws.datapipelinePipeline.DatapipelinePipeline(this, "default", {
    name: "tf-pipeline-default",
  });
new aws.datapipelinePipelineDefinition.DatapipelinePipelineDefinition(
  this,
  "example",
  {
    pipelineId: awsDatapipelinePipelineDefault.id,
    pipelineObject: [
      {
        field: [
          {
            key: "workerGroup",
            stringValue: "workerGroup",
          },
        ],
        id: "Default",
        name: "Default",
      },
      {
        field: [
          {
            key: "startDateTime",
            stringValue: "2012-12-12T00:00:00",
          },
          {
            key: "type",
            stringValue: "Schedule",
          },
          {
            key: "period",
            stringValue: "1 hour",
          },
          {
            key: "endDateTime",
            stringValue: "2012-12-21T18:00:00",
          },
        ],
        id: "Schedule",
        name: "Schedule",
      },
      {
        field: [
          {
            key: "type",
            stringValue: "ShellCommandActivity",
          },
          {
            key: "command",
            stringValue: "echo hello",
          },
          {
            key: "parent",
            stringValue: "Default",
          },
          {
            key: "schedule",
            stringValue: "Schedule",
          },
        ],
        id: "SayHello",
        name: "SayHello",
      },
    ],
  }
);

```

## Argument Reference

The following arguments are required:

* `pipelineId` - (Required) ID of the pipeline.
* `pipelineObject` - (Required) Configuration block for the objects that define the pipeline. See below

The following arguments are optional:

* `parameterObject` - (Optional) Configuration block for the parameter objects used in the pipeline definition. See below
* `parameterValue` - (Optional) Configuration block for the parameter values used in the pipeline definition. See below

### `pipelineObject`

* `field` - (Required) Configuration block for Key-value pairs that define the properties of the object. See below
* `id` - (Required) ID of the object.
* `name` - (Required) ARN of the storage connector.

### `field`

* `key` - (Required) Field identifier.
* `refValue` - (Optional) Field value, expressed as the identifier of another object
* `stringValue` - (Optional) Field value, expressed as a String.

### `parameterObject`

* `attribute` - (Required) Configuration block for attributes of the parameter object. See below
* `id` - (Required) ID of the parameter object.

### `attribute`

* `key` - (Required) Field identifier.
* `stringValue` - (Required) Field value, expressed as a String.

### `parameterValue`

* `id` - (Required) ID of the parameter value.
* `stringValue` - (Required) Field value, expressed as a String.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Unique ID of the datapipeline definition.

## Import

`awsDatapipelinePipelineDefinition` can be imported using the id, e.g.

```console
$ terraform import aws_datapipeline_pipeline_definition.example df-1234567890
```
