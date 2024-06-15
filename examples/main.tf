provider "mgc" {
  region = "br-ne1"
}

resource "random_string" "sufix_name" {
  length  = 8
  special = false
}

resource "random_string" "password" {
  length  = 8
  special = false
}

module "dbaas-example" {
  source          = "../"
  name            = "db-example-${random_string.sufix_name.id}"
  flavor          = "cloud-dbaas-bs1.medium"
  engine          = "mysql-8.0"
  user            = "admin"
  password        = random_string.password.id
  replicas_enable = true
  replicas_num_hosts = 1
  volume_size     = 20
  backup_enable   = true
  bastion_enable = true
  bastion_ssh_key_name = "key-example"
}
