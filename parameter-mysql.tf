# O recurso do grupo de parâmetros (sem alteração)
resource "mgc_dbaas_parameter_groups" "mysql" {
  count          = var.engine == "mysql" ? 1 : 0
  engine_name    = var.engine
  engine_version = var.engine_version
  name           = "pg-${var.name}-${var.engine}"
}

locals {
  # 1. NOSSOS PADRÕES
  # Renomeei para 'default_' para ficar mais claro
  mysql_essential_parameters = {
  }

  # 2. A COMBINAÇÃO
  # Esta é a parte principal:
  # - Começa com os padrões.
  # - Mescla as personalizações do usuário por cima.
  # - Se o usuário passar "max_connections", o valor dele substitui o nosso.
  final_mysql_parameters = merge(
    local.mysql_essential_parameters, # Os padrões vêm primeiro
    var.custom_parameters             # Os overrides do usuário vêm por último (e vencem)
  )
}

# 3. O RECURSO
# Agora, o for_each itera sobre o mapa final combinado
resource "mgc_dbaas_parameters" "mysql" {
  depends_on = [mgc_dbaas_parameter_groups.mysql]
  for_each   = var.engine == "mysql" ? local.final_mysql_parameters : {}

  parameter_group_id = mgc_dbaas_parameter_groups.mysql[0].id
  name               = upper(each.key)
  value              = each.value
}