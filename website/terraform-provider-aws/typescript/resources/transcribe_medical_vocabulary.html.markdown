---
subcategory: "Transcribe"
layout: "aws"
page_title: "AWS: aws_transcribe_medical_vocabulary"
description: |-
  Terraform resource for managing an AWS Transcribe MedicalVocabulary.
---

# Resource: awsTranscribeMedicalVocabulary

Terraform resource for managing an AWS Transcribe MedicalVocabulary.

## Example Usage

### Basic Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsS3BucketExample = new aws.s3Bucket.S3Bucket(this, "example", {
  bucket: "example-medical-vocab-123",
  forceDestroy: true,
});
const awsS3ObjectObject = new aws.s3Object.S3Object(this, "object", {
  bucket: awsS3BucketExample.id,
  key: "transcribe/test1.txt",
  source: "test.txt",
});
const awsTranscribeMedicalVocabularyExample =
  new aws.transcribeMedicalVocabulary.TranscribeMedicalVocabulary(
    this,
    "example_2",
    {
      depends_on: [`\${${awsS3ObjectObject.fqn}}`],
      languageCode: "en-US",
      tags: {
        tag1: "value1",
        tag2: "value3",
      },
      vocabularyFileUri: `s3://\${${awsS3BucketExample.id}}/\${${awsS3ObjectObject.key}}`,
      vocabularyName: "example",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsTranscribeMedicalVocabularyExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are required:

* `languageCode` - (Required) The language code you selected for your medical vocabulary. US English (en-US) is the only language supported with Amazon Transcribe Medical.
* `vocabularyFileUri` - (Required) The Amazon S3 location (URI) of the text file that contains your custom medical vocabulary.
* `vocabularyName` - (Required) The name of the Medical Vocabulary.

The following arguments are optional:

* `tags` - (Optional) A map of tags to assign to the MedicalVocabulary. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Name of the MedicalVocabulary.
* `arn` - ARN of the MedicalVocabulary.
* `downloadUri` - Generated download URI.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `30M`)
* `update` - (Default `30M`)
* `delete` - (Default `30M`)

## Import

Transcribe MedicalVocabulary can be imported using the `vocabularyName`, e.g.,

```console
$ terraform import aws_transcribe_medical_vocabulary.example example-name
```
