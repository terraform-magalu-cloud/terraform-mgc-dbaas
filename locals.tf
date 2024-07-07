locals {
  engine = {
    "mysql-5.6" = "021fbbe0-aea2-4d44-8594-ed4e9ebd0442"
    "mysql-5.7" = "4951a18e-88eb-407d-88a5-ff05903724ed"
    "mysql-8.0" = "063f3994-b6c2-4c37-96c9-bab8d82d36f7"
  }
  flavor = {
    "cloud-dbaas-bs1.medium" = "c460d5c1-883d-4fea-afc3-1a208e982084"
    "cloud-dbaas-bs1.large"  = "650154ba-87a4-45b1-9ce6-f0b591603366"
    "cloud-dbaas-bs1.small"  = "8bbe8e01-40c8-4d2b-80e8-189debc44b1c"
    "cloud-dbaas-gp1.small"  = "a31e3ac5-845a-4fef-b2c3-e101ae25acb5"
    "cloud-dbaas-gp1.medium" = "8916323b-458f-4acf-92bf-5734b92bba61"
    "cloud-dbaas-gp1.large"  = "481aac7d-dd67-4054-bad2-dff712f4c77f"
    "cloud-dbaas-hm1.medium" = "c29c2a8f-6d31-4c3d-9f7c-90bbf9a71e60"
    "cloud-dbaas-hm1.large"  = "897bc067-2cd2-4bf3-838c-9702a7b52b2c"
    "cloud-dbaas-hm1.small"  = "09106b02-5cfc-4d9b-afa2-2433d3458b61"
  }
  is_windows = length(regexall("^[a-z]:", lower(abspath(path.root)))) > 0

}
