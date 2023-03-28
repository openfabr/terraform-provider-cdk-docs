---
subcategory: "S3 (Simple Storage)"
layout: "aws"
page_title: "AWS: aws_s3_bucket"
description: |-
  Provides a S3 bucket resource.
---

# Resource: awsS3Bucket

Provides a S3 bucket resource.

\-> This functionality is for managing S3 in an AWS Partition. To manage [S3 on Outposts](https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html), see the [`awsS3ControlBucket`](/docs/providers/aws/r/s3control_bucket.html) resource.

\~> **NOTE on S3 Bucket Accelerate Configuration:** S3 Bucket Accelerate can be configured in either the standalone resource [`awsS3BucketAccelerateConfiguration`](s3_bucket_accelerate_configuration.html)
or with the deprecated parameter `accelerationStatus` in the resource `awsS3Bucket`.
Configuring with both will cause inconsistencies and may overwrite configuration.

\~> **NOTE on S3 Bucket canned ACL Configuration:** S3 Bucket canned ACL can be configured in either the standalone resource [`awsS3BucketAcl`](s3_bucket_acl.html.markdown)
or with the deprecated parameter `acl` in the resource `awsS3Bucket`.
Configuring with both will cause inconsistencies and may overwrite configuration.

\~> **NOTE on S3 Bucket ACL Grants Configuration:** S3 Bucket grants can be configured in either the standalone resource [`awsS3BucketAcl`](s3_bucket_acl.html.markdown)
or with the deprecated parameter `grant` in the resource `awsS3Bucket`.
Configuring with both will cause inconsistencies and may overwrite configuration.

\~> **NOTE on S3 Bucket CORS Configuration:** S3 Bucket CORS can be configured in either the standalone resource [`awsS3BucketCorsConfiguration`](s3_bucket_cors_configuration.html.markdown)
or with the deprecated parameter `corsRule` in the resource `awsS3Bucket`.
Configuring with both will cause inconsistencies and may overwrite configuration.

\~> **NOTE on S3 Bucket Lifecycle Configuration:** S3 Bucket Lifecycle can be configured in either the standalone resource [`awsS3BucketLifecycleConfiguration`](s3_bucket_lifecycle_configuration.html)
or with the deprecated parameter `lifecycleRule` in the resource `awsS3Bucket`.
Configuring with both will cause inconsistencies and may overwrite configuration.

\~> **NOTE on S3 Bucket Logging Configuration:** S3 Bucket logging can be configured in either the standalone resource [`awsS3BucketLogging`](s3_bucket_logging.html.markdown)
or with the deprecated parameter `logging` in the resource `awsS3Bucket`.
Configuring with both will cause inconsistencies and may overwrite configuration.

\~> **NOTE on S3 Bucket Object Lock Configuration:** S3 Bucket Object Lock can be configured in either the standalone resource [`awsS3BucketObjectLockConfiguration`](s3_bucket_object_lock_configuration.html)
or with the deprecated parameter `objectLockConfiguration` in the resource `awsS3Bucket`.
Configuring with both will cause inconsistencies and may overwrite configuration.

\~> **NOTE on S3 Bucket Policy Configuration:** S3 Bucket Policy can be configured in either the standalone resource [`awsS3BucketPolicy`](s3_bucket_policy.html)
or with the deprecated parameter `policy` in the resource `awsS3Bucket`.
Configuring with both will cause inconsistencies and may overwrite configuration.

\~> **NOTE on S3 Bucket Replication Configuration:** S3 Bucket Replication can be configured in either the standalone resource [`awsS3BucketReplicationConfiguration`](s3_bucket_replication_configuration.html)
or with the deprecated parameter `replicationConfiguration` in the resource `awsS3Bucket`.
Configuring with both will cause inconsistencies and may overwrite configuration.

\~> **NOTE on S3 Bucket Request Payment Configuration:** S3 Bucket Request Payment can be configured in either the standalone resource [`awsS3BucketRequestPaymentConfiguration`](s3_bucket_request_payment_configuration.html)
or with the deprecated parameter `requestPayer` in the resource `awsS3Bucket`.
Configuring with both will cause inconsistencies and may overwrite configuration.

\~> **NOTE on S3 Bucket Server Side Encryption Configuration:** S3 Bucket Server Side Encryption can be configured in either the standalone resource [`awsS3BucketServerSideEncryptionConfiguration`](s3_bucket_server_side_encryption_configuration.html)
or with the deprecated parameter `serverSideEncryptionConfiguration` in the resource `awsS3Bucket`.
Configuring with both will cause inconsistencies and may overwrite configuration.

\~> **NOTE on S3 Bucket Versioning Configuration:** S3 Bucket versioning can be configured in either the standalone resource [`awsS3BucketVersioning`](s3_bucket_versioning.html.markdown)
or with the deprecated parameter `versioning` in the resource `awsS3Bucket`.
Configuring with both will cause inconsistencies and may overwrite configuration.

