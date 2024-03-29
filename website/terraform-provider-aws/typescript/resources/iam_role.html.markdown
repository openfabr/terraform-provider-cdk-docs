---
subcategory: "IAM (Identity & Access Management)"
layout: "aws"
page_title: "AWS: aws_iam_role"
description: |-
  Provides an IAM role.
---

# Resource: awsIamRole

Provides an IAM role.

\~> **NOTE:** If policies are attached to the role via the [`awsIamPolicyAttachment` resource](/docs/providers/aws/r/iam_policy_attachment.html) and you are modifying the role `name` or `path`, the `forceDetachPolicies` argument must be set to `true` and applied before attempting the operation otherwise you will encounter a `deleteConflict` error. The [`awsIamRolePolicyAttachment` resource (recommended)](/docs/providers/aws/r/iam_role_policy_attachment.html) does not have this requirement.

\~> **NOTE:** If you use this resource's `managedPolicyArns` argument or `inlinePolicy` configuration blocks, this resource will take over exclusive management of the role's respective policy types (e.g., both policy types if both arguments are used). These arguments are incompatible with other ways of managing a role's policies, such as [`awsIamPolicyAttachment`](/docs/providers/aws/r/iam_policy_attachment.html), [`awsIamRolePolicyAttachment`](/docs/providers/aws/r/iam_role_policy_attachment.html), and [`awsIamRolePolicy`](/docs/providers/aws/r/iam_role_policy.html). If you attempt to manage a role's policies by multiple means, you will get resource cycling and/or errors.

## Example Usage

### Basic Example

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.iamRole.IamRole(this, "test_role", {
  assumeRolePolicy:
    '${jsonencode({\n    Version = "2012-10-17"\n    Statement = [\n      {\n        Action = "sts:AssumeRole"\n        Effect = "Allow"\n        Sid    = ""\n        Principal = {\n          Service = "ec2.amazonaws.com"\n        }\n      },\n    ]\n  })}',
  name: "test_role",
  tags: {
    "tag-key": "tag-value",
  },
});

```

### Example of Using Data Source for Assume Role Policy

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsIamPolicyDocumentInstanceAssumeRolePolicy =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "instance_assume_role_policy",
    {
      statement: [
        {
          actions: ["sts:AssumeRole"],
          principals: [
            {
              identifiers: ["ec2.amazonaws.com"],
              type: "Service",
            },
          ],
        },
      ],
    }
  );
new aws.iamRole.IamRole(this, "instance", {
  assumeRolePolicy: dataAwsIamPolicyDocumentInstanceAssumeRolePolicy.json,
  name: "instance_role",
  path: "/system/",
});

```

### Example of Exclusive Inline Policies

This example creates an IAM role with two inline IAM policies. If someone adds another inline policy out-of-band, on the next apply, Terraform will remove that policy. If someone deletes these policies out-of-band, Terraform will recreate them.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsIamPolicyDocumentInlinePolicy =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "inline_policy",
    {
      statement: [
        {
          actions: ["ec2:DescribeAccountAttributes"],
          resources: ["*"],
        },
      ],
    }
  );
new aws.iamRole.IamRole(this, "example", {
  assumeRolePolicy:
    "${data.aws_iam_policy_document.instance_assume_role_policy.json}",
  inlinePolicy: [
    {
      name: "my_inline_policy",
      policy:
        '${jsonencode({\n      Version = "2012-10-17"\n      Statement = [\n        {\n          Action   = ["ec2:Describe*"]\n          Effect   = "Allow"\n          Resource = "*"\n        },\n      ]\n    })}',
    },
    {
      name: "policy-8675309",
      policy: dataAwsIamPolicyDocumentInlinePolicy.json,
    },
  ],
  name: "yak_role",
});

```

### Example of Removing Inline Policies

This example creates an IAM role with what appears to be empty IAM `inlinePolicy` argument instead of using `inlinePolicy` as a configuration block. The result is that if someone were to add an inline policy out-of-band, on the next apply, Terraform will remove that policy.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.iamRole.IamRole(this, "example", {
  assumeRolePolicy:
    "${data.aws_iam_policy_document.instance_assume_role_policy.json}",
  inlinePolicy: [{}],
  name: "yak_role",
});

```

### Example of Exclusive Managed Policies

