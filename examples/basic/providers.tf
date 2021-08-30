terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.4.1"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.2.0"
    }

    kafka-connect = {
      source  = "Mongey/kafka-connect"
      version = "0.2.3"
    }

    http = {
      source  = "terraform-aws-modules/http"
      version = ">= 2.4.1"
    }
  }
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.deo_eks_terraform_staging.outputs.eks.cluster_endpoint
  cluster_ca_certificate = data.terraform_remote_state.deo_eks_terraform_staging.outputs.terraform_service_account_cluster_admin_secret_data["ca.crt"]
  token                  = data.terraform_remote_state.deo_eks_terraform_staging.outputs.terraform_service_account_cluster_admin_secret_data["token"]

  experiments {
    manifest_resource = true
  }
}

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.deo_eks_terraform_staging.outputs.eks.cluster_endpoint
    cluster_ca_certificate = data.terraform_remote_state.deo_eks_terraform_staging.outputs.terraform_service_account_cluster_admin_secret_data["ca.crt"]
    token                  = data.terraform_remote_state.deo_eks_terraform_staging.outputs.terraform_service_account_cluster_admin_secret_data["token"]
  }
}

# provider "kafka-connect" {
#   url = format(
#     "http://%s:8083",
#     data.kubernetes_service.kafka_connect.status.0.load_balancer.0.ingress.0.hostname
#   )
# }