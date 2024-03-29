---
subcategory: "IAM (Identity & Access Management)"
layout: "aws"
page_title: "AWS: aws_iam_server_certificate"
description: |-
  Provides an IAM Server Certificate
---

# Resource: awsIamServerCertificate

Provides an IAM Server Certificate resource to upload Server Certificates.
Certs uploaded to IAM can easily work with other AWS services such as:

* AWS Elastic Beanstalk
* Elastic Load Balancing
* CloudFront
* AWS OpsWorks

For information about server certificates in IAM, see [Managing Server
Certificates][2] in AWS Documentation.

\~> **Note:** All arguments including the private key will be stored in the raw state as plain-text.
[Read more about sensitive data in state](https://www.terraform.io/docs/state/sensitive-data.html).

## Example Usage

**Using certs on file:**

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.iamServerCertificate.IamServerCertificate(this, "test_cert", {
  certificateBody: '${file("self-ca-cert.pem")}',
  name: "some_test_cert",
  privateKey: '${file("test-key.pem")}',
});

```

**Example with cert in-line:**

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.iamServerCertificate.IamServerCertificate(this, "test_cert_alt", {
  certificateBody:
    "-----BEGIN CERTIFICATE-----\n[......] # cert contents\n-----END CERTIFICATE-----\n",
  name: "alt_test_cert",
  privateKey:
    "-----BEGIN RSA PRIVATE KEY-----\n[......] # cert contents\n-----END RSA PRIVATE KEY-----\n",
});

```

**Use in combination with an AWS ELB resource:**

Some properties of an IAM Server Certificates cannot be updated while they are
in use. In order for Terraform to effectively manage a Certificate in this situation, it is
recommended you utilize the `namePrefix` attribute and enable the
`createBeforeDestroy` [lifecycle block][lifecycle]. This will allow Terraform
to create a new, updated `awsIamServerCertificate` resource and replace it in
dependant resources before attempting to destroy the old version.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsIamServerCertificateTestCert =
  new aws.iamServerCertificate.IamServerCertificate(this, "test_cert", {
    certificateBody: '${file("self-ca-cert.pem")}',
    namePrefix: "example-cert",
    privateKey: '${file("test-key.pem")}',
  });
awsIamServerCertificateTestCert.addOverride("lifecycle", [
  {
    create_before_destroy: true,
  },
]);
new aws.elb.Elb(this, "ourapp", {
  availabilityZones: ["us-west-2a"],
  crossZoneLoadBalancing: true,
  listener: [
    {
      instancePort: 8000,
      instanceProtocol: "http",
      lbPort: 443,
      lbProtocol: "https",
      sslCertificateId: awsIamServerCertificateTestCert.arn,
    },
  ],
  name: "terraform-asg-deployment-example",
});

```

## Argument Reference

The following arguments are supported:

* `name` - (Optional) The name of the Server Certificate. Do not include the
  path in this value. If omitted, Terraform will assign a random, unique name.
* `namePrefix` - (Optional) Creates a unique name beginning with the specified
  prefix. Conflicts with `name`.
* `certificateBody` – (Required) The contents of the public key certificate in
  PEM-encoded format.
* `certificateChain` – (Optional) The contents of the certificate chain.
  This is typically a concatenation of the PEM-encoded public key certificates
  of the chain.
* `privateKey` – (Required) The contents of the private key in PEM-encoded format.
* `path` - (Optional) The IAM path for the server certificate.  If it is not
  included, it defaults to a slash (/). If this certificate is for use with
  AWS CloudFront, the path must be in format `/cloudfront/yourPathHere`.
  See [IAM Identifiers][1] for more details on IAM Paths.
* `tags` - (Optional) Map of resource tags for the server certificate. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

\~> **NOTE:** AWS performs behind-the-scenes modifications to some certificate files if they do not adhere to a specific format. These modifications will result in terraform forever believing that it needs to update the resources since the local and AWS file contents will not match after theses modifications occur. In order to prevent this from happening you must ensure that all your PEM-encoded files use UNIX line-breaks and that `certificateBody` contains only one certificate. All other certificates should go in `certificateChain`. It is common for some Certificate Authorities to issue certificate files that have DOS line-breaks and that are actually multiple certificates concatenated together in order to form a full certificate chain.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The Amazon Resource Name (ARN) specifying the server certificate.
* `expiration` - Date and time in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8) on which the certificate is set to expire.
* `id` - The unique Server Certificate name
* `name` - The name of the Server Certificate
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).
* `uploadDate` - Date and time in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8) when the server certificate was uploaded.

## Import

IAM Server Certificates can be imported using the `name`, e.g.,

```console
$ terraform import aws_iam_server_certificate.certificate example.com-certificate-until-2018
```

[1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html

[2]: https://docs.aws.amazon.com/IAM/latest/UserGuide/ManagingServerCerts.html

[lifecycle]: /docs/configuration/resources.html
