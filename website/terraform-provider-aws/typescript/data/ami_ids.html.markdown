---
subcategory: "EC2 (Elastic Compute Cloud)"
layout: "aws"
page_title: "AWS: aws_ami_ids"
description: |-
  Provides a list of AMI IDs.
---

# Data Source: awsAmiIds

Use this data source to get a list of AMI IDs matching the specified criteria.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsAmiIds.DataAwsAmiIds(this, "ubuntu", {
  filter: [
    {
      name: "name",
      values: ["ubuntu/images/ubuntu-*-*-amd64-server-*"],
    },
  ],
  owners: ["099720109477"],
});

```

## Argument Reference

*   `owners` - (Required) List of AMI owners to limit search. At least 1 value must be specified. Valid values: an AWS account ID, `self` (the current account), or an AWS owner alias (e.g., `amazon`, `awsMarketplace`, `microsoft`).

*   `executableUsers` - (Optional) Limit search to users with *explicit* launch
    permission on  the image. Valid items are the numeric account ID or `self`.

*   `filter` - (Optional) One or more name/value pairs to filter off of. There
    are several valid keys, for a full reference, check out
    [describe-images in the AWS CLI reference][1].

*   `nameRegex` - (Optional) Regex string to apply to the AMI list returned
    by AWS. This allows more advanced filtering not supported from the AWS API.
    This filtering is done locally on what AWS returns, and could have a performance
    impact if the result is large. Combine this with other
    options to narrow down the list AWS returns.

*   `sortAscending`  - (Defaults to `false`) Used to sort AMIs by creation time.

## Attributes Reference

`ids` is set to the list of AMI IDs, sorted by creation time according to `sortAscending`.

[1]: http://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `read` - (Default `20M`)
