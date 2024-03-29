---
subcategory: "ECR (Elastic Container Registry)"
layout: "aws"
page_title: "AWS: aws_ecr_pull_through_cache_rule"
description: |-
  Provides an Elastic Container Registry Pull Through Cache Rule.
---

# Resource: awsEcrPullThroughCacheRule

Provides an Elastic Container Registry Pull Through Cache Rule.

More information about pull through cache rules, including the set of supported
upstream repositories, see [Using pull through cache rules](https://docs.aws.amazon.com/AmazonECR/latest/userguide/pull-through-cache.html).

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.ecrPullThroughCacheRule.EcrPullThroughCacheRule(this, "example", {
  ecrRepositoryPrefix: "ecr-public",
  upstreamRegistryUrl: "public.ecr.aws",
});

```

## Argument Reference

The following arguments are supported:

* `ecrRepositoryPrefix` - (Required, Forces new resource) The repository name prefix to use when caching images from the source registry.
* `upstreamRegistryUrl` - (Required, Forces new resource) The registry URL of the upstream public registry to use as the source.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `registryId` - The registry ID where the repository was created.

## Import

Use the `ecrRepositoryPrefix` to import a Pull Through Cache Rule. For example:

```console
$ terraform import aws_ecr_pull_through_cache_rule.example ecr-public
```
