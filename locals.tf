locals {
  is_windows = length(regexall("^[a-z]:", lower(abspath(path.root)))) > 0

  parameter_group = {
    mysql = try(mgc_dbaas_parameter_groups.mysql[0].id,null)
    postgresql = try(mgc_dbaas_parameter_groups.postgresql[0].id,null)
  }

}