\~> **NOTE on S3 Bucket Website Configuration:** S3 Bucket Website can be configured in either the standalone resource [`awsS3BucketWebsiteConfiguration`](s3_bucket_website_configuration.html.markdown)
or with the deprecated parameter `website` in the resource `awsS3Bucket`.
Configuring with both will cause inconsistencies and may overwrite configuration.

## Example Usage

### Private Bucket w/ Tags

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketB = new aws.s3Bucket.S3Bucket(this, "b", {
  bucket: "my-tf-test-bucket",
  tags: {
    Environment: "Dev",
    Name: "My bucket",
  },
});
new aws.s3BucketAcl.S3BucketAcl(this, "example", {
  acl: "private",
  bucket: awsS3BucketB.id,
});

```

### Static Website Hosting

\-> **NOTE:** The parameter `website` is deprecated.
Use the resource [`awsS3BucketWebsiteConfiguration`](s3_bucket_website_configuration.html.markdown) instead.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "b", {
  acl: "public-read",
  bucket: "s3-website-test.hashicorp.com",
  policy: '${file("policy.json")}',
  website: {
    errorDocument: "error.html",
    indexDocument: "index.html",
    routingRules:
      '[{\n    "Condition": {\n        "KeyPrefixEquals": "docs/"\n    },\n    "Redirect": {\n        "ReplaceKeyPrefixWith": "documents/"\n    }\n}]\n',
  },
});

```

### Using CORS

\-> **NOTE:** The parameter `corsRule` is deprecated.
Use the resource [`awsS3BucketCorsConfiguration`](s3_bucket_cors_configuration.html.markdown) instead.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "b", {
  acl: "public-read",
  bucket: "s3-website-test.hashicorp.com",
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

### Using versioning

\-> **NOTE:** The parameter `versioning` is deprecated.
Use the resource [`awsS3BucketVersioning`](s3_bucket_versioning.html.markdown) instead.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "b", {
  acl: "private",
  bucket: "my-tf-test-bucket",
  versioning: {
    enabled: true,
  },
});

```

### Enable Logging

\-> **NOTE:** The parameter `logging` is deprecated.
Use the resource [`awsS3BucketLogging`](s3_bucket_logging.html.markdown) instead.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketLogBucket = new aws.s3Bucket.S3Bucket(this, "log_bucket", {
  acl: "log-delivery-write",
  bucket: "my-tf-log-bucket",
});
new aws.s3Bucket.S3Bucket(this, "b", {
  acl: "private",
  bucket: "my-tf-test-bucket",
  logging: {
    targetBucket: awsS3BucketLogBucket.id,
    targetPrefix: "log/",
  },
});

```

### Using object lifecycle

\-> **NOTE:** The parameter `lifecycleRule` is deprecated.
Use the resource [`awsS3BucketLifecycleConfiguration`](s3_bucket_lifecycle_configuration.html) instead.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "bucket", {
  acl: "private",
  bucket: "my-bucket",
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
        date: "2016-01-12",
      },
      id: "tmp",
      prefix: "tmp/",
    },
  ],
});
new aws.s3Bucket.S3Bucket(this, "versioning_bucket", {
  acl: "private",
  bucket: "my-versioning-bucket",
  lifecycleRule: [
    {
      enabled: true,
      noncurrentVersionExpiration: {
        days: 90,
      },
      noncurrentVersionTransition: [
        {
          days: 30,
          storageClass: "STANDARD_IA",
        },
        {
          days: 60,
          storageClass: "GLACIER",
        },
      ],
      prefix: "config/",
    },
  ],
  versioning: {
    enabled: true,
  },
});

```

### Using object lock configuration

\-> **NOTE:** The parameter `objectLockConfiguration` is deprecated.
To **enable** Object Lock on a **new** bucket, use the `objectLockEnabled` argument in **this** resource.
To configure the default retention rule of the Object Lock configuration use the resource [`awsS3BucketObjectLockConfiguration` resource](s3_bucket_object_lock_configuration.html.markdown) instead.
To **enable** Object Lock on an **existing** bucket, please contact AWS Support and refer to the [Object lock configuration for an existing bucket](s3_bucket_object_lock_configuration.html.markdown#object-lock-configuration-for-an-existing-bucket) example for more details.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "my-tf-example-bucket",
  objectLockConfiguration: {
    objectLockEnabled: "Enabled",
    rule: {
      defaultRetention: {
        days: 5,
        mode: "COMPLIANCE",
      },
    },
  },
});

```

### Using replication configuration

