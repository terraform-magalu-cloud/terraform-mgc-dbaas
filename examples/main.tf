provider "mgc" {
  region = "br-ne1"
}

module "dbaas-example" {
  source = "../"
  name   = var.name
}