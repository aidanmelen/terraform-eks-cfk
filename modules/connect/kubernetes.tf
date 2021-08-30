resource "kubernetes_namespace" "kafka_connect" {
  metadata {
    name = var.kubernetes_namespace
  }
}

resource "kubernetes_secret" "kafka_connect" {
  metadata {
    name      = "kafka-connect"
    namespace = kubernetes_namespace.kafka_connect.id
  }

  data = var.connector_external_secrets_data
}