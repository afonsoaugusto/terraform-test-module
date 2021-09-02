data "aws_vpc_endpoint_service" "this" {
  service      = "s3"
  service_name = null

  filter {
    name   = "service-type"
    values = ["Interface"]
  }
}

output "data" {
  value = data.aws_vpc_endpoint_service.this
}
