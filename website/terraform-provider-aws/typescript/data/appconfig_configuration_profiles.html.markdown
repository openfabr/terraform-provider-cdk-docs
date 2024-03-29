---
subcategory: "AppConfig"
layout: "aws"
page_title: "AWS: aws_appconfig_configuration_profiles"
description: |-
    Terraform data source for managing an AWS AppConfig Configuration Profiles.
---

# Data Source: awsAppconfigConfigurationProfiles

Provides access to all Configuration Properties for an AppConfig Application. This will allow you to pass Configuration
Profile IDs to another resource.

## Example Usage

### Basic Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsAppconfigConfigurationProfilesExample =
  new aws.dataAwsAppconfigConfigurationProfiles.DataAwsAppconfigConfigurationProfiles(
    this,
    "example",
    {
      applicationId: "a1d3rpe",
    }
  );
const dataAwsAppconfigConfigurationProfileExample =
  new aws.dataAwsAppconfigConfigurationProfile.DataAwsAppconfigConfigurationProfile(
    this,
    "example_1",
    {
      applicationId: "${aws_appconfig_application.example.id}",
      configurationProfileId: "${each.value}",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAwsAppconfigConfigurationProfileExample.overrideLogicalId("example");
/*In most cases loops should be handled in the programming language context and 
not inside of the Terraform context. If you are looping over something external, e.g. a variable or a file input
you should consider using a for loop. If you are looping over something only known to Terraform, e.g. a result of a data source
you need to keep this like it is.*/
dataAwsAppconfigConfigurationProfileExample.addOverride(
  "for_each",
  dataAwsAppconfigConfigurationProfilesExample.configurationProfileIds
);

```

## Argument Reference

The following arguments are required:

* `applicationId` - (Required) ID of the AppConfig Application.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `configurationProfileIds` - Set of Configuration Profile IDs associated with the AppConfig Application.
