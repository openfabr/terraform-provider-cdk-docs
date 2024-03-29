---
subcategory: "FSx"
layout: "aws"
page_title: "AWS: aws_fsx_windows_file_system"
description: |-
  Manages a FSx Windows File System.
---

# Resource: awsFsxWindowsFileSystem

Manages a FSx Windows File System. See the [FSx Windows Guide](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/what-is.html) for more information.

\~> **NOTE:** Either the `activeDirectoryId` argument or `selfManagedActiveDirectory` configuration block must be specified.

## Example Usage

### Using AWS Directory Service

Additional information for using AWS Directory Service with Windows File Systems can be found in the [FSx Windows Guide](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/fsx-aws-managed-ad.html).

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.fsxWindowsFileSystem.FsxWindowsFileSystem(this, "example", {
  activeDirectoryId: "${aws_directory_service_directory.example.id}",
  kmsKeyId: "${aws_kms_key.example.arn}",
  storageCapacity: 300,
  subnetIds: ["${aws_subnet.example.id}"],
  throughputCapacity: 1024,
});

```

### Using a Self-Managed Microsoft Active Directory

Additional information for using AWS Directory Service with Windows File Systems can be found in the [FSx Windows Guide](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/self-managed-AD.html).

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.fsxWindowsFileSystem.FsxWindowsFileSystem(this, "example", {
  kmsKeyId: "${aws_kms_key.example.arn}",
  selfManagedActiveDirectory: {
    dnsIps: ["10.0.0.111", "10.0.0.222"],
    domainName: "corp.example.com",
    password: "avoid-plaintext-passwords",
    username: "Admin",
  },
  storageCapacity: 300,
  subnetIds: ["${aws_subnet.example.id}"],
  throughputCapacity: 1024,
});

```

## Argument Reference

The following arguments are supported:

* `storageCapacity` - (Optional) Storage capacity (GiB) of the file system. Minimum of 32 and maximum of 65536. If the storage type is set to `hdd` the minimum value is 2000. Required when not creating filesystem for a backup.
* `subnetIds` - (Required) A list of IDs for the subnets that the file system will be accessible from. To specify more than a single subnet set `deploymentType` to `MULTI_AZ_1`.
* `throughputCapacity` - (Required) Throughput (megabytes per second) of the file system in power of 2 increments. Minimum of `8` and maximum of `2048`.
* `backupId` - (Optional) The ID of the source backup to create the filesystem from.
* `activeDirectoryId` - (Optional) The ID for an existing Microsoft Active Directory instance that the file system should join when it's created. Cannot be specified with `selfManagedActiveDirectory`.
* `aliases` - (Optional) An array DNS alias names that you want to associate with the Amazon FSx file system.  For more information, see [Working with DNS Aliases](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-dns-aliases.html)
* `automaticBackupRetentionDays` - (Optional) The number of days to retain automatic backups. Minimum of `0` and maximum of `90`. Defaults to `7`. Set to `0` to disable.
* `copyTagsToBackups` - (Optional) A boolean flag indicating whether tags on the file system should be copied to backups. Defaults to `false`.
* `dailyAutomaticBackupStartTime` - (Optional) The preferred time (in `hh:mm` format) to take daily automatic backups, in the UTC time zone.
* `kmsKeyId` - (Optional) ARN for the KMS Key to encrypt the file system at rest. Defaults to an AWS managed KMS Key.
* `securityGroupIds` - (Optional) A list of IDs for the security groups that apply to the specified network interfaces created for file system access. These security groups will apply to all network interfaces.
* `selfManagedActiveDirectory` - (Optional) Configuration block that Amazon FSx uses to join the Windows File Server instance to your self-managed (including on-premises) Microsoft Active Directory (AD) directory. Cannot be specified with `activeDirectoryId`. Detailed below.
* `skipFinalBackup` - (Optional) When enabled, will skip the default final backup taken when the file system is deleted. This configuration must be applied separately before attempting to delete the resource to have the desired behavior. Defaults to `false`.
* `tags` - (Optional) A map of tags to assign to the file system. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `weeklyMaintenanceStartTime` - (Optional) The preferred start time (in `d:hh:mm` format) to perform weekly maintenance, in the UTC time zone.
* `deploymentType` - (Optional) Specifies the file system deployment type, valid values are `MULTI_AZ_1`, `SINGLE_AZ_1` and `SINGLE_AZ_2`. Default value is `SINGLE_AZ_1`.
* `preferredSubnetId` - (Optional) Specifies the subnet in which you want the preferred file server to be located. Required for when deployment type is `MULTI_AZ_1`.
* `auditLogConfiguration` - (Optional) The configuration that Amazon FSx for Windows File Server uses to audit and log user accesses of files, folders, and file shares on the Amazon FSx for Windows File Server file system. See below.
* `storageType` - (Optional) Specifies the storage type, Valid values are `ssd` and `hdd`. `hdd` is supported on `SINGLE_AZ_2` and `MULTI_AZ_1` Windows file system deployment types. Default value is `ssd`.

