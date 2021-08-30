data "kubernetes_service" "kafka_connect" {
  depends_on = [kubernetes_manifest.kafka_connect_workers]

  metadata {
    name      = "connect-bootstrap-lb"
    namespace = kubernetes_namespace.kafka_connect.id
  }
}

# data "http" "connectors" {
#   depends_on = [
#       kafka-connect_connector.key_string_key_string,
#       kafka-connect_connector.key_string_key_avro,
#       kafka-connect_connector.key_avro_key_avro
#   ]

#   url = format(
#     "http://%s:8083/connectors",
#     data.kubernetes_service.kafka_connect.status.0.load_balancer.0.ingress.0.hostname
#   )

#   request_headers = {
#     Accept = "application/json"
#   }
# }

# data "http" "connectors_status" {
#   for_each = toset(concat(local.internal_topics, local.gen1_topics, local.gen2_topics))

#   depends_on = [
#       kafka-connect_connector.key_string_key_string,
#       kafka-connect_connector.key_string_key_avro,
#       kafka-connect_connector.key_avro_key_avro
#   ]

#   url = format(
#     "http://%s:8083/connectors/snowflake-${lower(replace(each.key,".", "-"))}/status",
#     data.kubernetes_service.kafka_connect.status.0.load_balancer.0.ingress.0.hostname
#   )

#   request_headers = {
#     Accept = "application/json"
#   }
# }