\-> **NOTE:** The parameter `replicationConfiguration` is deprecated.
Use the resource [`awsS3BucketReplicationConfiguration`](s3_bucket_replication_configuration.html) instead.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.provider.AwsProvider(this, "aws", {
  region: "eu-west-1",
});
const awsCentral = new aws.provider.AwsProvider(this, "aws_1", {
  alias: "central",
  region: "eu-central-1",
});
const awsS3BucketDestination = new aws.s3Bucket.S3Bucket(this, "destination", {
  bucket: "tf-test-bucket-destination-12345",
  versioning: {
    enabled: true,
  },
});
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
              identifiers: ["s3.amazonaws.com"],
              type: "Service",
            },
          ],
        },
      ],
    }
  );
const awsIamRoleReplication = new aws.iamRole.IamRole(this, "replication", {
  assumeRolePolicy: dataAwsIamPolicyDocumentAssumeRole.json,
  name: "tf-iam-role-replication-12345",
});
const awsS3BucketSource = new aws.s3Bucket.S3Bucket(this, "source", {
  acl: "private",
  bucket: "tf-test-bucket-source-12345",
  provider: `\${${awsCentral.fqn}}`,
  replicationConfiguration: {
    role: awsIamRoleReplication.arn,
    rules: [
      {
        destination: {
          bucket: awsS3BucketDestination.arn,
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
  versioning: {
    enabled: true,
  },
});
const dataAwsIamPolicyDocumentReplication =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "replication_6",
    {
      statement: [
        {
          actions: ["s3:GetReplicationConfiguration", "s3:ListBucket"],
          effect: "Allow",
          resources: [awsS3BucketSource.arn],
        },
        {
          actions: [
            "s3:GetObjectVersionForReplication",
            "s3:GetObjectVersionAcl",
            "s3:GetObjectVersionTagging",
          ],
          effect: "Allow",
          resources: [`\${${awsS3BucketSource.arn}}/*`],
        },
        {
          actions: [
            "s3:ReplicateObject",
            "s3:ReplicateDelete",
            "s3:ReplicateTags",
          ],
          effect: "Allow",
          resources: [`\${${awsS3BucketDestination.arn}}/*`],
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAwsIamPolicyDocumentReplication.overrideLogicalId("replication");
const awsIamPolicyReplication = new aws.iamPolicy.IamPolicy(
  this,
  "replication_7",
  {
    name: "tf-iam-role-policy-replication-12345",
    policy: dataAwsIamPolicyDocumentReplication.json,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamPolicyReplication.overrideLogicalId("replication");
const awsIamRolePolicyAttachmentReplication =
  new aws.iamRolePolicyAttachment.IamRolePolicyAttachment(
    this,
    "replication_8",
    {
      policyArn: awsIamPolicyReplication.arn,
      role: awsIamRoleReplication.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamRolePolicyAttachmentReplication.overrideLogicalId("replication");

```

### Enable SSE-KMS Server Side Encryption

\-> **NOTE:** The parameter `serverSideEncryptionConfiguration` is deprecated.
Use the resource [`awsS3BucketServerSideEncryptionConfiguration`](s3_bucket_server_side_encryption_configuration.html) instead.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsKmsKeyMykey = new aws.kmsKey.KmsKey(this, "mykey", {
  deletionWindowInDays: 10,
  description: "This key is used to encrypt bucket objects",
});
new aws.s3Bucket.S3Bucket(this, "mybucket", {
  bucket: "mybucket",
  serverSideEncryptionConfiguration: {
    rule: {
      applyServerSideEncryptionByDefault: {
        kmsMasterKeyId: awsKmsKeyMykey.arn,
        sseAlgorithm: "aws:kms",
      },
    },
  },
});

```

### Using ACL policy grants

\-> **NOTE:** The parameters `acl` and `grant` are deprecated.
Use the resource [`awsS3BucketAcl`](s3_bucket_acl.html.markdown) instead.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsCanonicalUserIdCurrentUser =
  new aws.dataAwsCanonicalUserId.DataAwsCanonicalUserId(
    this,
    "current_user",
    {}
  );
new aws.s3Bucket.S3Bucket(this, "bucket", {
  bucket: "mybucket",
  grant: [
    {
      id: dataAwsCanonicalUserIdCurrentUser.id,
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

## Argument Reference

The following arguments are supported:

* `bucket` - (Optional, Forces new resource) Name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length. A full list of bucket naming rules [may be found here](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html).
* `bucketPrefix` - (Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. Conflicts with `bucket`. Must be lowercase and less than or equal to 37 characters in length. A full list of bucket naming rules [may be found here](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html).
* `accelerationStatus` - (Optional, **Deprecated**) Sets the accelerate configuration of an existing bucket. Can be `enabled` or `suspended`. Cannot be used in `cnNorth1` or `usGovWest1`. Terraform will only perform drift detection if a configuration value is provided.
  Use the resource [`awsS3BucketAccelerateConfiguration`](s3_bucket_accelerate_configuration.html) instead.
* `acl` - (Optional, **Deprecated**) The [canned ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) to apply. Valid values are `private`, `publicRead`, `publicReadWrite`, `awsExecRead`, `authenticatedRead`, and `logDeliveryWrite`. Defaults to `private`.  Conflicts with `grant`. Terraform will only perform drift detection if a configuration value is provided. Use the resource [`awsS3BucketAcl`](s3_bucket_acl.html.markdown) instead.
* `grant` - (Optional, **Deprecated**) An [ACL policy grant](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#sample-acl). See [Grant](#grant) below for details. Conflicts with `acl`. Terraform will only perform drift detection if a configuration value is provided. Use the resource [`awsS3BucketAcl`](s3_bucket_acl.html.markdown) instead.
* `corsRule` - (Optional, **Deprecated**) Rule of [Cross-Origin Resource Sharing](https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html). See [CORS rule](#cors-rule) below for details. Terraform will only perform drift detection if a configuration value is provided. Use the resource [`awsS3BucketCorsConfiguration`](s3_bucket_cors_configuration.html.markdown) instead.
* `forceDestroy` - (Optional, Default:`false`) Boolean that indicates all objects (including any [locked objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock-overview.html)) should be deleted from the bucket *when the bucket is destroyed* so that the bucket can be destroyed without error. These objects are *not* recoverable. This only deletes objects when the bucket is destroyed, *not* when setting this parameter to `true`. Once this parameter is set to `true`, there must be a successful `terraformApply` run before a destroy is required to update this value in the resource state. Without a successful `terraformApply` after this parameter is set, this flag will have no effect. If setting this field in the same operation that would require replacing the bucket or destroying the bucket, this flag will not work. Additionally when importing a bucket, a successful `terraformApply` is required to set this value in state before it will take effect on a destroy operation.
* `lifecycleRule` - (Optional, **Deprecated**) Configuration of [object lifecycle management](http://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html). See [Lifecycle Rule](#lifecycle-rule) below for details. Terraform will only perform drift detection if a configuration value is provided.
  Use the resource [`awsS3BucketLifecycleConfiguration`](s3_bucket_lifecycle_configuration.html) instead.
* `logging` - (Optional, **Deprecated**) Configuration of [S3 bucket logging](https://docs.aws.amazon.com/AmazonS3/latest/UG/ManagingBucketLogging.html) parameters. See [Logging](#logging) below for details. Terraform will only perform drift detection if a configuration value is provided.
  Use the resource [`awsS3BucketLogging`](s3_bucket_logging.html.markdown) instead.
* `objectLockEnabled` - (Optional, Forces new resource) Indicates whether this bucket has an Object Lock configuration enabled. Valid values are `true` or `false`. This argument is not supported in all regions or partitions.
* `objectLockConfiguration` - (Optional, **Deprecated**) Configuration of [S3 object locking](https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html). See [Object Lock Configuration](#object-lock-configuration) below for details.
  Terraform wil only perform drift detection if a configuration value is provided.
  Use the `objectLockEnabled` parameter and the resource [`awsS3BucketObjectLockConfiguration`](s3_bucket_object_lock_configuration.html.markdown) instead.
* `policy` - (Optional, **Deprecated**) Valid [bucket policy](https://docs.aws.amazon.com/AmazonS3/latest/dev/example-bucket-policies.html) JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a `terraformPlan`. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the [AWS IAM Policy Document Guide](https://learn.hashicorp.com/terraform/aws/iam-policy).
  Terraform will only perform drift detection if a configuration value is provided.
  Use the resource [`awsS3BucketPolicy`](s3_bucket_policy.html) instead.
* `replicationConfiguration` - (Optional, **Deprecated**) Configuration of [replication configuration](http://docs.aws.amazon.com/AmazonS3/latest/dev/crr.html). See [Replication Configuration](#replication-configuration) below for details. Terraform will only perform drift detection if a configuration value is provided.
  Use the resource [`awsS3BucketReplicationConfiguration`](s3_bucket_replication_configuration.html) instead.
* `requestPayer` - (Optional, **Deprecated**) Specifies who should bear the cost of Amazon S3 data transfer.
  Can be either `bucketOwner` or `requester`. By default, the owner of the S3 bucket would incur the costs of any data transfer.
  See [Requester Pays Buckets](http://docs.aws.amazon.com/AmazonS3/latest/dev/RequesterPaysBuckets.html) developer guide for more information.
  Terraform will only perform drift detection if a configuration value is provided.
  Use the resource [`awsS3BucketRequestPaymentConfiguration`](s3_bucket_request_payment_configuration.html) instead.
* `serverSideEncryptionConfiguration` - (Optional, **Deprecated**) Configuration of [server-side encryption configuration](http://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html). See [Server Side Encryption Configuration](#server-side-encryption-configuration) below for details.
  Terraform will only perform drift detection if a configuration value is provided.
  Use the resource [`awsS3BucketServerSideEncryptionConfiguration`](s3_bucket_server_side_encryption_configuration.html) instead.
* `versioning` - (Optional, **Deprecated**) Configuration of the [S3 bucket versioning state](https://docs.aws.amazon.com/AmazonS3/latest/dev/Versioning.html). See [Versioning](#versioning) below for details. Terraform will only perform drift detection if a configuration value is provided. Use the resource [`awsS3BucketVersioning`](s3_bucket_versioning.html.markdown) instead.
* `website` - (Optional, **Deprecated**) Configuration of the [S3 bucket website](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html). See [Website](#website) below for details. Terraform will only perform drift detection if a configuration value is provided.
  Use the resource [`awsS3BucketWebsiteConfiguration`](s3_bucket_website_configuration.html.markdown) instead.
* `tags` - (Optional) Map of tags to assign to the bucket. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### CORS Rule

\~> **NOTE:** Currently, changes to the `corsRule` configuration of *existing* resources cannot be automatically detected by Terraform. To manage changes of CORS rules to an S3 bucket, use the `awsS3BucketCorsConfiguration` resource instead. If you use `corsRule` on an `awsS3Bucket`, Terraform will assume management over the full set of CORS rules for the S3 bucket, treating additional CORS rules as drift. For this reason, `corsRule` cannot be mixed with the external `awsS3BucketCorsConfiguration` resource for a given S3 bucket.

The `corsRule` configuration block supports the following arguments:

* `allowedHeaders` - (Optional) List of headers allowed.
* `allowedMethods` - (Required) One or more HTTP methods that you allow the origin to execute. Can be `get`, `put`, `post`, `delete` or `head`.
* `allowedOrigins` - (Required) One or more origins you want customers to be able to access the bucket from.
* `exposeHeaders` - (Optional) One or more headers in the response that you want customers to be able to access from their applications (for example, from a JavaScript `xmlHttpRequest` object).
* `maxAgeSeconds` - (Optional) Specifies time in seconds that browser can cache the response for a preflight request.

### Grant

\~> **NOTE:** Currently, changes to the `grant` configuration of *existing* resources cannot be automatically detected by Terraform. To manage changes of ACL grants to an S3 bucket, use the `awsS3BucketAcl` resource instead. If you use `grant` on an `awsS3Bucket`, Terraform will assume management over the full set of ACL grants for the S3 bucket, treating additional ACL grants as drift. For this reason, `grant` cannot be mixed with the external `awsS3BucketAcl` resource for a given S3 bucket.

The `grant` configuration block supports the following arguments:

* `id` - (Optional) Canonical user id to grant for. Used only when `type` is `canonicalUser`.
* `type` - (Required) Type of grantee to apply for. Valid values are `canonicalUser` and `group`. `amazonCustomerByEmail` is not supported.
* `permissions` - (Required) List of permissions to apply for grantee. Valid values are `read`, `write`, `READ_ACP`, `WRITE_ACP`, `FULL_CONTROL`.
* `uri` - (Optional) Uri address to grant for. Used only when `type` is `group`.

### Lifecycle Rule

\~> **NOTE:** Currently, changes to the `lifecycleRule` configuration of *existing* resources cannot be automatically detected by Terraform. To manage changes of Lifecycle rules to an S3 bucket, use the `awsS3BucketLifecycleConfiguration` resource instead. If you use `lifecycleRule` on an `awsS3Bucket`, Terraform will assume management over the full set of Lifecycle rules for the S3 bucket, treating additional Lifecycle rules as drift. For this reason, `lifecycleRule` cannot be mixed with the external `awsS3BucketLifecycleConfiguration` resource for a given S3 bucket.

\~> **NOTE:** At least one of `abortIncompleteMultipartUploadDays`, `expiration`, `transition`, `noncurrentVersionExpiration`, `noncurrentVersionTransition` must be specified.

The `lifecycleRule` configuration block supports the following arguments:

* `id` - (Optional) Unique identifier for the rule. Must be less than or equal to 255 characters in length.
* `prefix` - (Optional) Object key prefix identifying one or more objects to which the rule applies.
* `tags` - (Optional) Specifies object tags key and value.
* `enabled` - (Required) Specifies lifecycle rule status.
* `abortIncompleteMultipartUploadDays` (Optional) Specifies the number of days after initiating a multipart upload when the multipart upload must be completed.
* `expiration` - (Optional) Specifies a period in the object's expire. See [Expiration](#expiration) below for details.
* `transition` - (Optional) Specifies a period in the object's transitions. See [Transition](#transition) below for details.
* `noncurrentVersionExpiration` - (Optional) Specifies when noncurrent object versions expire. See [Noncurrent Version Expiration](#noncurrent-version-expiration) below for details.
* `noncurrentVersionTransition` - (Optional) Specifies when noncurrent object versions transitions. See [Noncurrent Version Transition](#noncurrent-version-transition) below for details.

### Expiration

The `expiration` configuration block supports the following arguments:

* `date` - (Optional) Specifies the date after which you want the corresponding action to take effect.
* `days` - (Optional) Specifies the number of days after object creation when the specific rule action takes effect.
* `expiredObjectDeleteMarker` - (Optional) On a versioned bucket (versioning-enabled or versioning-suspended bucket), you can add this element in the lifecycle configuration to direct Amazon S3 to delete expired object delete markers. This cannot be specified with Days or Date in a Lifecycle Expiration Policy.

### Transition

The `transition` configuration block supports the following arguments:

* `date` - (Optional) Specifies the date after which you want the corresponding action to take effect.
* `days` - (Optional) Specifies the number of days after object creation when the specific rule action takes effect.
* `storageClass` - (Required) Specifies the Amazon S3 [storage class](https://docs.aws.amazon.com/AmazonS3/latest/API/API_Transition.html#AmazonS3-Type-Transition-StorageClass) to which you want the object to transition.

### Noncurrent Version Expiration

The `noncurrentVersionExpiration` configuration block supports the following arguments:

* `days` - (Required) Specifies the number of days noncurrent object versions expire.

### Noncurrent Version Transition

The `noncurrentVersionTransition` configuration supports the following arguments:

* `days` - (Required) Specifies the number of days noncurrent object versions transition.
* `storageClass` - (Required) Specifies the Amazon S3 [storage class](https://docs.aws.amazon.com/AmazonS3/latest/API/API_Transition.html#AmazonS3-Type-Transition-StorageClass) to which you want the object to transition.

### Logging

\~> **NOTE:** Currently, changes to the `logging` configuration of *existing* resources cannot be automatically detected by Terraform. To manage changes of logging parameters to an S3 bucket, use the `awsS3BucketLogging` resource instead. If you use `logging` on an `awsS3Bucket`, Terraform will assume management over the full set of logging parameters for the S3 bucket, treating additional logging parameters as drift. For this reason, `logging` cannot be mixed with the external `awsS3BucketLogging` resource for a given S3 bucket.

The `logging` configuration block supports the following arguments:

* `targetBucket` - (Required) Name of the bucket that will receive the log objects.
* `targetPrefix` - (Optional) To specify a key prefix for log objects.

### Object Lock Configuration

\~> **NOTE:** You can only **enable** S3 Object Lock for **new** buckets. If you need to **enable** S3 Object Lock for an **existing** bucket, please contact AWS Support.
When you create a bucket with S3 Object Lock enabled, Amazon S3 automatically enables versioning for the bucket.
Once you create a bucket with S3 Object Lock enabled, you can't disable Object Lock or suspend versioning for the bucket.

\~> **NOTE:** Currently, changes to the `objectLockConfiguration` configuration of *existing* resources cannot be automatically detected by Terraform. To manage changes of Object Lock settings to an S3 bucket, use the `awsS3BucketObjectLockConfiguration` resource instead. If you use `objectLockConfiguration` on an `awsS3Bucket`, Terraform will assume management over the full set of Object Lock configuration parameters for the S3 bucket, treating additional Object Lock configuration parameters as drift. For this reason, `objectLockConfiguration` cannot be mixed with the external `awsS3BucketObjectLockConfiguration` resource for a given S3 bucket.

The `objectLockConfiguration` configuration block supports the following arguments:

* `objectLockEnabled` - (Optional, **Deprecated**) Indicates whether this bucket has an Object Lock configuration enabled. Valid value is `enabled`. Use the top-level argument `objectLockEnabled` instead.
* `rule` - (Optional) Object Lock rule in place for this bucket ([documented below](#rule)).

#### Rule

The `rule` configuration block supports the following argument:

* `defaultRetention` - (Required) Default retention period that you want to apply to new objects placed in this bucket ([documented below](#default-retention)).

#### Default Retention

The `defaultRetention` configuration block supports the following arguments:

\~> **NOTE:** Either `days` or `years` must be specified, but not both.

* `mode` - (Required) Default Object Lock retention mode you want to apply to new objects placed in this bucket. Valid values are `governance` and `compliance`.
* `days` - (Optional) Number of days that you want to specify for the default retention period.
* `years` - (Optional) Number of years that you want to specify for the default retention period.

### Replication Configuration

\~> **NOTE:** Currently, changes to the `replicationConfiguration` configuration of *existing* resources cannot be automatically detected by Terraform. To manage replication configuration changes to an S3 bucket, use the `awsS3BucketReplicationConfiguration` resource instead. If you use `replicationConfiguration` on an `awsS3Bucket`, Terraform will assume management over the full replication configuration for the S3 bucket, treating additional replication configuration rules as drift. For this reason, `replicationConfiguration` cannot be mixed with the external `awsS3BucketReplicationConfiguration` resource for a given S3 bucket.

The `replicationConfiguration` configuration block supports the following arguments:

* `role` - (Required) ARN of the IAM role for Amazon S3 to assume when replicating the objects.
* `rules` - (Required) Specifies the rules managing the replication ([documented below](#rules)).

#### Rules

The `rules` configuration block supports the following arguments:

\~> **NOTE:** Amazon S3's latest version of the replication configuration is V2, which includes the `filter` attribute for replication rules.
With the `filter` attribute, you can specify object filters based on the object key prefix, tags, or both to scope the objects that the rule applies to.
Replication configuration V1 supports filtering based on only the `prefix` attribute. For backwards compatibility, Amazon S3 continues to support the V1 configuration.

* `deleteMarkerReplicationStatus` - (Optional) Whether delete markers are replicated. The only valid value is `enabled`. To disable, omit this argument. This argument is only valid with V2 replication configurations (i.e., when `filter` is used).
* `destination` - (Required) Specifies the destination for the rule ([documented below](#destination)).
* `filter` - (Optional, Conflicts with `prefix`) Filter that identifies subset of objects to which the replication rule applies ([documented below](#filter)).
* `id` - (Optional) Unique identifier for the rule. Must be less than or equal to 255 characters in length.
* `prefix` - (Optional, Conflicts with `filter`) Object keyname prefix identifying one or more objects to which the rule applies. Must be less than or equal to 1024 characters in length.
* `priority` - (Optional) Priority associated with the rule. Priority should only be set if `filter` is configured. If not provided, defaults to `0`. Priority must be unique between multiple rules.
* `sourceSelectionCriteria` - (Optional) Specifies special object selection criteria ([documented below](#source-selection-criteria)).
* `status` - (Required) Status of the rule. Either `enabled` or `disabled`. The rule is ignored if status is not Enabled.

#### Filter

The `filter` configuration block supports the following arguments:

* `prefix` - (Optional) Object keyname prefix that identifies subset of objects to which the rule applies. Must be less than or equal to 1024 characters in length.
* `tags` - (Optional)  A map of tags that identifies subset of objects to which the rule applies.
  The rule applies only to objects having all the tags in its tagset.

#### Destination

\~> **NOTE:** Replication to multiple destination buckets requires that `priority` is specified in the `rules` object. If the corresponding rule requires no filter, an empty configuration block `filter {}` must be specified.

The `destination` configuration block supports the following arguments:

* `bucket` - (Required) ARN of the S3 bucket where you want Amazon S3 to store replicas of the object identified by the rule.
* `storageClass` - (Optional) The [storage class](https://docs.aws.amazon.com/AmazonS3/latest/API/API_Destination.html#AmazonS3-Type-Destination-StorageClass) used to store the object. By default, Amazon S3 uses the storage class of the source object to create the object replica.
* `replicaKmsKeyId` - (Optional) Destination KMS encryption key ARN for SSE-KMS replication. Must be used in conjunction with
  `sseKmsEncryptedObjects` source selection criteria.
* `accessControlTranslation` - (Optional) Specifies the overrides to use for object owners on replication. Must be used in conjunction with `accountId` owner override configuration.
* `accountId` - (Optional) Account ID to use for overriding the object owner on replication. Must be used in conjunction with `accessControlTranslation` override configuration.
* `replicationTime` - (Optional) Enables S3 Replication Time Control (S3 RTC) ([documented below](#replication-time)).
* `metrics` - (Optional) Enables replication metrics (required for S3 RTC) ([documented below](#metrics)).

#### Replication Time

The `replicationTime` configuration block supports the following arguments:

* `status` - (Optional) Status of RTC. Either `enabled` or `disabled`.
* `minutes` - (Optional) Threshold within which objects are to be replicated. The only valid value is `15`.

#### Metrics

The `metrics` configuration block supports the following arguments:

* `status` - (Optional) Status of replication metrics. Either `enabled` or `disabled`.
* `minutes` - (Optional) Threshold within which objects are to be replicated. The only valid value is `15`.

#### Source Selection Criteria

The `sourceSelectionCriteria` configuration block supports the following argument:

* `sseKmsEncryptedObjects` - (Optional) Match SSE-KMS encrypted objects ([documented below](#sse-kms-encrypted-objects)). If specified, `replicaKmsKeyId`
  in `destination` must be specified as well.

#### SSE KMS Encrypted Objects

The `sseKmsEncryptedObjects` configuration block supports the following argument:

* `enabled` - (Required) Boolean which indicates if this criteria is enabled.

### Server Side Encryption Configuration

\~> **NOTE:** Currently, changes to the `serverSideEncryptionConfiguration` configuration of *existing* resources cannot be automatically detected by Terraform. To manage changes in encryption of an S3 bucket, use the `awsS3BucketServerSideEncryptionConfiguration` resource instead. If you use `serverSideEncryptionConfiguration` on an `awsS3Bucket`, Terraform will assume management over the encryption configuration for the S3 bucket, treating additional encryption changes as drift. For this reason, `serverSideEncryptionConfiguration` cannot be mixed with the external `awsS3BucketServerSideEncryptionConfiguration` resource for a given S3 bucket.

The `serverSideEncryptionConfiguration` configuration block supports the following argument:

* `rule` - (Required) Single object for server-side encryption by default configuration. (documented below)

The `rule` configuration block supports the following arguments:

* `applyServerSideEncryptionByDefault` - (Required) Single object for setting server-side encryption by default. (documented below)
* `bucketKeyEnabled` - (Optional) Whether or not to use [Amazon S3 Bucket Keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-key.html) for SSE-KMS.

The `applyServerSideEncryptionByDefault` configuration block supports the following arguments:

* `sseAlgorithm` - (Required) Server-side encryption algorithm to use. Valid values are `aes256` and `aws:kms`
* `kmsMasterKeyId` - (Optional) AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of `sseAlgorithm` as `aws:kms`. The default `aws/s3` AWS KMS master key is used if this element is absent while the `sseAlgorithm` is `aws:kms`.

### Versioning

\~> **NOTE:** Currently, changes to the `versioning` configuration of *existing* resources cannot be automatically detected by Terraform. To manage changes of versioning state to an S3 bucket, use the `awsS3BucketVersioning` resource instead. If you use `versioning` on an `awsS3Bucket`, Terraform will assume management over the versioning state of the S3 bucket, treating additional versioning state changes as drift. For this reason, `versioning` cannot be mixed with the external `awsS3BucketVersioning` resource for a given S3 bucket.

The `versioning` configuration block supports the following arguments:

* `enabled` - (Optional) Enable versioning. Once you version-enable a bucket, it can never return to an unversioned state. You can, however, suspend versioning on that bucket.
* `mfaDelete` - (Optional) Enable MFA delete for either `changeTheVersioningStateOfYourBucket` or `permanentlyDeleteAnObjectVersion`. Default is `false`. This cannot be used to toggle this setting but is available to allow managed buckets to reflect the state in AWS

### Website

\~> **NOTE:** Currently, changes to the `website` configuration of *existing* resources cannot be automatically detected by Terraform. To manage changes to the website configuration of an S3 bucket, use the `awsS3BucketWebsiteConfiguration` resource instead. If you use `website` on an `awsS3Bucket`, Terraform will assume management over the configuration of the website of the S3 bucket, treating additional website configuration changes as drift. For this reason, `website` cannot be mixed with the external `awsS3BucketWebsiteConfiguration` resource for a given S3 bucket.

The `website` configuration block supports the following arguments:

* `indexDocument` - (Required, unless using `redirectAllRequestsTo`) Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders.
* `errorDocument` - (Optional) Absolute path to the document to return in case of a 4XX error.
* `redirectAllRequestsTo` - (Optional) Hostname to redirect all website requests for this bucket to. Hostname can optionally be prefixed with a protocol (`http://` or `https://`) to use when redirecting requests. The default is the protocol that is used in the original request.
* `routingRules` - (Optional) JSON array containing [routing rules](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-websiteconfiguration-routingrules.html)
  describing redirect behavior and when redirects are applied.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Name of the bucket.
* `arn` - ARN of the bucket. Will be of format `arn:aws:s3:::bucketname`.
* `bucketDomainName` - Bucket domain name. Will be of format `bucketnameS3AmazonawsCom`.
* `bucketRegionalDomainName` - Bucket region-specific domain name. The bucket domain name including the region name, please refer [here](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region) for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent [redirect issues](https://forums.aws.amazon.com/thread.jspa?threadID=216814) from CloudFront to S3 Origin URL.
* `hostedZoneId` - [Route 53 Hosted Zone ID](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_website_region_endpoints) for this bucket's region.
* `region` - AWS region this bucket resides in.
* `tagsAll` - Map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).
* `websiteEndpoint` - (**Deprecated**) Website endpoint, if the bucket is configured with a website. If not, this will be an empty string. Use the resource [`awsS3BucketWebsiteConfiguration`](s3_bucket_website_configuration.html.markdown) instead.
* `websiteDomain` - (**Deprecated**) Domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string. This is used to create Route 53 alias records. Use the resource [`awsS3BucketWebsiteConfiguration`](s3_bucket_website_configuration.html.markdown) instead.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `20M`)
* `read` - (Default `20M`)
* `update` - (Default `20M`)
* `delete` - (Default `60M`)

## Import

S3 bucket can be imported using the `bucket`, e.g.,

```console
$ terraform import aws_s3_bucket.bucket bucket-name
```
