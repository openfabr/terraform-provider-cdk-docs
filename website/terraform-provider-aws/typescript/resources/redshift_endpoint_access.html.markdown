---
subcategory: "Redshift"
layout: "aws"
page_title: "AWS: aws_redshift_endpoint_access"
description: |-
  Provides a Redshift Endpoint Access resource.
---

# Resource: awsRedshiftEndpointAccess

Creates a new Amazon Redshift endpoint access.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.redshiftEndpointAccess.RedshiftEndpointAccess(this, "example", {
  clusterIdentifier: "${aws_redshift_cluster.example.cluster_identifier}",
  endpointName: "example",
  subnetGroupName: "${aws_redshift_subnet_group.example.id}",
});

```

## Argument Reference

The following arguments are supported:

* `clusterIdentifier` - (Required) The cluster identifier of the cluster to access.
* `endpointName` - (Required) The Redshift-managed VPC endpoint name.
* `resourceOwner` - (Optional) The Amazon Web Services account ID of the owner of the cluster. This is only required if the cluster is in another Amazon Web Services account.
* `subnetGroupName` - (Required) The subnet group from which Amazon Redshift chooses the subnet to deploy the endpoint.
* `vpcSecurityGroupIds` - (Optional) The security group that defines the ports, protocols, and sources for inbound traffic that you are authorizing into your endpoint.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `address` - The DNS address of the endpoint.
* `id` - The Redshift-managed VPC endpoint name.
* `port` - The port number on which the cluster accepts incoming connections.
* `vpcEndpoint` - The connection endpoint for connecting to an Amazon Redshift cluster through the proxy. See details below.

### VPC Endpoint

* `networkInterface` - One or more network interfaces of the endpoint. Also known as an interface endpoint. See details below.
* `vpcEndpointId` - The connection endpoint ID for connecting an Amazon Redshift cluster through the proxy.
* `vpcId` - The VPC identifier that the endpoint is associated.

### Network Interface

* `availabilityZone` - The Availability Zone.
* `networkInterfaceId` - The network interface identifier.
* `privateIpAddress` - The IPv4 address of the network interface within the subnet.
* `subnetId` - The subnet identifier.

## Import

Redshift endpoint access can be imported using the `name`, e.g.,

```console
$ terraform import aws_redshift_endpoint_access.example example
```
