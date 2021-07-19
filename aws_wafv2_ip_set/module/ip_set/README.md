<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.31 |
| aws | >= 3.39.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.39.0 |

## Resources

| Name | Type |
|------|------|
| [aws_wafv2_ip_set.ip_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_ip_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| addresses | Contains an array of strings that specify one or more IP addresses or blocks of IP addresses in Classless Inter-Domain Routing (CIDR) notation. AWS WAF supports all address ranges for IP versions IPv4 and IPv6. | `list(string)` | n/a | yes |
| ip\_address\_version | Specify IPV4 or IPV6. Valid values are IPV4 or IPV6. | `string` | n/a | yes |
| name | A friendly name of the IP set. | `string` | n/a | yes |
| scope | Specifies whether this is for an AWS CloudFront distribution or for a regional application. Valid values are CLOUDFRONT or REGIONAL | `string` | n/a | yes |
| action | Set action for use in a WebACL. Valid values are ALLOW, BLOCK, or COUNT. | `string` | `"ALLOW"` | no |
| description | A friendly description of the IP set. | `string` | `""` | no |
| priority | Set priority for use in a WebACL. | `number` | `1` | no |
| tags | Tags for resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The Amazon Resource Name (ARN) that identifies the cluster. |
| id | A unique identifier for the set. |
| ip\_set\_rule | Object for use in module terraform-waf-module |
| tags\_all | A map of tags assigned to the resource, including those inherited from the provider. |
<!-- END_TF_DOCS -->