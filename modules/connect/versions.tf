terraform {
  required_version = ">= 1.0.5"

  required_providers {
    aws           = ">= 3.40.0"
    kafka-connect = ">= 0.2.3"
    kubernetes    = ">= 2.4.1"
    helm          = ">= 2.2.0"
    http = {
      source  = "terraform-aws-modules/http"
      version = ">= 2.4.1"
    }
  }
}