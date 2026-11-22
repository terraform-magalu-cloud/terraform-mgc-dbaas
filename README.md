<img title="a title" alt="Logo da magalu cloud" src="https://github.com/terraform-magalu-cloud/.github/blob/61d26ff88c3d74c97d46c0957afd36894b8bbed1/profile/img/magalu.png" width="100" height="100">  <img title="a title" alt="Logo do terraform" src="https://github.com/terraform-magalu-cloud/.github/blob/61d26ff88c3d74c97d46c0957afd36894b8bbed1/profile/img/terraform.png" width="100" height="100">

## Summary
Enterprise-grade Terraform module to provision and manage **Database-as-a-Service (DBaaS)** on **Magalu Cloud** using the official `MagaluCloud/mgc` provider (`>= 0.56.0`).

### Key Features:
- **Multiple Topologies:**
  - `standalone`: Single managed database instance (`mgc_dbaas_instances`).
  - `replicas`: Primary instance with $N$ read-only replicas (`mgc_dbaas_replicas`).
  - `cluster`: Production-ready High Availability database cluster (`mgc_dbaas_clusters`).
- **Engines:** Native support for **MySQL** (e.g. `8.0`) and **PostgreSQL** (e.g. `15`, `16`).
- **Zero Plain-Text Passwords:** Automatically generates a secure 24-character random password if none is provided.
- **Application Ready:** Formatted connection URIs (`connection_url`), ports, and hosts ready for Kubernetes and app configurations.
- **Dedicated Scope:** 100% focused on managed database instances and clusters without external infrastructure coupling.

