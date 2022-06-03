variable "number_of_broker_nodes" {
  type    = number
  default = 2
}

data "template_file" "msk_cluster_configuration_properties" {
  template = file(format("%s/%s", path.module, "msk_cluster_configuration_properties.tmpl"))

  vars = {
    auto_create_topics_enable  = true
    delete_topic_enable        = true
    default_replication_factor = var.number_of_broker_nodes
  }
}

output "file" {
  value = data.template_file.msk_cluster_configuration_properties.rendered
}

output "operador_true" {
  value = true ? "true" : "false"
}

output "operador_false" {
  value = false ? "true" : "false"
}
