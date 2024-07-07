<img title="a title" alt="Logo da magalu cloud" src="https://github.com/terraform-magalu-cloud/.github/blob/61d26ff88c3d74c97d46c0957afd36894b8bbed1/profile/img/magalu.png" width="100" height="100">  <img title="a title" alt="Logo do terraform" src="https://github.com/terraform-magalu-cloud/.github/blob/61d26ff88c3d74c97d46c0957afd36894b8bbed1/profile/img/terraform.png" width="100" height="100">

## Sumary
This module was created and maintained by the community. If you want to help, see how to do this by accessing the repository:
[terraform-magalu-cloud/how-can-help](https://github.com/terraform-magalu-cloud/how-can-help)

## Example:
[Default](https://github.com/terraform-magalu-cloud/terraform-mgc-dbaas/tree/main/examples)

### Options Available:

Engines: mysql-8.0

Flavors:     "cloud-dbaas-bs1.medium", "cloud-dbaas-bs1.large", "cloud-dbaas-bs1.small", "cloud-dbaas-gp1.small", "cloud-dbaas-gp1.medium", "cloud-dbaas-gp1.large", "cloud-dbaas-hm1.medium", "cloud-dbaas-hm1.large", "cloud-dbaas-hm1.small"

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
| <a name="provider_time"></a> [time](#provider\_time) | 0.11.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | terraform-magalu-cloud/virtual-machine/mgc | 1.2.0 |

## Resources

| Name | Type |
|------|------|
| [mgc_dbaas_instances.this](https://registry.terraform.io/providers/MagaluCloud/mgc/0.18.10/docs/resources/dbaas_instances) | resource |
| [mgc_dbaas_replicas.this](https://registry.terraform.io/providers/MagaluCloud/mgc/0.18.10/docs/resources/dbaas_replicas) | resource |
| [time_sleep.wait_5_minutes](https://registry.terraform.io/providers/hashicorp/time/0.11.1/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Defines the name of resource | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | Define password firt user to login dbaas | `string` | n/a | yes |
| <a name="input_backup_enable"></a> [backup\_enable](#input\_backup\_enable) | Define if backup is enable of the dbaas | `bool` | `true` | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | Define days to backup frequency of the dbaas | `number` | `7` | no |
| <a name="input_backup_start_at"></a> [backup\_start\_at](#input\_backup\_start\_at) | Define hour start backup of the dbaas | `string` | `"02:00:00"` | no |
| <a name="input_bastion_enable"></a> [bastion\_enable](#input\_bastion\_enable) | Defini if bastion server will be create to acces database by CLI | `bool` | `false` | no |
| <a name="input_bastion_ssh_key_name"></a> [bastion\_ssh\_key\_name](#input\_bastion\_ssh\_key\_name) | Name of ssh key name to bastion server to access DB | `string` | `""` | no |
| <a name="input_create"></a> [create](#input\_create) | Defines whether resource will be created or not | `bool` | `true` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | Definie which egine dbaas will be use, possible values: mysq-5.6 (deprecated), mysql-5.7 (deprecated) and mysql-8.0 | `string` | `"mysql-8.0"` | no |
| <a name="input_exchange"></a> [exchange](#input\_exchange) | Define exchange type | `string` | `"dbaas-internal"` | no |
| <a name="input_flavor"></a> [flavor](#input\_flavor) | Define size instance database, possible values: cloud-dbaas-bs1.medium, cloud-dbaas-bs1.large, cloud-dbaas-bs1.small, cloud-dbaas-gp1.small, cloud-dbaas-gp1.medium,  cloud-dbaas-gp1.large, cloud-dbaas-hm1.medium, cloud-dbaas-hm1.large, cloud-dbaas-hm1.small | `string` | `"cloud-dbaas-bs1.medium"` | no |
| <a name="input_replicas_enable"></a> [replicas\_enable](#input\_replicas\_enable) | Define if this dbaas use replica | `bool` | `false` | no |
| <a name="input_replicas_number"></a> [replicas\_number](#input\_replicas\_number) | Define number of replica | `number` | `1` | no |
| <a name="input_user"></a> [user](#input\_user) | Define name firts user to login dbaas | `string` | `"admin"` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Define size volume in GB on dbaas | `number` | `20` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Define type volume in GB on dbaas | `string` | `"CLOUD_NVME_15K"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access"></a> [access](#output\_access) | Type access this resource, format PRIVATE or PUBLIC |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | Timstamp when this resource was created |
| <a name="output_current_status"></a> [current\_status](#output\_current\_status) | Current status this resource |
| <a name="output_id"></a> [id](#output\_id) | Id of resource |
| <a name="output_ipv4"></a> [ipv4](#output\_ipv4) | IP this resource, format IPv4 |
| <a name="output_name"></a> [name](#output\_name) | Name of resource |
| <a name="output_replicas_access"></a> [replicas\_access](#output\_replicas\_access) | Type access this resources, format PRIVATE or PUBLIC |
| <a name="output_replicas_id"></a> [replicas\_id](#output\_replicas\_id) | TId this resources |
| <a name="output_replicas_ipv4"></a> [replicas\_ipv4](#output\_replicas\_ipv4) | IP this resource, format IPv4 |
| <a name="output_replicas_name"></a> [replicas\_name](#output\_replicas\_name) | Name this resources |
| <a name="output_started_at"></a> [started\_at](#output\_started\_at) | Timstamp when this resource was started last time |
| <a name="output_updated_at"></a> [updated\_at](#output\_updated\_at) | Timstamp when this resource was updated last time |