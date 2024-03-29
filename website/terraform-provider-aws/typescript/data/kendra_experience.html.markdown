---
subcategory: "Kendra"
layout: "aws"
page_title: "AWS: aws_kendra_experience"
description: |-
  Provides details about a specific Amazon Kendra Experience.
---

# Data Source: awsKendraExperience

Provides details about a specific Amazon Kendra Experience.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsKendraExperience.DataAwsKendraExperience(this, "example", {
  experienceId: "87654321-1234-4321-4321-321987654321",
  indexId: "12345678-1234-1234-1234-123456789123",
});

```

## Argument Reference

The following arguments are supported:

* `experienceId` - (Required) Identifier of the Experience.
* `indexId` - (Required) Identifier of the index that contains the Experience.

## Attributes Reference

In addition to all of the arguments above, the following attributes are exported:

* `arn` - ARN of the Experience.
* `configuration` - Block that specifies the configuration information for your Amazon Kendra Experience. This includes `contentSourceConfiguration`, which specifies the data source IDs and/or FAQ IDs, and `userIdentityConfiguration`, which specifies the user or group information to grant access to your Amazon Kendra Experience. Documented below.
* `createdAt` - Unix datetime that the Experience was created.
* `description` - Description of the Experience.
* `endpoints` - Shows the endpoint URLs for your Amazon Kendra Experiences. The URLs are unique and fully hosted by AWS. Documented below.
* `errorMessage` - Reason your Amazon Kendra Experience could not properly process.
* `id` - Unique identifiers of the Experience and index separated by a slash (`/`).
* `name` - Name of the Experience.
* `roleArn` - Shows the ARN of a role with permission to access `query` API, `querySuggestions` API, `submitFeedback` API, and AWS SSO that stores your user and group information.
* `status` - Current processing status of your Amazon Kendra Experience. When the status is `active`, your Amazon Kendra Experience is ready to use. When the status is `failed`, the `errorMessage` field contains the reason that this failed.
* `updatedAt` - Date and time that the Experience was last updated.

The `configuration` block supports the following attributes:

* `contentSourceConfiguration` - The identifiers of your data sources and FAQs. This is the content you want to use for your Amazon Kendra Experience. Documented below.
* `userIdentityConfiguration` - The AWS SSO field name that contains the identifiers of your users, such as their emails. Documented below.

The `contentSourceConfiguration` block supports the following attributes:

* `dataSourceIds` - Identifiers of the data sources you want to use for your Amazon Kendra Experience.
* `directPutContent` - Whether to use documents you indexed directly using the `batchPutDocumentApi`.
* `faqIds` - Identifier of the FAQs that you want to use for your Amazon Kendra Experience.

The `userIdentityConfiguration` block supports the following attributes:

* `identityAttributeName` - The AWS SSO field name that contains the identifiers of your users, such as their emails.

The `endpoints` block supports the following attributes:

* `endpoint` - Endpoint of your Amazon Kendra Experience.
* `endpointType` - Type of endpoint for your Amazon Kendra Experience.
