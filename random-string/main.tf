resource "random_id" "s3" {
  keepers = {
    "bucket_name" = format("%s-%s", "mysql-cluster", "hmg")
  }
  byte_length = 4
}

output "random" {
  value = random_id.s3
}
