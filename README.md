[![Lint Status](https://github.com/aidanmelen/terraform-eks-cfk/workflows/Lint/badge.svg)](https://github.com/aidanmelen/terraform-eks-cfk/actions)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![cookiecutter-tf-module](https://img.shields.io/badge/cookiecutter--tf--module-enabled-brightgreen)](https://github.com/aidanmelen/cookiecutter-tf-module)
[![tflint](https://img.shields.io/badge/code--style-tflint-black)](https://github.com/terraform-linters/tflint)

# terraform-eks-cfk

Terraform module to run a Confluent for Kubernetes (CFK) platform on AWS Elastic Kubernetes Service (EKS).

## Usage

### basic example

A basic example can be found at [examples/basic](examples/basic).

```hcl
module "terraform-eks-cfk" {
  source  = "app.terraform.io/example_corp/vpc/aws"
}
```

### complete example

A complete example can be found at [examples/complete](examples/complete).

```hcl
module "terraform-eks-cfk" {
  source  = "app.terraform.io/example_corp/vpc/aws"
}
```

## Makefile Targets

```text
Available targets:

  all                                 Run install and lint
  install                             Initialize and install pre-commit
  lint                                Lint terraform code
  test                                Run basic and complete example tests
  test-basic                         Run basic example test
  test-complete                       Run complete example test
```

## License

MIT Licensed. See [LICENSE](https://github.com/aidanmelen/terraform-eks-cfk/tree/master/LICENSE) for full details.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.5 |

## Providers

No provider.

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| hello\_world | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
