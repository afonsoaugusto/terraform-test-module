locals {
  name = list({
    "name" : "AWSManagedRulesCommonRuleSet"
    "vendor_name" : "AWS"
    "priority" : "10"
    "override_action" : "none"
    "excluded_rules" : ["UserAgent_BadBots_HEADER"] },
    { "name" : "AWSManagedRulesAmazonIpReputationList"
      "vendor_name" : "AWS"
      "priority" : "20"
      "override_action" : "none"
    "excluded_rules" : [] },
    { "name" : "AWSManagedRulesLinuxRuleSet"
      "vendor_name" : "AWS"
      "priority" : "30"
      "override_action" : "none"
  "excluded_rules" : [] })
  e = list({ "name" : "AWSManagedRulesCommonRuleSet", "vendor_name" : "AWS", "priority" : "10", "override_action" : "none", "excluded_rules" : ["UserAgent_BadBots_HEADER"] }, { "name" : "AWSManagedRulesAmazonIpReputationList", "vendor_name" : "AWS", "priority" : "20", "override_action" : "none", "excluded_rules" : [] }, { "name" : "AWSManagedRulesLinuxRuleSet", "vendor_name" : "AWS", "priority" : "30", "override_action" : "none", "excluded_rules" : [] })
}

output "name" {
  value = local.name
}
