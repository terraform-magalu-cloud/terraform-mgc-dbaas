provider "mgc" {
  region = "br-ne1"
}

resource "random_string" "random" {
  length  = 8
  special = false
}

resource "random_string" "password" {
  length  = 8
  special = false
}

module "dbaas-example" {
  source   = "../"
  name     = "db-example-${random_string.random.id}"
  flavor   = "cloud-dbaas-bs1.medium"
  engine   = "mysql-5.7"
  user     = "admin"
  password = random_string.password.id
}
