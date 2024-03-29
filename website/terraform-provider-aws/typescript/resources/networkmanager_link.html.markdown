---
subcategory: "Network Manager"
layout: "aws"
page_title: "AWS: aws_networkmanager_link"
description: |-
  Creates a link for a site.
---

# Resource: awsNetworkmanagerLink

Creates a link for a site.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.networkmanagerLink.NetworkmanagerLink(this, "example", {
  bandwidth: {
    downloadSpeed: 50,
    uploadSpeed: 10,
  },
  globalNetworkId: "${aws_networkmanager_global_network.example.id}",
  providerName: "MegaCorp",
  siteId: "${aws_networkmanager_site.example.id}",
});

```

## Argument Reference

The following arguments are supported:

* `bandwidth` - (Required) The upload speed and download speed in Mbps. Documented below.
* `description` - (Optional) A description of the link.
* `globalNetworkId` - (Required) The ID of the global network.
* `providerName` - (Optional) The provider of the link.
* `siteId` - (Required) The ID of the site.
* `tags` - (Optional) Key-value tags for the link. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `type` - (Optional) The type of the link.

The `bandwidth` object supports the following:

* `downloadSpeed` - (Optional) Download speed in Mbps.
* `uploadSpeed` - (Optional) Upload speed in Mbps.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Link Amazon Resource Name (ARN).
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsNetworkmanagerLink` can be imported using the link ARN, e.g.

```console
$ terraform import aws_networkmanager_link.example arn:aws:networkmanager::123456789012:link/global-network-0d47f6t230mz46dy4/link-444555aaabbb11223
```
