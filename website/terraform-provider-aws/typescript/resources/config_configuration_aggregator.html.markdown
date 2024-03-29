---
subcategory: "Config"
layout: "aws"
page_title: "AWS: aws_config_configuration_aggregator"
description: |-
  Manages an AWS Config Configuration Aggregator.
---

# Resource: awsConfigConfigurationAggregator

Manages an AWS Config Configuration Aggregator

## Example Usage

### Account Based Aggregation

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.configConfigurationAggregator.ConfigConfigurationAggregator(
  this,
  "account",
  {
    accountAggregationSource: {
      accountIds: ["123456789012"],
      regions: ["us-west-2"],
    },
    name: "example",
  }
);

```

### Organization Based Aggregation

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsIamPolicyDocumentAssumeRole =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "assume_role",
    {
      statement: [
        {
          actions: ["sts:AssumeRole"],
          effect: "Allow",
          principals: [
            {
              identifiers: ["config.amazonaws.com"],
              type: "Service",
            },
          ],
        },
      ],
    }
  );
const awsIamRoleOrganization = new aws.iamRole.IamRole(this, "organization", {
  assumeRolePolicy: dataAwsIamPolicyDocumentAssumeRole.json,
  name: "example",
});
const awsIamRolePolicyAttachmentOrganization =
  new aws.iamRolePolicyAttachment.IamRolePolicyAttachment(
    this,
    "organization_2",
    {
      policyArn:
        "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations",
      role: awsIamRoleOrganization.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamRolePolicyAttachmentOrganization.overrideLogicalId("organization");
const awsConfigConfigurationAggregatorOrganization =
  new aws.configConfigurationAggregator.ConfigConfigurationAggregator(
    this,
    "organization_3",
    {
      depends_on: [`\${${awsIamRolePolicyAttachmentOrganization.fqn}}`],
      name: "example",
      organizationAggregationSource: {
        allRegions: true,
        roleArn: awsIamRoleOrganization.arn,
      },
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsConfigConfigurationAggregatorOrganization.overrideLogicalId("organization");

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the configuration aggregator.
* `accountAggregationSource` - (Optional) The account(s) to aggregate config data from as documented below.
* `organizationAggregationSource` - (Optional) The organization to aggregate config data from as documented below.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

Either `accountAggregationSource` or `organizationAggregationSource` must be specified.

### `accountAggregationSource`

* `accountIds` - (Required) List of 12-digit account IDs of the account(s) being aggregated.
* `allRegions` - (Optional) If true, aggregate existing AWS Config regions and future regions.
* `regions` - (Optional) List of source regions being aggregated.

Either `regions` or `allRegions` (as true) must be specified.

### `organizationAggregationSource`

\~> **Note:** If your source type is an organization, you must be signed in to the master account and all features must be enabled in your organization. AWS Config calls EnableAwsServiceAccess API to enable integration between AWS Config and AWS Organizations.

* `allRegions` - (Optional) If true, aggregate existing AWS Config regions and future regions.
* `regions` - (Optional) List of source regions being aggregated.
* `roleArn` - (Required) ARN of the IAM role used to retrieve AWS Organization details associated with the aggregator account.

Either `regions` or `allRegions` (as true) must be specified.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The ARN of the aggregator
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Configuration Aggregators can be imported using the name, e.g.,

```console
$ terraform import aws_config_configuration_aggregator.example foo
```
