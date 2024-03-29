---
# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    Type: MMv1     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in
#     .github/CONTRIBUTING.md.
#
# ----------------------------------------------------------------------------
subcategory: "Document AI"
description: |-
  The default version for the processor.
---

# googleDocumentAiProcessorDefaultVersion

The default version for the processor. Deleting this resource is a no-op, and does not unset the default version.

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=documentai_default_version&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Documentai Default Version

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleDocumentAiProcessorProcessor =
  new google.documentAiProcessor.DocumentAiProcessor(this, "processor", {
    display_name: "test-processor",
    location: "us",
    type: "OCR_PROCESSOR",
  });
const googleDocumentAiProcessorDefaultVersionProcessor =
  new google.documentAiProcessorDefaultVersion.DocumentAiProcessorDefaultVersion(
    this,
    "processor_1",
    {
      processor: googleDocumentAiProcessorProcessor.id,
      version: `\${${googleDocumentAiProcessorProcessor.id}}/processorVersions/stable`,
    }
  );
googleDocumentAiProcessorDefaultVersionProcessor.addOverride("lifecycle", [
  {
    ignore_changes: ["${version}"],
  },
]);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
googleDocumentAiProcessorDefaultVersionProcessor.overrideLogicalId("processor");

```

## Argument Reference

The following arguments are supported:

*   `version` -
    (Required)
    The version to set. Using `stable` or `rc` will cause the API to return the latest version in that release channel.
    Apply `lifecycleIgnoreChanges` to the `version` field to suppress this diff.

*   `processor` -
    (Required)
    The processor to set the version on.

***

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

* `id` - an identifier for the resource with format `{{processor}}`

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

ProcessorDefaultVersion can be imported using any of these accepted formats:

```console
$ terraform import google_document_ai_processor_default_version.default {{processor}}
```