### selfManagedActiveDirectory

The following arguments are supported for `selfManagedActiveDirectory` configuration block:

* `dnsIps` - (Required) A list of up to two IP addresses of DNS servers or domain controllers in the self-managed AD directory. The IP addresses need to be either in the same VPC CIDR range as the file system or in the private IP version 4 (IPv4) address ranges as specified in [RFC 1918](https://tools.ietf.org/html/rfc1918).
* `domainName` - (Required) The fully qualified domain name of the self-managed AD directory. For example, `corpExampleCom`.
* `password` - (Required) The password for the service account on your self-managed AD domain that Amazon FSx will use to join to your AD domain.
* `username` - (Required) The user name for the service account on your self-managed AD domain that Amazon FSx will use to join to your AD domain.
* `fileSystemAdministratorsGroup` - (Optional) The name of the domain group whose members are granted administrative privileges for the file system. Administrative privileges include taking ownership of files and folders, and setting audit controls (audit ACLs) on files and folders. The group that you specify must already exist in your domain. Defaults to `domainAdmins`.
* `organizationalUnitDistinguishedName` - (Optional) The fully qualified distinguished name of the organizational unit within your self-managed AD directory that the Windows File Server instance will join. For example, `ou=fSx,dc=yourdomain,dc=corp,dc=com`. Only accepts OU as the direct parent of the file system. If none is provided, the FSx file system is created in the default location of your self-managed AD directory. To learn more, see [RFC 2253](https://tools.ietf.org/html/rfc2253).

### auditLogConfiguration

* `auditLogDestination` - (Optional) The Amazon Resource Name (ARN) for the destination of the audit logs. The destination can be any Amazon CloudWatch Logs log group ARN or Amazon Kinesis Data Firehose delivery stream ARN. Can be specified when `fileAccessAuditLogLevel` and `fileShareAccessAuditLogLevel` are not set to `disabled`. The name of the Amazon CloudWatch Logs log group must begin with the `/aws/fsx` prefix. The name of the Amazon Kinesis Data Firehouse delivery stream must begin with the `awsFsx` prefix. If you do not provide a destination in `auditLogDestionation`, Amazon FSx will create and use a log stream in the CloudWatch Logs /aws/fsx/windows log group.
* `fileAccessAuditLogLevel` - (Optional) Sets which attempt type is logged by Amazon FSx for file and folder accesses. Valid values are `SUCCESS_ONLY`, `FAILURE_ONLY`, `SUCCESS_AND_FAILURE`, and `disabled`. Default value is `disabled`.
* `fileShareAccessAuditLogLevel` - (Optional) Sets which attempt type is logged by Amazon FSx for file share accesses. Valid values are `SUCCESS_ONLY`, `FAILURE_ONLY`, `SUCCESS_AND_FAILURE`, and `disabled`. Default value is `disabled`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name of the file system.
* `dnsName` - DNS name for the file system, e.g., `fs12345678CorpExampleCom` (domain name matching the Active Directory domain name)
* `id` - Identifier of the file system, e.g., `fs12345678`
* `networkInterfaceIds` - Set of Elastic Network Interface identifiers from which the file system is accessible.
* `ownerId` - AWS account identifier that created the file system.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).
* `vpcId` - Identifier of the Virtual Private Cloud for the file system.
* `preferredFileServerIp` - The IP address of the primary, or preferred, file server.
* `remoteAdministrationEndpoint` - For `MULTI_AZ_1` deployment types, use this endpoint when performing administrative tasks on the file system using Amazon FSx Remote PowerShell. For `SINGLE_AZ_1` deployment types, this is the DNS name of the file system.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `45M`)
* `delete` - (Default `30M`)
* `update` - (Default `45M`)

## Import

FSx File Systems can be imported using the `id`, e.g.,

```console
$ terraform import aws_fsx_windows_file_system.example fs-543ab12b1ca672f33
```

Certain resource arguments, like `securityGroupIds` and the `selfManagedActiveDirectory` configuation block `password`, do not have a FSx API method for reading the information after creation. If these arguments are set in the Terraform configuration on an imported resource, Terraform will always show a difference. To workaround this behavior, either omit the argument from the Terraform configuration or use [`ignoreChanges`](https://www.terraform.io/docs/configuration/meta-arguments/lifecycle.html#ignore_changes) to hide the difference, e.g.,

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsFsxWindowsFileSystemExample =
  new aws.fsxWindowsFileSystem.FsxWindowsFileSystem(this, "example", {
    securityGroupIds: ["${aws_security_group.example.id}"],
  });
awsFsxWindowsFileSystemExample.addOverride("lifecycle", [
  {
    ignore_changes: ["${security_group_ids}"],
  },
]);

```
