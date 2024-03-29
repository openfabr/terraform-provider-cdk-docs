---
subcategory: "Redshift Serverless"
layout: "aws"
page_title: "AWS: aws_redshiftserverless_namespace"
description: |-
  Provides a Redshift Serverless Namespace resource.
---

# Resource: awsRedshiftserverlessNamespace

Creates a new Amazon Redshift Serverless Namespace.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.redshiftserverlessNamespace.RedshiftserverlessNamespace(
  this,
  "example",
  {
    namespaceName: "concurrency-scaling",
  }
);

```

## Argument Reference

The following arguments are supported:

* `adminUserPassword` - (Optional) The password of the administrator for the first database created in the namespace.
* `adminUsername` - (Optional) The username of the administrator for the first database created in the namespace.
* `dbName` - (Optional) The name of the first database created in the namespace.
* `defaultIamRoleArn` - (Optional) The Amazon Resource Name (ARN) of the IAM role to set as a default in the namespace. When specifying `defaultIamRoleArn`, it also must be part of `iamRoles`.
* `iamRoles` - (Optional) A list of IAM roles to associate with the namespace.
* `kmsKeyId` - (Optional) The ARN of the Amazon Web Services Key Management Service key used to encrypt your data.
* `logExports` - (Optional) The types of logs the namespace can export. Available export types are `userlog`, `connectionlog`, and `useractivitylog`.
* `namespaceName` - (Required) The name of the namespace.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the Redshift Serverless Namespace.
* `id` - The Redshift Namespace Name.
* `namespaceId` - The Redshift Namespace ID.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Redshift Serverless Namespaces can be imported using the `namespaceName`, e.g.,

```console
$ terraform import aws_redshiftserverless_namespace.example example
```
