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
  default_postgresql_16_parameters = {

    # --- Configurações de Memória (CRÍTICAS - AJUSTAR!) ---
    # 25% da RAM total da instância é um bom ponto de partida.
    # Ex: "2GB" para 8GB RAM, "4GB" para 16GB RAM.
    "shared_buffers" = "2GB"

    # 50-75% da RAM total. Ajuda o planner a estimar o cache do SO.
    # Ex: "6GB" para 8GB RAM, "12GB" para 16GB RAM.
    "effective_cache_size" = "6GB"

    # Memória para operações como sorting, hashing. 
    # Cuidado: é por operação, não por conexão.
    "work_mem" = "32MB"

    # Memória para operações de manutenção (VACUUM, CREATE INDEX).
    "maintenance_work_mem" = "512MB"

    # --- Configurações de Checkpoint (WAL) ---
    # Controla a frequência dos checkpoints. Valores maiores = melhor performance de escrita.
    "max_wal_size" = "2GB"
    "min_wal_size" = "512MB"

    # Espalha o I/O do checkpoint ao longo do tempo. 0.9 é um padrão recomendado.
    "checkpoint_completion_target" = "0.9"

    # --- Configurações de Custo (CRÍTICO PARA SSDs) ---
    # Diz ao planner que discos SSD/NVMe são rápidos em I/O aleatório.
    # O padrão (4.0) é para discos mecânicos (HDDs).
    "random_page_cost" = "1.1"

    # --- Configurações de Logging (Essencial para Debug) ---
    "logging_collector" = "on"
    "log_destination"   = "stderr" # Cloud providers geralmente coletam stderr

    # Loga queries que demoram mais de 1 segundo (1000ms).
    "log_min_duration_statement" = "1000"

    # Útil para tuning de checkpoints e I/O.
    "log_checkpoints" = "on"

    # Essencial para debugar contenção de locks.
    "log_lock_waits" = "on"

    # Loga arquivos temporários (bom para identificar 'work_mem' baixo)
    "log_temp_files" = "0" # 0 = loga todos

    # Loga atividade do autovacuum (bom para tuning)
    "log_autovacuum_min_duration" = "0" # 0 = loga todos

    # --- Configurações de Conexão e Encoding ---
    "max_connections" = "300"
    "client_encoding" = "UTF8"
    "timezone"        = "UTC"

    # --- Estatísticas ---
    # Coleta estatísticas mais detalhadas, ajudando o planner.
    "default_statistics_target" = "500"
  }

  # 3. A COMBINAÇÃO
  # Mescla os padrões (primeiro) com os overrides do usuário (por último, para vencer).
  final_postgresql_parameters = merge(
    local.default_postgresql_16_parameters,
    var.custom_parameters
  )
}

# 4. Crie TODOS os parâmetros dinamicamente com for_each
resource "mgc_dbaas_parameters" "postgresql" {
  depends_on = [mgc_dbaas_parameter_groups.postgresql]
  for_each = var.engine == "postgresql" ? local.final_postgresql_parameters : {}

  parameter_group_id = mgc_dbaas_parameter_groups.postgresql[0].id
    name  = each.key
    value = each.value
}