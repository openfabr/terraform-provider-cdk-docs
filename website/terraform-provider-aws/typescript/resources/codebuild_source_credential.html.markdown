---
subcategory: "CodeBuild"
layout: "aws"
page_title: "AWS: aws_codebuild_source_credential"
description: |-
  Provides a CodeBuild Source Credential resource.
---

# Resource: awsCodebuildSourceCredential

Provides a CodeBuild Source Credentials Resource.

\~> **NOTE:**
[Codebuild only allows a single credential per given server type in a given region](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_codebuild.GitHubSourceCredentials.html). Therefore, when you define `awsCodebuildSourceCredential`, [`awsCodebuildProject` resource](/docs/providers/aws/r/codebuild_project.html) defined in the same module will use it.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.codebuildSourceCredential.CodebuildSourceCredential(this, "example", {
  authType: "PERSONAL_ACCESS_TOKEN",
  serverType: "GITHUB",
  token: "example",
});

```

### Bitbucket Server Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.codebuildSourceCredential.CodebuildSourceCredential(this, "example", {
  authType: "BASIC_AUTH",
  serverType: "BITBUCKET",
  token: "example",
  userName: "test-user",
});

```

## Argument Reference

The following arguments are supported:

* `authType` - (Required) The type of authentication used to connect to a GitHub, GitHub Enterprise, or Bitbucket repository. An OAUTH connection is not supported by the API.
* `serverType` - (Required) The source provider used for this project.
* `token` - (Required) For `gitHub` or `gitHubEnterprise`, this is the personal access token. For `bitbucket`, this is the app password.
* `userName` - (Optional) The Bitbucket username when the authType is `BASIC_AUTH`. This parameter is not valid for other types of source providers or connections.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ARN of Source Credential.
* `arn` - The ARN of Source Credential.

## Import

CodeBuild Source Credential can be imported using the CodeBuild Source Credential arn, e.g.,

```console
$ terraform import aws_codebuild_source_credential.example arn:aws:codebuild:us-west-2:123456789:token:github
```
