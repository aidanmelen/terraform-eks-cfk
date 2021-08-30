resource "kubernetes_manifest" "kafka_connect_workers" {
  count = var.create_connect_workers ? 1 : 0
  manifest = {
    apiVersion = "platform.confluent.io/v1beta1"
    kind       = "Connect"

    metadata = {
      name      = "connect"
      namespace = kubernetes_namespace.kafka_connect.id
      finalizers = [
        "connect.finalizers.platform.confluent.io",
      ]
    }

    spec = {
      # https://docs.confluent.io/operator/current/co-configure-misc.html#configuration-overrides
      configOverrides = {
        server = [for k, v in var.worker_server_configuration_properties : format("%s=%s", k, v)]
        jvm    = [for k, v in var.worker_jvm_configuration_properties : format("%s=%s", k, v)]
        log4j  = [for k, v in var.worker_log4_configurationj_properties : format("%s=%s", k, v)]
      }

      dependencies = {
        kafka = {
          bootstrapEndpoint = join(",", var.bootstrap_servers)
        }
      }

      externalAccess = var.worker_external_access

      image = {
        # https://docs.confluent.io/operator/current/co-configure-connect.html
        application = var.worker_application_image
        init        = var.worker_init_container_image
      }

      mountedSecrets = [
        {
          secretRef = kubernetes_secret.kafka_connect.metadata.0.name
        }
      ]

      podTemplate = {
        podSecurityContext = {
          fsGroup      = 1000
          runAsUser    = 1000
          runAsNonRoot = true
        }
      }

      replicas = var.worker_size
    }

    # license = {
    #   globalLicense = var.confluent_for_kubernetes_license_key != "" ? true : false
    # }
  }
}