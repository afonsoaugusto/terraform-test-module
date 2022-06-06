# Get folder by id
data "google_folder" "my_folder_1" {
  folder              = "folders/938190096677"
  lookup_organization = true
}

# Search by fields
data "google_folder" "my_folder_2" {
  folder = "folders/938190096677"
}

output "my_folder_1_organization" {
  value = data.google_folder.my_folder_1
}

output "my_folder_2_parent" {
  value = data.google_folder.my_folder_2
}
