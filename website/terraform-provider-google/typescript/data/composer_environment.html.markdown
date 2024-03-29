---
subcategory: "Cloud Composer"
description: |-
  Provides Cloud Composer environment configuration data.
---

# googleComposerEnvironment

Provides access to Cloud Composer environment configuration in a region for a given project.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleComposerEnvironmentComposerEnv =
  new google.composerEnvironment.ComposerEnvironment(this, "composer_env", {
    name: "composer-environment",
  });
const dataGoogleComposerEnvironmentComposerEnv =
  new google.dataGoogleComposerEnvironment.DataGoogleComposerEnvironment(
    this,
    "composer_env_1",
    {
      depends_on: [`\${${googleComposerEnvironmentComposerEnv.fqn}}`],
      name: "${google_composer_environment.test.name}",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataGoogleComposerEnvironmentComposerEnv.overrideLogicalId("composer_env");
new cdktf.TerraformOutput(this, "debug", {
  value: dataGoogleComposerEnvironmentComposerEnv.config,
});

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Name of the environment.

*   `project` - (Optional) The ID of the project in which the resource belongs.
    If it is not provided, the provider project is used.

*   `region` - (Optional) The location or Compute Engine region of the environment.

## Attributes Reference

The following attributes are exported:

*   `id` - An identifier for the resource in format `projects/{{project}}/locations/{{region}}/environments/{{name}}`

*   `config` - Configuration parameters for the environment.
    Full structure is provided by [composer environment resource documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/composer_environment#config).

    *   `config0GkeCluster` -
        The Kubernetes Engine cluster used to run the environment.

    *   `config0DagGcsPrefix` -
        The Cloud Storage prefix of the DAGs for the environment.

    *   `config0AirflowUri` -
        The URI of the Apache Airflow Web UI hosted within the
        environment.
