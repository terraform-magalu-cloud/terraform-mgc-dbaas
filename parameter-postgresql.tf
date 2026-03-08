# 1. Defina o Grupo de Parâmetros do PostgreSQL
resource "mgc_dbaas_parameter_groups" "postgresql" {
  count          = var.engine == "postgresql" ? 1 : 0
  engine_name    = var.engine
  engine_version = var.engine_version
  name           = "${var.name}-${var.engine}-parameters-group"
}

locals {
  # 2. NOSSOS PADRÕES OTIMIZADOS PARA POSTGRESQL 16
  # Esta é a sua "lista completa" de padrões recomendados.
  postgres_essential_parameters = {

  }

  # 3. A COMBINAÇÃO
  # Mescla os padrões (primeiro) com os overrides do usuário (por último, para vencer).
  final_postgresql_parameters = merge(
    local.postgres_essential_parameters,
    var.custom_parameters
  )
}

# 4. Crie TODOS os parâmetros dinamicamente com for_each
resource "mgc_dbaas_parameters" "postgresql" {
  depends_on = [mgc_dbaas_parameter_groups.postgresql]
  for_each   = var.engine == "postgresql" ? local.final_postgresql_parameters : {}

  parameter_group_id = mgc_dbaas_parameter_groups.postgresql[0].id
  name               = upper(each.key)
  value              = each.value
}