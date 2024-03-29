---
subcategory: "Logic App"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_logic_app_standard"
description: |-
  Manages a Logic Application (Standard / Single Tenant).

---

# azurermLogicAppStandard

Manages a Logic App (Standard / Single Tenant)

## Example Usage (with App Service Plan)

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example",
  {
    location: "West Europe",
    name: "azure-functions-test-rg",
  }
);
const azurermStorageAccountExample = new azurerm.storageAccount.StorageAccount(
  this,
  "example_1",
  {
    account_replication_type: "LRS",
    account_tier: "Standard",
    location: azurermResourceGroupExample.location,
    name: "functionsapptestsa",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const azurermAppServicePlanExample = new azurerm.appServicePlan.AppServicePlan(
  this,
  "example_2",
  {
    kind: "elastic",
    location: azurermResourceGroupExample.location,
    name: "azure-functions-test-service-plan",
    resource_group_name: azurermResourceGroupExample.name,
    sku: [
      {
        size: "WS1",
        tier: "WorkflowStandard",
      },
    ],
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermAppServicePlanExample.overrideLogicalId("example");
const azurermLogicAppStandardExample =
  new azurerm.logicAppStandard.LogicAppStandard(this, "example_3", {
    app_service_plan_id: azurermAppServicePlanExample.id,
    app_settings: [
      {
        FUNCTIONS_WORKER_RUNTIME: "node",
        WEBSITE_NODE_DEFAULT_VERSION: "~18",
      },
    ],
    location: azurermResourceGroupExample.location,
    name: "test-azure-functions",
    resource_group_name: azurermResourceGroupExample.name,
    storage_account_access_key: azurermStorageAccountExample.primaryAccessKey,
    storage_account_name: azurermStorageAccountExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLogicAppStandardExample.overrideLogicalId("example");

```

## Example Usage (for container mode)

\~> **Note:** You must set `azurermAppServicePlan` `kind` to `linux` and `reserved` to `true` when used with `linuxFxVersion`

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example",
  {
    location: "West Europe",
    name: "azure-functions-test-rg",
  }
);
const azurermStorageAccountExample = new azurerm.storageAccount.StorageAccount(
  this,
  "example_1",
  {
    account_replication_type: "LRS",
    account_tier: "Standard",
    location: azurermResourceGroupExample.location,
    name: "functionsapptestsa",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const azurermAppServicePlanExample = new azurerm.appServicePlan.AppServicePlan(
  this,
  "example_2",
  {
    kind: "Linux",
    location: azurermResourceGroupExample.location,
    name: "azure-functions-test-service-plan",
    reserved: true,
    resource_group_name: azurermResourceGroupExample.name,
    sku: [
      {
        size: "WS1",
        tier: "WorkflowStandard",
      },
    ],
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermAppServicePlanExample.overrideLogicalId("example");
const azurermLogicAppStandardExample =
  new azurerm.logicAppStandard.LogicAppStandard(this, "example_3", {
    app_service_plan_id: azurermAppServicePlanExample.id,
    app_settings: [
      {
        DOCKER_REGISTRY_SERVER_PASSWORD: "password",
        DOCKER_REGISTRY_SERVER_URL: "https://<server-name>.azurecr.io",
        DOCKER_REGISTRY_SERVER_USERNAME: "username",
      },
    ],
    location: azurermResourceGroupExample.location,
    name: "test-azure-functions",
    resource_group_name: azurermResourceGroupExample.name,
    site_config: [
      {
        linux_fx_version:
          "DOCKER|mcr.microsoft.com/azure-functions/dotnet:3.0-appservice",
      },
    ],
    storage_account_access_key: azurermStorageAccountExample.primaryAccessKey,
    storage_account_name: azurermStorageAccountExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLogicAppStandardExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Specifies the name of the Logic App Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the resource group in which to create the Logic App. Changing this forces a new resource to be created.

*   `location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.

*   `appServicePlanId` - (Required) The ID of the App Service Plan within which to create this Logic App

*   `appSettings` - (Optional) A map of key-value pairs for [App Settings](https://docs.microsoft.com/azure/azure-functions/functions-app-settings) and custom values.

\~> **NOTE:** There are a number of application settings that will be managed for you by this resource type and *shouldn't* be configured separately as part of the app\_settings you specify.  `azureWebJobsStorage` is filled based on `storageAccountName` and `storageAccountAccessKey`. `websiteContentshare` is detailed below. `functionsExtensionVersion` is filled based on `version`. `appKind` is set to workflowApp and `azureFunctionsJobHostExtensionBundleId` and `azureFunctionsJobHostExtensionBundleVersion` are set as detailed below.

*   `useExtensionBundle` - (Optional) Should the logic app use the bundled extension package? If true, then application settings for `azureFunctionsJobHostExtensionBundleId` and `azureFunctionsJobHostExtensionBundleVersion` will be created. Defaults to `true`.

*   `bundleVersion` - (Optional) If `useExtensionBundle` then controls the allowed range for bundle versions. Default `[1.*,200)`

*   `connectionString` - (Optional) An `connectionString` block as defined below.

*   `clientAffinityEnabled` - (Optional) Should the Logic App send session affinity cookies, which route client requests in the same session to the same instance?

*   `clientCertificateMode` - (Optional) The mode of the Logic App's client certificates requirement for incoming requests. Possible values are `required` and `optional`.

*   `enabled` - (Optional) Is the Logic App enabled? Defaults to `true`.

*   `httpsOnly` - (Optional) Can the Logic App only be accessed via HTTPS? Defaults to `false`.

*   `identity` - (Optional) An `identity` block as defined below.

*   `siteConfig` - (Optional) A `siteConfig` object as defined below.

*   `storageAccountName` - (Required) The backend storage account name which will be used by this Logic App (e.g. for Stateful workflows data). Changing this forces a new resource to be created.

*   `storageAccountAccessKey` - (Required) The access key which will be used to access the backend storage account for the Logic App

*   `storageAccountShareName` - (Optional) The name of the share used by the logic app, if you want to use a custom name. This corresponds to the WEBSITE\_CONTENTSHARE appsetting, which this resource will create for you. If you don't specify a name, then this resource will generate a dynamic name. This setting is useful if you want to provision a storage account and create a share using azurerm\_storage\_share

\~> **Note:** When integrating a `ci/cdPipeline` and expecting to run from a deployed package in `azure` you must seed your `appSettings` as part of terraform code for Logic App to be successfully deployed. `importantDefaultKeyPairs`: (`"websiteRunFromPackage" = ""`, `"functionsWorkerRuntime" = "node"` (or Python, etc), `"websiteNodeDefaultVersion" = "10141"`, `"appinsightsInstrumentationkey" = ""`).

\~> **Note:**  When using an App Service Plan in the `free` or `shared` Tiers `use32BitWorkerProcess` must be set to `true`.

*   `version` - (Optional) The runtime version associated with the Logic App Defaults to `~3`.

*   `virtualNetworkSubnetId` - (Optional) The subnet id which will be used by this resource for [regional virtual network integration](https://docs.microsoft.com/en-us/azure/app-service/overview-vnet-integration#regional-virtual-network-integration).

\~> **NOTE on regional virtual network integration:** The AzureRM Terraform provider provides regional virtual network integration via the standalone resource [app\_service\_virtual\_network\_swift\_connection](app_service_virtual_network_swift_connection.html) and in-line within this resource using the `virtualNetworkSubnetId` property. You cannot use both methods simutaneously.

\~> **Note:** Assigning the `virtualNetworkSubnetId` property requires [RBAC permissions on the subnet](https://docs.microsoft.com/en-us/azure/app-service/overview-vnet-integration#permissions)

* `tags` - (Optional) A mapping of tags to assign to the resource.

***

The `connectionString` block supports the following:

*   `name` - (Required) The name of the Connection String.

*   `type` - (Required) The type of the Connection String. Possible values are `apiHub`, `custom`, `docDb`, `eventHub`, `mySql`, `notificationHub`, `postgreSql`, `redisCache`, `serviceBus`, `sqlAzure` and `sqlServer`.

*   `value` - (Required) The value for the Connection String.

***

The `siteConfig` block supports the following:

*   `alwaysOn` - (Optional) Should the Logic App be loaded at all times? Defaults to `false`.

*   `appScaleLimit` - (Optional) The number of workers this Logic App can scale out to. Only applicable to apps on the Consumption and Premium plan.

*   `cors` - (Optional) A `cors` block as defined below.

*   `dotnetFrameworkVersion` - (Optional) The version of the .NET framework's CLR used in this Logic App Possible values are `v40` (including .NET Core 2.1 and 3.1), `v50` and `v60`. [For more information on which .NET Framework version to use based on the runtime version you're targeting - please see this table](https://docs.microsoft.com/azure/azure-functions/functions-dotnet-class-library#supported-versions). Defaults to `v40`.

*   `elasticInstanceMinimum` - (Optional) The number of minimum instances for this Logic App Only affects apps on the Premium plan.

*   `ftpsState` - (Optional) State of FTP / FTPS service for this Logic App Possible values include: `allAllowed`, `ftpsOnly` and `disabled`. Defaults to `allAllowed`.

*   `healthCheckPath` - (Optional) Path which will be checked for this Logic App health.

*   `http2Enabled` - (Optional) Specifies whether or not the HTTP2 protocol should be enabled. Defaults to `false`.

*   `ipRestriction` - (Optional) A [List of objects](/docs/configuration/attr-as-blocks.html) representing IP restrictions as defined below.

\-> **NOTE** User has to explicitly set `ipRestriction` to empty slice (`[]`) to remove it.

* `scmIpRestriction` - (Optional) A [List of objects](/docs/configuration/attr-as-blocks.html) representing SCM IP restrictions as defined below.

\-> **NOTE** User has to explicitly set `scmIpRestriction` to empty slice (`[]`) to remove it.

*   `scmUseMainIpRestriction` - (Optional) Should the Logic App `ipRestriction` configuration be used for the SCM too. Defaults to `false`.

*   `scmMinTlsVersion` - (Optional) Configures the minimum version of TLS required for SSL requests to the SCM site. Possible values are `10`, `11` and `12`.

*   `scmType` - (Optional) The type of Source Control used by the Logic App in use by the Windows Function App. Defaults to `none`. Possible values are: `bitbucketGit`, `bitbucketHg`, `codePlexGit`, `codePlexHg`, `dropbox`, `externalGit`, `externalHg`, `gitHub`, `localGit`, `none`, `oneDrive`, `tfs`, `vso`, and `vstsrm`

*   `linuxFxVersion` - (Optional) Linux App Framework and version for the AppService, e.g. `docker|(golang:latest)`. Setting this value will also set the `kind` of application deployed to `functionapp,linux,container,workflowapp`

*   `minTlsVersion` - (Optional) The minimum supported TLS version for the Logic App Possible values are `10`, `11`, and `12`. Defaults to `12` for new Logic Apps.

*   `preWarmedInstanceCount` - (Optional) The number of pre-warmed instances for this Logic App Only affects apps on the Premium plan.

*   `runtimeScaleMonitoringEnabled` - (Optional) Should Runtime Scale Monitoring be enabled?. Only applicable to apps on the Premium plan. Defaults to `false`.

*   `use32BitWorkerProcess` - (Optional) Should the Logic App run in 32 bit mode, rather than 64 bit mode? Defaults to `true`.

\~> **Note:** when using an App Service Plan in the `free` or `shared` Tiers `use32BitWorkerProcess` must be set to `true`.

*   `vnetRouteAllEnabled` - (Optional) Should all outbound traffic to have Virtual Network Security Groups and User Defined Routes applied.

*   `websocketsEnabled` - (Optional) Should WebSockets be enabled?

***

A `cors` block supports the following:

*   `allowedOrigins` - (Required) A list of origins which should be able to make cross-origin calls. `*` can be used to allow all calls.

*   `supportCredentials` - (Optional) Are credentials supported?

***

An `identity` block supports the following:

* `type` - (Required) Specifies the type of Managed Service Identity that should be configured on this Logic App Standard. Possible values are `systemAssigned`, `userAssigned` and `systemAssigned,UserAssigned` (to enable both).
* `identityIds` - (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Logic App Standard.

\~> **NOTE:** When `type` is set to `systemAssigned`, The assigned `principalId` and `tenantId` can be retrieved after the Logic App has been created. More details are available below.

\~> **NOTE:** The `identityIds` is required when `type` is set to `userAssigned` or `systemAssigned,UserAssigned`.

***

A `ipRestriction` block supports the following:

*   `ipAddress` - (Optional) The IP Address used for this IP Restriction in CIDR notation.

*   `serviceTag` - (Optional) The Service Tag used for this IP Restriction.

*   `virtualNetworkSubnetId` - (Optional) The Virtual Network Subnet ID used for this IP Restriction.

\-> **NOTE:** One of either `ipAddress`, `serviceTag` or `virtualNetworkSubnetId` must be specified

*   `name` - (Optional) The name for this IP Restriction.

*   `priority` - (Optional) The priority for this IP Restriction. Restrictions are enforced in priority order. By default, the priority is set to 65000 if not specified.

*   `action` - (Optional) Does this restriction `allow` or `deny` access for this IP range. Defaults to `allow`.

*   `headers` - (Optional) The headers for this specific `ipRestriction` as defined below.

***

A `scmIpRestriction` block supports the following:

*   `ipAddress` - (Optional) The IP Address used for this IP Restriction in CIDR notation.

*   `serviceTag` - (Optional) The Service Tag used for this IP Restriction.

*   `virtualNetworkSubnetId` - (Optional) The Virtual Network Subnet ID used for this IP Restriction.

\-> **NOTE:** One of either `ipAddress`, `serviceTag` or `virtualNetworkSubnetId` must be specified

*   `name` - (Optional) The name for this IP Restriction.

*   `priority` - (Optional) The priority for this IP Restriction. Restrictions are enforced in priority order. By default, the priority is set to 65000 if not specified.

*   `action` - (Optional) Does this restriction `allow` or `deny` access for this IP range. Defaults to `allow`.

*   `headers` - (Optional) The headers for this specific `ipRestriction` as defined below.

***

A `headers` block supports the following:

*   `xAzureFdid` - (Optional) A list of allowed Azure FrontDoor IDs in UUID notation with a maximum of 8.

*   `xFdHealthProbe` - (Optional) A list to allow the Azure FrontDoor health probe header. Only allowed value is "1".

*   `xForwardedFor` - (Optional) A list of allowed 'X-Forwarded-For' IPs in CIDR notation with a maximum of 8

*   `xForwardedHost` - (Optional) A list of allowed 'X-Forwarded-Host' domains with a maximum of 8.

## Attributes Reference

The following attributes are exported:

*   `id` - The ID of the Logic App

*   `customDomainVerificationId` - An identifier used by App Service to perform domain ownership verification via DNS TXT record.

*   `defaultHostname` - The default hostname associated with the Logic App - such as `mysiteAzurewebsitesNet`

*   `outboundIpAddresses` - A comma separated list of outbound IP addresses - such as `5223253,521434312`

*   `possibleOutboundIpAddresses` - A comma separated list of outbound IP addresses - such as `5223253,521434312,521434317` - not all of which are necessarily in use. Superset of `outboundIpAddresses`.

*   `identity` - An `identity` block as defined below, which contains the Managed Service Identity information for this App Service.

*   `siteCredential` - A `siteCredential` block as defined below, which contains the site-level credentials used to publish to this App Service.

*   `kind` - The Logic App kind - will be `functionapp,workflowapp`

***

The `identity` block exports the following:

*   `principalId` - The Principal ID for the Service Principal associated with the Managed Service Identity of this App Service.

*   `tenantId` - The Tenant ID for the Service Principal associated with the Managed Service Identity of this App Service.

\-> You can access the Principal ID via `azurermAppServiceExampleIdentity0PrincipalId` and the Tenant ID via `azurermAppServiceExampleIdentity0TenantId`

***

The `siteCredential` block exports the following:

*   `username` - The username which can be used to publish to this App Service

*   `password` - The password associated with the username, which can be used to publish to this App Service.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Logic App
* `update` - (Defaults to 30 minutes) Used when updating the Logic App
* `read` - (Defaults to 5 minutes) Used when retrieving the Logic App
* `delete` - (Defaults to 30 minutes) Used when deleting the Logic App

## Import

Logic Apps can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_logic_app_standard.logicapp1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Web/sites/logicapp1
```
