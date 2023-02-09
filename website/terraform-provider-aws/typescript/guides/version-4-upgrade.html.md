---
subcategory: ""
layout: "aws"
page_title: "Terraform AWS Provider Version 4 Upgrade Guide"
description: |-
  Terraform AWS Provider Version 4 Upgrade Guide
---

# Terraform AWS Provider Version 4 Upgrade Guide

Version 4.0.0 of the AWS provider for Terraform is a major release and includes some changes that you will need to consider when upgrading. We intend this guide to help with that process and focus only on changes from version 3.X to version 4.0.0. See the [Version 3 Upgrade Guide](/docs/providers/aws/guides/version-3-upgrade.html) for information about upgrading from 1.X to version 3.0.0.

We previously marked most of the changes we outline in this guide as deprecated in the Terraform plan/apply output throughout previous provider releases. You can find these changes, including deprecation notices, in the [Terraform AWS Provider CHANGELOG](https://github.com/hashicorp/terraform-provider-aws/blob/main/CHANGELOG.md).

\~> **NOTE:** Versions 4.0.0 through v4.8.0 of the AWS Provider introduce significant breaking changes to the `awsS3Bucket` resource. See [S3 Bucket Refactor](#s3-bucket-refactor) for more details.
We recommend upgrading to v4.9.0 or later of the AWS Provider instead, where only non-breaking changes and deprecation notices are introduced to the `awsS3Bucket`. See  [Changes to S3 Bucket Drift Detection](#changes-to-s3-bucket-drift-detection) for additional considerations when upgrading to v4.9.0 or later.

\~> **NOTE:** Version 4.0.0 of the AWS Provider introduces changes to the precedence of some authentication and configuration parameters.
These changes bring the provider in line with the AWS CLI and SDKs.
See [Changes to Authentication](#changes-to-authentication) for more details.

\~> **NOTE:** Version 4.0.0 of the AWS Provider will be the last major version to support [EC2-Classic resources](#ec2-classic-resource-and-data-source-support) as AWS plans to fully retire EC2-Classic Networking. See the [AWS News Blog](https://aws.amazon.com/blogs/aws/ec2-classic-is-retiring-heres-how-to-prepare/) for additional details.

\~> **NOTE:** Version 4.0.0 and 4.x.x versions of the AWS Provider will be the last versions compatible with Terraform 0.12-0.15.

Upgrade topics:

<!-- TOC depthFrom:2 depthTo:2 -->

* [Provider Version Configuration](#provider-version-configuration)
* [Changes to Authentication](#changes-to-authentication)
* [New Provider Arguments](#new-provider-arguments)
* [Changes to S3 Bucket Drift Detection](#changes-to-s3-bucket-drift-detection) (**Applicable to v4.9.0 and later of the AWS Provider**)
* [S3 Bucket Refactor](#s3-bucket-refactor) (**Only applicable to v4.0.0 through v4.8.0 of the AWS Provider**)
  * [`accelerationStatus` Argument](#acceleration_status-argument)
  * [`acl` Argument](#acl-argument)
  * [`corsRule` Argument](#cors_rule-argument)
  * [`grant` Argument](#grant-argument)
  * [`lifecycleRule` Argument](#lifecycle_rule-argument)
  * [`logging` Argument](#logging-argument)
  * [`objectLockConfiguration` `rule` Argument](#object_lock_configuration-rule-argument)
  * [`policy` Argument](#policy-argument)
  * [`replicationConfiguration` Argument](#replication_configuration-argument)
  * [`requestPayer` Argument](#request_payer-argument)
  * [`serverSideEncryptionConfiguration` Argument](#server_side_encryption_configuration-argument)
  * [`versioning` Argument](#versioning-argument)
  * [`website`, `websiteDomain`, and `websiteEndpoint` Arguments](#website-website_domain-and-website_endpoint-arguments)
* [Full Resource Lifecycle of Default Resources](#full-resource-lifecycle-of-default-resources)
  * [Resource: aws\_default\_subnet](#resource-aws_default_subnet)
  * [Resource: aws\_default\_vpc](#resource-aws_default_vpc)
* [Plural Data Source Behavior](#plural-data-source-behavior)
* [Empty Strings Not Valid For Certain Resources](#empty-strings-not-valid-for-certain-resources)
  * [Resource: aws\_cloudwatch\_event\_target (Empty String)](#resource-aws_cloudwatch_event_target-empty-string)
  * [Resource: aws\_customer\_gateway](#resource-aws_customer_gateway)
  * [Resource: aws\_default\_network\_acl](#resource-aws_default_network_acl)
  * [Resource: aws\_default\_route\_table](#resource-aws_default_route_table)
  * [Resource: aws\_default\_vpc (Empty String)](#resource-aws_default_vpc-empty-string)
  * [Resource: aws\_efs\_mount\_target](#resource-aws_efs_mount_target)
  * [Resource: aws\_elasticsearch\_domain](#resource-aws_elasticsearch_domain)
  * [Resource: aws\_instance](#resource-aws_instance)
  * [Resource: aws\_network\_acl](#resource-aws_network_acl)
  * [Resource: aws\_route](#resource-aws_route)
  * [Resource: aws\_route\_table](#resource-aws_route_table)
  * [Resource: aws\_vpc](#resource-aws_vpc)
  * [Resource: aws\_vpc\_ipv6\_cidr\_block\_association](#resource-aws_vpc_ipv6_cidr_block_association)
* [Data Source: aws\_cloudwatch\_log\_group](#data-source-aws_cloudwatch_log_group)
* [Data Source: aws\_subnet\_ids](#data-source-aws_subnet_ids)
* [Data Source: aws\_s3\_bucket\_object](#data-source-aws_s3_bucket_object)
* [Data Source: aws\_s3\_bucket\_objects](#data-source-aws_s3_bucket_objects)
* [Resource: aws\_batch\_compute\_environment](#resource-aws_batch_compute_environment)
* [Resource: aws\_cloudwatch\_event\_target](#resource-aws_cloudwatch_event_target)
* [Resource: aws\_elasticache\_cluster](#resource-aws_elasticache_cluster)
* [Resource: aws\_elasticache\_global\_replication\_group](#resource-aws_elasticache_global_replication_group)
* [Resource: aws\_fsx\_ontap\_storage\_virtual\_machine](#resource-aws_fsx_ontap_storage_virtual_machine)
* [Resource: aws\_lb\_target\_group](#resource-aws_lb_target_group)
* [Resource: aws\_s3\_bucket\_object](#resource-aws_s3_bucket_object)
* [Resource: aws\_spot\_instance\_request](#resource-aws_spot_instance_request)

<!-- /TOC -->

Additional Topics:

<!-- TOC depthFrom:2 depthTo:2 -->

* [EC2-Classic resource and data source support](#ec2-classic-resource-and-data-source-support)

<!-- /TOC -->

## Provider Version Configuration

\-> Before upgrading to version 4.0.0, upgrade to the most recent 3.X version of the provider and ensure that your environment successfully runs [`terraformPlan`](https://www.terraform.io/docs/commands/plan.html). You should not see changes you don't expect or deprecation notices.

Use [version constraints when configuring Terraform providers](https://www.terraform.io/docs/configuration/providers.html#provider-versions). If you are following that recommendation, update the version constraints in your Terraform configuration and run [`terraformInitUpgrade`](https://www.terraform.io/docs/commands/init.html) to download the new version.

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.provider.AwsProvider(this, "aws", {});

```

Update to the latest 4.X version:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.provider.AwsProvider(this, "aws", {});

```

## Changes to Authentication

The authentication configuration for the AWS Provider has changed in this version to match the behavior of other AWS products, including the AWS SDK and AWS CLI. *This will cause authentication failures in AWS provider configurations where you set a non-empty `profile` in the `provider` configuration but the profile does not correspond to an AWS profile with valid credentials.*

Precedence for authentication settings is as follows:

* `provider` configuration
* Environment variables
* Shared credentials and configuration files (*e.g.*, `~/Aws/credentials` and `~/Aws/config`)

In previous versions of the provider, you could explicitly set `profile` in the `provider`, and if the profile did not correspond to valid credentials, the provider would use credentials from environment variables. Starting in v4.0, the Terraform AWS provider enforces the precedence shown above, similarly to how the AWS SDK and AWS CLI behave.

In other words, when you explicitly set `profile` in `provider`, the AWS provider will not use environment variables per the precedence shown above. Before v4.0, if `profile` was configured in the `provider` configuration but did not correspond to an AWS profile or valid credentials, the provider would attempt to use environment variables. **This is no longer the case.** An explicitly set profile that does not have valid credentials will cause an authentication error.

For example, with the following, the environment variables will not be used:

```console
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
```

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.provider.AwsProvider(this, "aws", {
  profile: "customprofile",
  region: "us-west-2",
});

```

## New Provider Arguments

Version 4.x adds these new `provider` arguments:

* `assumeRoleDuration` - Assume role duration as a string, *e.g.*, `"1H"` or `"1H30S"`. Terraform AWS Provider v4.0.0 deprecates `assumeRoleDurationSeconds` and a future version will remove it.
* `customCaBundle` - File containing custom root and intermediate certificates. Can also be configured using the `awsCaBundle` environment variable. (Setting `caBundle` in the shared config file is not supported.)
* `ec2MetadataServiceEndpoint` - Address of the EC2 metadata service (IMDS) endpoint to use. Can also be set with the `awsEc2MetadataServiceEndpoint` environment variable.
* `ec2MetadataServiceEndpointMode` - Mode to use in communicating with the metadata service. Valid values are `iPv4` and `iPv6`. Can also be set with the `awsEc2MetadataServiceEndpointMode` environment variable.
* `s3UsePathStyle` - Replaces `s3ForcePathStyle`, which has been deprecated in Terraform AWS Provider v4.0.0 and support will be removed in a future version.
* `sharedConfigFiles` - List of paths to AWS shared config files. If not set, the default is `[~/Aws/config]`. A single value can also be set with the `awsConfigFile` environment variable.
* `sharedCredentialsFiles` - List of paths to the shared credentials file. If not set, the default  is `[~/Aws/credentials]`. A single value can also be set with the `awsSharedCredentialsFile` environment variable. Replaces `sharedCredentialsFile`, which has been deprecated in Terraform AWS Provider v4.0.0 and support will be removed in a future version.
* `stsRegion` - Region where AWS STS operations will take place. For example, `usEast1` and `usWest2`.
* `useDualstackEndpoint` - Force the provider to resolve endpoints with DualStack capability. Can also be set with the `awsUseDualstackEndpoint` environment variable or in a shared config file (`useDualstackEndpoint`).
* `useFipsEndpoint` - Force the provider to resolve endpoints with FIPS capability. Can also be set with the `awsUseFipsEndpoint` environment variable or in a shared config file (`useFipsEndpoint`).

\~> **NOTE:** Using the `awsMetadataUrl` environment variable has been deprecated in Terraform AWS Provider v4.0.0 and support will be removed in a future version. Change any scripts or environments using `awsMetadataUrl` to instead use `awsEc2MetadataServiceEndpoint`.

For example, in previous versions, to use FIPS endpoints, you would need to provide all the FIPS endpoints that you wanted to use in the `endpoints` configuration block:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.provider.AwsProvider(this, "aws", {
  endpoints: [
    {
      ec2: "https://ec2-fips.us-west-2.amazonaws.com",
      s3: "https://s3-fips.us-west-2.amazonaws.com",
      sts: "https://sts-fips.us-west-2.amazonaws.com",
    },
  ],
});

```

In v4.0.0, you can still set endpoints in the same way. However, you can instead use the `useFipsEndpoint` argument to have the provider automatically resolve FIPS endpoints for all supported services:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.provider.AwsProvider(this, "aws", {
  useFipsEndpoint: true,
});

```

Note that the provider can only resolve FIPS endpoints where AWS provides FIPS support. Support depends on the service and may include `usEast1`, `usEast2`, `usWest1`, `usWest2`, `usGovEast1`, `usGovWest1`, and `caCentral1`. For more information, see [Federal Information Processing Standard (FIPS) 140-2](https://aws.amazon.com/compliance/fips/).

## Changes to S3 Bucket Drift Detection

\~> **NOTE:** This only applies to v4.9.0 and later of the AWS Provider.

\~> **NOTE:** If you are migrating from v3.75.x of the AWS Provider and you have already adopted the standalone S3 bucket resources (e.g. `awsS3BucketLifecycleConfiguration`),
a [`lifecycle` configuration block to ignore changes](https://www.terraform.io/language/meta-arguments/lifecycle#ignore_changes) to the internal parameters of the source `awsS3Bucket` resources will no longer be necessary and can be removed upon upgrade.

\~> **NOTE:** In the next major version, v5.0, the parameters listed below will be removed entirely from the `awsS3Bucket` resource.
For this reason, a deprecation notice is printed in the Terraform CLI for each of the parameters when used in a configuration.

To remediate the breaking changes introduced to the `awsS3Bucket` resource in v4.0.0 of the AWS Provider,
v4.9.0 and later retain the same configuration parameters of the `awsS3Bucket` resource as in v3.x and functionality of the `awsS3Bucket` resource only differs from v3.x
in that Terraform will only perform drift detection for each of the following parameters if a configuration value is provided:

* `accelerationStatus`
* `acl`
* `corsRule`
* `grant`
* `lifecycleRule`
* `logging`
* `objectLockConfiguration`
* `policy`
* `replicationConfiguration`
* `requestPayer`
* `serverSideEncryptionConfiguration`
* `versioning`
* `website`

Thus, if one of these parameters was once configured and then is entirely removed from an `awsS3Bucket` resource configuration,
Terraform will not pick up on these changes on a subsequent `terraformPlan` or `terraformApply`.

For example, given the following configuration with a single `corsRule`:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  corsRule: [
    {
      allowedHeaders: ["*"],
      allowedMethods: ["PUT", "POST"],
      allowedOrigins: ["https://s3-website-test.hashicorp.com"],
      exposeHeaders: ["ETag"],
      maxAgeSeconds: 3000,
    },
  ],
});

```

When updated to the following configuration without a `corsRule`:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});

```

Terraform CLI with v4.9.0 of the AWS Provider will report back:

```shell
aws_s3_bucket.example: Refreshing state... [id=yournamehere]
...
No changes. Your infrastructure matches the configuration.
```

With that said, to manage changes to these parameters in the `awsS3Bucket` resource, practitioners should configure each parameter's respective standalone resource
and perform updates directly on those new configurations. The parameters are mapped to the standalone resources as follows:

| `awsS3Bucket` Parameter              | Standalone Resource                                  |
|----------------------------------------|------------------------------------------------------|
| `accelerationStatus`                  | `awsS3BucketAccelerateConfiguration`             |
| `acl`                                  | `awsS3BucketAcl`                                  |
| `corsRule`                            | `awsS3BucketCorsConfiguration`                   |
| `grant`                                | `awsS3BucketAcl`                                  |
| `lifecycleRule`                       | `awsS3BucketLifecycleConfiguration`              |
| `logging`                              | `awsS3BucketLogging`                              |
| `objectLockConfiguration`            | `awsS3BucketObjectLockConfiguration`            |
| `policy`                               | `awsS3BucketPolicy`                               |
| `replicationConfiguration`            | `awsS3BucketReplicationConfiguration`            |
| `requestPayer`                        | `awsS3BucketRequestPaymentConfiguration`        |
| `serverSideEncryptionConfiguration` | `awsS3BucketServerSideEncryptionConfiguration` |
| `versioning`                           | `awsS3BucketVersioning`                           |
| `website`                              | `awsS3BucketWebsiteConfiguration`                |

Going back to the earlier example, given the following configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  corsRule: [
    {
      allowedHeaders: ["*"],
      allowedMethods: ["PUT", "POST"],
      allowedOrigins: ["https://s3-website-test.hashicorp.com"],
      exposeHeaders: ["ETag"],
      maxAgeSeconds: 3000,
    },
  ],
});

```

Practitioners can upgrade to v4.9.0 and then introduce the standalone `awsS3BucketCorsConfiguration` resource, e.g.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketCorsConfigurationExample =
  new aws.s3BucketCorsConfiguration.S3BucketCorsConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      corsRule: [
        {
          allowedHeaders: ["*"],
          allowedMethods: ["PUT", "POST"],
          allowedOrigins: ["https://s3-website-test.hashicorp.com"],
          exposeHeaders: ["ETag"],
          maxAgeSeconds: 3000,
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketCorsConfigurationExample.overrideLogicalId("example");

```

Depending on the tools available to you, the above configuration can either be directly applied with Terraform or the standalone resource
can be imported into Terraform state. Please refer to each standalone resource's *Import* documentation for the proper syntax.

Once the standalone resources are managed by Terraform, updates and removal can be performed as needed.

The following sections depict standalone resource adoption per individual parameter. Standalone resource adoption is not required to upgrade but is recommended to ensure drift is detected by Terraform.
The examples below are by no means exhaustive. The aim is to provide important concepts when migrating to a standalone resource whose parameters may not entirely align with the corresponding parameter in the `awsS3Bucket` resource.

### Migrating to `awsS3BucketAccelerateConfiguration`

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  accelerationStatus: "Enabled",
  bucket: "yournamehere",
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketAccelerateConfigurationExample =
  new aws.s3BucketAccelerateConfiguration.S3BucketAccelerateConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      status: "Enabled",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketAccelerateConfigurationExample.overrideLogicalId("example");

```

### Migrating to `awsS3BucketAcl`

#### With `acl`

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  acl: "private",
  bucket: "yournamehere",
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketAclExample = new aws.s3BucketAcl.S3BucketAcl(
  this,
  "example_1",
  {
    acl: "private",
    bucket: awsS3BucketExample.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketAclExample.overrideLogicalId("example");

```

#### With `grant`

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  grant: [
    {
      id: "${data.aws_canonical_user_id.current_user.id}",
      permissions: ["FULL_CONTROL"],
      type: "CanonicalUser",
    },
    {
      permissions: ["READ_ACP", "WRITE"],
      type: "Group",
      uri: "http://acs.amazonaws.com/groups/s3/LogDelivery",
    },
  ],
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketAclExample = new aws.s3BucketAcl.S3BucketAcl(
  this,
  "example_1",
  {
    accessControlPolicy: {
      grant: [
        {
          grantee: {
            id: "${data.aws_canonical_user_id.current_user.id}",
            type: "CanonicalUser",
          },
          permission: "FULL_CONTROL",
        },
        {
          grantee: {
            type: "Group",
            uri: "http://acs.amazonaws.com/groups/s3/LogDelivery",
          },
          permission: "READ_ACP",
        },
        {
          grantee: {
            type: "Group",
            uri: "http://acs.amazonaws.com/groups/s3/LogDelivery",
          },
          permission: "WRITE",
        },
      ],
      owner: {
        id: "${data.aws_canonical_user_id.current_user.id}",
      },
    },
    bucket: awsS3BucketExample.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketAclExample.overrideLogicalId("example");

```

### Migrating to `awsS3BucketCorsConfiguration`

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  corsRule: [
    {
      allowedHeaders: ["*"],
      allowedMethods: ["PUT", "POST"],
      allowedOrigins: ["https://s3-website-test.hashicorp.com"],
      exposeHeaders: ["ETag"],
      maxAgeSeconds: 3000,
    },
  ],
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketCorsConfigurationExample =
  new aws.s3BucketCorsConfiguration.S3BucketCorsConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      corsRule: [
        {
          allowedHeaders: ["*"],
          allowedMethods: ["PUT", "POST"],
          allowedOrigins: ["https://s3-website-test.hashicorp.com"],
          exposeHeaders: ["ETag"],
          maxAgeSeconds: 3000,
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketCorsConfigurationExample.overrideLogicalId("example");

```

### Migrating to `awsS3BucketLifecycleConfiguration`

\~> **Note:** In version `3X` of the provider, the `lifecycleRuleId` argument was optional, while in version `4X`, the `awsS3BucketLifecycleConfigurationRuleId` argument required. Use the AWS CLI s3api [get-bucket-lifecycle-configuration](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/get-bucket-lifecycle-configuration.html) to get the source bucket's lifecycle configuration to determine the ID.

#### For Lifecycle Rules with no `prefix` previously configured

\~> **Note:** When configuring the `ruleFilter` configuration block in the new `awsS3BucketLifecycleConfiguration` resource, use the AWS CLI s3api [get-bucket-lifecycle-configuration](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/get-bucket-lifecycle-configuration.html)
to get the source bucket's lifecycle configuration and determine if the `filter` is configured as `"filter" : {}` or `"filter" : { "prefix": "" }`.
If AWS returns the former, configure `ruleFilter` as `filter {}`. Otherwise, neither a `ruleFilter` nor `rulePrefix` parameter should be configured as shown here:

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  lifecycleRule: [
    {
      enabled: true,
      id: "Keep previous version 30 days, then in Glacier another 60",
      noncurrentVersionExpiration: {
        days: 90,
      },
      noncurrentVersionTransition: [
        {
          days: 30,
          storageClass: "GLACIER",
        },
      ],
    },
    {
      abortIncompleteMultipartUploadDays: 7,
      enabled: true,
      id: "Delete old incomplete multi-part uploads",
    },
  ],
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketLifecycleConfigurationExample =
  new aws.s3BucketLifecycleConfiguration.S3BucketLifecycleConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      rule: [
        {
          id: "Keep previous version 30 days, then in Glacier another 60",
          noncurrentVersionExpiration: {
            noncurrentDays: 90,
          },
          noncurrentVersionTransition: [
            {
              noncurrentDays: 30,
              storageClass: "GLACIER",
            },
          ],
          status: "Enabled",
        },
        {
          abortIncompleteMultipartUpload: {
            daysAfterInitiation: 7,
          },
          id: "Delete old incomplete multi-part uploads",
          status: "Enabled",
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketLifecycleConfigurationExample.overrideLogicalId("example");

```

#### For Lifecycle Rules with `prefix` previously configured as an empty string

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  lifecycleRule: [
    {
      enabled: true,
      id: "log-expiration",
      prefix: "",
      transition: [
        {
          days: 30,
          storageClass: "STANDARD_IA",
        },
        {
          days: 180,
          storageClass: "GLACIER",
        },
      ],
    },
  ],
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketLifecycleConfigurationExample =
  new aws.s3BucketLifecycleConfiguration.S3BucketLifecycleConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      rule: [
        {
          id: "log-expiration",
          status: "Enabled",
          transition: [
            {
              days: 30,
              storageClass: "STANDARD_IA",
            },
            {
              days: 180,
              storageClass: "GLACIER",
            },
          ],
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketLifecycleConfigurationExample.overrideLogicalId("example");

```

#### For Lifecycle Rules with `prefix`

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  lifecycleRule: [
    {
      enabled: true,
      id: "log-expiration",
      prefix: "foobar",
      transition: [
        {
          days: 30,
          storageClass: "STANDARD_IA",
        },
        {
          days: 180,
          storageClass: "GLACIER",
        },
      ],
    },
  ],
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketLifecycleConfigurationExample =
  new aws.s3BucketLifecycleConfiguration.S3BucketLifecycleConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      rule: [
        {
          filter: {
            prefix: "foobar",
          },
          id: "log-expiration",
          status: "Enabled",
          transition: [
            {
              days: 30,
              storageClass: "STANDARD_IA",
            },
            {
              days: 180,
              storageClass: "GLACIER",
            },
          ],
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketLifecycleConfigurationExample.overrideLogicalId("example");

```

#### For Lifecycle Rules with `prefix` and `tags`

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  lifecycleRule: [
    {
      enabled: true,
      expiration: {
        days: 90,
      },
      id: "log",
      prefix: "log/",
      tags: {
        autoclean: "true",
        rule: "log",
      },
      transition: [
        {
          days: 30,
          storageClass: "STANDARD_IA",
        },
        {
          days: 60,
          storageClass: "GLACIER",
        },
      ],
    },
    {
      enabled: true,
      expiration: {
        date: "2022-12-31",
      },
      id: "tmp",
      prefix: "tmp/",
    },
  ],
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketLifecycleConfigurationExample =
  new aws.s3BucketLifecycleConfiguration.S3BucketLifecycleConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      rule: [
        {
          expiration: {
            days: 90,
          },
          filter: {
            and: {
              prefix: "log/",
              tags: {
                autoclean: "true",
                rule: "log",
              },
            },
          },
          id: "log",
          status: "Enabled",
          transition: [
            {
              days: 30,
              storageClass: "STANDARD_IA",
            },
            {
              days: 60,
              storageClass: "GLACIER",
            },
          ],
        },
        {
          expiration: {
            date: "2022-12-31T00:00:00Z",
          },
          filter: {
            prefix: "tmp/",
          },
          id: "tmp",
          status: "Enabled",
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketLifecycleConfigurationExample.overrideLogicalId("example");

```

### Migrating to `awsS3BucketLogging`

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketLogBucket = new aws.s3Bucket.S3Bucket(this, "log_bucket", {
  bucket: "example-log-bucket",
});
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  logging: {
    targetBucket: awsS3BucketLogBucket.id,
    targetPrefix: "log/",
  },
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketLogBucket = new aws.s3Bucket.S3Bucket(this, "log_bucket", {
  bucket: "example-log-bucket",
});
const awsS3BucketLoggingExample = new aws.s3BucketLogging.S3BucketLoggingA(
  this,
  "example_2",
  {
    bucket: awsS3BucketExample.id,
    targetBucket: awsS3BucketLogBucket.id,
    targetPrefix: "log/",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketLoggingExample.overrideLogicalId("example");

```

### Migrating to `awsS3BucketObjectLockConfiguration`

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  objectLockConfiguration: {
    objectLockEnabled: "Enabled",
    rule: {
      defaultRetention: {
        days: 3,
        mode: "COMPLIANCE",
      },
    },
  },
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  objectLockEnabled: true,
});
const awsS3BucketObjectLockConfigurationExample =
  new aws.s3BucketObjectLockConfiguration.S3BucketObjectLockConfigurationA(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      rule: {
        defaultRetention: {
          days: 3,
          mode: "COMPLIANCE",
        },
      },
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketObjectLockConfigurationExample.overrideLogicalId("example");

```

### Migrating to `awsS3BucketPolicy`

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  policy:
    '{\n  "Id": "Policy1446577137248",\n  "Statement": [\n    {\n      "Action": "s3:PutObject",\n      "Effect": "Allow",\n      "Principal": {\n        "AWS": "${data.aws_elb_service_account.current.arn}"\n      },\n      "Resource": "arn:${data.aws_partition.current.partition}:s3:::yournamehere/*",\n      "Sid": "Stmt1446575236270"\n    }\n  ],\n  "Version": "2012-10-17"\n}\n',
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketPolicyExample = new aws.s3BucketPolicy.S3BucketPolicy(
  this,
  "example_1",
  {
    bucket: awsS3BucketExample.id,
    policy: `{
  "Id": "Policy1446577137248",
  "Statement": [
    {
      "Action": "s3:PutObject",
      "Effect": "Allow",
      "Principal": {
        "AWS": "\${data.aws_elb_service_account.current.arn}"
      },
      "Resource": "\${${awsS3BucketExample.arn}}/*",
      "Sid": "Stmt1446575236270"
    }
  ],
  "Version": "2012-10-17"
}
`,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketPolicyExample.overrideLogicalId("example");

```

### Migrating to `awsS3BucketReplicationConfiguration`

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  provider: "${aws.central}",
  replicationConfiguration: {
    role: "${aws_iam_role.replication.arn}",
    rules: [
      {
        destination: {
          bucket: "${aws_s3_bucket.destination.arn}",
          metrics: {
            minutes: 15,
            status: "Enabled",
          },
          replicationTime: {
            minutes: 15,
            status: "Enabled",
          },
          storageClass: "STANDARD",
        },
        filter: {
          tags: {},
        },
        id: "foobar",
        status: "Enabled",
      },
    ],
  },
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  provider: "${aws.central}",
});
const awsS3BucketReplicationConfigurationExample =
  new aws.s3BucketReplicationConfiguration.S3BucketReplicationConfigurationA(
    this,
    "example_1",
    {
      bucket: "${aws_s3_bucket.source.id}",
      role: "${aws_iam_role.replication.arn}",
      rule: [
        {
          deleteMarkerReplication: {
            status: "Enabled",
          },
          destination: {
            bucket: "${aws_s3_bucket.destination.arn}",
            metrics: {
              eventThreshold: {
                minutes: 15,
              },
              status: "Enabled",
            },
            replicationTime: {
              status: "Enabled",
              time: {
                minutes: 15,
              },
            },
            storageClass: "STANDARD",
          },
          filter: {},
          id: "foobar",
          status: "Enabled",
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketReplicationConfigurationExample.overrideLogicalId("example");

```

### Migrating to `awsS3BucketRequestPaymentConfiguration`

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  requestPayer: "Requester",
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketRequestPaymentConfigurationExample =
  new aws.s3BucketRequestPaymentConfiguration.S3BucketRequestPaymentConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      payer: "Requester",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketRequestPaymentConfigurationExample.overrideLogicalId("example");

```

### Migrating to `awsS3BucketServerSideEncryptionConfiguration`

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  serverSideEncryptionConfiguration: {
    rule: {
      applyServerSideEncryptionByDefault: {
        kmsMasterKeyId: "${aws_kms_key.mykey.arn}",
        sseAlgorithm: "aws:kms",
      },
    },
  },
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketServerSideEncryptionConfigurationExample =
  new aws.s3BucketServerSideEncryptionConfiguration.S3BucketServerSideEncryptionConfigurationA(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      rule: [
        {
          applyServerSideEncryptionByDefault: {
            kmsMasterKeyId: "${aws_kms_key.mykey.arn}",
            sseAlgorithm: "aws:kms",
          },
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketServerSideEncryptionConfigurationExample.overrideLogicalId(
  "example"
);

```

### Migrating to `awsS3BucketVersioning`

\~> **NOTE:** As `awsS3BucketVersioning` is a separate resource, any S3 objects for which versioning is important (*e.g.*, a truststore for mutual TLS authentication) must implicitly or explicitly depend on the `awsS3BucketVersioning` resource. Otherwise, the S3 objects may be created before versioning has been set. [See below](#ensure-objects-depend-on-versioning) for an example. Also note that AWS recommends waiting 15 minutes after enabling versioning on a bucket before putting or deleting objects in/from the bucket.

#### Buckets With Versioning Enabled

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  versioning: {
    enabled: true,
  },
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketVersioningExample =
  new aws.s3BucketVersioning.S3BucketVersioningA(this, "example_1", {
    bucket: awsS3BucketExample.id,
    versioningConfiguration: {
      status: "Enabled",
    },
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketVersioningExample.overrideLogicalId("example");

```

#### Buckets With Versioning Disabled or Suspended

Depending on the version of the Terraform AWS Provider you are migrating from, the interpretation of `versioningEnabled =False`
in your `awsS3Bucket` resource will differ and thus the migration to the `awsS3BucketVersioning` resource will also differ as follows.

If you are migrating from the Terraform AWS Provider `v3700` or later:

* For new S3 buckets, `enabled =False` is synonymous to `disabled`.
* For existing S3 buckets, `enabled =False` is synonymous to `suspended`.

If you are migrating from an earlier version of the Terraform AWS Provider:

* For both new and existing S3 buckets, `enabled =False` is synonymous to `suspended`.

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  versioning: {
    enabled: false,
  },
});

```

Update the configuration to one of the following:

*   If migrating from Terraform AWS Provider `v3700` or later and bucket versioning was never enabled:

    ```typescript
    /*Provider bindings are generated by running cdktf get.
    See https://cdk.tf/provider-generation for more details.*/
    import * as aws from "./.gen/providers/aws";
    const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
      bucket: "yournamehere",
    });
    const awsS3BucketVersioningExample =
      new aws.s3BucketVersioning.S3BucketVersioningA(this, "example_1", {
        bucket: awsS3BucketExample.id,
        versioningConfiguration: {
          status: "Disabled",
        },
      });
    /*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
    awsS3BucketVersioningExample.overrideLogicalId("example");

    ```

*   If migrating from Terraform AWS Provider `v3700` or later and bucket versioning was enabled at one point:

    ```typescript
    /*Provider bindings are generated by running cdktf get.
    See https://cdk.tf/provider-generation for more details.*/
    import * as aws from "./.gen/providers/aws";
    const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
      bucket: "yournamehere",
    });
    const awsS3BucketVersioningExample =
      new aws.s3BucketVersioning.S3BucketVersioningA(this, "example_1", {
        bucket: awsS3BucketExample.id,
        versioningConfiguration: {
          status: "Suspended",
        },
      });
    /*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
    awsS3BucketVersioningExample.overrideLogicalId("example");

    ```

*   If migrating from an earlier version of Terraform AWS Provider:

    ```typescript
    /*Provider bindings are generated by running cdktf get.
    See https://cdk.tf/provider-generation for more details.*/
    import * as aws from "./.gen/providers/aws";
    const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
      bucket: "yournamehere",
    });
    const awsS3BucketVersioningExample =
      new aws.s3BucketVersioning.S3BucketVersioningA(this, "example_1", {
        bucket: awsS3BucketExample.id,
        versioningConfiguration: {
          status: "Suspended",
        },
      });
    /*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
    awsS3BucketVersioningExample.overrideLogicalId("example");

    ```

#### Ensure Objects Depend on Versioning

When you create an object whose `versionId` you need and an `awsS3BucketVersioning` resource in the same configuration, you are more likely to have success by ensuring the `s3Object` depends either implicitly (see below) or explicitly (i.e., using `dependsOn = [awsS3BucketVersioningExample]`) on the `awsS3BucketVersioning` resource.

\~> **NOTE:** For critical and/or production S3 objects, do not create a bucket, enable versioning, and create an object in the bucket within the same configuration. Doing so will not allow the AWS-recommended 15 minutes between enabling versioning and writing to the bucket.

This example shows the `awsS3ObjectExample` depending implicitly on the versioning resource through the reference to `awsS3BucketVersioningExampleBucket` to define `bucket`:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yotto",
});
const awsS3BucketVersioningExample =
  new aws.s3BucketVersioning.S3BucketVersioningA(this, "example_1", {
    bucket: awsS3BucketExample.id,
    versioningConfiguration: {
      status: "Enabled",
    },
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketVersioningExample.overrideLogicalId("example");
const awsS3ObjectExample = new aws.s3Object.S3Object(this, "example_2", {
  bucket: awsS3BucketVersioningExample.bucket,
  key: "droeloe",
  source: "example.txt",
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3ObjectExample.overrideLogicalId("example");

```

### Migrating to `awsS3BucketWebsiteConfiguration`

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  website: {
    errorDocument: "error.html",
    indexDocument: "index.html",
  },
});

```

Update the configuration to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketWebsiteConfigurationExample =
  new aws.s3BucketWebsiteConfiguration.S3BucketWebsiteConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      errorDocument: {
        key: "error.html",
      },
      indexDocument: {
        suffix: "index.html",
      },
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketWebsiteConfigurationExample.overrideLogicalId("example");

```

Given this previous configuration that uses the `awsS3Bucket` parameter `websiteDomain` with `awsRoute53Record`:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsRoute53ZoneMain = new aws.route53Zone.Route53Zone(this, "main", {
  name: "domain.test",
});
const awsS3BucketWebsite = new aws.s3Bucket.S3Bucket(this, "website", {
  website: {
    errorDocument: "error.html",
    indexDocument: "index.html",
  },
});
new aws.route53Record.Route53Record(this, "alias", {
  alias: {
    evaluateTargetHealth: true,
    name: awsS3BucketWebsite.websiteDomain,
    zoneId: awsS3BucketWebsite.hostedZoneId,
  },
  name: "www",
  type: "A",
  zoneId: awsRoute53ZoneMain.zoneId,
});

```

Update the configuration to use the `awsS3BucketWebsiteConfiguration` resource and its `websiteDomain` parameter:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsRoute53ZoneMain = new aws.route53Zone.Route53Zone(this, "main", {
  name: "domain.test",
});
const awsS3BucketWebsite = new aws.s3Bucket.S3Bucket(this, "website", {});
const awsS3BucketWebsiteConfigurationExample =
  new aws.s3BucketWebsiteConfiguration.S3BucketWebsiteConfiguration(
    this,
    "example",
    {
      bucket: awsS3BucketWebsite.id,
      indexDocument: {
        suffix: "index.html",
      },
    }
  );
new aws.route53Record.Route53Record(this, "alias", {
  alias: {
    evaluateTargetHealth: true,
    name: awsS3BucketWebsiteConfigurationExample.websiteDomain,
    zoneId: awsS3BucketWebsite.hostedZoneId,
  },
  name: "www",
  type: "A",
  zoneId: awsRoute53ZoneMain.zoneId,
});

```

## S3 Bucket Refactor

\~> **NOTE:** This only applies to v4.0.0 through v4.8.0 of the AWS Provider, which introduce significant breaking
changes to the `awsS3Bucket` resource. We recommend upgrading to v4.9.0 of the AWS Provider instead. See the section above, [Changes to S3 Bucket Drift Detection](#changes-to-s3-bucket-drift-detection), for additional upgrade considerations.

To help distribute the management of S3 bucket settings via independent resources, various arguments and attributes in the `awsS3Bucket` resource have become **read-only**.

Configurations dependent on these arguments should be updated to use the corresponding `awsS3Bucket_*` resource in order to prevent Terraform from reporting “unconfigurable attribute” errors for read-only arguments. Once updated, it is recommended to import new `awsS3Bucket_*` resources into Terraform state.

In the event practitioners do not anticipate future modifications to the S3 bucket settings associated with these read-only arguments or drift detection is not needed, these read-only arguments should be removed from `awsS3Bucket` resource configurations in order to prevent Terraform from reporting “unconfigurable attribute” errors; the states of these arguments will be preserved but are subject to change with modifications made outside Terraform.

\~> **NOTE:** Each of the new `awsS3Bucket_*` resources relies on S3 API calls that utilize a `put` action in order to modify the target S3 bucket. These calls follow standard HTTP methods for REST APIs, and therefore **should** handle situations where the target configuration already exists. While it is not strictly necessary to import new `awsS3Bucket_*` resources where the updated configuration matches the configuration used in previous versions of the AWS provider, skipping this step will lead to a diff in the first plan after a configuration change indicating that any new `awsS3Bucket_*` resources will be created, making it more difficult to determine whether the appropriate actions will be taken.

### `accelerationStatus` Argument

Switch your Terraform configuration to the [`awsS3BucketAccelerateConfiguration` resource](/docs/providers/aws/r/s3_bucket_accelerate_configuration.html) instead.

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  accelerationStatus: "Enabled",
  bucket: "yournamehere",
});

```

You will get the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "acceleration_status": its value will be decided automatically based on the result of applying this configuration.
```

Since `accelerationStatus` is now read only, update your configuration to use the `awsS3BucketAccelerateConfiguration`
resource and remove `accelerationStatus` in the `awsS3Bucket` resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketAccelerateConfigurationExample =
  new aws.s3BucketAccelerateConfiguration.S3BucketAccelerateConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      status: "Enabled",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketAccelerateConfigurationExample.overrideLogicalId("example");

```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_accelerate_configuration.example yournamehere
aws_s3_bucket_accelerate_configuration.example: Importing from ID "yournamehere"...
aws_s3_bucket_accelerate_configuration.example: Import prepared!
  Prepared aws_s3_bucket_accelerate_configuration for import
aws_s3_bucket_accelerate_configuration.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

### `acl` Argument

Switch your Terraform configuration to the [`awsS3BucketAcl` resource](/docs/providers/aws/r/s3_bucket_acl.html) instead.

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  acl: "private",
  bucket: "yournamehere",
});

```

You will get the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "acl": its value will be decided automatically based on the result of applying this configuration.
```

Since `acl` is now read only, update your configuration to use the `awsS3BucketAcl`
resource and remove the `acl` argument in the `awsS3Bucket` resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketAclExample = new aws.s3BucketAcl.S3BucketAcl(
  this,
  "example_1",
  {
    acl: "private",
    bucket: awsS3BucketExample.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketAclExample.overrideLogicalId("example");

```

\~> **NOTE:** When importing into `awsS3BucketAcl`, make sure you use the S3 bucket name (*e.g.*, `yournamehere` in the example above) as part of the ID, and *not* the Terraform bucket configuration name (*e.g.*, `example` in the example above).

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_acl.example yournamehere,private
aws_s3_bucket_acl.example: Importing from ID "yournamehere,private"...
aws_s3_bucket_acl.example: Import prepared!
  Prepared aws_s3_bucket_acl for import
aws_s3_bucket_acl.example: Refreshing state... [id=yournamehere,private]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

### `corsRule` Argument

Switch your Terraform configuration to the [`awsS3BucketCorsConfiguration` resource](/docs/providers/aws/r/s3_bucket_cors_configuration.html) instead.

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  corsRule: [
    {
      allowedHeaders: ["*"],
      allowedMethods: ["PUT", "POST"],
      allowedOrigins: ["https://s3-website-test.hashicorp.com"],
      exposeHeaders: ["ETag"],
      maxAgeSeconds: 3000,
    },
  ],
});

```

You will get the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "cors_rule": its value will be decided automatically based on the result of applying this configuration.
```

Since `corsRule` is now read only, update your configuration to use the `awsS3BucketCorsConfiguration`
resource and remove `corsRule` and its nested arguments in the `awsS3Bucket` resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketCorsConfigurationExample =
  new aws.s3BucketCorsConfiguration.S3BucketCorsConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      corsRule: [
        {
          allowedHeaders: ["*"],
          allowedMethods: ["PUT", "POST"],
          allowedOrigins: ["https://s3-website-test.hashicorp.com"],
          exposeHeaders: ["ETag"],
          maxAgeSeconds: 3000,
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketCorsConfigurationExample.overrideLogicalId("example");

```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_cors_configuration.example yournamehere
aws_s3_bucket_cors_configuration.example: Importing from ID "yournamehere"...
aws_s3_bucket_cors_configuration.example: Import prepared!
  Prepared aws_s3_bucket_cors_configuration for import
aws_s3_bucket_cors_configuration.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

### `grant` Argument

Switch your Terraform configuration to the [`awsS3BucketAcl` resource](/docs/providers/aws/r/s3_bucket_acl.html) instead.

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  grant: [
    {
      id: "${data.aws_canonical_user_id.current_user.id}",
      permissions: ["FULL_CONTROL"],
      type: "CanonicalUser",
    },
    {
      permissions: ["READ_ACP", "WRITE"],
      type: "Group",
      uri: "http://acs.amazonaws.com/groups/s3/LogDelivery",
    },
  ],
});

```

You will get the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "grant": its value will be decided automatically based on the result of applying this configuration.
```

Since `grant` is now read only, update your configuration to use the `awsS3BucketAcl`
resource and remove `grant` in the `awsS3Bucket` resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketAclExample = new aws.s3BucketAcl.S3BucketAcl(
  this,
  "example_1",
  {
    accessControlPolicy: {
      grant: [
        {
          grantee: {
            id: "${data.aws_canonical_user_id.current_user.id}",
            type: "CanonicalUser",
          },
          permission: "FULL_CONTROL",
        },
        {
          grantee: {
            type: "Group",
            uri: "http://acs.amazonaws.com/groups/s3/LogDelivery",
          },
          permission: "READ_ACP",
        },
        {
          grantee: {
            type: "Group",
            uri: "http://acs.amazonaws.com/groups/s3/LogDelivery",
          },
          permission: "WRITE",
        },
      ],
      owner: {
        id: "${data.aws_canonical_user_id.current_user.id}",
      },
    },
    bucket: awsS3BucketExample.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketAclExample.overrideLogicalId("example");

```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_acl.example yournamehere
aws_s3_bucket_acl.example: Importing from ID "yournamehere"...
aws_s3_bucket_acl.example: Import prepared!
  Prepared aws_s3_bucket_acl for import
aws_s3_bucket_acl.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

### `lifecycleRule` Argument

Switch your Terraform configuration to the [`awsS3BucketLifecycleConfiguration` resource](/docs/providers/aws/r/s3_bucket_lifecycle_configuration.html) instead.

#### For Lifecycle Rules with no `prefix` previously configured

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  lifecycleRule: [
    {
      enabled: true,
      id: "Keep previous version 30 days, then in Glacier another 60",
      noncurrentVersionExpiration: {
        days: 90,
      },
      noncurrentVersionTransition: [
        {
          days: 30,
          storageClass: "GLACIER",
        },
      ],
    },
    {
      abortIncompleteMultipartUploadDays: 7,
      enabled: true,
      id: "Delete old incomplete multi-part uploads",
    },
  ],
});

```

You will receive the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "lifecycle_rule": its value will be decided automatically based on the result of applying this configuration.
```

Since the `lifecycleRule` argument changed to read-only, update the configuration to use the `awsS3BucketLifecycleConfiguration`
resource and remove `lifecycleRule` and its nested arguments in the `awsS3Bucket` resource.

\~> **Note:** When configuring the `ruleFilter` configuration block in the new `awsS3BucketLifecycleConfiguration` resource, use the AWS CLI s3api [get-bucket-lifecycle-configuration](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/get-bucket-lifecycle-configuration.html)
to get the source bucket's lifecycle configuration and determine if the `filter` is configured as `"filter" : {}` or `"filter" : { "prefix": "" }`.
If AWS returns the former, configure `ruleFilter` as `filter {}`. Otherwise, neither a `ruleFilter` nor `rulePrefix` parameter should be configured as shown here:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketLifecycleConfigurationExample =
  new aws.s3BucketLifecycleConfiguration.S3BucketLifecycleConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      rule: [
        {
          id: "Keep previous version 30 days, then in Glacier another 60",
          noncurrentVersionExpiration: {
            noncurrentDays: 90,
          },
          noncurrentVersionTransition: [
            {
              noncurrentDays: 30,
              storageClass: "GLACIER",
            },
          ],
          status: "Enabled",
        },
        {
          abortIncompleteMultipartUpload: {
            daysAfterInitiation: 7,
          },
          id: "Delete old incomplete multi-part uploads",
          status: "Enabled",
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketLifecycleConfigurationExample.overrideLogicalId("example");

```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_lifecycle_configuration.example yournamehere
aws_s3_bucket_lifecycle_configuration.example: Importing from ID "yournamehere"...
aws_s3_bucket_lifecycle_configuration.example: Import prepared!
  Prepared aws_s3_bucket_lifecycle_configuration for import
aws_s3_bucket_lifecycle_configuration.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

#### For Lifecycle Rules with `prefix` previously configured as an empty string

For example, given this configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  lifecycleRule: [
    {
      enabled: true,
      id: "log-expiration",
      prefix: "",
      transition: [
        {
          days: 30,
          storageClass: "STANDARD_IA",
        },
        {
          days: 180,
          storageClass: "GLACIER",
        },
      ],
    },
  ],
});

```

You will receive the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "lifecycle_rule": its value will be decided automatically based on the result of applying this configuration.
```

Since the `lifecycleRule` argument changed to read-only, update the configuration to use the `awsS3BucketLifecycleConfiguration`
resource and remove `lifecycleRule` and its nested arguments in the `awsS3Bucket` resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketLifecycleConfigurationExample =
  new aws.s3BucketLifecycleConfiguration.S3BucketLifecycleConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      rule: [
        {
          id: "log-expiration",
          status: "Enabled",
          transition: [
            {
              days: 30,
              storageClass: "STANDARD_IA",
            },
            {
              days: 180,
              storageClass: "GLACIER",
            },
          ],
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketLifecycleConfigurationExample.overrideLogicalId("example");

```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_lifecycle_configuration.example yournamehere
aws_s3_bucket_lifecycle_configuration.example: Importing from ID "yournamehere"...
aws_s3_bucket_lifecycle_configuration.example: Import prepared!
  Prepared aws_s3_bucket_lifecycle_configuration for import
aws_s3_bucket_lifecycle_configuration.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

#### For Lifecycle Rules with `prefix`

For example, given this configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  lifecycleRule: [
    {
      enabled: true,
      id: "log-expiration",
      prefix: "foobar",
      transition: [
        {
          days: 30,
          storageClass: "STANDARD_IA",
        },
        {
          days: 180,
          storageClass: "GLACIER",
        },
      ],
    },
  ],
});

```

You will receive the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "lifecycle_rule": its value will be decided automatically based on the result of applying this configuration.
```

Since the `lifecycleRule` argument changed to read-only, update the configuration to use the `awsS3BucketLifecycleConfiguration`
resource and remove `lifecycleRule` and its nested arguments in the `awsS3Bucket` resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketLifecycleConfigurationExample =
  new aws.s3BucketLifecycleConfiguration.S3BucketLifecycleConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      rule: [
        {
          filter: {
            prefix: "foobar",
          },
          id: "log-expiration",
          status: "Enabled",
          transition: [
            {
              days: 30,
              storageClass: "STANDARD_IA",
            },
            {
              days: 180,
              storageClass: "GLACIER",
            },
          ],
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketLifecycleConfigurationExample.overrideLogicalId("example");

```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_lifecycle_configuration.example yournamehere
aws_s3_bucket_lifecycle_configuration.example: Importing from ID "yournamehere"...
aws_s3_bucket_lifecycle_configuration.example: Import prepared!
  Prepared aws_s3_bucket_lifecycle_configuration for import
aws_s3_bucket_lifecycle_configuration.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

#### For Lifecycle Rules with `prefix` and `tags`

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  lifecycleRule: [
    {
      enabled: true,
      expiration: {
        days: 90,
      },
      id: "log",
      prefix: "log/",
      tags: {
        autoclean: "true",
        rule: "log",
      },
      transition: [
        {
          days: 30,
          storageClass: "STANDARD_IA",
        },
        {
          days: 60,
          storageClass: "GLACIER",
        },
      ],
    },
    {
      enabled: true,
      expiration: {
        date: "2022-12-31",
      },
      id: "tmp",
      prefix: "tmp/",
    },
  ],
});

```

You will get the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "lifecycle_rule": its value will be decided automatically based on the result of applying this configuration.
```

Since `lifecycleRule` is now read only, update your configuration to use the `awsS3BucketLifecycleConfiguration`
resource and remove `lifecycleRule` and its nested arguments in the `awsS3Bucket` resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketLifecycleConfigurationExample =
  new aws.s3BucketLifecycleConfiguration.S3BucketLifecycleConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      rule: [
        {
          expiration: {
            days: 90,
          },
          filter: {
            and: {
              prefix: "log/",
              tags: {
                autoclean: "true",
                rule: "log",
              },
            },
          },
          id: "log",
          status: "Enabled",
          transition: [
            {
              days: 30,
              storageClass: "STANDARD_IA",
            },
            {
              days: 60,
              storageClass: "GLACIER",
            },
          ],
        },
        {
          expiration: {
            date: "2022-12-31T00:00:00Z",
          },
          filter: {
            prefix: "tmp/",
          },
          id: "tmp",
          status: "Enabled",
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketLifecycleConfigurationExample.overrideLogicalId("example");

```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_lifecycle_configuration.example yournamehere
aws_s3_bucket_lifecycle_configuration.example: Importing from ID "yournamehere"...
aws_s3_bucket_lifecycle_configuration.example: Import prepared!
  Prepared aws_s3_bucket_lifecycle_configuration for import
aws_s3_bucket_lifecycle_configuration.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

### `logging` Argument

Switch your Terraform configuration to the [`awsS3BucketLogging` resource](/docs/providers/aws/r/s3_bucket_logging.html) instead.

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketLogBucket = new aws.s3Bucket.S3Bucket(this, "log_bucket", {
  bucket: "example-log-bucket",
});
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  logging: {
    targetBucket: awsS3BucketLogBucket.id,
    targetPrefix: "log/",
  },
});

```

You will get the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "logging": its value will be decided automatically based on the result of applying this configuration.
```

Since `logging` is now read only, update your configuration to use the `awsS3BucketLogging`
resource and remove `logging` and its nested arguments in the `awsS3Bucket` resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketLogBucket = new aws.s3Bucket.S3Bucket(this, "log_bucket", {
  bucket: "example-log-bucket",
});
const awsS3BucketLoggingExample = new aws.s3BucketLogging.S3BucketLoggingA(
  this,
  "example_2",
  {
    bucket: awsS3BucketExample.id,
    targetBucket: awsS3BucketLogBucket.id,
    targetPrefix: "log/",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketLoggingExample.overrideLogicalId("example");

```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_logging.example yournamehere
aws_s3_bucket_logging.example: Importing from ID "yournamehere"...
aws_s3_bucket_logging.example: Import prepared!
  Prepared aws_s3_bucket_logging for import
aws_s3_bucket_logging.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

### `objectLockConfiguration` `rule` Argument

Switch your Terraform configuration to the [`awsS3BucketObjectLockConfiguration` resource](/docs/providers/aws/r/s3_bucket_object_lock_configuration.html) instead.

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  objectLockConfiguration: {
    objectLockEnabled: "Enabled",
    rule: {
      defaultRetention: {
        days: 3,
        mode: "COMPLIANCE",
      },
    },
  },
});

```

You will get the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "object_lock_configuration.0.rule": its value will be decided automatically based on the result of applying this configuration.
```

Since the `rule` argument of the `objectLockConfiguration` configuration block changed to read-only, update your configuration to use the `awsS3BucketObjectLockConfiguration`
resource and remove `rule` and its nested arguments in the `awsS3Bucket` resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  objectLockEnabled: true,
});
const awsS3BucketObjectLockConfigurationExample =
  new aws.s3BucketObjectLockConfiguration.S3BucketObjectLockConfigurationA(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      rule: {
        defaultRetention: {
          days: 3,
          mode: "COMPLIANCE",
        },
      },
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketObjectLockConfigurationExample.overrideLogicalId("example");

```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_object_lock_configuration.example yournamehere
aws_s3_bucket_object_lock_configuration.example: Importing from ID "yournamehere"...
aws_s3_bucket_object_lock_configuration.example: Import prepared!
  Prepared aws_s3_bucket_object_lock_configuration for import
aws_s3_bucket_object_lock_configuration.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

### `policy` Argument

Switch your Terraform configuration to the [`awsS3BucketPolicy` resource](/docs/providers/aws/r/s3_bucket_policy.html) instead.

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  policy:
    '{\n  "Id": "Policy1446577137248",\n  "Statement": [\n    {\n      "Action": "s3:PutObject",\n      "Effect": "Allow",\n      "Principal": {\n        "AWS": "${data.aws_elb_service_account.current.arn}"\n      },\n      "Resource": "arn:${data.aws_partition.current.partition}:s3:::yournamehere/*",\n      "Sid": "Stmt1446575236270"\n    }\n  ],\n  "Version": "2012-10-17"\n}\n',
});

```

You will get the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "policy": its value will be decided automatically based on the result of applying this configuration.
```

Since `policy` is now read only, update your configuration to use the `awsS3BucketPolicy`
resource and remove `policy` in the `awsS3Bucket` resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketPolicyExample = new aws.s3BucketPolicy.S3BucketPolicy(
  this,
  "example_1",
  {
    bucket: awsS3BucketExample.id,
    policy: `{
  "Id": "Policy1446577137248",
  "Statement": [
    {
      "Action": "s3:PutObject",
      "Effect": "Allow",
      "Principal": {
        "AWS": "\${data.aws_elb_service_account.current.arn}"
      },
      "Resource": "\${${awsS3BucketExample.arn}}/*",
      "Sid": "Stmt1446575236270"
    }
  ],
  "Version": "2012-10-17"
}
`,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketPolicyExample.overrideLogicalId("example");

```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_policy.example yournamehere
aws_s3_bucket_policy.example: Importing from ID "yournamehere"...
aws_s3_bucket_policy.example: Import prepared!
  Prepared aws_s3_bucket_policy for import
aws_s3_bucket_policy.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

### `replicationConfiguration` Argument

Switch your Terraform configuration to the [`awsS3BucketReplicationConfiguration` resource](/docs/providers/aws/r/s3_bucket_replication_configuration.html) instead.

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  provider: "${aws.central}",
  replicationConfiguration: {
    role: "${aws_iam_role.replication.arn}",
    rules: [
      {
        destination: {
          bucket: "${aws_s3_bucket.destination.arn}",
          metrics: {
            minutes: 15,
            status: "Enabled",
          },
          replicationTime: {
            minutes: 15,
            status: "Enabled",
          },
          storageClass: "STANDARD",
        },
        filter: {
          tags: {},
        },
        id: "foobar",
        status: "Enabled",
      },
    ],
  },
});

```

You will get the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "replication_configuration": its value will be decided automatically based on the result of applying this configuration.
```

Since `replicationConfiguration` is now read only, update your configuration to use the `awsS3BucketReplicationConfiguration`
resource and remove `replicationConfiguration` and its nested arguments in the `awsS3Bucket` resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  provider: "${aws.central}",
});
const awsS3BucketReplicationConfigurationExample =
  new aws.s3BucketReplicationConfiguration.S3BucketReplicationConfigurationA(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      role: "${aws_iam_role.replication.arn}",
      rule: [
        {
          deleteMarkerReplication: {
            status: "Enabled",
          },
          destination: {
            bucket: "${aws_s3_bucket.destination.arn}",
            metrics: {
              eventThreshold: {
                minutes: 15,
              },
              status: "Enabled",
            },
            replicationTime: {
              status: "Enabled",
              time: {
                minutes: 15,
              },
            },
            storageClass: "STANDARD",
          },
          filter: {},
          id: "foobar",
          status: "Enabled",
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketReplicationConfigurationExample.overrideLogicalId("example");

```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_replication_configuration.example yournamehere
aws_s3_bucket_replication_configuration.example: Importing from ID "yournamehere"...
aws_s3_bucket_replication_configuration.example: Import prepared!
  Prepared aws_s3_bucket_replication_configuration for import
aws_s3_bucket_replication_configuration.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

### `requestPayer` Argument

Switch your Terraform configuration to the [`awsS3BucketRequestPaymentConfiguration` resource](/docs/providers/aws/r/s3_bucket_request_payment_configuration.html) instead.

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  requestPayer: "Requester",
});

```

You will get the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "request_payer": its value will be decided automatically based on the result of applying this configuration.
```

Since `requestPayer` is now read only, update your configuration to use the `awsS3BucketRequestPaymentConfiguration`
resource and remove `requestPayer` in the `awsS3Bucket` resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketRequestPaymentConfigurationExample =
  new aws.s3BucketRequestPaymentConfiguration.S3BucketRequestPaymentConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      payer: "Requester",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketRequestPaymentConfigurationExample.overrideLogicalId("example");

```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_request_payment_configuration.example yournamehere
aws_s3_bucket_request_payment_configuration.example: Importing from ID "yournamehere"...
aws_s3_bucket_request_payment_configuration.example: Import prepared!
  Prepared aws_s3_bucket_request_payment_configuration for import
aws_s3_bucket_request_payment_configuration.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

### `serverSideEncryptionConfiguration` Argument

Switch your Terraform configuration to the [`awsS3BucketServerSideEncryptionConfiguration` resource](/docs/providers/aws/r/s3_bucket_server_side_encryption_configuration.html) instead.

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  serverSideEncryptionConfiguration: {
    rule: {
      applyServerSideEncryptionByDefault: {
        kmsMasterKeyId: "${aws_kms_key.mykey.arn}",
        sseAlgorithm: "aws:kms",
      },
    },
  },
});

```

You will get the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "server_side_encryption_configuration": its value will be decided automatically based on the result of applying this configuration.
```

Since `serverSideEncryptionConfiguration` is now read only, update your configuration to use the `awsS3BucketServerSideEncryptionConfiguration`
resource and remove `serverSideEncryptionConfiguration` and its nested arguments in the `awsS3Bucket` resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketServerSideEncryptionConfigurationExample =
  new aws.s3BucketServerSideEncryptionConfiguration.S3BucketServerSideEncryptionConfigurationA(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      rule: [
        {
          applyServerSideEncryptionByDefault: {
            kmsMasterKeyId: "${aws_kms_key.mykey.arn}",
            sseAlgorithm: "aws:kms",
          },
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketServerSideEncryptionConfigurationExample.overrideLogicalId(
  "example"
);

```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_server_side_encryption_configuration.example yournamehere
aws_s3_bucket_server_side_encryption_configuration.example: Importing from ID "yournamehere"...
aws_s3_bucket_server_side_encryption_configuration.example: Import prepared!
  Prepared aws_s3_bucket_server_side_encryption_configuration for import
aws_s3_bucket_server_side_encryption_configuration.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

### `versioning` Argument

Switch your Terraform configuration to the [`awsS3BucketVersioning` resource](/docs/providers/aws/r/s3_bucket_versioning.html) instead.

\~> **NOTE:** As `awsS3BucketVersioning` is a separate resource, any S3 objects for which versioning is important (*e.g.*, a truststore for mutual TLS authentication) must implicitly or explicitly depend on the `awsS3BucketVersioning` resource. Otherwise, the S3 objects may be created before versioning has been set. [See below](#ensure-objects-depend-on-versioning) for an example. Also note that AWS recommends waiting 15 minutes after enabling versioning on a bucket before putting or deleting objects in/from the bucket.

#### Buckets With Versioning Enabled

Given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  versioning: {
    enabled: true,
  },
});

```

You will get the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "versioning": its value will be decided automatically based on the result of applying this configuration.
```

Since `versioning` is now read only, update your configuration to use the `awsS3BucketVersioning`
resource and remove `versioning` and its nested arguments in the `awsS3Bucket` resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketVersioningExample =
  new aws.s3BucketVersioning.S3BucketVersioningA(this, "example_1", {
    bucket: awsS3BucketExample.id,
    versioningConfiguration: {
      status: "Enabled",
    },
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketVersioningExample.overrideLogicalId("example");

```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_versioning.example yournamehere
aws_s3_bucket_versioning.example: Importing from ID "yournamehere"...
aws_s3_bucket_versioning.example: Import prepared!
  Prepared aws_s3_bucket_versioning for import
aws_s3_bucket_versioning.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

#### Buckets With Versioning Disabled or Suspended

Depending on the version of the Terraform AWS Provider you are migrating from, the interpretation of `versioningEnabled =False`
in your `awsS3Bucket` resource will differ and thus the migration to the `awsS3BucketVersioning` resource will also differ as follows.

If you are migrating from the Terraform AWS Provider `v3700` or later:

* For new S3 buckets, `enabled =False` is synonymous to `disabled`.
* For existing S3 buckets, `enabled =False` is synonymous to `suspended`.

If you are migrating from an earlier version of the Terraform AWS Provider:

* For both new and existing S3 buckets, `enabled =False` is synonymous to `suspended`.

Given this previous configuration :

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  versioning: {
    enabled: false,
  },
});

```

You will get the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "versioning": its value will be decided automatically based on the result of applying this configuration.
```

Since `versioning` is now read only, update your configuration to use the `awsS3BucketVersioning`
resource and remove `versioning` and its nested arguments in the `awsS3Bucket` resource.

*   If migrating from Terraform AWS Provider `v3700` or later and bucket versioning was never enabled:

    ```typescript
    /*Provider bindings are generated by running cdktf get.
    See https://cdk.tf/provider-generation for more details.*/
    import * as aws from "./.gen/providers/aws";
    const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
      bucket: "yournamehere",
    });
    const awsS3BucketVersioningExample =
      new aws.s3BucketVersioning.S3BucketVersioningA(this, "example_1", {
        bucket: awsS3BucketExample.id,
        versioningConfiguration: {
          status: "Disabled",
        },
      });
    /*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
    awsS3BucketVersioningExample.overrideLogicalId("example");

    ```

*   If migrating from Terraform AWS Provider `v3700` or later and bucket versioning was enabled at one point:

    ```typescript
    /*Provider bindings are generated by running cdktf get.
    See https://cdk.tf/provider-generation for more details.*/
    import * as aws from "./.gen/providers/aws";
    const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
      bucket: "yournamehere",
    });
    const awsS3BucketVersioningExample =
      new aws.s3BucketVersioning.S3BucketVersioningA(this, "example_1", {
        bucket: awsS3BucketExample.id,
        versioningConfiguration: {
          status: "Suspended",
        },
      });
    /*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
    awsS3BucketVersioningExample.overrideLogicalId("example");

    ```

*   If migrating from an earlier version of Terraform AWS Provider:

    ```typescript
    /*Provider bindings are generated by running cdktf get.
    See https://cdk.tf/provider-generation for more details.*/
    import * as aws from "./.gen/providers/aws";
    const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
      bucket: "yournamehere",
    });
    const awsS3BucketVersioningExample =
      new aws.s3BucketVersioning.S3BucketVersioningA(this, "example_1", {
        bucket: awsS3BucketExample.id,
        versioningConfiguration: {
          status: "Suspended",
        },
      });
    /*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
    awsS3BucketVersioningExample.overrideLogicalId("example");

    ```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_versioning.example yournamehere
aws_s3_bucket_versioning.example: Importing from ID "yournamehere"...
aws_s3_bucket_versioning.example: Import prepared!
  Prepared aws_s3_bucket_versioning for import
aws_s3_bucket_versioning.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

#### Ensure Objects Depend on Versioning

When you create an object whose `versionId` you need and an `awsS3BucketVersioning` resource in the same configuration, you are more likely to have success by ensuring the `s3Object` depends either implicitly (see below) or explicitly (i.e., using `dependsOn = [awsS3BucketVersioningExample]`) on the `awsS3BucketVersioning` resource.

\~> **NOTE:** For critical and/or production S3 objects, do not create a bucket, enable versioning, and create an object in the bucket within the same configuration. Doing so will not allow the AWS-recommended 15 minutes between enabling versioning and writing to the bucket.

This example shows the `awsS3ObjectExample` depending implicitly on the versioning resource through the reference to `awsS3BucketVersioningExampleBucket` to define `bucket`:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yotto",
});
const awsS3BucketVersioningExample =
  new aws.s3BucketVersioning.S3BucketVersioningA(this, "example_1", {
    bucket: awsS3BucketExample.id,
    versioningConfiguration: {
      status: "Enabled",
    },
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketVersioningExample.overrideLogicalId("example");
const awsS3ObjectExample = new aws.s3Object.S3Object(this, "example_2", {
  bucket: awsS3BucketVersioningExample.bucket,
  key: "droeloe",
  source: "example.txt",
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3ObjectExample.overrideLogicalId("example");

```

### `website`, `websiteDomain`, and `websiteEndpoint` Arguments

Switch your Terraform configuration to the [`awsS3BucketWebsiteConfiguration` resource](/docs/providers/aws/r/s3_bucket_website_configuration.html) instead.

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
  website: {
    errorDocument: "error.html",
    indexDocument: "index.html",
  },
});

```

You will get the following error after upgrading:

```console
│ Error: Value for unconfigurable attribute
│
│   with aws_s3_bucket.example,
│   on main.tf line 1, in resource "aws_s3_bucket" "example":
│    1: resource "aws_s3_bucket" "example" {
│
│ Can't configure a value for "website": its value will be decided automatically based on the result of applying this configuration.
```

Since `website` is now read only, update your configuration to use the `awsS3BucketWebsiteConfiguration`
resource and remove `website` and its nested arguments in the `awsS3Bucket` resource:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "yournamehere",
});
const awsS3BucketWebsiteConfigurationExample =
  new aws.s3BucketWebsiteConfiguration.S3BucketWebsiteConfiguration(
    this,
    "example_1",
    {
      bucket: awsS3BucketExample.id,
      errorDocument: {
        key: "error.html",
      },
      indexDocument: {
        suffix: "index.html",
      },
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketWebsiteConfigurationExample.overrideLogicalId("example");

```

Run `terraformImport` on each new resource, *e.g.*,

```shell
$ terraform import aws_s3_bucket_website_configuration.example yournamehere
aws_s3_bucket_website_configuration.example: Importing from ID "yournamehere"...
aws_s3_bucket_website_configuration.example: Import prepared!
  Prepared aws_s3_bucket_website_configuration for import
aws_s3_bucket_website_configuration.example: Refreshing state... [id=yournamehere]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

For example, if you use the `awsS3Bucket` attribute `websiteDomain` with `awsRoute53Record`, as shown below, you will need to update your configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsRoute53ZoneMain = new aws.route53Zone.Route53Zone(this, "main", {
  name: "domain.test",
});
const awsS3BucketWebsite = new aws.s3Bucket.S3Bucket(this, "website", {
  website: {
    errorDocument: "error.html",
    indexDocument: "index.html",
  },
});
new aws.route53Record.Route53Record(this, "alias", {
  alias: {
    evaluateTargetHealth: true,
    name: awsS3BucketWebsite.websiteDomain,
    zoneId: awsS3BucketWebsite.hostedZoneId,
  },
  name: "www",
  type: "A",
  zoneId: awsRoute53ZoneMain.zoneId,
});

```

Instead, you will now use the `awsS3BucketWebsiteConfiguration` resource and its `websiteDomain` attribute:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsRoute53ZoneMain = new aws.route53Zone.Route53Zone(this, "main", {
  name: "domain.test",
});
const awsS3BucketWebsite = new aws.s3Bucket.S3Bucket(this, "website", {});
const awsS3BucketWebsiteConfigurationExample =
  new aws.s3BucketWebsiteConfiguration.S3BucketWebsiteConfiguration(
    this,
    "example",
    {
      bucket: awsS3BucketWebsite.id,
      indexDocument: {
        suffix: "index.html",
      },
    }
  );
new aws.route53Record.Route53Record(this, "alias", {
  alias: {
    evaluateTargetHealth: true,
    name: awsS3BucketWebsiteConfigurationExample.websiteDomain,
    zoneId: awsS3BucketWebsite.hostedZoneId,
  },
  name: "www",
  type: "A",
  zoneId: awsRoute53ZoneMain.zoneId,
});

```

## Full Resource Lifecycle of Default Resources

Default subnets and vpcs can now do full resource lifecycle operations such that resource
creation and deletion are now supported.

### Resource: aws\_default\_subnet

The `awsDefaultSubnet` resource behaves differently from normal resources in that if a default subnet exists in the specified Availability Zone, Terraform does not *create* this resource, but instead "adopts" it into management.
If no default subnet exists, Terraform creates a new default subnet.
By default, `terraformDestroy` does not delete the default subnet but does remove the resource from Terraform state.
Set the `forceDestroy` argument to `true` to delete the default subnet.

For example, given this previous configuration with no existing default subnet:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.provider.AwsProvider(this, "aws", {
  region: "eu-west-2",
});
new aws.defaultSubnet.DefaultSubnet(this, "default", {});

```

The following error was thrown on `terraformApply`:

```console
│ Error: Default subnet not found.
│
│   with aws_default_subnet.default,
│   on main.tf line 5, in resource "aws_default_subnet" "default":
│    5: resource "aws_default_subnet" "default" {}
```

Now after upgrading, the above configuration will apply successfully.

To delete the default subnet, the above configuration should be updated as follows:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.defaultSubnet.DefaultSubnet(this, "default", {
  forceDestroy: true,
});

```

### Resource: aws\_default\_vpc

The `awsDefaultVpc` resource behaves differently from normal resources in that if a default VPC exists, Terraform does not *create* this resource, but instead "adopts" it into management.
If no default VPC exists, Terraform creates a new default VPC, which leads to the implicit creation of [other resources](https://docs.aws.amazon.com/vpc/latest/userguide/default-vpc.html#default-vpc-components).
By default, `terraformDestroy` does not delete the default VPC but does remove the resource from Terraform state.
Set the `forceDestroy` argument to `true` to delete the default VPC.

For example, given this previous configuration with no existing default VPC:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.defaultVpc.DefaultVpc(this, "default", {});

```

The following error was thrown on `terraformApply`:

```console
│ Error: No default VPC found in this region.
│
│   with aws_default_vpc.default,
│   on main.tf line 5, in resource "aws_default_vpc" "default":
│    5: resource "aws_default_vpc" "default" {}
```

Now after upgrading, the above configuration will apply successfully.

To delete the default VPC, the above configuration should be updated to:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.defaultVpc.DefaultVpc(this, "default", {
  forceDestroy: true,
});

```

## Plural Data Source Behavior

The following plural data sources are now consistent with [Provider Design](https://hashicorp.github.io/terraform-provider-aws/provider-design/#plural-data-sources)
such that they no longer return an error if zero results are found.

* [aws\_cognito\_user\_pools](/docs/providers/aws/d/cognito_user_pools.html)
* [aws\_db\_event\_categories](/docs/providers/aws/d/db_event_categories.html)
* [aws\_ebs\_volumes](/docs/providers/aws/d/ebs_volumes.html)
* [aws\_ec2\_coip\_pools](/docs/providers/aws/d/ec2_coip_pools.html)
* [aws\_ec2\_local\_gateway\_route\_tables](/docs/providers/aws/d/ec2_local_gateway_route_tables.html)
* [aws\_ec2\_local\_gateway\_virtual\_interface\_groups](/docs/providers/aws/d/ec2_local_gateway_virtual_interface_groups.html)
* [aws\_ec2\_local\_gateways](/docs/providers/aws/d/ec2_local_gateways.html)
* [aws\_ec2\_transit\_gateway\_route\_tables](/docs/providers/aws/d/ec2_transit_gateway_route_tables.html)
* [aws\_efs\_access\_points](/docs/providers/aws/d/efs_access_points.html)
* [aws\_emr\_release\_labels](/docs/providers/aws/d/emr_release_labels.markdown)
* [aws\_inspector\_rules\_packages](/docs/providers/aws/d/inspector_rules_packages.html)
* [aws\_ip\_ranges](/docs/providers/aws/d/ip_ranges.html)
* [aws\_network\_acls](/docs/providers/aws/d/network_acls.html)
* [aws\_route\_tables](/docs/providers/aws/d/route_tables.html)
* [aws\_security\_groups](/docs/providers/aws/d/security_groups.html)
* [aws\_ssoadmin\_instances](/docs/providers/aws/d/ssoadmin_instances.html)
* [aws\_vpcs](/docs/providers/aws/d/vpcs.html)
* [aws\_vpc\_peering\_connections](/docs/providers/aws/d/vpc_peering_connections.html)

## Empty Strings Not Valid For Certain Resources

First, this is a breaking change but should affect very few configurations.

Second, the motivation behind this change is that previously, you might set an argument to `""` to explicitly convey it is empty. However, with the introduction of `null` in Terraform 0.12 and to prepare for continuing enhancements that distinguish between unset arguments and those that have a value, including an empty string (`""`), we are moving away from this use of zero values. We ask practitioners to either use `null` instead or remove the arguments that are set to `""`.

### Resource: aws\_cloudwatch\_event\_target (Empty String)

Previously, you could set `ecsTarget0LaunchType` to `""`. However, the value `""` is no longer valid. Now, set the argument to `null` (*e.g.*, `launchType =Null`) or remove the empty-string configuration.

For example, this type of configuration is now not valid:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.cloudwatchEventTarget.CloudwatchEventTarget(this, "example", {
  ecsTarget: {
    launchType: "",
    taskCount: 1,
    taskDefinitionArn: "${aws_ecs_task_definition.task.arn}",
  },
});

```

We fix this configuration by setting `launchType` to `null`:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.cloudwatchEventTarget.CloudwatchEventTarget(this, "example", {
  ecsTarget: {
    launchType: null,
    taskCount: 1,
    taskDefinitionArn: "${aws_ecs_task_definition.task.arn}",
  },
});

```

### Resource: aws\_customer\_gateway

Previously, you could set `ipAddress` to `""`, which would result in an AWS error. However, the provider now also gives an error.

### Resource: aws\_default\_network\_acl

Previously, you could set `egress.*CidrBlock`, `egress.*Ipv6CidrBlock`, `ingress.*CidrBlock`, or `ingress.*Ipv6CidrBlock` to `""`. However, the value `""` is no longer valid. Now, set the argument to `null` (*e.g.*, `ipv6CidrBlock =Null`) or remove the empty-string configuration.

For example, this type of configuration is now not valid:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.defaultNetworkAcl.DefaultNetworkAcl(this, "example", {
  egress: [
    {
      cidrBlock: "0.0.0.0/0",
      ipv6CidrBlock: "",
    },
  ],
});

```

To fix this configuration, we remove the empty-string configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.defaultNetworkAcl.DefaultNetworkAcl(this, "example", {
  egress: [
    {
      cidrBlock: "0.0.0.0/0",
    },
  ],
});

```

### Resource: aws\_default\_route\_table

Previously, you could set `route.*CidrBlock` or `route.*Ipv6CidrBlock` to `""`. However, the value `""` is no longer valid. Now, set the argument to `null` (*e.g.*, `ipv6CidrBlock =Null`) or remove the empty-string configuration.

For example, this type of configuration is now not valid:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.defaultRouteTable.DefaultRouteTable(this, "example", {
  route: [
    {
      cidrBlock: '${local.ipv6 ? "" : local.destination}',
      ipv6CidrBlock: '${local.ipv6 ? local.destination_ipv6 : ""}',
    },
  ],
});

```

We fix this configuration by using `null` instead of an empty string (`""`):

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.defaultRouteTable.DefaultRouteTable(this, "example", {
  route: [
    {
      cidrBlock: "${local.ipv6 ? null : local.destination}",
      ipv6CidrBlock: "${local.ipv6 ? local.destination_ipv6 : null}",
    },
  ],
});

```

### Resource: aws\_default\_vpc (Empty String)

Previously, you could set `ipv6CidrBlock` to `""`. However, the value `""` is no longer valid. Now, set the argument to `null` (*e.g.*, `ipv6CidrBlock =Null`) or remove the empty-string configuration.

### Resource: aws\_instance

Previously, you could set `privateIp` to `""`. However, the value `""` is no longer valid. Now, set the argument to `null` (*e.g.*, `privateIp =Null`) or remove the empty-string configuration.

For example, this type of configuration is now not valid:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.instance.Instance(this, "example", {
  instanceType: "t2.micro",
  privateIp: "",
});

```

We fix this configuration by removing the empty-string configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.instance.Instance(this, "example", {
  instanceType: "t2.micro",
});

```

### Resource: aws\_efs\_mount\_target

Previously, you could set `ipAddress` to `""`. However, the value `""` is no longer valid. Now, set the argument to `null` (*e.g.*, `ipAddress =Null`) or remove the empty-string configuration.

For example, this type of configuration is now not valid: `ipAddress = ""`.

### Resource: aws\_elasticsearch\_domain

Previously, you could set `ebsOptions0VolumeType` to `""`. However, the value `""` is no longer valid. Now, set the argument to `null` (*e.g.*, `volumeType =Null`) or remove the empty-string configuration.

For example, this type of configuration is now not valid:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.elasticsearchDomain.ElasticsearchDomain(this, "example", {
  ebsOptions: {
    ebsEnabled: true,
    volumeSize: "${var.volume_size}",
    volumeType: '${var.volume_size > 0 ? local.volume_type : ""}',
  },
});

```

We fix this configuration by using `null` instead of `""`:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.elasticsearchDomain.ElasticsearchDomain(this, "example", {
  ebsOptions: {
    ebsEnabled: true,
    volumeSize: "${var.volume_size}",
    volumeType: "${var.volume_size > 0 ? local.volume_type : null}",
  },
});

```

### Resource: aws\_network\_acl

Previously, `egress.*CidrBlock`, `egress.*Ipv6CidrBlock`, `ingress.*CidrBlock`, and `ingress.*Ipv6CidrBlock` could be set to `""`. However, the value `""` is no longer valid. Now, set the argument to `null` (*e.g.*, `ipv6CidrBlock =Null`) or remove the empty-string configuration.

For example, this type of configuration is now not valid:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.networkAcl.NetworkAcl(this, "example", {
  egress: [
    {
      cidrBlock: "0.0.0.0/0",
      ipv6CidrBlock: "",
    },
  ],
});

```

We fix this configuration by removing the empty-string configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.networkAcl.NetworkAcl(this, "example", {
  egress: [
    {
      cidrBlock: "0.0.0.0/0",
    },
  ],
});

```

### Resource: aws\_route

Previously, `destinationCidrBlock` and `destinationIpv6CidrBlock` could be set to `""`. However, the value `""` is no longer valid. Now, set the argument to `null` (*e.g.*, `destinationIpv6CidrBlock =Null`) or remove the empty-string configuration.

In addition, now exactly one of `destinationCidrBlock`, `destinationIpv6CidrBlock`, and `destinationPrefixListId` can be set.

For example, this type of configuration for `awsRoute` is now not valid:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.route.Route(this, "example", {
  destinationCidrBlock: '${local.ipv6 ? "" : local.destination}',
  destinationIpv6CidrBlock: '${local.ipv6 ? local.destination_ipv6 : ""}',
  gatewayId: "${aws_internet_gateway.example.id}",
  routeTableId: "${aws_route_table.example.id}",
});

```

We fix this configuration by using `null` instead of an empty-string (`""`):

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.route.Route(this, "example", {
  destinationCidrBlock: "${local.ipv6 ? null : local.destination}",
  destinationIpv6CidrBlock: "${local.ipv6 ? local.destination_ipv6 : null}",
  gatewayId: "${aws_internet_gateway.example.id}",
  routeTableId: "${aws_route_table.example.id}",
});

```

### Resource: aws\_route\_table

Previously, `route.*CidrBlock` and `route.*Ipv6CidrBlock` could be set to `""`. However, the value `""` is no longer valid. Now, set the argument to `null` (*e.g.*, `ipv6CidrBlock =Null`) or remove the empty-string configuration.

For example, this type of configuration is now not valid:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.routeTable.RouteTable(this, "example", {
  route: [
    {
      cidrBlock: '${local.ipv6 ? "" : local.destination}',
      ipv6CidrBlock: '${local.ipv6 ? local.destination_ipv6 : ""}',
    },
  ],
});

```

We fix this configuration by usingd `null` instead of an empty-string (`""`):

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.routeTable.RouteTable(this, "example", {
  route: [
    {
      cidrBlock: "${local.ipv6 ? null : local.destination}",
      ipv6CidrBlock: "${local.ipv6 ? local.destination_ipv6 : null}",
    },
  ],
});

```

### Resource: aws\_vpc

Previously, `ipv6CidrBlock` could be set to `""`. However, the value `""` is no longer valid. Now, set the argument to `null` (*e.g.*, `ipv6CidrBlock =Null`) or remove the empty-string configuration.

For example, this type of configuration is now not valid:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.vpc.Vpc(this, "example", {
  cidrBlock: "10.1.0.0/16",
  ipv6CidrBlock: "",
});

```

We fix this configuration by removing `ipv6CidrBlock`:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.vpc.Vpc(this, "example", {
  cidrBlock: "10.1.0.0/16",
});

```

### Resource: aws\_vpc\_ipv6\_cidr\_block\_association

Previously, `ipv6CidrBlock` could be set to `""`. However, the value `""` is no longer valid. Now, set the argument to `null` (*e.g.*, `ipv6CidrBlock =Null`) or remove the empty-string configuration.

## Data Source: aws\_cloudwatch\_log\_group

### Removal of arn Wildcard Suffix

Previously, the data source returned the ARN directly from the API, which included a `:*` suffix to denote all CloudWatch Log Streams under the CloudWatch Log Group. Most other AWS resources that return ARNs and many other AWS services do not use the `:*` suffix. The suffix is now automatically removed. For example, the data source previously returned an ARN such as `arn:aws:logs:usEast1:123456789012:logGroup:/example:*` but will now return `arn:aws:logs:usEast1:123456789012:logGroup:/example`.

Workarounds, such as using `replace()` as shown below, should be removed:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsCloudwatchLogGroupExample =
  new aws.dataAwsCloudwatchLogGroup.DataAwsCloudwatchLogGroup(this, "example", {
    name: "example",
  });
const awsDatasyncTaskExample = new aws.datasyncTask.DatasyncTask(
  this,
  "example_1",
  {
    cloudwatchLogGroupArn: `\${replace(${dataAwsCloudwatchLogGroupExample.arn}, ":*", "")}`,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsDatasyncTaskExample.overrideLogicalId("example");

```

Removing the `:*` suffix is a breaking change for some configurations. Fix these configurations using string interpolations as demonstrated below. For example, this configuration is now broken:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
  this,
  "ad-log-policy",
  {
    statement: [
      {
        actions: ["logs:CreateLogStream", "logs:PutLogEvents"],
        effect: "Allow",
        principals: [
          {
            identifiers: ["ds.amazonaws.com"],
            type: "Service",
          },
        ],
        resources: ["${data.aws_cloudwatch_log_group.example.arn}"],
      },
    ],
  }
);

```

An updated configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
  this,
  "ad-log-policy",
  {
    statement: [
      {
        actions: ["logs:CreateLogStream", "logs:PutLogEvents"],
        effect: "Allow",
        principals: [
          {
            identifiers: ["ds.amazonaws.com"],
            type: "Service",
          },
        ],
        resources: ["${data.aws_cloudwatch_log_group.example.arn}:*"],
      },
    ],
  }
);

```

## Data Source: aws\_subnet\_ids

The `awsSubnetIds` data source has been deprecated and will be removed in a future version. Use the `awsSubnets` data source instead.

For example, change a configuration such as

```hcl
data "aws_subnet_ids" "example" {
  vpc_id = var.vpc_id
}

data "aws_subnet" "example" {
  for_each = data.aws_subnet_ids.example.ids
  id       = each.value
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.example : s.cidr_block]
}
```

to

```hcl
data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "example" {
  for_each = data.aws_subnets.example.ids
  id       = each.value
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.example : s.cidr_block]
}
```

## Data Source: aws\_s3\_bucket\_object

Version 4.x deprecates the `awsS3BucketObject` data source. Maintainers will remove it in a future version. Use `awsS3Object` instead, where new features and fixes will be added.

## Data Source: aws\_s3\_bucket\_objects

Version 4.x deprecates the `awsS3BucketObjects` data source. Maintainers will remove it in a future version. Use `awsS3Objects` instead, where new features and fixes will be added.

## Resource: aws\_batch\_compute\_environment

You can no longer specify `computeResources` when `type` is `unmanaged`.

Previously, you could apply this configuration and the provider would ignore any compute resources:

```hcl
resource "aws_batch_compute_environment" "test" {
  compute_environment_name = "test"

  compute_resources {
    instance_role = aws_iam_instance_profile.ecs_instance.arn
    instance_type = [
      "c4.large",
    ]
    max_vcpus = 16
    min_vcpus = 0
    security_group_ids = [
      aws_security_group.test.id
    ]
    subnets = [
      aws_subnet.test.id
    ]
    type = "EC2"
  }

  service_role = aws_iam_role.batch_service.arn
  type         = "UNMANAGED"
}
```

Now, this configuration is invalid and will result in an error during plan.

To resolve this error, simply remove or comment out the `computeResources` configuration block.

```hcl
resource "aws_batch_compute_environment" "test" {
  compute_environment_name = "test"

  service_role = aws_iam_role.batch_service.arn
  type         = "UNMANAGED"
}
```

## Resource: aws\_cloudwatch\_event\_target

### Removal of `ecsTarget` `launchType` default value

Previously, the provider assigned `ecsTarget` `launchType` the default value of `ec2` if you did not configure a value. However, the provider no longer assigns a default value.

For example, previously you could workaround the default value by using an empty string (`""`), as shown:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.cloudwatchEventTarget.CloudwatchEventTarget(this, "test", {
  arn: "${aws_ecs_cluster.test.id}",
  ecsTarget: {
    launchType: "",
    networkConfiguration: {
      subnets: ["${aws_subnet.subnet.id}"],
    },
    taskCount: 1,
    taskDefinitionArn: "${aws_ecs_task_definition.task.arn}",
  },
  roleArn: "${aws_iam_role.test.arn}",
  rule: "${aws_cloudwatch_event_rule.test.id}",
});

```

This is no longer necessary. We fix the configuration by removing the empty string assignment:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.cloudwatchEventTarget.CloudwatchEventTarget(this, "test", {
  arn: "${aws_ecs_cluster.test.id}",
  ecsTarget: {
    networkConfiguration: {
      subnets: ["${aws_subnet.subnet.id}"],
    },
    taskCount: 1,
    taskDefinitionArn: "${aws_ecs_task_definition.task.arn}",
  },
  roleArn: "${aws_iam_role.test.arn}",
  rule: "${aws_cloudwatch_event_rule.test.id}",
});

```

## Resource: aws\_elasticache\_cluster

### Error raised if neither `engine` nor `replicationGroupId` is specified

Previously, when you did not specify either `engine` or `replicationGroupId`, Terraform would not prevent you from applying the invalid configuration.
Now, this will produce an error similar to the one below:

```console
Error: Invalid combination of arguments

          with aws_elasticache_cluster.example,
          on terraform_plugin_test.tf line 2, in resource "aws_elasticache_cluster" "example":
           2: resource "aws_elasticache_cluster" "example" {

        "replication_group_id": one of `engine,replication_group_id` must be
        specified

        Error: Invalid combination of arguments

          with aws_elasticache_cluster.example,
          on terraform_plugin_test.tf line 2, in resource "aws_elasticache_cluster" "example":
           2: resource "aws_elasticache_cluster" "example" {

        "engine": one of `engine,replication_group_id` must be specified
```

Update your configuration to supply one of `engine` or `replicationGroupId`.

## Resource: aws\_elasticache\_global\_replication\_group

### actual\_engine\_version Attribute removal

Switch your Terraform configuration from using `actualEngineVersion` to use the `engineVersionActual` attribute instead.

For example, given this previous configuration:

```typescript
import * as cdktf from "cdktf";
new cdktf.TerraformOutput(
  this,
  "elasticache_global_replication_group_version_result",
  {
    value:
      "${aws_elasticache_global_replication_group.example.actual_engine_version}",
  }
);

```

An updated configuration:

```typescript
import * as cdktf from "cdktf";
new cdktf.TerraformOutput(
  this,
  "elasticache_global_replication_group_version_result",
  {
    value:
      "${aws_elasticache_global_replication_group.example.engine_version_actual}",
  }
);

```

## Resource: aws\_fsx\_ontap\_storage\_virtual\_machine

We removed the misspelled argument `activeDirectoryConfiguration0SelfManagedActiveDirectoryConfiguration0OrganizationalUnitDistinguidshedName` that we previously deprecated. Use `activeDirectoryConfiguration0SelfManagedActiveDirectoryConfiguration0OrganizationalUnitDistinguishedName` now instead. Terraform will automatically migrate the state to `activeDirectoryConfiguration0SelfManagedActiveDirectoryConfiguration0OrganizationalUnitDistinguishedName` during planning.

## Resource: aws\_lb\_target\_group

For `protocol = "tcp"`, you can no longer set `stickinessType` to `lbCookie` even when `enabled =False`. Instead, either change the `protocol` to `"http"` or `"https"`, or change `stickinessType` to `"sourceIp"`.

For example, this configuration is no longer valid:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.lbTargetGroup.LbTargetGroup(this, "test", {
  port: 25,
  protocol: "TCP",
  stickiness: {
    enabled: false,
    type: "lb_cookie",
  },
  vpcId: "${aws_vpc.test.id}",
});

```

To fix this, we change the `stickinessType` to `"sourceIp"`.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.lbTargetGroup.LbTargetGroup(this, "test", {
  port: 25,
  protocol: "TCP",
  stickiness: {
    enabled: false,
    type: "source_ip",
  },
  vpcId: "${aws_vpc.test.id}",
});

```

## Resource: aws\_s3\_bucket\_object

Version 4.x deprecates the `awsS3BucketObject` and maintainers will remove it in a future version. Use `awsS3Object` instead, where new features and fixes will be added.

When replacing `awsS3BucketObject` with `awsS3Object` in your configuration, on the next apply, Terraform will recreate the object. If you prefer to not have Terraform recreate the object, import the object using `awsS3Object`.

For example, the following will import an S3 object into state, assuming the configuration exists, as `awsS3ObjectExample`:

```console
% terraform import aws_s3_object.example s3://some-bucket-name/some/key.txt
```

\~> **CAUTION:** We do not recommend modifying the state file manually. If you do, you can make it unusable. However, if you accept that risk, some community members have upgraded to the new resource by searching and replacing `"type": "awsS3BucketObject",` with `"type": "awsS3Object",` in the state file, and then running `terraformApplyRefreshOnly`.

## Resource: aws\_spot\_instance\_request

### instance\_interruption\_behaviour Argument removal

Switch your Terraform configuration from the `instanceInterruptionBehaviour` attribute to the `instanceInterruptionBehavior` attribute instead.

For example, given this previous configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.spotInstanceRequest.SpotInstanceRequest(this, "example", {
  instance_interruption_behaviour: "hibernate",
});

```

An updated configuration:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.spotInstanceRequest.SpotInstanceRequest(this, "example", {
  instanceInterruptionBehavior: "hibernate",
});

```

## EC2-Classic Resource and Data Source Support

While an upgrade to this major version will not directly impact EC2-Classic resources configured with Terraform,
it is important to keep in the mind the following AWS Provider resources will eventually no longer
be compatible with EC2-Classic as AWS completes their EC2-Classic networking retirement (expected around August 15, 2022).

* Running or stopped [EC2 instances](/docs/providers/aws/r/instance.html)
* Running or stopped [RDS database instances](/docs/providers/aws/r/db_instance.html)
* [Elastic IP addresses](/docs/providers/aws/r/eip.html)
* [Classic Load Balancers](/docs/providers/aws/r/lb.html)
* [Redshift clusters](/docs/providers/aws/r/redshift_cluster.html)
* [Elastic Beanstalk environments](/docs/providers/aws/r/elastic_beanstalk_environment.html)
* [EMR clusters](/docs/providers/aws/r/emr_cluster.html)
* [AWS Data Pipelines pipelines](/docs/providers/aws/r/datapipeline_pipeline.html)
* [ElastiCache clusters](/docs/providers/aws/r/elasticache_cluster.html)
* [Spot Requests](/docs/providers/aws/r/spot_instance_request.html)
* [Capacity Reservations](/docs/providers/aws/r/ec2_capacity_reservation.html)
