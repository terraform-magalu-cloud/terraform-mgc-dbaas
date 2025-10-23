# O recurso do grupo de parâmetros (sem alteração)
resource "mgc_dbaas_parameter_groups" "mysql" {
  count          = var.engine == "mysql" ? 1 : 0
  engine_name    = var.engine
  engine_version = var.engine_version
  name           = "${var.name}-${var.engine}-parameters-group"
}

locals {
  # 1. NOSSOS PADRÕES
  # Renomeei para 'default_' para ficar mais claro
default_mysql_8_0_parameters = {
  # --- CONEXÃO E SESSÃO ---
  "MAX_CONNECTIONS"           = "300"
  "MAX_ALLOWED_PACKET"        = "1073741824" # 1G
  "CONNECT_TIMEOUT"           = "10"
  "INTERACTIVE_TIMEOUT"       = "28800"
  "WAIT_TIMEOUT"              = "28800"
  "NET_READ_TIMEOUT"          = "60"
  "NET_WRITE_TIMEOUT"         = "120"
  "MAX_CONNECT_ERRORS"        = "100"
  "BACK_LOG"                  = "300"

  # --- INNOBD (APENAS OS SUPORTADOS) ---
  "INNODB_BUFFER_POOL_INSTANCES" = "8"
  "INNODB_FILL_FACTOR"           = "100"
  "INNODB_FT_ENABLE_STOPWORD"    = "ON"
  "INNODB_FT_MAX_TOKEN_SIZE"     = "84"
  "INNODB_FT_MIN_TOKEN_SIZE"     = "3"
  "INNODB_FT_NUM_WORD_OPTIMIZE"  = "2000"
  "INNODB_FT_RESULT_CACHE_LIMIT" = "2000000000"
  "INNODB_LOCK_WAIT_TIMEOUT"     = "50"
  "INNODB_LOG_BUFFER_SIZE"       = "16777216"
  "INNODB_MAX_UNDO_LOG_SIZE"     = "1073741824"
  "INNODB_OPTIMIZE_FULLTEXT_ONLY" = "OFF"
  "INNODB_PRINT_ALL_DEADLOCKS"    = "OFF"
  "INNODB_PRINT_DDL_LOGS"         = "ON"
  "INNODB_READ_IO_THREADS"        = "4"
  "INNODB_REDO_LOG_CAPACITY"      = "3145728000" # 1G
  "INNODB_ROLLBACK_ON_TIMEOUT"    = "OFF"
  "INNODB_SEGMENT_RESERVE_FACTOR" = "12"
  "INNODB_WRITE_IO_THREADS"       = "4"

  # --- LOGS ---
  "SLOW_QUERY_LOG"                      = "ON"
  "LONG_QUERY_TIME"                     = "2"
  "LOG_QUERIES_NOT_USING_INDEXES"       = "ON"
  "LOG_ERROR_VERBOSITY"                 = "2"
  "LOG_SLOW_ADMIN_STATEMENTS"           = "ON"
  "LOG_THROTTLE_QUERIES_NOT_USING_INDEXES" = "0"
  "GENERAL_LOG"                         = "OFF"

  # --- CACHE ---
  "TABLE_OPEN_CACHE"          = "2000"
  "TABLE_DEFINITION_CACHE"    = "1400"
  "TABLE_OPEN_CACHE_INSTANCES" = "16"
  "STORED_PROGRAM_CACHE"      = "256"
  "STORED_PROGRAM_DEFINITION_CACHE" = "256"

  # --- CHARACTER SET ---
  "CHARACTER_SET_SERVER" = "utf8mb4"
  "COLLATION_SERVER"     = "utf8mb4_unicode_ci"

  # --- SQL MODE ---
  "SQL_MODE" = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"

  # --- SEGURANÇA ---
  "SKIP_NAME_RESOLVE"    = "ON"
  "SKIP_SHOW_DATABASE"   = "OFF"

  # --- PERFORMANCE ---
  "MAX_EXECUTION_TIME"   = "0"
  "MAX_JOIN_SIZE"        = "1000000"
  "MAX_SORT_LENGTH"      = "1024"
  "MAX_SP_RECURSION_DEPTH" = "0"
  "MAX_USER_CONNECTIONS" = "0"
  "MAX_PREPARED_STMT_COUNT" = "16382"
  "JOIN_BUFFER_SIZE"     = "262144"
  "TMP_TABLE_SIZE"       = "33554432"
}

  # 2. A COMBINAÇÃO
  # Esta é a parte principal:
  # - Começa com os padrões.
  # - Mescla as personalizações do usuário por cima.
  # - Se o usuário passar "max_connections", o valor dele substitui o nosso.
  final_mysql_parameters = merge(
    local.default_mysql_8_0_parameters, # Os padrões vêm primeiro
    var.custom_parameters               # Os overrides do usuário vêm por último (e vencem)
  )
}

# 3. O RECURSO
# Agora, o for_each itera sobre o mapa final combinado
resource "mgc_dbaas_parameters" "mysql" {
  depends_on = [mgc_dbaas_parameter_groups.mysql]
  for_each   = var.engine == "mysql" ? local.final_mysql_parameters : {}

  parameter_group_id = mgc_dbaas_parameter_groups.mysql[0].id
  name               = each.key
  value              = each.value
}