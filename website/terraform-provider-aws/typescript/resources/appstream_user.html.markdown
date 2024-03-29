---
subcategory: "AppStream 2.0"
layout: "aws"
page_title: "AWS: aws_appstream_user"
description: |-
  Provides an AppStream user
---

# Resource: awsAppstreamUser

Provides an AppStream user.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.appstreamUser.AppstreamUser(this, "example", {
  authenticationType: "USERPOOL",
  firstName: "FIRST NAME",
  lastName: "LAST NAME",
  userName: "EMAIL",
});

```

## Argument Reference

The following arguments are required:

* `authenticationType` - (Required) Authentication type for the user. You must specify USERPOOL. Valid values: `api`, `saml`, `userpool`
* `userName` - (Required) Email address of the user.

The following arguments are optional:

* `enabled` - (Optional) Whether the user in the user pool is enabled.
* `firstName` - (Optional) First name, or given name, of the user.
* `lastName` - (Optional) Last name, or surname, of the user.
* `sendEmailNotification` - (Optional) Send an email notification.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the appstream user.
* `createdTime` - Date and time, in UTC and extended RFC 3339 format, when the user was created.
* `id` - Unique ID of the appstream user.
* `status` - Status of the user in the user pool.

## Import

`awsAppstreamUser` can be imported using the `userName` and `authenticationType` separated by a slash (`/`), e.g.,

```console
$ terraform import aws_appstream_user.example UserName/AuthenticationType
```
