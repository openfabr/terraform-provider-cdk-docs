# Terraform Provider CDK Docs

This repo contains Terrform Provider CDK docs for TypeScript, Python, Java, and CSharp. They are auto generated from the respective providers HCL docs. The HCL code block conversion is done by running the OpenFABR HCL2CDK batch converter. Under-the-hood this converter uses `@cdktf/hcl2cdk` which is used by the CDKTF CLI Convert fesature.  

## Repo structure conventions

- website-docs
  - provider-repo-name1
    - typescript
    - python
    - java
    - csharp
  - provider-repo-name2
    - typescript
    - python
    - java
    - csharp

## Generating CDK docs

Source Markdown docs are in each provider repo. The batch converter is run again this source. Output Markdown files are written to this repo. Then the MKDocs static site generator is run to publish as a HTML website.

- clone a provider repo
- create a branch on this repo
- run the converter with the input folder set to `<provider-repo>/website/docs` and output set to the respective folder in this repo `terraform-provider-cdk-docs/website/<provider-name>/<language>`.
- check and commit the newly added docs
- when ready merge into main (specific workflow tbd)
- TODO: GH acion to generate site (using MKdocs)
- same process for _updating_ docs.

## Local - compline and preview

- run `./perview-website.sh` (requires Docker)

## License

[LICENSE](./LICENSE)
