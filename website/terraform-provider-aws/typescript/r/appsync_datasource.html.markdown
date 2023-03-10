---
subcategory: "AppSync"
layout: "aws"
page_title: "AWS: aws_appsync_datasource"
description: |-
  Provides an AppSync Data Source.
---

# Resource: aws\_appsync\_datasource

Provides an AppSync Data Source.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsAppsyncGraphqlApiExample = new aws.appsyncGraphqlApi.AppsyncGraphqlApi(
  this,
  "example",
  {
    authenticationType: "API_KEY",
    name: "tf_appsync_example",
  }
);
const awsDynamodbTableExample = new aws.dynamodbTable.DynamodbTable(
  this,
  "example_1",
  {
    attribute: [
      {
        name: "UserId",
        type: "S",
      },
    ],
    hashKey: "UserId",
    name: "example",
    readCapacity: 1,
    writeCapacity: 1,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsDynamodbTableExample.overrideLogicalId("example");
const awsIamRoleExample = new aws.iamRole.IamRole(this, "example_2", {
  assumeRolePolicy:
    '{\n  "Version": "2012-10-17",\n  "Statement": [\n    {\n      "Action": "sts:AssumeRole",\n      "Principal": {\n        "Service": "appsync.amazonaws.com"\n      },\n      "Effect": "Allow"\n    }\n  ]\n}\n',
  name: "example",
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamRoleExample.overrideLogicalId("example");
const awsIamRolePolicyExample = new aws.iamRolePolicy.IamRolePolicy(
  this,
  "example_3",
  {
    name: "example",
    policy: `{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "\${${awsDynamodbTableExample.arn}}"
      ]
    }
  ]
}
`,
    role: awsIamRoleExample.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsIamRolePolicyExample.overrideLogicalId("example");
const awsAppsyncDatasourceExample = new aws.appsyncDatasource.AppsyncDatasource(
  this,
  "example_4",
  {
    apiId: awsAppsyncGraphqlApiExample.id,
    dynamodbConfig: {
      tableName: awsDynamodbTableExample.name,
    },
    name: "tf_appsync_example",
    serviceRoleArn: awsIamRoleExample.arn,
    type: "AMAZON_DYNAMODB",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsAppsyncDatasourceExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `apiId` - (Required) API ID for the GraphQL API for the data source.
* `name` - (Required) User-supplied name for the data source.
* `type` - (Required) Type of the Data Source. Valid values: `awsLambda`, `amazonDynamodb`, `amazonElasticsearch`, `http`, `none`, `relationalDatabase`.
* `description` - (Optional) Description of the data source.
* `serviceRoleArn` - (Optional) IAM service role ARN for the data source.
* `dynamodbConfig` - (Optional) DynamoDB settings. See [below](#dynamodb_config)
* `elasticsearchConfig` - (Optional) Amazon Elasticsearch settings. See [below](#elasticsearch_config)
* `httpConfig` - (Optional) HTTP settings. See [below](#http_config)
* `lambdaConfig` - (Optional) AWS Lambda settings. See [below](#lambda_config)
* `relationalDatabaseConfig` (Optional) AWS RDS settings. See [Relational Database Config](#relational_database_config)

### dynamodb\_config

The following arguments are supported:

* `tableName` - (Required) Name of the DynamoDB table.
* `region` - (Optional) AWS region of the DynamoDB table. Defaults to current region.
* `useCallerCredentials` - (Optional) Set to `true` to use Amazon Cognito credentials with this data source.

### elasticsearch\_config

The following arguments are supported:

* `endpoint` - (Required) HTTP endpoint of the Elasticsearch domain.
* `region` - (Optional) AWS region of Elasticsearch domain. Defaults to current region.

### http\_config

The following arguments are supported:

* `endpoint` - (Required) HTTP URL.
* `authorizationConfig` - (Optional) Authorization configuration in case the HTTP endpoint requires authorization. See [Authorization Config](#authorization_config).

#### authorization\_config

The following arguments are supported:

* `authorizationType` - (Optional) Authorization type that the HTTP endpoint requires. Default values is `awsIam`.
* `awsIamConfig` - (Optional) Identity and Access Management (IAM) settings. See [AWS IAM Config](#aws_iam_config).

##### aws\_iam\_config

The following arguments are supported:

* `signingRegion` - (Optional) Signing Amazon Web Services Region for IAM authorization.
* `signingServiceName`- (Optional) Signing service name for IAM authorization.

### relational\_database\_config

The following arguments are supported:

* `httpEndpointConfig` - (Required) Amazon RDS HTTP endpoint configuration. See [HTTP Endpoint Config](#http_endpoint_config).
* `sourceType` - (Optional) Source type for the relational database. Valid values: `rdsHttpEndpoint`.

#### http\_endpoint\_config

The following arguments are supported:

* `dbClusterIdentifier` - (Required) Amazon RDS cluster identifier.
* `awsSecretStoreArn` - (Required) AWS secret store ARN for database credentials.
* `databaseName` - (Optional) Logical database name.
* `region` - (Optional) AWS Region for RDS HTTP endpoint. Defaults to current region.
* `schema` - (Optional) Logical schema name.

### lambda\_config

The following arguments are supported:

* `functionArn` - (Required) ARN for the Lambda function.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN

## Import

`awsAppsyncDatasource` can be imported with their `apiId`, a hyphen, and `name`, e.g.,

```console
$ terraform import aws_appsync_datasource.example abcdef123456-example
```
