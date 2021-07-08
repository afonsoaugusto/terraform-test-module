locals {
  metadata_svc_account_lb_name                      = map("name", "aws-load-balancer-controller")
  metadata_svc_account_lb_namespace                 = map("namespace", "kube-system")
  metadata_svc_account_lb_awsLoadBalancerController = map("awsLoadBalancerController", true)
  metadata_svc_account_lb_wellKnownPolicies         = map("wellKnownPolicies", local.metadata_svc_account_lb_awsLoadBalancerController)
  metadata_svc_account_lb = map("metadata", merge(local.metadata_svc_account_lb_name,
    local.metadata_svc_account_lb_namespace,
  local.metadata_svc_account_lb_wellKnownPolicies))
}

locals {
  metadata_svc_account_ext_dns_name              = map("name", "external-dns")
  metadata_svc_account_ext_dns_namespace         = map("namespace", "kube-system")
  metadata_svc_account_ext_dns_externalDNS       = map("externalDNS", true)
  metadata_svc_account_ext_dns_wellKnownPolicies = map("wellKnownPolicies", local.metadata_svc_account_ext_dns_externalDNS)
  metadata_svc_account_ext_dns = map("metadata", merge(local.metadata_svc_account_ext_dns_name,
    local.metadata_svc_account_ext_dns_namespace,
  local.metadata_svc_account_ext_dns_wellKnownPolicies))
}

locals {
  metadata_svc_account_cert_manager_name              = map("name", "cert-manager")
  metadata_svc_account_cert_manager_namespace         = map("namespace", "cert-manager")
  metadata_svc_account_cert_manager_externalDNS       = map("certManager", true)
  metadata_svc_account_cert_manager_wellKnownPolicies = map("wellKnownPolicies", local.metadata_svc_account_cert_manager_externalDNS)
  metadata_svc_account_cert_manager = map("metadata", merge(local.metadata_svc_account_cert_manager_name,
    local.metadata_svc_account_cert_manager_namespace,
  local.metadata_svc_account_ext_dns_wellKnownPolicies))
}

locals {
  metadata_svc_accounts_products = tolist(flatten([
    for namespace in local.namespaces : [
      map("metadata", merge(map("name", namespace),
        map("namespace", namespace))
    #   ,map("attachRoleARN", list(local.role))
      )
    ]
  ]))
}

# locals {
#   metadata_svc_accounts_products = tolist(flatten([
#     for namespace in local.namespaces : [
#       {
#           "metadata" = {
#               "name" = namespace,
#               "namespace" = namespace
#           },
#           "attachRoleARN" = local.role
#       }
#     ]
#   ]))
# }


output "metadata_svc_accounts_products" {
  value = local.metadata_svc_accounts_products
}

locals {
  list_service_accounts_default = list(local.metadata_svc_account_lb,
    local.metadata_svc_account_ext_dns,
  local.metadata_svc_account_cert_manager)

  list_service_accounts = flatten(list(local.list_service_accounts_default, local.metadata_svc_accounts_products))
  service_accounts      = map("serviceAccounts", local.list_service_accounts)
}
