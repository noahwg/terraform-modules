# terraform-modules

Reusable Terraform modules organized by cloud provider and service category.

## Repository Structure

```
modules/<provider>/<category>/<module>/    # Module source code
examples/<provider>/<category>/<module>/   # Usage examples
```

## Using a Module

Reference a module from this repo using a Git source:

```hcl
module "my_table" {
  source = "git::https://github.com/noahwg/terraform-modules.git//modules/aws/storage/dynamo-db?ref=main"

  name     = "MyTable"
  hash_key = "id"

  attributes = [
    {
      name = "id"
      type = "S"
    },
  ]
}
```

Or with a relative path if working locally:

```hcl
module "my_table" {
  source = "../path/to/terraform-modules/modules/aws/storage/dynamo-db"
}
```

Each module has an auto-generated `README.md` with full documentation of inputs, outputs, and resources.

Pin to a specific version using the module's tag:

```hcl
module "my_table" {
  source = "git::https://github.com/noahwg/terraform-modules.git//modules/aws/storage/dynamo-db?ref=dynamo-db/v1.0.0"
}
```

## Tagging and Versioning

Each module is versioned independently using git tags in the format `<module-name>/v<major>.<minor>.<patch>`.

```sh
./tag-module.sh dynamo-db           # patch bump: dynamo-db/v0.0.1
./tag-module.sh dynamo-db --minor   # minor bump: dynamo-db/v0.1.0
./tag-module.sh dynamo-db --major   # major bump: dynamo-db/v1.0.0
```

The script searches `modules/` to verify the module exists before creating a tag. If multiple modules share the same name, it will error and ask you to disambiguate.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- [pre-commit](https://pre-commit.com/#install) (`pip install pre-commit`)
- [terraform-docs](https://terraform-docs.io/user-guide/installation/) (`brew install terraform-docs`)
- [tflint](https://github.com/terraform-linters/tflint#installation) (`brew install tflint`)

## Pre-commit Setup

```sh
pre-commit install
```

To run all hooks manually:

```sh
pre-commit run --all-files
```
