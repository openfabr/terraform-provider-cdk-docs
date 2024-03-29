---
subcategory: "VPC (Virtual Private Cloud)"
layout: "aws"
page_title: "AWS: aws_security_groups"
description: |-
  Get information about a set of Security Groups.
---

# Data Source: awsSecurityGroups

Use this data source to get IDs and VPC membership of Security Groups that are created outside of Terraform.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsSecurityGroups.DataAwsSecurityGroups(this, "test", {
  tags: {
    Application: "k8s",
    Environment: "dev",
  },
});

```

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsSecurityGroups.DataAwsSecurityGroups(this, "test", {
  filter: [
    {
      name: "group-name",
      values: ["*nodes*"],
    },
    {
      name: "vpc-id",
      values: ["${var.vpc_id}"],
    },
  ],
});

```

## Argument Reference

* `tags` - (Optional) Map of tags, each pair of which must exactly match for desired security groups.
* `filter` - (Optional) One or more name/value pairs to use as filters. There are several valid keys, for a full reference, check out [describe-security-groups in the AWS CLI reference][1].

## Attributes Reference

* `arns` - ARNs of the matched security groups.
* `id` - AWS Region.
* `ids` - IDs of the matches security groups.
* `vpcIds` - VPC IDs of the matched security groups. The data source's tag or filter *will span VPCs* unless the `vpcId` filter is also used.

[1]: https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-security-groups.html

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `read` - (Default `20M`)
