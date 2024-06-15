<img title="a title" alt="Logo da magalu cloud" src="./docs/img/magalu.png" width="100" height="100">  <img title="a title" alt="Logo do terraform" src="./docs/img/terraform.png" width="100" height="100">

## Sumary
This module was created and maintained by the community. If you want to help, see how to do this by accessing the repository:
[terraform-magalu-cloud/how-can-help](https://github.com/terraform-magalu-cloud/how-can-help)

## Example:
[Default](https://github.com/terraform-magalu-cloud/terraform-mgc-dbaas/tree/main/example)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_mgc"></a> [mgc](#requirement\_mgc) | 0.18.10 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.11.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mgc"></a> [mgc](#provider\_mgc) | 0.18.10 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [mgc_dbaas_instances.this](https://registry.terraform.io/providers/MagaluCloud/mgc/0.18.10/docs/resources/dbaas_instances) | resource |
| [mgc_dbaas_replicas.this](https://registry.terraform.io/providers/MagaluCloud/mgc/0.18.10/docs/resources/dbaas_replicas) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_enable"></a> [backup\_enable](#input\_backup\_enable) | value | `bool` | `true` | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | value | `number` | `7` | no |
| <a name="input_backup_start_at"></a> [backup\_start\_at](#input\_backup\_start\_at) | value | `string` | `"02:00:00"` | no |
| <a name="input_create"></a> [create](#input\_create) | Defines whether resource will be created or not | `bool` | `true` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | value | `string` | `"mysql-8.0"` | no |
| <a name="input_exchange"></a> [exchange](#input\_exchange) | value | `string` | `"dbaas-internal"` | no |
| <a name="input_flavor"></a> [flavor](#input\_flavor) | Define size instance database, possible values: cloud-dbaas-bs1.medium, cloud-dbaas-bs1.large, cloud-dbaas-bs1.small, cloud-dbaas-gp1.small, cloud-dbaas-gp1.medium,  cloud-dbaas-gp1.large, cloud-dbaas-hm1.medium, cloud-dbaas-hm1.large, cloud-dbaas-hm1.small | `string` | `"cloud-dbaas-bs1.medium"` | no |
| <a name="input_name"></a> [name](#input\_name) | Defines the name of resource | `string` | `"test-db-terraform"` | no |
| <a name="input_password"></a> [password](#input\_password) | value | `string` | `"abc0123asdmc"` | no |
| <a name="input_replicas_enable"></a> [replicas\_enable](#input\_replicas\_enable) | value | `bool` | `true` | no |
| <a name="input_replicas_num_hosts"></a> [replicas\_num\_hosts](#input\_replicas\_num\_hosts) | value | `number` | `2` | no |
| <a name="input_user"></a> [user](#input\_user) | value | `string` | `"admin"` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | value | `number` | `10` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | value | `string` | `"CLOUD_NVME_15K"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_addresses_access"></a> [addresses\_access](#output\_addresses\_access) | n/a |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | n/a |
| <a name="output_current_status"></a> [current\_status](#output\_current\_status) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_started_at"></a> [started\_at](#output\_started\_at) | n/a |
| <a name="output_updated_at"></a> [updated\_at](#output\_updated\_at) | n/a |