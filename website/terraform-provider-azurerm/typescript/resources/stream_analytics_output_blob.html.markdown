---
subcategory: "Stream Analytics"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_stream_analytics_output_blob"
description: |-
  Manages a Stream Analytics Output to Blob Storage.
---

# azurermStreamAnalyticsOutputBlob

Manages a Stream Analytics Output to Blob Storage.

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
    name: "rg-example",
  }
);
const azurermStorageAccountExample = new azurerm.storageAccount.StorageAccount(
  this,
  "example_1",
  {
    account_replication_type: "LRS",
    account_tier: "Standard",
    location: azurermResourceGroupExample.location,
    name: "examplesa",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const azurermStorageContainerExample =
  new azurerm.storageContainer.StorageContainer(this, "example_2", {
    container_access_type: "private",
    name: "example",
    storage_account_name: azurermStorageAccountExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageContainerExample.overrideLogicalId("example");
const dataAzurermStreamAnalyticsJobExample =
  new azurerm.dataAzurermStreamAnalyticsJob.DataAzurermStreamAnalyticsJob(
    this,
    "example_3",
    {
      name: "example-job",
      resource_group_name: azurermResourceGroupExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAzurermStreamAnalyticsJobExample.overrideLogicalId("example");
const azurermStreamAnalyticsOutputBlobExample =
  new azurerm.streamAnalyticsOutputBlob.StreamAnalyticsOutputBlob(
    this,
    "example_4",
    {
      date_format: "yyyy-MM-dd",
      name: "output-to-blob-storage",
      path_pattern: "some-pattern",
      resource_group_name:
        dataAzurermStreamAnalyticsJobExample.resourceGroupName,
      serialization: [
        {
          encoding: "UTF8",
          field_delimiter: ",",
          type: "Csv",
        },
      ],
      storage_account_key: azurermStorageAccountExample.primaryAccessKey,
      storage_account_name: azurermStorageAccountExample.name,
      storage_container_name: azurermStorageContainerExample.name,
      stream_analytics_job_name: dataAzurermStreamAnalyticsJobExample.name,
      time_format: "HH",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStreamAnalyticsOutputBlobExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the Stream Output. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the Resource Group where the Stream Analytics Job exists. Changing this forces a new resource to be created.

*   `streamAnalyticsJobName` - (Required) The name of the Stream Analytics Job. Changing this forces a new resource to be created.

*   `dateFormat` - (Required) The date format. Wherever `{date}` appears in `pathPattern`, the value of this property is used as the date format instead.

*   `pathPattern` - (Required) The blob path pattern. Not a regular expression. It represents a pattern against which blob names will be matched to determine whether or not they should be included as input or output to the job.

*   `storageAccountName` - (Required) The name of the Storage Account.

*   `storageContainerName` - (Required) The name of the Container within the Storage Account.

*   `timeFormat` - (Required) The time format. Wherever `{time}` appears in `pathPattern`, the value of this property is used as the time format instead.

*   `serialization` - (Required) A `serialization` block as defined below.

*   `authenticationMode` - (Optional) The authentication mode for the Stream Output. Possible values are `msi` and `connectionString`. Defaults to `connectionString`.

*   `batchMaxWaitTime` - (Optional) The maximum wait time per batch in `hh:mm:ss` e.g. `00:02:00` for two minutes.

*   `batchMinRows` - (Optional) The minimum number of rows per batch (must be between `0` and `10000`).

*   `storageAccountKey` - (Optional) The Access Key which should be used to connect to this Storage Account.

***

A `serialization` block supports the following:

* `type` - (Required) The serialization format used for outgoing data streams. Possible values are `avro`, `csv`, `json` and `parquet`.

\-> **NOTE:** `batchMaxWaitTime` and `batchMinRows` are required when `type` is set to `parquet`

* `encoding` - (Optional) The encoding of the incoming data in the case of input and the encoding of outgoing data in the case of output. It currently can only be set to `utf8`.

\-> **NOTE:** This is required when `type` is set to `csv` or `json`.

* `fieldDelimiter` - (Optional) The delimiter that will be used to separate comma-separated value (CSV) records. Possible values are `` (space), `,` (comma), `` (tab), `|` (pipe) and `;`.

\-> **NOTE:** This is required when `type` is set to `csv`.

* `format` - (Optional) Specifies the format of the JSON the output will be written in. Possible values are `array` and `lineSeparated`.

\-> **NOTE:** This is Required and can only be specified when `type` is set to `json`.

## Attributes Reference

The following attributes are exported in addition to the arguments listed above:

* `id` - The ID of the Stream Analytics Output Blob Storage.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Stream Analytics Output Blob Storage.
* `update` - (Defaults to 30 minutes) Used when updating the Stream Analytics Output Blob Storage.
* `read` - (Defaults to 5 minutes) Used when retrieving the Stream Analytics Output Blob Storage.
* `delete` - (Defaults to 30 minutes) Used when deleting the Stream Analytics Output Blob Storage.

## Import

Stream Analytics Outputs to Blob Storage can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_stream_analytics_output_blob.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.StreamAnalytics/streamingJobs/job1/outputs/output1
```
