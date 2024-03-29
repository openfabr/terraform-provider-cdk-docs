---
subcategory: "EKS (Elastic Kubernetes)"
layout: "aws"
page_title: "AWS: aws_eks_cluster"
description: |-
  Retrieve information about an EKS Cluster
---

# Data Source: awsEksCluster

Retrieve information about an EKS Cluster.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsEksClusterExample = new aws.dataAwsEksCluster.DataAwsEksCluster(
  this,
  "example",
  {
    name: "example",
  }
);
new cdktf.TerraformOutput(this, "endpoint", {
  value: dataAwsEksClusterExample.endpoint,
});
new cdktf.TerraformOutput(this, "identity-oidc-issuer", {
  value: `\${${dataAwsEksClusterExample.identity.fqn}[0].oidc[0].issuer}`,
});
new cdktf.TerraformOutput(this, "kubeconfig-certificate-authority-data", {
  value: `\${${dataAwsEksClusterExample.certificateAuthority.fqn}[0].data}`,
});

```

## Argument Reference

* `name` - (Required) Name of the cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (`^[09AZaZ][aZaZ09\_]+$`).

## Attributes Reference

* `id` - Name of the cluster
* `arn` - ARN of the cluster.
* `certificateAuthority` - Nested attribute containing `certificateAuthorityData` for your cluster.
  * `data` - The base64 encoded certificate data required to communicate with your cluster. Add this to the `certificateAuthorityData` section of the `kubeconfig` file for your cluster.
* `clusterId` - The ID of your local Amazon EKS cluster on the AWS Outpost. This attribute isn't available for an AWS EKS cluster on AWS cloud.
* `createdAt` - Unix epoch time stamp in seconds for when the cluster was created.
* `enabledClusterLogTypes` - The enabled control plane logs.
* `endpoint` - Endpoint for your Kubernetes API server.
* `identity` - Nested attribute containing identity provider information for your cluster. Only available on Kubernetes version 1.13 and 1.14 clusters created or upgraded on or after September 3, 2019. For an example using this information to enable IAM Roles for Service Accounts, see the [`awsEksCluster` resource documentation](/docs/providers/aws/r/eks_cluster.html).
  * `oidc` - Nested attribute containing [OpenID Connect](https://openid.net/connect/) identity provider information for the cluster.
    * `issuer` - Issuer URL for the OpenID Connect identity provider.
* `kubernetesNetworkConfig` - Nested list containing Kubernetes Network Configuration.
  * `ipFamily` - `ipv4` or `ipv6`.
  * `serviceIpv4Cidr` - The CIDR block to assign Kubernetes pod and service IP addresses from if `ipv4` was specified when the cluster was created.
  * `serviceIpv6Cidr` - The CIDR block to assign Kubernetes pod and service IP addresses from if `ipv6` was specified when the cluster was created. Kubernetes assigns service addresses from the unique local address range (fc00::/7) because you can't specify a custom IPv6 CIDR block when you create the cluster.
* `outpostConfig` - Contains Outpost Configuration.
  * `controlPlaneInstanceType` - The Amazon EC2 instance type for all Kubernetes control plane instances.
  * `controlPlanePlacement` - An object representing the placement configuration for all the control plane instances of your local Amazon EKS cluster on AWS Outpost.
    * `groupName` - The name of the placement group for the Kubernetes control plane instances.
  * `outpostArns` - List of ARNs of the Outposts hosting the EKS cluster. Only a single ARN is supported currently.
* `platformVersion` - Platform version for the cluster.
* `roleArn` - ARN of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf.
* `status` - Status of the EKS cluster. One of `creating`, `active`, `deleting`, `failed`.
* `tags` - Key-value map of resource tags.
* `version` - Kubernetes server version for the cluster.
* `vpcConfig` - Nested list containing VPC configuration for the cluster.
  * `clusterSecurityGroupId` - The cluster security group that was created by Amazon EKS for the cluster.
  * `endpointPrivateAccess` - Indicates whether or not the Amazon EKS private API server endpoint is enabled.
  * `endpointPublicAccess` - Indicates whether or not the Amazon EKS public API server endpoint is enabled.
  * `publicAccessCidrs` - List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint.
  * `securityGroupIds` – List of security group IDs
  * `subnetIds` – List of subnet IDs
  * `vpcId` – The VPC associated with your cluster.
