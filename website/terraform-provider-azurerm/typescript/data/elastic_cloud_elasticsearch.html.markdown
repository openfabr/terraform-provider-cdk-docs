---
subcategory: "Elastic"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_elastic_cloud_elasticsearch"
description: |- 
    Gets information about an existing Elasticsearch resource.

---

# Data Source: azurermElasticCloudElasticsearch

Use this data source to access information about an existing Elasticsearch resource.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermElasticCloudElasticsearchExample =
  new azurerm.dataAzurermElasticCloudElasticsearch.DataAzurermElasticCloudElasticsearch(
    this,
    "example",
    {
      name: "my-elastic-search",
      resource_group_name: "example-resources",
    }
  );
new cdktf.TerraformOutput(this, "elasticsearch_endpoint", {
  value: dataAzurermElasticCloudElasticsearchExample.elasticsearchServiceUrl,
});
new cdktf.TerraformOutput(this, "kibana_endpoint", {
  value: dataAzurermElasticCloudElasticsearchExample.kibanaServiceUrl,
});

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name of the Elasticsearch resource.

*   `resourceGroupName` - (Required) The name of the resource group in which the Elasticsearch exists.

## Attributes Reference

The following attributes are exported:

*   `id` - The ID of the Elasticsearch.

*   `elasticCloudDeploymentId` - The ID of the Deployment within Elastic Cloud.

*   `elasticCloudEmailAddress` - The Email Address which is associated with this Elasticsearch account.

*   `elasticCloudSsoDefaultUrl` - The Default URL used for Single Sign On (SSO) to Elastic Cloud.

*   `elasticCloudUserId` - The ID of the User Account within Elastic Cloud.

*   `elasticsearchServiceUrl` - The URL to the Elasticsearch Service associated with this Elasticsearch.

*   `kibanaServiceUrl` - The URL to the Kibana Dashboard associated with this Elasticsearch.

*   `kibanaSsoUri` - The URI used for SSO to the Kibana Dashboard associated with this Elasticsearch.

*   `location` - The Azure Region in which this Elasticsearch exists.

*   `logs` - A `logs` block as defined below.

*   `monitoringEnabled` - Specifies if monitoring is enabled on this Elasticsearch or not.

*   `skuName` - The name of the SKU used for this Elasticsearch.

*   `tags` - A mapping of tags assigned to the Elasticsearch.

***

The `filteringTag` block exports the following:

*   `action` - The type of action which is taken when the Tag matches the `name` and `value`.

*   `name` - The name (key) of the Tag which should be filtered.

*   `value` - The value of the Tag which should be filtered.

***

The `logs` block exports the following:

*   `filteringTag` - A list of `filteringTag` blocks as defined above.

*   `sendActivityLogs` - Should the Azure Activity Logs should be sent to the Elasticsearch cluster?

*   `sendAzureadLogs` - Should the AzureAD Logs should be sent to the Elasticsearch cluster?

*   `sendSubscriptionLogs` - Should the Azure Subscription Logs should be sent to the Elasticsearch cluster?

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Elasticsearch.
