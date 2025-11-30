resource "aws_msk_cluster" "main" {
  cluster_name           = var.name
  kafka_version          = var.kafka.version
  number_of_broker_nodes = var.kafka.broker_count

  client_authentication {
    sasl {
      iam = true
    }
  }

  broker_node_group_info {
    instance_type  = var.kafka.broker_instance
    client_subnets = var.vpc.subnet_ids

    storage_info {
      ebs_storage_info {
        volume_size = var.kafka.volume_size
      }
    }

    security_groups = var.vpc.security_groups
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }

      node_exporter {
        enabled_in_broker = true
      }
    }
  }

  configuration_info {
    arn      = aws_msk_configuration.main.arn
    revision = 1
  }
}

resource "aws_msk_configuration" "main" {
  name              = "${var.name}-configuration"
  server_properties = <<PROPERTIES
  auto.create.topics.enable = true
  PROPERTIES
}

resource "aws_cloudwatch_log_group" "msk" {
  name = "msk_broker_logs"
}
