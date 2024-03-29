---
subcategory: "VPC IPAM (IP Address Manager)"
layout: "aws"
page_title: "AWS: aws_vpc_ipam_pools"
description: |-
    Returns details about IPAM pools that match the search parameters provided.
---

# Data Source: awsVpcIpamPools

`awsVpcIpamPools` provides details about IPAM pools.

This resource can prove useful when IPAM pools are created in another root
module and you need the pool ids as input variables. For example, pools
can be shared via RAM and used to create vpcs with CIDRs from that pool.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsVpcIpamPools.DataAwsVpcIpamPools(this, "test", {
  filter: [
    {
      name: "description",
      values: ["*test*"],
    },
    {
      name: "address-family",
      values: ["ipv4"],
    },
  ],
});

```

## Argument Reference

The arguments of this data source act as filters for querying the available
IPAM Pools in the current region.

* `filter` - (Required) Custom filter block as described below.

### filter

* `name` - (Required) The name of the filter. Filter names are case-sensitive.
* `values` - (Required) The filter values. Filter values are case-sensitive.

## Attributes Reference

In addition to all of the arguments above, the following attributes are exported:

* `ipamPools` - List of IPAM pools and their attributes. See below for details

### ipamPools

The following attributes are available on each pool entry found.

* `addressFamily` - IP protocol assigned to this pool.
* `allocationDefaultNetmaskLength` - A default netmask length for allocations added to this pool. If, for example, the CIDR assigned to this pool is `10000/8` and you enter 16 here, new allocations will default to `10000/16`.
* `allocationMaxNetmaskLength` - The maximum netmask length that will be required for CIDR allocations in this pool.
* `allocationMinNetmaskLength` - The minimum netmask length that will be required for CIDR allocations in this pool.
* `allocationResourceTags` - Tags that are required to create resources in using this pool.
* `arn` - ARN of the pool
* `autoImport` - If enabled, IPAM will continuously look for resources within the CIDR range of this pool and automatically import them as allocations into your IPAM.
* `awsService` - Limits which service in AWS that the pool can be used in. `ec2` for example, allows users to use space for Elastic IP addresses and VPCs.
* `description` - Description for the IPAM pool.
* `id` - ID of the IPAM pool.
* `ipamScopeId` - ID of the scope the pool belongs to.
* `locale` - Locale is the Region where your pool is available for allocations. You can only create pools with locales that match the operating Regions of the IPAM. You can only create VPCs from a pool whose locale matches the VPC's Region.
* `publiclyAdvertisable` - Defines whether or not IPv6 pool space is publicly advertisable over the internet.
* `sourceIpamPoolId` - ID of the source IPAM pool.
* `tags` - Map of tags to assigned to the resource.
