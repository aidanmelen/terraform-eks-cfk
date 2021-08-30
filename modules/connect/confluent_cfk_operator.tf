# https://www.confluent.io/installation
# https://docs.confluent.io/operator/current/overview.html
resource "helm_release" "cfk_operator" {
  count     = var.create_cfk_operator ? 1 : 0
  name      = "confluent-for-kubernetes-operator"
  namespace = kubernetes_namespace.kafka_connect.id
  chart     = "confluentinc/confluent-for-kubernetes"
  timeout   = 30

  # set {
  #   name  = "licenseKey"
  #   value = var.confluent_for_kubernetes_license_key
  # }
}