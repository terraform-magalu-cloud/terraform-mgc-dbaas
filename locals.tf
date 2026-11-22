locals {
  # Support legacy "engine" parameter (e.g., "mysql-8.0") or dedicated engine_name / engine_version variables
  legacy_engine_parts = var.engine != null ? split("-", var.engine) : []

  engine_name = coalesce(
    length(local.legacy_engine_parts) > 0 ? local.legacy_engine_parts[0] : null,
    var.engine_name,
    "mysql"
  )

  engine_version = coalesce(
    length(local.legacy_engine_parts) > 1 ? local.legacy_engine_parts[1] : null,
    var.engine_version,
    "8.0"
  )

  # Instance type / flavor fallback
  instance_type = coalesce(var.flavor, var.instance_type, "DP2-8-40")

  # Topology calculation with backward compatibility
  is_cluster  = var.deployment_type == "cluster"
  is_replicas = var.deployment_type == "replicas" || (!local.is_cluster && var.replicas_enable)

  # Effective password (user provided or auto-generated)
  effective_password = coalesce(
    var.password,
    try(random_password.master_password[0].result, null),
    ""
  )

  # Default network ports by engine
  default_port = local.engine_name == "postgresql" ? 5432 : 3306
  port         = coalesce(var.port, local.default_port)

  database_name = coalesce(var.database_name, "defaultdb")
  host          = var.name
}
