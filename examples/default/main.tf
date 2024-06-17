provider "mgc" {
  alias  = "ne"
  region = "br-ne1"
}

provider "mgc" {
  alias  = "se"
  region = "br-se1"
}

resource "random_string" "sufix_name" {
  length  = 8
  special = false
}

resource "random_string" "password" {
  length  = 8
  special = false
}

module "dbaas_example_ne" {
  providers = {
    mgc = mgc.ne
  }
  source               = "../../"
  name                 = "db-example-ne-${random_string.sufix_name.id}"
  flavor               = "cloud-dbaas-bs1.medium"
  engine               = "mysql-8.0"
  user                 = "admin"
  password             = random_string.password.id
  replicas_enable      = true
  volume_size          = 20
  backup_enable        = true
  bastion_enable       = false
  bastion_ssh_key_name = var.ssh_key_name
}


module "dbaas_example_se" {
  depends_on = [ module.dbaas_example_ne ]
  providers = {
    mgc = mgc.se
  }
  source               = "../../"
  name                 = "db-example-se-${random_string.sufix_name.id}"
  flavor               = "cloud-dbaas-bs1.medium"
  engine               = "mysql-8.0"
  user                 = "admin"
  password             = random_string.password.id
  replicas_enable      = true
  volume_size          = 20
  backup_enable        = true
  bastion_enable       = true
  bastion_ssh_key_name = var.ssh_key_name
}