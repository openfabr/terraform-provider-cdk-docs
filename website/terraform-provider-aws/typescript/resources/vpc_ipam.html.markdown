---
subcategory: "VPC IPAM (IP Address Manager)"
layout: "aws"
page_title: "AWS: aws_vpc_ipam"
description: |-
  Provides an IPAM resource.
---

# Resource: awsVpcIpam

Provides an IPAM resource.

## Example Usage

Basic usage:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsRegionCurrent = new aws.dataAwsRegion.DataAwsRegion(
  this,
  "current",
  {}
);
new aws.vpcIpam.VpcIpam(this, "main", {
  description: "My IPAM",
  operatingRegions: [
    {
      regionName: dataAwsRegionCurrent.name,
    },
  ],
  tags: {
    Test: "Main",
  },
});

```

Shared with multiple operating\_regions:

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
/*Terraform Variables are not always the best fit for getting inputs in the context of Terraform CDK.
You can read more about this at https://cdk.tf/variables*/
const ipamRegions = new cdktf.TerraformVariable(this, "ipam_regions", {
  default: ["us-east-1", "us-west-2"],
});
const dataAwsRegionCurrent = new aws.dataAwsRegion.DataAwsRegion(
  this,
  "current",
  {}
);
const allIpamRegions = `\${distinct(concat([${dataAwsRegionCurrent.name}], ${ipamRegions.value}))}`;
const awsVpcIpamMain = new aws.vpcIpam.VpcIpam(this, "main", {
  description: "multi region ipam",
  operating_regions: [],
});
/*In most cases loops should be handled in the programming language context and 
not inside of the Terraform context. If you are looping over something external, e.g. a variable or a file input
you should consider using a for loop. If you are looping over something only known to Terraform, e.g. a result of a data source
you need to keep this like it is.*/
awsVpcIpamMain.addOverride("operating_regions", {
  for_each: allIpamRegions,
  content: [
    {
      region_name: "${operating_regions.value}",
    },
  ],
});

```

## Argument Reference

The following arguments are supported:

* `description` - (Optional) A description for the IPAM.
* `operatingRegions` - (Required) Determines which locales can be chosen when you create pools. Locale is the Region where you want to make an IPAM pool available for allocations. You can only create pools with locales that match the operating Regions of the IPAM. You can only create VPCs from a pool whose locale matches the VPC's Region. You specify a region using the [region\_name](#operating_regions) parameter. You **must** set your provider block region as an operating\_region.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `cascade` - (Optional) Enables you to quickly delete an IPAM, private scopes, pools in private scopes, and any allocations in the pools in private scopes.

### operatingRegions

* `regionName` - (Required) The name of the Region you want to add to the IPAM.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of IPAM
* `id` - The ID of the IPAM
* `defaultResourceDiscoveryId` - The IPAM's default resource discovery ID.
* `defaultResourceDiscoveryAssociationId` - The IPAM's default resource discovery association ID.
* `privateDefaultScopeId` - The ID of the IPAM's private scope. A scope is a top-level container in IPAM. Each scope represents an IP-independent network. Scopes enable you to represent networks where you have overlapping IP space. When you create an IPAM, IPAM automatically creates two scopes: public and private. The private scope is intended for private IP space. The public scope is intended for all internet-routable IP space.
* `publicDefaultScopeId` - The ID of the IPAM's public scope. A scope is a top-level container in IPAM. Each scope represents an IP-independent network. Scopes enable you to represent networks where you have overlapping IP space. When you create an IPAM, IPAM automatically creates two scopes: public and private. The private scope is intended for private
  IP space. The public scope is intended for all internet-routable IP space.
* `scopeCount` - The number of scopes in the IPAM.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

IPAMs can be imported using the `ipamId`, e.g.

```console
$ terraform import aws_vpc_ipam.example ipam-0178368ad2146a492
```
