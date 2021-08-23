
module "compute-cluster" {
  source     = "git@github.com:mentoriaiac/iac-modulo-compute-cluster-gcp.git?tag=v0.0.1"
  project_id = "<PROJECT ID>"
  name       = "mentoria-cluster"
  region     = "us-central1"
  zones      = ["us-central1-a", "us-central1-b", "us-central1-f"]
  network    = "vpc-01"
  subnetwork = "us-central1-01"
  node_pools = [
    {
      name = "cp-node" # vai virar o name do cluster + instance_name + count
      # exemplo: "mentoria-cluster-cp-node-1"
      machine_type            = "e2-medium"
      node_locations          = "us-central1-b,us-central1-c" # no loop vai virar 1 zone por node ou instancia
      count                   = 1                             # quantidade de nós
      instance_image          = "debian-cloud/debian-9"       # é a imagem da maquina
      metadata_startup_script = "startup-cp.sh"               # tem que ser implementado no modulo iac-modulo-compute-gcp
    },
    {
      name = "worker-node" # vai virar o name do cluster + instance_name + count
      # exemplo: "mentoria-cluster-worker-node-1"
      machine_type            = "e2-medium"
      node_locations          = "us-central1-b,us-central1-c" # no loop vai virar 1 zone por node ou instancia
      count                   = 3                             # quantidade de nós
      instance_image          = "debian-cloud/debian-9"       # é a imagem da maquina
      metadata_startup_script = "startup-worker.sh"
    },
  ]
}