This example creates an IAM role and attaches two managed IAM policies. If someone attaches another managed policy out-of-band, on the next apply, Terraform will detach that policy. If someone detaches these policies out-of-band, Terraform will attach them again.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsIamPolicyPolicyOne = new aws.iamPolicy.IamPolicy(this, "policy_one", {
  name: "policy-618033",
  policy:
    '${jsonencode({\n    Version = "2012-10-17"\n    Statement = [\n      {\n        Action   = ["ec2:Describe*"]\n        Effect   = "Allow"\n        Resource = "*"\n      },\n    ]\n  })}',
});
const awsIamPolicyPolicyTwo = new aws.iamPolicy.IamPolicy(this, "policy_two", {
  name: "policy-381966",
  policy:
    '${jsonencode({\n    Version = "2012-10-17"\n    Statement = [\n      {\n        Action   = ["s3:ListAllMyBuckets", "s3:ListBucket", "s3:HeadBucket"]\n        Effect   = "Allow"\n        Resource = "*"\n      },\n    ]\n  })}',
});
new aws.iamRole.IamRole(this, "example", {
  assumeRolePolicy:
    "${data.aws_iam_policy_document.instance_assume_role_policy.json}",
  managedPolicyArns: [awsIamPolicyPolicyOne.arn, awsIamPolicyPolicyTwo.arn],
  name: "yak_role",
});

```

### Example of Removing Managed Policies

This example creates an IAM role with an empty `managedPolicyArns` argument. If someone attaches a policy out-of-band, on the next apply, Terraform will detach that policy.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.iamRole.IamRole(this, "example", {
  assumeRolePolicy:
    "${data.aws_iam_policy_document.instance_assume_role_policy.json}",
  managedPolicyArns: [],
  name: "yak_role",
});

```

## Argument Reference

The following argument is required:

* `assumeRolePolicy` - (Required) Policy that grants an entity permission to assume the role.

\~> **NOTE:** The `assumeRolePolicy` is very similar to but slightly different than a standard IAM policy and cannot use an `awsIamPolicy` resource.  However, it *can* use an `awsIamPolicyDocument` [data source](/docs/providers/aws/d/iam_policy_document.html). See the example above of how this works.

The following arguments are optional:

* `description` - (Optional) Description of the role.
* `forceDetachPolicies` - (Optional) Whether to force detaching any policies the role has before destroying it. Defaults to `false`.
* `inlinePolicy` - (Optional) Configuration block defining an exclusive set of IAM inline policies associated with the IAM role. See below. If no blocks are configured, Terraform will not manage any inline policies in this resource. Configuring one empty block (i.e., `inlinePolicy {}`) will cause Terraform to remove *all* inline policies added out of band on `apply`.
* `managedPolicyArns` - (Optional) Set of exclusive IAM managed policy ARNs to attach to the IAM role. If this attribute is not configured, Terraform will ignore policy attachments to this resource. When configured, Terraform will align the role's managed policy attachments with this set by attaching or detaching managed policies. Configuring an empty set (i.e., `managedPolicyArns = []`) will cause Terraform to remove *all* managed policy attachments.
* `maxSessionDuration` - (Optional) Maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours.
* `name` - (Optional, Forces new resource) Friendly name of the role. If omitted, Terraform will assign a random, unique name. See [IAM Identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) for more information.
* `namePrefix` - (Optional, Forces new resource) Creates a unique friendly name beginning with the specified prefix. Conflicts with `name`.
* `path` - (Optional) Path to the role. See [IAM Identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) for more information.
* `permissionsBoundary` - (Optional) ARN of the policy that is used to set the permissions boundary for the role.
* `tags` - Key-value mapping of tags for the IAM role. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### inlinePolicy

This configuration block supports the following:

\~> **NOTE:** Since one empty block (i.e., `inlinePolicy {}`) is valid syntactically to remove out of band policies on `apply`, `name` and `policy` are technically *optional*. However, they are both *required* in order to manage actual inline policies. Not including one or the other may not result in Terraform errors but will result in unpredictable and incorrect behavior.

* `name` - (Required) Name of the role policy.
* `policy` - (Required) Policy document as a JSON formatted string. For more information about building IAM policy documents with Terraform, see the [AWS IAM Policy Document Guide](https://learn.hashicorp.com/tutorials/terraform/aws-iam-policy).

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) specifying the role.
* `createDate` - Creation date of the IAM role.
* `id` - Name of the role.
* `name` - Name of the role.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).
* `uniqueId` - Stable and unique string identifying the role.

## Import

IAM Roles can be imported using the `name`, e.g.,

```console
$ terraform import aws_iam_role.developer developer_name
```
