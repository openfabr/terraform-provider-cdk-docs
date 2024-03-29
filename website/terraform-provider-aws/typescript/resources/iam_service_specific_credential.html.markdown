---
subcategory: "IAM (Identity & Access Management)"
layout: "aws"
page_title: "AWS: aws_iam_service_specific_credential"
description: |-
  Provides an IAM Service Specific Credential.
---

# Resource: awsIamServiceSpecificCredential

Provides an IAM Service Specific Credential.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsIamUserExample = new aws.iamUser.IamUser(this, "example", {
  name: "example",
});
const awsIamServiceSpecificCredentialExample =
  new aws.iamServiceSpecificCredential.IamServiceSpecificCredential(
    this,
    "example_1",
    {
      serviceName: "codecommit.amazonaws.com",
      userName: awsIamUserExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamServiceSpecificCredentialExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `serviceName` - (Required) The name of the AWS service that is to be associated with the credentials. The service you specify here is the only service that can be accessed using these credentials.
* `userName` - (Required) The name of the IAM user that is to be associated with the credentials. The new service-specific credentials have the same permissions as the associated user except that they can be used only to access the specified service.
* `status` - (Optional) The status to be assigned to the service-specific credential. Valid values are `active` and `inactive`. Default value is `active`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The combination of `serviceName` and `userName` as such: `serviceName:userName:serviceSpecificCredentialId`.
* `servicePassword` - The generated password for the service-specific credential.
* `serviceUserName` - The generated user name for the service-specific credential. This value is generated by combining the IAM user's name combined with the ID number of the AWS account, as in `janeAt123456789012`, for example.
* `serviceSpecificCredentialId` - The unique identifier for the service-specific credential.

## Import

IAM Service Specific Credentials can be imported using the `serviceName:userName:serviceSpecificCredentialId`, e.g.

```console
$ terraform import aws_iam_service_specific_credential.default `codecommit.amazonaws.com:example:some-id`
```
