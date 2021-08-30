variable "bootstrap_servers" {
  type        = list(string)
  description = "A list of host:port pairs to use for establishing the initial connection to the Kafka cluster."
  default     = ["kafka:9092"]
}

# TODO: Need to dynamically set licenseKey in helm_release.cfk_operator 
# https://docs.confluent.io/operator/current/co-license.html#update-co-global-license
# variable "confluent_for_kubernetes_license_key" {
#   type        = string
#   description = "The Confluent for Kuberenetes license key."
# }

variable "confluent_for_kuberetes_chart" {
  type        = string
  description = "The Helm chart for the Confluent for Kubernetes Operator."
  default     = "confluentinc/confluent-for-kubernetes"
}

# https://docs.confluent.io/platform/current/connect/security.html#fileconfigprovider
variable "connector_external_secrets_data" {
  type        = map(string)
  description = "Data to be stored in Kubernetes Secret, mounted to workers, and configured by connectors using the FileConfigProvider."
  default     = { /* "snowflake-properties" = "snowflake.private.key=YOUR_SNOWFLAKE_PRIVATE_KEY_HERE" */ }
  sensitive   = true
}

variable "create_cfk_operator" {
  type        = bool
  description = "Install the Confluent for Kubernetes Operator with Helm chart. This will install the chart specified in confluent_for_kuberetes_chart."
  default     = true
}

variable "create_connect_workers" {
  description = "Whether to create the Kafka Connect workers."
  default     = true
}

variable "create_kubernetes_namespace" {
  type        = bool
  description = "Whether to create the kubernetes namespace or reuse an existing namespace with the name specified in kubernetes_namespace."
  default     = true
}

variable "kubernetes_namespace" {
  description = "The Kubernetes namespace."
  default     = "confluent"
  type        = string
}

# https://docs.confluent.io/operator/current/co-configure-connect.html
variable "worker_application_image" {
  type        = string
  description = "The image URL for the Kafka Connect workers."
  default     = "confluentinc/cp-server-connect-operator:6.1.0.0"
}

variable "worker_init_container_image" {
  type        = string
  description = "The image URL for the init container."
  default     = "confluentinc/cp-init-container-operator:6.1.0.0"
}

# https://docs.confluent.io/platform/current/connect/references/allconfigs.html
variable "worker_server_configuration_properties" {
  type        = map(any)
  description = "Kafka Connect worker configuration properties. These values will override worker_server_configuration_properties_defaults values."
  default = {
    "group.id"                          = "kafka-connect",
    "config.storage.topic"              = "kafka-connect-config",
    "offset.storage.topic"              = "kafka-connect-offset",
    "status.storage.topic"              = "kafka-connect-status"
    "config.storage.replication.factor" = "1",
    "offset.storage.replication.factor" = "1",
    "status.storage.replication.factor" = "1",
    "plugin.path"                       = "/usr/share/java,/usr/share/confluent-hub-components"
  }
}

variable "worker_jvm_configuration_properties" {
  type        = map(any)
  description = "Kafka Connect worker JVM properties."
  default     = {}
}

variable "worker_log4j_configuration_properties" {
  type        = map(any)
  description = "Kafka Connect worker Log4j properties."
  default = {
    "connect.log.pattern" = "[%d] %p %X{connector.context}%m (%c:%L)%n"
  }
}

variable "worker_external_access" {
  type        = any
  description = "Configuration for external access for the Kafka Connect server. Defaults to internal AWS ELB."
  default = {
    type = "loadBalancer"
    "loadBalancer" = {
      "annotations" = {
        "service.beta.kubernetes.io/aws-load-balancer-internal" = "true"
        # "service.beta.kubernetes.io/aws-load-balancer-extra-security-groups" = "sg-1234567890"
      }
      "domain" = "psdatum.com"
      "prefix" = "kafka-connect"
      "loadBalancerSourceRanges" = [
        "0.0.0.0/0"
      ]
      "port" = 8083
    }
  }
}

variable "worker_size" {
  type        = number
  description = "The number of Kafka Connect workers."
  default     = 1
}