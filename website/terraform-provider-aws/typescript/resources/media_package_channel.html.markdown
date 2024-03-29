---
subcategory: "Elemental MediaPackage"
layout: "aws"
page_title: "AWS: aws_media_package_channel"
description: |-
  Provides an AWS Elemental MediaPackage Channel.
---

# Resource: awsMediaPackageChannel

Provides an AWS Elemental MediaPackage Channel.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.mediaPackageChannel.MediaPackageChannel(this, "kittens", {
  channelId: "kitten-channel",
  description: "A channel dedicated to amusing videos of kittens.",
});

```

## Argument Reference

The following arguments are supported:

* `channelId` - (Required) A unique identifier describing the channel
* `description` - (Optional) A description of the channel
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The same as `channelId`
* `arn` - The ARN of the channel
* `hlsIngest` - A single item list of HLS ingest information
  * `ingestEndpoints` - A list of the ingest endpoints
    * `password` - The password
    * `url` - The URL
    * `username` - The username
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Media Package Channels can be imported via the channel ID, e.g.,

```console
$ terraform import aws_media_package_channel.kittens kittens-channel
```
