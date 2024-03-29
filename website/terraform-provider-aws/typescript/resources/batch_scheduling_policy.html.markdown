---
subcategory: "Batch"
layout: "aws"
page_title: "AWS: aws_batch_scheduling_policy"
description: |-
  Provides a Batch Scheduling Policy resource.
---

# Resource: awsBatchSchedulingPolicy

Provides a Batch Scheduling Policy resource.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.batchSchedulingPolicy.BatchSchedulingPolicy(this, "example", {
  fairSharePolicy: {
    computeReservation: 1,
    shareDecaySeconds: 3600,
    shareDistribution: [
      {
        shareIdentifier: "A1*",
        weightFactor: 0.1,
      },
      {
        shareIdentifier: "A2",
        weightFactor: 0.2,
      },
    ],
  },
  name: "example",
  tags: {
    Name: "Example Batch Scheduling Policy",
  },
});

```

## Argument Reference

The following arguments are supported:

* `fairsharePolicy` - (Optional) A fairshare policy block specifies the `computeReservation`, `shareDelaySeconds`, and `shareDistribution` of the scheduling policy. The `fairsharePolicy` block is documented below.
* `name` - (Required) Specifies the name of the scheduling policy.
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

A `fairsharePolicy` block supports the following arguments:

* `computeReservation` - (Optional) A value used to reserve some of the available maximum vCPU for fair share identifiers that have not yet been used. For more information, see [FairsharePolicy](https://docs.aws.amazon.com/batch/latest/APIReference/API_FairsharePolicy.html).
* `shareDelaySeconds` - (Optional) The time period to use to calculate a fair share percentage for each fair share identifier in use, in seconds. For more information, see [FairsharePolicy](https://docs.aws.amazon.com/batch/latest/APIReference/API_FairsharePolicy.html).
* `shareDistribution` - (Optional) One or more share distribution blocks which define the weights for the fair share identifiers for the fair share policy. For more information, see [FairsharePolicy](https://docs.aws.amazon.com/batch/latest/APIReference/API_FairsharePolicy.html). The `shareDistribution` block is documented below.

A `shareDistribution` block supports the following arguments:

* `shareIdentifier` - (Required) A fair share identifier or fair share identifier prefix. For more information, see [ShareAttributes](https://docs.aws.amazon.com/batch/latest/APIReference/API_ShareAttributes.html).
* `weightFactor` - (Optional) The weight factor for the fair share identifier. For more information, see [ShareAttributes](https://docs.aws.amazon.com/batch/latest/APIReference/API_ShareAttributes.html).

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The Amazon Resource Name of the scheduling policy.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Batch Scheduling Policy can be imported using the `arn`, e.g.,

```console
$ terraform import aws_batch_scheduling_policy.test_policy arn:aws:batch:us-east-1:123456789012:scheduling-policy/sample
```
