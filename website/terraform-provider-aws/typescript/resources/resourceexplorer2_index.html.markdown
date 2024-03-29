---
subcategory: "Resource Explorer"
layout: "aws"
page_title: "AWS: aws_resourceexplorer2_index"
description: |-
  Provides a resource to manage a Resource Explorer index in the current AWS Region.
---

# Resource: awsResourceexplorer2Index

Provides a resource to manage a Resource Explorer index in the current AWS Region.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.resourceexplorer2Index.Resourceexplorer2Index(this, "example", {
  type: "LOCAL",
});

```

## Argument Reference

The following arguments are supported:

* `type` - (Required) The type of the index. Valid values: `aggregator`, `local`. To understand the difference between `local` and `aggregator`, see the [*AWS Resource Explorer User Guide*](https://docs.aws.amazon.com/resource-explorer/latest/userguide/manage-aggregator-region.html).
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `2H`)
* `update` - (Default `2H`)
* `delete` - (Default `10M`)

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the Resource Explorer index.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Resource Explorer indexes can be imported using the `arn`, e.g.

```console
$ terraform import aws_resourceexplorer2_index.example arn:aws:resource-explorer-2:us-east-1:123456789012:index/6047ac4e-207e-4487-9bcf-cb53bb0ff5cc
```
