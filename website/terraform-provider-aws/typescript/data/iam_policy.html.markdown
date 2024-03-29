---
subcategory: "IAM (Identity & Access Management)"
layout: "aws"
page_title: "AWS: aws_iam_policy"
description: |-
  Get information on a Amazon IAM policy
---

# Data Source: awsIamPolicy

This data source can be used to fetch information about a specific
IAM policy.

## Example Usage

### By ARN

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsIamPolicy.DataAwsIamPolicy(this, "example", {
  arn: "arn:aws:iam::123456789012:policy/UsersManageOwnCredentials",
});

```

### By Name

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsIamPolicy.DataAwsIamPolicy(this, "example", {
  name: "test_policy",
});

```

## Argument Reference

* `arn` - (Optional) ARN of the IAM policy.
  Conflicts with `name` and `pathPrefix`.
* `name` - (Optional) Name of the IAM policy.
  Conflicts with `arn`.
* `pathPrefix` - (Optional) Prefix of the path to the IAM policy.
  Defaults to a slash (`/`).
  Conflicts with `arn`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the policy.
* `path` - Path to the policy.
* `description` - Description of the policy.
* `policy` - Policy document of the policy.
* `policyId` - Policy's ID.
* `tags` - Key-value mapping of tags for the IAM Policy.
