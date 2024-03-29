---
subcategory: "Spring Cloud"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_spring_cloud_connection"
description: |-
  Manages a service connector for spring cloud app.
---

# azurermSpringCloudConnection

Manages a service connector for spring cloud app.

## Example Usage

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
    name: "example-resources",
  }
);
const azurermSpringCloudServiceExample =
  new azurerm.springCloudService.SpringCloudService(this, "example_1", {
    location: azurermResourceGroupExample.location,
    name: "examplespringcloud",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSpringCloudServiceExample.overrideLogicalId("example");
const azurermCosmosdbAccountExample =
  new azurerm.cosmosdbAccount.CosmosdbAccount(this, "example_2", {
    consistency_policy: [
      {
        consistency_level: "BoundedStaleness",
        max_interval_in_seconds: 10,
        max_staleness_prefix: 200,
      },
    ],
    geo_location: [
      {
        failover_priority: 0,
        location: azurermResourceGroupExample.location,
      },
    ],
    kind: "GlobalDocumentDB",
    location: azurermResourceGroupExample.location,
    name: "example-cosmosdb-account",
    offer_type: "Standard",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermCosmosdbAccountExample.overrideLogicalId("example");
const azurermCosmosdbSqlDatabaseExample =
  new azurerm.cosmosdbSqlDatabase.CosmosdbSqlDatabase(this, "example_3", {
    account_name: azurermCosmosdbAccountExample.name,
    name: "cosmos-sql-db",
    resource_group_name: azurermCosmosdbAccountExample.resourceGroupName,
    throughput: 400,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermCosmosdbSqlDatabaseExample.overrideLogicalId("example");
const azurermSpringCloudAppExample = new azurerm.springCloudApp.SpringCloudApp(
  this,
  "example_4",
  {
    identity: [
      {
        type: "SystemAssigned",
      },
    ],
    name: "examplespringcloudapp",
    resource_group_name: azurermResourceGroupExample.name,
    service_name: azurermSpringCloudServiceExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSpringCloudAppExample.overrideLogicalId("example");
const azurermSpringCloudJavaDeploymentExample =
  new azurerm.springCloudJavaDeployment.SpringCloudJavaDeployment(
    this,
    "example_5",
    {
      name: "exampledeployment",
      spring_cloud_app_id: azurermSpringCloudAppExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSpringCloudJavaDeploymentExample.overrideLogicalId("example");
const azurermCosmosdbSqlContainerExample =
  new azurerm.cosmosdbSqlContainer.CosmosdbSqlContainer(this, "example_6", {
    account_name: azurermCosmosdbAccountExample.name,
    database_name: azurermCosmosdbSqlDatabaseExample.name,
    name: "example-container",
    partition_key_path: "/definition",
    resource_group_name: azurermCosmosdbAccountExample.resourceGroupName,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermCosmosdbSqlContainerExample.overrideLogicalId("example");
const azurermSpringCloudConnectionExample =
  new azurerm.springCloudConnection.SpringCloudConnection(this, "example_7", {
    authentication: [
      {
        type: "systemAssignedIdentity",
      },
    ],
    name: "example-serviceconnector",
    spring_cloud_id: azurermSpringCloudJavaDeploymentExample.id,
    target_resource_id: azurermCosmosdbSqlDatabaseExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSpringCloudConnectionExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the service connection. Changing this forces a new resource to be created.

*   `springCloudId` - (Required) The ID of the data source spring cloud. Changing this forces a new resource to be created.

*   `targetResourceId` - (Required) The ID of the target resource. Changing this forces a new resource to be created. Possible values are `postgres`, `postgresFlexible`, `mysql`, `sql`, `redis`, `redisEnterprise`, `cosmosCassandra`, `cosmosGremlin`, `cosmosMongo`, `cosmosSql`, `cosmosTable`, `storageBlob`, `storageQueue`, `storageFile`, `storageTable`, `appConfig`, `eventHub`, `serviceBus`, `signalR`, `webPubSub`, `confluentKafka`.

*   `authentication` - (Required) The authentication info. An `authentication` block as defined below.

***

An `authentication` block supports the following:

*   `type` - (Required) The authentication type. Possible values are `systemAssignedIdentity`, `userAssignedIdentity`, `servicePrincipalSecret`, `servicePrincipalCertificate`, `secret`. Changing this forces a new resource to be created.

*   `name` - (Optional) Username or account name for secret auth. `name` and `secret` should be either both specified or both not specified when `type` is set to `secret`.

*   `secret` - (Optional) Password or account key for secret auth. `secret` and `name` should be either both specified or both not specified when `type` is set to `secret`.

*   `clientId` - (Optional) Client ID for `userAssignedIdentity` or `servicePrincipal` auth. Should be specified when `type` is set to `servicePrincipalSecret` or `servicePrincipalCertificate`. When `type` is set to `userAssignedIdentity`, `clientId` and `subscriptionId` should be either both specified or both not specified.

*   `subscriptionId` - (Optional) Subscription ID for `userAssignedIdentity`. `subscriptionId` and `clientId` should be either both specified or both not specified.

*   `principalId` - (Optional) Principal ID for `servicePrincipal` auth. Should be specified when `type` is set to `servicePrincipalSecret` or `servicePrincipalCertificate`.

*   `certificate` - (Optional) Service principal certificate for `servicePrincipal` auth. Should be specified when `type` is set to `servicePrincipalCertificate`.

***

*   `clientType` - (Optional) The application client type. Possible values are `none`, `dotnet`, `java`, `python`, `go`, `php`, `ruby`, `django`, `nodejs` and `springBoot`.

*   `vnetSolution` - (Optional) The type of the VNet solution. Possible values are `serviceEndpoint`, `privateLink`.

*   `secretStore` - (Optional) An option to store secret value in secure place. An `secretStore` block as defined below.

***

An `secretStore` block supports the following:

* `keyVaultId` - (required) The key vault id to store secret.

## Attribute Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the service connector.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/docs/configuration/resources.html#timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Service Connector for spring cloud.
* `read` - (Defaults to 5 minutes) Used when retrieving the Service Connector for spring cloud.
* `update` - (Defaults to 30 minutes) Used when updating the Service Connector for spring cloud.
* `delete` - (Defaults to 30 minutes) Used when deleting the Service Connector for spring cloud.

## Import

Service Connector for spring cloud can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_spring_cloud_connection.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.AppPlatform/Spring/springcloud/apps/springcloudapp/deployments/deployment/providers/Microsoft.ServiceLinker/linkers/serviceconnector1
```
