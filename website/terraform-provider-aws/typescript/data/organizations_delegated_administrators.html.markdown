---
subcategory: "Organizations"
layout: "aws"
page_title: "AWS: aws_organizations_delegated_administrators"
description: |-
  Get a list of AWS accounts that are designated as delegated administrators in this organization 
---

# Data Source: awsOrganizationsDelegatedAdministrators

Get a list of AWS accounts that are designated as delegated administrators in this organization

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsOrganizationsDelegatedAdministrators.DataAwsOrganizationsDelegatedAdministrators(
  this,
  "example",
  {
    servicePrincipal: "SERVICE PRINCIPAL",
  }
);

```

## Argument Reference

* `servicePrincipal` - (Optional) Specifies a service principal name. If specified, then the operation lists the delegated administrators only for the specified service. If you don't specify a service principal, the operation lists all delegated administrators for all services in your organization.

## Attributes Reference

* `delegatedAdministrators` - The list of delegated administrators in your organization, which have the following attributes:
  * `arn` - The ARN of the delegated administrator's account.
  * `delegationEnabledDate` - The date when the account was made a delegated administrator.
  * `email` - The email address that is associated with the delegated administrator's AWS account.
  * `id` - The unique identifier (ID) of the delegated administrator's account.
  * `joinedMethod` - The method by which the delegated administrator's account joined the organization.
  * `joinedTimestamp` - The date when the delegated administrator's account became a part of the organization.
  * `name` - The friendly name of the delegated administrator's account.
  * `status` - The status of the delegated administrator's account in the organization.
