# data "http" "connectors" {
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
#     "http://%s:8083/connectors/${lower(replace(each.key,".", "-"))}/status",
#     data.kubernetes_service.kafka_connect.status.0.load_balancer.0.ingress.0.hostname
#   )

#   request_headers = {
#     Accept = "application/json"
#   }
# }