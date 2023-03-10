---
subcategory: "CodeBuild"
layout: "aws"
page_title: "AWS: aws_codebuild_project"
description: |-
  Provides a CodeBuild Project resource.
---

# Resource: aws\_codebuild\_project

Provides a CodeBuild Project resource. See also the [`awsCodebuildWebhook` resource](/docs/providers/aws/r/codebuild_webhook.html), which manages the webhook to the source (e.g., the "rebuild every time a code change is pushed" option in the CodeBuild web console).

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsIamRoleExample = new aws.iamRole.IamRole(this, "example", {
  assumeRolePolicy:
    '{\n  "Version": "2012-10-17",\n  "Statement": [\n    {\n      "Effect": "Allow",\n      "Principal": {\n        "Service": "codebuild.amazonaws.com"\n      },\n      "Action": "sts:AssumeRole"\n    }\n  ]\n}\n',
  name: "example",
});
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example_1", {
  bucket: "example",
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketExample.overrideLogicalId("example");
const awsS3BucketAclExample = new aws.s3BucketAcl.S3BucketAcl(
  this,
  "example_2",
  {
    acl: "private",
    bucket: awsS3BucketExample.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsS3BucketAclExample.overrideLogicalId("example");
const awsCodebuildProjectExample = new aws.codebuildProject.CodebuildProject(
  this,
  "example_3",
  {
    artifacts: {
      type: "NO_ARTIFACTS",
    },
    buildTimeout: "5",
    cache: {
      location: awsS3BucketExample.bucket,
      type: "S3",
    },
    description: "test_codebuild_project",
    environment: {
      computeType: "BUILD_GENERAL1_SMALL",
      environmentVariable: [
        {
          name: "SOME_KEY1",
          value: "SOME_VALUE1",
        },
        {
          name: "SOME_KEY2",
          type: "PARAMETER_STORE",
          value: "SOME_VALUE2",
        },
      ],
      image: "aws/codebuild/standard:1.0",
      imagePullCredentialsType: "CODEBUILD",
      type: "LINUX_CONTAINER",
    },
    logsConfig: {
      cloudwatchLogs: {
        groupName: "log-group",
        streamName: "log-stream",
      },
      s3Logs: {
        location: `\${${awsS3BucketExample.id}}/build-log`,
        status: "ENABLED",
      },
    },
    name: "test-project",
    serviceRole: awsIamRoleExample.arn,
    source: {
      gitCloneDepth: 1,
      gitSubmodulesConfig: {
        fetchSubmodules: true,
      },
      location: "https://github.com/mitchellh/packer.git",
      type: "GITHUB",
    },
    sourceVersion: "master",
    tags: {
      Environment: "Test",
    },
    vpcConfig: {
      securityGroupIds: [
        "${aws_security_group.example1.id}",
        "${aws_security_group.example2.id}",
      ],
      subnets: ["${aws_subnet.example1.id}", "${aws_subnet.example2.id}"],
      vpcId: "${aws_vpc.example.id}",
    },
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsCodebuildProjectExample.overrideLogicalId("example");
new aws.codebuildProject.CodebuildProject(this, "project-with-cache", {
  artifacts: {
    type: "NO_ARTIFACTS",
  },
  buildTimeout: "5",
  cache: {
    modes: ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"],
    type: "LOCAL",
  },
  description: "test_codebuild_project_cache",
  environment: {
    computeType: "BUILD_GENERAL1_SMALL",
    environmentVariable: [
      {
        name: "SOME_KEY1",
        value: "SOME_VALUE1",
      },
    ],
    image: "aws/codebuild/standard:1.0",
    imagePullCredentialsType: "CODEBUILD",
    type: "LINUX_CONTAINER",
  },
  name: "test-project-cache",
  queuedTimeout: "5",
  serviceRole: awsIamRoleExample.arn,
  source: {
    gitCloneDepth: 1,
    location: "https://github.com/mitchellh/packer.git",
    type: "GITHUB",
  },
  tags: {
    Environment: "Test",
  },
});
const awsIamRolePolicyExample = new aws.iamRolePolicy.IamRolePolicy(
  this,
  "example_5",
  {
    policy: `{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeDhcpOptions",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterfacePermission"
      ],
      "Resource": [
        "arn:aws:ec2:us-east-1:123456789012:network-interface/*"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:Subnet": [
            "\${aws_subnet.example1.arn}",
            "\${aws_subnet.example2.arn}"
          ],
          "ec2:AuthorizedService": "codebuild.amazonaws.com"
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "\${${awsS3BucketExample.arn}}",
        "\${${awsS3BucketExample.arn}}/*"
      ]
    }
  ]
}
`,
    role: awsIamRoleExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamRolePolicyExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are required:

* `artifacts` - (Required) Configuration block. Detailed below.
* `environment` - (Required) Configuration block. Detailed below.
* `name` - (Required) Project's name.
* `serviceRole` - (Required) Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) role that enables AWS CodeBuild to interact with dependent AWS services on behalf of the AWS account.
* `source` - (Required) Configuration block. Detailed below.

The following arguments are optional:

* `badgeEnabled` - (Optional) Generates a publicly-accessible URL for the projects build badge. Available as `badgeUrl` attribute when enabled.
* `buildBatchConfig` - (Optional) Defines the batch build options for the project.
* `buildTimeout` - (Optional) Number of minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed. The default is 60 minutes.
* `cache` - (Optional) Configuration block. Detailed below.
* `concurrentBuildLimit` - (Optional) Specify a maximum number of concurrent builds for the project. The value specified must be greater than 0 and less than the account concurrent running builds limit.
* `description` - (Optional) Short description of the project.
* `fileSystemLocations` - (Optional) A set of file system locations to mount inside the build. File system locations are documented below.
* `encryptionKey` - (Optional) AWS Key Management Service (AWS KMS) customer master key (CMK) to be used for encrypting the build project's build output artifacts.
* `logsConfig` - (Optional) Configuration block. Detailed below.
* `projectVisibility` - (Optional) Specifies the visibility of the project's builds. Possible values are: `publicRead` and `private`. Default value is `private`.
* `resourceAccessRole` - The ARN of the IAM role that enables CodeBuild to access the CloudWatch Logs and Amazon S3 artifacts for the project's builds.
* `queuedTimeout` - (Optional) Number of minutes, from 5 to 480 (8 hours), a build is allowed to be queued before it times out. The default is 8 hours.
* `secondaryArtifacts` - (Optional) Configuration block. Detailed below.
* `secondarySources` - (Optional) Configuration block. Detailed below.
* `secondarySourceVersion` - (Optional) Configuration block. Detailed below.
* `sourceVersion` - (Optional) Version of the build input to be built for this project. If not specified, the latest version is used.
* `tags` - (Optional) Map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `vpcConfig` - (Optional) Configuration block. Detailed below.

### artifacts

* `artifactIdentifier` - (Optional) Artifact identifier. Must be the same specified inside the AWS CodeBuild build specification.
* `bucketOwnerAccess` - (Optional) Specifies the bucket owner's access for objects that another account uploads to their Amazon S3 bucket. By default, only the account that uploads the objects to the bucket has access to these objects. This property allows you to give the bucket owner access to these objects. Valid values are `none`, `readOnly`, and `full`. your CodeBuild service role must have the `s3:putBucketAcl` permission. This permission allows CodeBuild to modify the access control list for the bucket.
* `encryptionDisabled` - (Optional) Whether to disable encrypting output artifacts. If `type` is set to `noArtifacts`, this value is ignored. Defaults to `false`.
* `location` - (Optional) Information about the build output artifact location. If `type` is set to `codepipeline` or `noArtifacts`, this value is ignored. If `type` is set to `s3`, this is the name of the output bucket.
* `name` - (Optional) Name of the project. If `type` is set to `s3`, this is the name of the output artifact object
* `namespaceType` - (Optional) Namespace to use in storing build artifacts. If `type` is set to `s3`, then valid values are `buildId`, `none`.
* `overrideArtifactName` (Optional) Whether a name specified in the build specification overrides the artifact name.
* `packaging` - (Optional) Type of build output artifact to create. If `type` is set to `s3`, valid values are `none`, `zip`
* `path` - (Optional) If `type` is set to `s3`, this is the path to the output artifact.
* `type` - (Required) Build output artifact's type. Valid values: `codepipeline`, `noArtifacts`, `s3`.

### build\_batch\_config

* `combineArtifacts` - (Optional) Specifies if the build artifacts for the batch build should be combined into a single artifact location.
* `restrictions` - (Optional) Configuration block specifying the restrictions for the batch build. Detailed below.
* `serviceRole` - (Required) Specifies the service role ARN for the batch build project.
* `timeoutInMins` - (Optional) Specifies the maximum amount of time, in minutes, that the batch build must be completed in.

#### build\_batch\_config: restrictions

* `computeTypesAllowed` - (Optional) An array of strings that specify the compute types that are allowed for the batch build. See [Build environment compute types](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html) in the AWS CodeBuild User Guide for these values.
* `maximumBuildsAllowed` - (Optional) Specifies the maximum number of builds allowed.

### cache

* `location` - (Required when cache type is `s3`) Location where the AWS CodeBuild project stores cached resources. For type `s3`, the value must be a valid S3 bucket name/prefix.
* `modes` - (Required when cache type is `local`) Specifies settings that AWS CodeBuild uses to store and reuse build dependencies. Valid values:  `localSourceCache`, `localDockerLayerCache`, `localCustomCache`.
* `type` - (Optional) Type of storage that will be used for the AWS CodeBuild project cache. Valid values: `noCache`, `local`, `s3`. Defaults to `noCache`.

### environment

* `certificate` - (Optional) ARN of the S3 bucket, path prefix and object key that contains the PEM-encoded certificate.
* `computeType` - (Required) Information about the compute resources the build project will use. Valid values: `buildGeneral1Small`, `buildGeneral1Medium`, `buildGeneral1Large`, `buildGeneral12Xlarge`. `buildGeneral1Small` is only valid if `type` is set to `linuxContainer`. When `type` is set to `linuxGpuContainer`, `computeType` must be `buildGeneral1Large`.
* `environmentVariable` - (Optional) Configuration block. Detailed below.
* `imagePullCredentialsType` - (Optional) Type of credentials AWS CodeBuild uses to pull images in your build. Valid values: `codebuild`, `serviceRole`. When you use a cross-account or private registry image, you must use SERVICE\_ROLE credentials. When you use an AWS CodeBuild curated image, you must use CodeBuild credentials. Defaults to `codebuild`.
* `image` - (Required) Docker image to use for this build project. Valid values include [Docker images provided by CodeBuild](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html) (e.g `aws/codebuild/standard:20`), [Docker Hub images](https://hub.docker.com/) (e.g., `hashicorp/terraform:latest`), and full Docker repository URIs such as those for ECR (e.g., `137112412989DkrEcrUsWest2AmazonawsCom/amazonlinux:latest`).
* `privilegedMode` - (Optional) Whether to enable running the Docker daemon inside a Docker container. Defaults to `false`.
* `registryCredential` - (Optional) Configuration block. Detailed below.
* `type` - (Required) Type of build environment to use for related builds. Valid values: `linuxContainer`, `linuxGpuContainer`, `windowsContainer` (deprecated), `windowsServer2019Container`, `armContainer`. For additional information, see the [CodeBuild User Guide](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html).

#### environment: environment\_variable

* `name` - (Required) Environment variable's name or key.
* `type` - (Optional) Type of environment variable. Valid values: `parameterStore`, `plaintext`, `secretsManager`.
* `value` - (Required) Environment variable's value.

#### environment: registry\_credential

Credentials for access to a private Docker registry.

* `credential` - (Required) ARN or name of credentials created using AWS Secrets Manager.
* `credentialProvider` - (Required) Service that created the credentials to access a private Docker registry. Valid value: `secretsManager` (AWS Secrets Manager).

### file\_system\_locations

See [ProjectFileSystemLocation](https://docs.aws.amazon.com/codebuild/latest/APIReference/API_ProjectFileSystemLocation.html) for more details of the fields.

* `identifier` - (Optional) The name used to access a file system created by Amazon EFS. CodeBuild creates an environment variable by appending the identifier in all capital letters to CODEBUILD\_. For example, if you specify my-efs for identifier, a new environment variable is create named CODEBUILD\_MY-EFS.
* `location` - (Optional) A string that specifies the location of the file system created by Amazon EFS. Its format is `efsDnsName:/directoryPath`.
* `mountOptions` - (Optional) The mount options for a file system created by AWS EFS.
* `mountPoint` - (Optional) The location in the container where you mount the file system.
* `type` - (Optional) The type of the file system. The one supported type is `efs`.

### logs\_config

* `cloudwatchLogs` - (Optional) Configuration block. Detailed below.
* `s3Logs` - (Optional) Configuration block. Detailed below.

#### logs\_config: cloudwatch\_logs

* `groupName` - (Optional) Group name of the logs in CloudWatch Logs.
* `status` - (Optional) Current status of logs in CloudWatch Logs for a build project. Valid values: `enabled`, `disabled`. Defaults to `enabled`.
* `streamName` - (Optional) Stream name of the logs in CloudWatch Logs.

#### logs\_config: s3\_logs

* `encryptionDisabled` - (Optional) Whether to disable encrypting S3 logs. Defaults to `false`.
* `location` - (Optional) Name of the S3 bucket and the path prefix for S3 logs. Must be set if status is `enabled`, otherwise it must be empty.
* `status` - (Optional) Current status of logs in S3 for a build project. Valid values: `enabled`, `disabled`. Defaults to `disabled`.
* `bucketOwnerAccess` - (Optional) Specifies the bucket owner's access for objects that another account uploads to their Amazon S3 bucket. By default, only the account that uploads the objects to the bucket has access to these objects. This property allows you to give the bucket owner access to these objects. Valid values are `none`, `readOnly`, and `full`. your CodeBuild service role must have the `s3:putBucketAcl` permission. This permission allows CodeBuild to modify the access control list for the bucket.

### secondary\_artifacts

* `artifactIdentifier` - (Required) Artifact identifier. Must be the same specified inside the AWS CodeBuild build specification.
* `bucketOwnerAccess` - (Optional) Specifies the bucket owner's access for objects that another account uploads to their Amazon S3 bucket. By default, only the account that uploads the objects to the bucket has access to these objects. This property allows you to give the bucket owner access to these objects. Valid values are `none`, `readOnly`, and `full`. your CodeBuild service role must have the `s3:putBucketAcl` permission. This permission allows CodeBuild to modify the access control list for the bucket.
* `encryptionDisabled` - (Optional) Whether to disable encrypting output artifacts. If `type` is set to `noArtifacts`, this value is ignored. Defaults to `false`.
* `location` - (Optional) Information about the build output artifact location. If `type` is set to `codepipeline` or `noArtifacts`, this value is ignored. If `type` is set to `s3`, this is the name of the output bucket. If `path` is not also specified, then `location` can also specify the path of the output artifact in the output bucket.
* `name` - (Optional) Name of the project. If `type` is set to `s3`, this is the name of the output artifact object
* `namespaceType` - (Optional) Namespace to use in storing build artifacts. If `type` is set to `s3`, then valid values are `buildId` or `none`.
* `overrideArtifactName` (Optional) Whether a name specified in the build specification overrides the artifact name.
* `packaging` - (Optional) Type of build output artifact to create. If `type` is set to `s3`, valid values are `none`, `zip`
* `path` - (Optional) If `type` is set to `s3`, this is the path to the output artifact.
* `type` - (Required) Build output artifact's type. The only valid value is `s3`.

### secondary\_sources

* `auth` - (Optional, **Deprecated**) Configuration block with the authorization settings for AWS CodeBuild to access the source code to be built. This information is for the AWS CodeBuild console's use only. Use the [`awsCodebuildSourceCredential` resource](codebuild_source_credential.html) instead. Auth blocks are documented below.
* `buildspec` - (Optional) The build spec declaration to use for this build project's related builds. This must be set when `type` is `noSource`. It can either be a path to a file residing in the repository to be built or a local file path leveraging the `file()` built-in.
* `gitCloneDepth` - (Optional) Truncate git history to this many commits. Use `0` for a `full` checkout which you need to run commands like `gitBranchShowCurrent`. See [AWS CodePipeline User Guide: Tutorial: Use full clone with a GitHub pipeline source](https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorials-github-gitclone.html) for details.
* `gitSubmodulesConfig` - (Optional) Configuration block. Detailed below.
* `insecureSsl` - (Optional) Ignore SSL warnings when connecting to source control.
* `location` - (Optional) Location of the source code from git or s3.
* `reportBuildStatus` - (Optional) Whether to report the status of a build's start and finish to your source provider. This option is only valid when your source provider is `github`, `bitbucket`, or `githubEnterprise`.
* `buildStatusConfig` - (Optional) Configuration block that contains information that defines how the build project reports the build status to the source provider. This option is only used when the source provider is `github`, `githubEnterprise`, or `bitbucket`. `buildStatusConfig` blocks are documented below.
* `sourceIdentifier` - (Required) An identifier for this project source. The identifier can only contain alphanumeric characters and underscores, and must be less than 128 characters in length.
* `type` - (Required) Type of repository that contains the source code to be built. Valid values: `codecommit`, `codepipeline`, `github`, `githubEnterprise`, `bitbucket` or `s3`.

#### secondary\_sources: auth

* `resource` - (Optional, **Deprecated**) Resource value that applies to the specified authorization type. Use the [`awsCodebuildSourceCredential` resource](codebuild_source_credential.html) instead.
* `type` - (Required, **Deprecated**) Authorization type to use. The only valid value is `oauth`. This data type is deprecated and is no longer accurate or used. Use the [`awsCodebuildSourceCredential` resource](codebuild_source_credential.html) instead.

#### secondary\_sources: git\_submodules\_config

This block is only valid when the `type` is `codecommit`, `github` or `githubEnterprise`.

* `fetchSubmodules` - (Required) Whether to fetch Git submodules for the AWS CodeBuild build project.

#### secondary\_sources: build\_status\_config

* `context` - (Optional) Specifies the context of the build status CodeBuild sends to the source provider. The usage of this parameter depends on the source provider.
* `targetUrl` - (Optional) Specifies the target url of the build status CodeBuild sends to the source provider. The usage of this parameter depends on the source provider.

### secondary\_source\_version

* `sourceIdentifier` - (Required) An identifier for a source in the build project.
* `sourceVersion` - (Required) The source version for the corresponding source identifier. See [AWS docs](https://docs.aws.amazon.com/codebuild/latest/APIReference/API_ProjectSourceVersion.html#CodeBuild-Type-ProjectSourceVersion-sourceVersion) for more details.

### source

* `auth` - (Optional, **Deprecated**) Configuration block with the authorization settings for AWS CodeBuild to access the source code to be built. This information is for the AWS CodeBuild console's use only. Use the [`awsCodebuildSourceCredential` resource](codebuild_source_credential.html) instead. Auth blocks are documented below.
* `buildspec` - (Optional) Build specification to use for this build project's related builds. This must be set when `type` is `noSource`.
* `gitCloneDepth` - (Optional) Truncate git history to this many commits. Use `0` for a `full` checkout which you need to run commands like `gitBranchShowCurrent`. See [AWS CodePipeline User Guide: Tutorial: Use full clone with a GitHub pipeline source](https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorials-github-gitclone.html) for details.
* `gitSubmodulesConfig` - (Optional) Configuration block. Detailed below.
* `insecureSsl` - (Optional) Ignore SSL warnings when connecting to source control.
* `location` - (Optional) Location of the source code from git or s3.
* `reportBuildStatus` - (Optional) Whether to report the status of a build's start and finish to your source provider. This option is only valid when the `type` is `bitbucket` or `github`.
* `buildStatusConfig` - (Optional) Configuration block that contains information that defines how the build project reports the build status to the source provider. This option is only used when the source provider is `github`, `githubEnterprise`, or `bitbucket`. `buildStatusConfig` blocks are documented below.
* `type` - (Required) Type of repository that contains the source code to be built. Valid values: `codecommit`, `codepipeline`, `github`, `githubEnterprise`, `bitbucket`, `s3`, `noSource`.

#### source: auth

* `resource` - (Optional, **Deprecated**) Resource value that applies to the specified authorization type. Use the [`awsCodebuildSourceCredential` resource](codebuild_source_credential.html) instead.
* `type` - (Required, **Deprecated**) Authorization type to use. The only valid value is `oauth`. This data type is deprecated and is no longer accurate or used. Use the [`awsCodebuildSourceCredential` resource](codebuild_source_credential.html) instead.

#### source: git\_submodules\_config

This block is only valid when the `type` is `codecommit`, `github` or `githubEnterprise`.

* `fetchSubmodules` - (Required) Whether to fetch Git submodules for the AWS CodeBuild build project.

#### source: build\_status\_config

* `context` - (Optional) Specifies the context of the build status CodeBuild sends to the source provider. The usage of this parameter depends on the source provider.
* `targetUrl` - (Optional) Specifies the target url of the build status CodeBuild sends to the source provider. The usage of this parameter depends on the source provider.

### vpc\_config

* `securityGroupIds` - (Required) Security group IDs to assign to running builds.
* `subnets` - (Required) Subnet IDs within which to run builds.
* `vpcId` - (Required) ID of the VPC within which to run builds.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the CodeBuild project.
* `badgeUrl` - URL of the build badge when `badgeEnabled` is enabled.
* `id` - Name (if imported via `name`) or ARN (if created via Terraform or imported via ARN) of the CodeBuild project.
* `publicProjectAlias` - The project identifier used with the public build APIs.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

CodeBuild Project can be imported using the `name`, e.g.,

```console
$ terraform import aws_codebuild_project.name project-name
```
