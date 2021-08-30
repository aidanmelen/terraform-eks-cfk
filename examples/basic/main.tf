module "terraform_eks_cfk" {
  source = "../../"

  create_cfk_operator       = false
  create_connect_workers    = false
  create_connect_connectors = false
}
