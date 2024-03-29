---
subcategory: "Elastic Beanstalk"
layout: "aws"
page_title: "AWS: aws_elastic_beanstalk_configuration_template"
description: |-
  Provides an Elastic Beanstalk Configuration Template
---

# Resource: awsElasticBeanstalkConfigurationTemplate

Provides an Elastic Beanstalk Configuration Template, which are associated with
a specific application and are used to deploy different versions of the
application with the same configuration settings.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsElasticBeanstalkApplicationTftest =
  new aws.elasticBeanstalkApplication.ElasticBeanstalkApplication(
    this,
    "tftest",
    {
      description: "tf-test-desc",
      name: "tf-test-name",
    }
  );
new aws.elasticBeanstalkConfigurationTemplate.ElasticBeanstalkConfigurationTemplate(
  this,
  "tf_template",
  {
    application: awsElasticBeanstalkApplicationTftest.name,
    name: "tf-test-template-config",
    solutionStackName: "64bit Amazon Linux 2015.09 v2.0.8 running Go 1.4",
  }
);

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) A unique name for this Template.
* `application` – (Required) name of the application to associate with this configuration template
* `description` - (Optional) Short description of the Template
* `environmentId` – (Optional) The ID of the environment used with this configuration template
* `setting` – (Optional) Option settings to configure the new Environment. These
  override specific values that are set as defaults. The format is detailed
  below in [Option Settings](#option-settings)
* `solutionStackName` – (Optional) A solution stack to base your Template
  off of. Example stacks can be found in the [Amazon API documentation][1]

## Option Settings

The `setting` field supports the following format:

* `namespace` - unique namespace identifying the option's associated AWS resource
* `name` - name of the configuration option
* `value` - value for the configuration option
* `resource` - (Optional) resource name for [scheduled action](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html#command-options-general-autoscalingscheduledaction)

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `name`
* `application`
* `description`
* `environmentId`
* `optionSettings`
* `solutionStackName`

[1]: https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/concepts.platforms.html
