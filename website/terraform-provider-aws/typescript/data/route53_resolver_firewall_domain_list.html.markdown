---
subcategory: "Route 53 Resolver"
layout: "aws"
page_title: "AWS: aws_route53_resolver_firewall_domain_list"
description: |-
    Retrieves the specified firewall domain list.
---

# Data Source: awsRoute53ResolverFirewallDomainList

`awsRoute53ResolverFirewallDomainList` Retrieves the specified firewall domain list.

This data source allows to retrieve details about a specific a Route 53 Resolver DNS Firewall domain list.

## Example Usage

The following example shows how to get a firewall domain list from its ID.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsRoute53ResolverFirewallDomainList.DataAwsRoute53ResolverFirewallDomainList(
  this,
  "example",
  {
    firewallDomainListId: "rslvr-fdl-example",
  }
);

```

## Argument Reference

* `firewallDomainListId` - (Required) The ID of the domain list.

The following attribute is additionally exported:

* `arn` - The Amazon Resource Name (ARN) of the firewall domain list.
* `creationTime` - The date and time that the domain list was created, in Unix time format and Coordinated Universal Time (UTC).
* `creatorRequestId` - A unique string defined by you to identify the request.
* `domainCount` - The number of domain names that are specified in the domain list.
* `name` - The name of the domain list.
* `managedOwnerName` - The owner of the list, used only for lists that are not managed by you.
* `modificationTime` - The date and time that the domain list was last modified, in Unix time format and Coordinated Universal Time (UTC).
* `status` - The status of the domain list.
* `statusMessage` - Additional information about the status of the list, if available.
