---
subcategory: "Serverless Application Repository"
layout: "aws"
page_title: "AWS: aws_serverlessapplicationrepository_application"
description: |-
  Get information on a AWS Serverless Application Repository application
---

# Data Source: awsServerlessapplicationrepositoryApplication

Use this data source to get information about an AWS Serverless Application Repository application. For example, this can be used to determine the required `capabilities` for an application.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsServerlessapplicationrepositoryApplicationExample =
  new aws.dataAwsServerlessapplicationrepositoryApplication.DataAwsServerlessapplicationrepositoryApplication(
    this,
    "example",
    {
      applicationId:
        "arn:aws:serverlessrepo:us-east-1:123456789012:applications/ExampleApplication",
    }
  );
const awsServerlessapplicationrepositoryCloudformationStackExample =
  new aws.serverlessapplicationrepositoryCloudformationStack.ServerlessapplicationrepositoryCloudformationStack(
    this,
    "example_1",
    {
      applicationId:
        dataAwsServerlessapplicationrepositoryApplicationExample.applicationId,
      capabilities:
        dataAwsServerlessapplicationrepositoryApplicationExample.requiredCapabilities,
      name: "Example",
      semanticVersion:
        dataAwsServerlessapplicationrepositoryApplicationExample.semanticVersion,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsServerlessapplicationrepositoryCloudformationStackExample.overrideLogicalId(
  "example"
);

```

## Argument Reference

* `applicationId` - (Required) ARN of the application.
* `semanticVersion` - (Optional) Requested version of the application. By default, retrieves the latest version.

## Attributes Reference

* `applicationId` - ARN of the application.
* `name` - Name of the application.
* `requiredCapabilities` - A list of capabilities describing the permissions needed to deploy the application.
* `sourceCodeUrl` - URL pointing to the source code of the application version.
* `templateUrl` - URL pointing to the Cloud Formation template for the application version.
