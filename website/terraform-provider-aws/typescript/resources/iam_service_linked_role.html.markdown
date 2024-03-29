---
subcategory: "IAM (Identity & Access Management)"
layout: "aws"
page_title: "AWS: aws_iam_service_linked_role"
description: |-
  Provides an IAM service-linked role.
---

# Resource: awsIamServiceLinkedRole

Provides an [IAM service-linked role](https://docs.aws.amazon.com/IAM/latest/UserGuide/using-service-linked-roles.html).

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.iamServiceLinkedRole.IamServiceLinkedRole(this, "elasticbeanstalk", {
  awsServiceName: "elasticbeanstalk.amazonaws.com",
});

```

## Argument Reference

The following arguments are supported:

* `awsServiceName` - (Required, Forces new resource) The AWS service to which this role is attached. You use a string similar to a URL but without the `http://` in front. For example: `elasticbeanstalkAmazonawsCom`. To find the full list of services that support service-linked roles, check [the docs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-services-that-work-with-iam.html).
* `customSuffix` - (Optional, forces new resource) Additional string appended to the role name. Not all AWS services support custom suffixes.
* `description` - (Optional) The description of the role.
* `tags` - Key-value mapping of tags for the IAM role. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The Amazon Resource Name (ARN) of the role.
* `arn` - The Amazon Resource Name (ARN) specifying the role.
* `createDate` - The creation date of the IAM role.
* `name` - The name of the role.
* `path` - The path of the role.
* `uniqueId` - The stable and unique string identifying the role.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

IAM service-linked roles can be imported using role ARN, e.g.,

```console
$ terraform import aws_iam_service_linked_role.elasticbeanstalk arn:aws:iam::123456789012:role/aws-service-role/elasticbeanstalk.amazonaws.com/AWSServiceRoleForElasticBeanstalk
```
