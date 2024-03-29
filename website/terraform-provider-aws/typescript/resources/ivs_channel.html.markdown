---
subcategory: "IVS (Interactive Video)"
layout: "aws"
page_title: "AWS: aws_ivs_channel"
description: |-
  Terraform resource for managing an AWS IVS (Interactive Video) Channel.
---

# Resource: awsIvsChannel

Terraform resource for managing an AWS IVS (Interactive Video) Channel.

## Example Usage

### Basic Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.ivsChannel.IvsChannel(this, "example", {
  name: "channel-1",
});

```

## Argument Reference

The following arguments are optional:

* `authorized` - (Optional) If `true`, channel is private (enabled for playback authorization).
* `latencyMode` - (Optional) Channel latency mode. Valid values: `normal`, `low`.
* `name` - (Optional) Channel name.
* `recordingConfigurationArn` - (Optional) Recording configuration ARN.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `type` - (Optional) Channel type, which determines the allowable resolution and bitrate. Valid values: `standard`, `basic`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the Channel.
* `ingestEndpoint` - Channel ingest endpoint, part of the definition of an ingest server, used when setting up streaming software.
* `playbackUrl` - Channel playback URL.
* `tagsAll` - Map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://www.terraform.io/docs/configuration/blocks/resources/syntax.html#operation-timeouts):

* `create` - (Default `5M`)
* `update` - (Default `5M`)
* `delete` - (Default `5M`)

## Import

IVS (Interactive Video) Channel can be imported using the ARN, e.g.,

```console
$ terraform import aws_ivs_channel.example arn:aws:ivs:us-west-2:326937407773:channel/0Y1lcs4U7jk5
```
