output "configuration_properties_merged" {
  value = local.configuration_properties_merged
}

# output "kubernetes_manifest" {
#   value = kubernetes_manifest.kafka_connect_workers.*
# }

# output "connectors" {
#   value = jsondecode(data.http.connectors.body)
# }

# output "connectors_status" {
#   value = [for response in data.http.connectors_status : jsondecode(response.body)]
# }