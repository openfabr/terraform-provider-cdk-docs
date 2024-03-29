---
subcategory: "WorkSpaces"
layout: "aws"
page_title: "AWS: aws_workspaces_directory"
description: |-
  Retrieve information about an AWS WorkSpaces directory.
---

# Data Source: awsWorkspacesDirectory

Retrieve information about an AWS WorkSpaces directory.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsWorkspacesDirectory.DataAwsWorkspacesDirectory(this, "example", {
  directoryId: "d-9067783251",
});

```

## Argument Reference

* `directoryId` - (Required) Directory identifier for registration in WorkSpaces service.

## Attributes Reference

* `id` - WorkSpaces directory identifier.
* `alias` - Directory alias.
* `customerUserName` - User name for the service account.
* `directoryName` - Name of the directory.
* `directoryType` - Directory type.
* `dnsIpAddresses` - IP addresses of the DNS servers for the directory.
* `iamRoleId` - Identifier of the IAM role. This is the role that allows Amazon WorkSpaces to make calls to other services, such as Amazon EC2, on your behalf.
* `ipGroupIds` - Identifiers of the IP access control groups associated with the directory.
* `registrationCode` - Registration code for the directory. This is the code that users enter in their Amazon WorkSpaces client application to connect to the directory.
* `selfServicePermissions` – The permissions to enable or disable self-service capabilities.
* `subnetIds` - Identifiers of the subnets where the directory resides.
* `tags` – A map of tags assigned to the WorkSpaces directory.
* `workspaceCreationProperties` – The default properties that are used for creating WorkSpaces. Defined below.
* `workspaceAccessProperties` – (Optional) Specifies which devices and operating systems users can use to access their WorkSpaces. Defined below.
* `workspaceSecurityGroupId` - The identifier of the security group that is assigned to new WorkSpaces. Defined below.

### selfServicePermissions

* `changeComputeType` – Whether WorkSpaces directory users can change the compute type (bundle) for their workspace.
* `increaseVolumeSize` – Whether WorkSpaces directory users can increase the volume size of the drives on their workspace.
* `rebuildWorkspace` – Whether WorkSpaces directory users can rebuild the operating system of a workspace to its original state.
* `restartWorkspace` – Whether WorkSpaces directory users can restart their workspace.
* `switchRunningMode` – Whether WorkSpaces directory users can switch the running mode of their workspace.

### workspaceAccessProperties

* `deviceTypeAndroid` – (Optional) Indicates whether users can use Android devices to access their WorkSpaces.
* `deviceTypeChromeos` – (Optional) Indicates whether users can use Chromebooks to access their WorkSpaces.
* `deviceTypeIos` – (Optional) Indicates whether users can use iOS devices to access their WorkSpaces.
* `deviceTypeLinux` – (Optional) Indicates whether users can use Linux clients to access their WorkSpaces.
* `deviceTypeOsx` – (Optional) Indicates whether users can use macOS clients to access their WorkSpaces.
* `deviceTypeWeb` – (Optional) Indicates whether users can access their WorkSpaces through a web browser.
* `deviceTypeWindows` – (Optional) Indicates whether users can use Windows clients to access their WorkSpaces.
* `deviceTypeZeroclient` – (Optional) Indicates whether users can use zero client devices to access their WorkSpaces.

### workspaceCreationProperties

* `customSecurityGroupId` – The identifier of your custom security group. Should relate to the same VPC, where workspaces reside in.
* `defaultOu` – The default organizational unit (OU) for your WorkSpace directories.
* `enableInternetAccess` – Indicates whether internet access is enabled for your WorkSpaces.
* `enableMaintenanceMode` – Indicates whether maintenance mode is enabled for your WorkSpaces. For more information, see [WorkSpace Maintenance](https://docs.aws.amazon.com/workspaces/latest/adminguide/workspace-maintenance.html).
* `userEnabledAsLocalAdministrator` – Indicates whether users are local administrators of their WorkSpaces.
