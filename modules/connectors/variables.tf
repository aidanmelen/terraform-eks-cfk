# https://docs.confluent.io/platform/current/connect/references/connector-configs.html
variable "configuration_properties" {
  type        = list(map(any))
  description = "The Kafka Connector configuration properties. These values will override configuration_properties_defaults values."
  default = [
    # {
    #   "buffer.flush.time" = 300
    #   topics              = "example-topic-name"
    #   "tasks.max"         = 5
    #   "profile_ref"       = "snowflake_key_string_value_avro"
    # },
    # {
    #   topics            = "example-topic1-name,example-topic2-name"
    #   "connector.class" = "io.confluent.connect.syslog.SyslogSourceConnector"
    #   "key.converter"   = "org.apache.kafka.connect.storage.StringConverter"
    # }
  ]
}

# https://docs.confluent.io/platform/current/connect/references/connector-configs.html
variable "configuration_properties_profiles" {
  type        = any
  description = "The Kafka Connector configuration properties profiles. These profiles can be refererenced and merged with configuration properties specified with the configuration_properties variable."
  default = {
    "postgres" = {
      "buffer.count.records"                = 10000,
      "buffer.flush.time"                   = 120,
      "buffer.size.bytes"                   = 5000000,
      "connector.class": "PostgresCdcSource",
      "config.providers"                    = "file",
      "config.providers.file.class"         = "org.apache.kafka.common.config.provider.FileConfigProvider",
      "database.hostname" = "debezium-1.<host-id>.us-east-2.rds.amazonaws.com",
      "database.port" = "5432",
      "database.user" = "postgres",
      "database.password" = "$${file:/mnt/secrets/kafka-connect/postgres-properties:database.password}",
      "database.dbname" = "postgres",
      "database.server.name" = "cdc",
      "table.include.list" = "public.passengers",
      "plugin.name" = "pgoutput",
      "output.data.format" = "JSON",
      "tasks.max" = "1"
    }
    "snowflake_key_string_value_avro" = {
      "buffer.count.records"                = 10000,
      "buffer.flush.time"                   = 120,
      "buffer.size.bytes"                   = 5000000,
      "connector.class"                     = "com.snowflake.kafka.connector.SnowflakeSinkConnector",
      "config.providers"                    = "file",
      "config.providers.file.class"         = "org.apache.kafka.common.config.provider.FileConfigProvider",
      "key.converter"                       = "org.apache.kafka.connect.storage.StringConverter",
      "value.converter"                     = "com.snowflake.kafka.connector.records.SnowflakeAvroConverter",
      "value.converter.schemas.enable"      = "true",
      "value.converter.schema.registry.url" = "http://schemaregistry.confluent.svc.cluster.local:8081",
      "snowflake.url.name"                  = "https://XXX12345.snowflakecomputing.com:443",
      "snowflake.user.name"                 = "USER",
      "snowflake.private.key"               = "$${file:/mnt/secrets/kafka-connect/snowflake-properties:snowflake.private.key}",
      "snowflake.database.name"             = "KAFKA",
      "snowflake.schema.name"               = "TOPICS",
      "tasks.max"                           = "1"
    }
  }
}


variable "create_connect_connectors" {
  description = "Whether to create the Kafka Connect connectors."
  default     = true
}
