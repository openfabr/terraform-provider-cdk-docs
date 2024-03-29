---
subcategory: "Macie"
layout: "aws"
page_title: "AWS: aws_macie2_organization_admin_account"
description: |-
  Provides a resource to manage an Amazon Macie Organization Admin Account.
---

# Resource: awsMacie2OrganizationAdminAccount

Provides a resource to manage an [Amazon Macie Organization Admin Account](https://docs.aws.amazon.com/macie/latest/APIReference/admin.html).

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsMacie2AccountExample = new aws.macie2Account.Macie2Account(
  this,
  "example",
  {}
);
const awsMacie2OrganizationAdminAccountExample =
  new aws.macie2OrganizationAdminAccount.Macie2OrganizationAdminAccount(
    this,
    "example_1",
    {
      adminAccountId: "ID OF THE ADMIN ACCOUNT",
      depends_on: [`\${${awsMacie2AccountExample.fqn}}`],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsMacie2OrganizationAdminAccountExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `adminAccountId` - (Required) The AWS account ID for the account to designate as the delegated Amazon Macie administrator account for the organization.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The unique identifier (ID) of the macie organization admin account.

## Import

`awsMacie2OrganizationAdminAccount` can be imported using the id, e.g.,

```console
$ terraform import aws_macie2_organization_admin_account.example abcd1
```