## Examples:
- [MySQL Standalone](https://github.com/terraform-magalu-cloud/terraform-mgc-dbaas/tree/main/examples/mysql-standalone)
- [MySQL with Replicas](https://github.com/terraform-magalu-cloud/terraform-mgc-dbaas/tree/main/examples/mysql-with-replicas)
- [MySQL Cluster (HA)](https://github.com/terraform-magalu-cloud/terraform-mgc-dbaas/tree/main/examples/mysql-cluster)
- [PostgreSQL Standalone](https://github.com/terraform-magalu-cloud/terraform-mgc-dbaas/tree/main/examples/postgres-standalone)
- [PostgreSQL with Replicas](https://github.com/terraform-magalu-cloud/terraform-mgc-dbaas/tree/main/examples/postgres-with-replicas)
- [PostgreSQL Cluster (HA)](https://github.com/terraform-magalu-cloud/terraform-mgc-dbaas/tree/main/examples/postgres-cluster)

### Supported Engines:
- **MySQL**: e.g., `8.0`
- **PostgreSQL**: e.g., `15`, `16`

### Instance Types (Hardware Labels):
- Configured via hardware labels as required by DBaaS v2 (e.g., `DP2-8-40`, `DP2-16-40`).
- To list all available labels in your tenant:
  ```bash
  mgc dbaas instance-types list --compatible-product SINGLE_INSTANCE
  ```

## Testing & Development
This module includes a comprehensive test suite using the native Terraform Test framework (`terraform test`):
- `tests/defaults.tftest.hcl`: Validates default MySQL standalone provisioning with auto-generated credentials.
- `tests/cluster.tftest.hcl`: Validates High Availability Cluster topology.
- `tests/replicas.tftest.hcl`: Validates Read Replicas topology and timer sequencing.
- `tests/postgres.tftest.hcl`: Validates PostgreSQL configuration and port mapping (5432).
- `tests/disabled.tftest.hcl`: Validates graceful execution when `create = false`.
- `tests/validations.tftest.hcl`: Validates input constraints and guardrails.
- `tests/legacy.tftest.hcl`: Validates backwards compatibility with legacy parameters.

A `Makefile` is provided for standard operations:
```bash
make help       # Show all available targets
make fmt        # Format all HCL files
make validate   # Validate module syntax
make test       # Run native terraform tests
make docs       # Regenerate README.md
make check      # Complete local pipeline (fmt -> validate -> docs -> test)
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.0 |
| <a name="requirement_mgc"></a> [mgc](#requirement\_mgc) | >= 0.56.0, < 1.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6.0, < 4.0.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.11.0, < 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mgc"></a> [mgc](#provider\_mgc) | >= 0.56.0, < 1.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.6.0, < 4.0.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.11.0, < 1.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [mgc_dbaas_clusters.this](https://registry.terraform.io/providers/MagaluCloud/mgc/latest/docs/resources/dbaas_clusters) | resource |
| [mgc_dbaas_instances.this](https://registry.terraform.io/providers/MagaluCloud/mgc/latest/docs/resources/dbaas_instances) | resource |
| [mgc_dbaas_replicas.this](https://registry.terraform.io/providers/MagaluCloud/mgc/latest/docs/resources/dbaas_replicas) | resource |
| [random_password.master_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [time_sleep.wait_for_master](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the DBaaS instance or cluster | `string` | n/a | yes |
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | Magalu Cloud API Key for provider authentication (UUID v4 format). Can also be provided via the MGC\_API\_KEY environment variable | `string` | `null` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Target availability zone for deployment (e.g., 'br-se1-a', 'br-ne1-a') | `string` | `null` | no |
| <a name="input_backup_enable"></a> [backup\_enable](#input\_backup\_enable) | Define if automated backups are enabled | `bool` | `true` | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | Number of days to retain automated backups | `number` | `7` | no |
| <a name="input_backup_start_at"></a> [backup\_start\_at](#input\_backup\_start\_at) | Daily backup start time in UTC format (HH:MM:SS) | `string` | `"02:00:00"` | no |
| <a name="input_create"></a> [create](#input\_create) | Defines whether DBaaS resources will be created or not | `bool` | `true` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name of the initial logical database to include in connection string outputs | `string` | `null` | no |
| <a name="input_deployment_type"></a> [deployment\_type](#input\_deployment\_type) | Deployment topology: 'standalone' (single instance), 'replicas' (primary + read replicas), or 'cluster' (High Availability cluster) | `string` | `"standalone"` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | Legacy: Database engine and version combined (e.g. 'mysql-8.0'). Deprecated in favor of engine\_name and engine\_version | `string` | `null` | no |
| <a name="input_engine_name"></a> [engine\_name](#input\_engine\_name) | Database engine name (e.g., 'mysql' or 'postgresql') | `string` | `"mysql"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Database engine version (e.g., '8.0' for mysql or '15', '16' for postgresql) | `string` | `"8.0"` | no |
| <a name="input_exchange"></a> [exchange](#input\_exchange) | Legacy: Exchange network type | `string` | `null` | no |
| <a name="input_flavor"></a> [flavor](#input\_flavor) | Legacy: Compute flavor. Deprecated in favor of instance\_type | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Compute instance type label (e.g. DP2-8-40, DP2-16-40) | `string` | `"DP2-8-40"` | no |
| <a name="input_password"></a> [password](#input\_password) | Administrative password for the database. If omitted (null), a strong 24-character random password is automatically generated | `string` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | Custom port for the database. Defaults to 3306 (mysql) or 5432 (postgresql) | `number` | `null` | no |
| <a name="input_replica_wait_duration"></a> [replica\_wait\_duration](#input\_replica\_wait\_duration) | Duration to wait before provisioning replicas after the primary instance is created | `string` | `"1m"` | no |
| <a name="input_replicas_enable"></a> [replicas\_enable](#input\_replicas\_enable) | Legacy / flag: Define whether to create read replicas (superseded by deployment\_type = 'replicas') | `bool` | `false` | no |
| <a name="input_replicas_number"></a> [replicas\_number](#input\_replicas\_number) | Number of read replicas to create when deployment\_type is 'replicas' or replicas\_enable is true | `number` | `1` | no |
| <a name="input_user"></a> [user](#input\_user) | Administrative user for the database instance | `string` | `"admin"` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Storage volume size in GB for the database | `number` | `20` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Storage performance tier volume type (e.g., CLOUD\_NVME15K, CLOUD\_NVME20K) | `string` | `"CLOUD_NVME15K"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_url"></a> [connection\_url](#output\_connection\_url) | Standard connection URI string ready for application configuration |
| <a name="output_current_status"></a> [current\_status](#output\_current\_status) | Legacy status alias |
| <a name="output_deployment_type"></a> [deployment\_type](#output\_deployment\_type) | Resolved deployment topology (standalone, replicas, or cluster) |
| <a name="output_host"></a> [host](#output\_host) | Target host / database name reference |
| <a name="output_id"></a> [id](#output\_id) | ID of the DBaaS instance or cluster |
| <a name="output_name"></a> [name](#output\_name) | Name of the DBaaS instance or cluster |
| <a name="output_password"></a> [password](#output\_password) | Administrative password (user-defined or auto-generated) |
| <a name="output_port"></a> [port](#output\_port) | TCP port of the database service |
| <a name="output_replicas"></a> [replicas](#output\_replicas) | List of read replicas created with their details |
| <a name="output_replicas_id"></a> [replicas\_id](#output\_replicas\_id) | List of IDs of all DBaaS replicas |
| <a name="output_replicas_name"></a> [replicas\_name](#output\_replicas\_name) | List of names of all DBaaS replicas |
| <a name="output_status"></a> [status](#output\_status) | Current status of the DBaaS resource |
| <a name="output_user"></a> [user](#output\_user) | Administrative user for database connection |