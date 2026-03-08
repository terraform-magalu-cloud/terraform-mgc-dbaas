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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.11.1 |
| <a name="requirement_mgc"></a> [mgc](#requirement\_mgc) | >= 0.45.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.11.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mgc"></a> [mgc](#provider\_mgc) | 0.45.1 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.11.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | terraform-magalu-cloud/virtual-machine/mgc | n/a |

## Resources

| Name | Type |
|------|------|
| [mgc_dbaas_instances.this](https://registry.terraform.io/providers/MagaluCloud/mgc/latest/docs/resources/dbaas_instances) | resource |
| [mgc_dbaas_parameter_groups.mysql](https://registry.terraform.io/providers/MagaluCloud/mgc/latest/docs/resources/dbaas_parameter_groups) | resource |
| [mgc_dbaas_parameter_groups.postgresql](https://registry.terraform.io/providers/MagaluCloud/mgc/latest/docs/resources/dbaas_parameter_groups) | resource |
| [mgc_dbaas_parameters.mysql](https://registry.terraform.io/providers/MagaluCloud/mgc/latest/docs/resources/dbaas_parameters) | resource |
| [mgc_dbaas_parameters.postgresql](https://registry.terraform.io/providers/MagaluCloud/mgc/latest/docs/resources/dbaas_parameters) | resource |
| [mgc_dbaas_replicas.this](https://registry.terraform.io/providers/MagaluCloud/mgc/latest/docs/resources/dbaas_replicas) | resource |
| [time_sleep.wait_5_minutes](https://registry.terraform.io/providers/hashicorp/time/0.11.1/docs/resources/sleep) | resource |
| [mgc_dbaas_engines.engines](https://registry.terraform.io/providers/MagaluCloud/mgc/latest/docs/data-sources/dbaas_engines) | data source |
| [mgc_dbaas_instance_types.all_instance_types](https://registry.terraform.io/providers/MagaluCloud/mgc/latest/docs/data-sources/dbaas_instance_types) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Defines the name of resource | `string` | n/a | yes |
| <a name="input_backup_enable"></a> [backup\_enable](#input\_backup\_enable) | Define if backup is enable of the dbaas | `bool` | `true` | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | Define days to backup frequency of the dbaas | `number` | `7` | no |
| <a name="input_backup_start_at"></a> [backup\_start\_at](#input\_backup\_start\_at) | Define hour start backup of the dbaas | `string` | `"02:00:00"` | no |
| <a name="input_bastion_enable"></a> [bastion\_enable](#input\_bastion\_enable) | Defini if bastion server will be create to acces database by CLI | `bool` | `false` | no |
| <a name="input_bastion_ssh_key_name"></a> [bastion\_ssh\_key\_name](#input\_bastion\_ssh\_key\_name) | Name of ssh key name to bastion server to access DB | `string` | `""` | no |
| <a name="input_create"></a> [create](#input\_create) | Defines whether resource will be created or not | `bool` | `true` | no |
| <a name="input_create_parameter_group"></a> [create\_parameter\_group](#input\_create\_parameter\_group) | Enable or not create parameter group | `bool` | `true` | no |
| <a name="input_custom_parameters"></a> [custom\_parameters](#input\_custom\_parameters) | Custom parameters | `map(string)` | `{}` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | Define which engine dbaas will be used. Possible values: 'mysql', 'postgresql'. | `string` | `"mysql"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Engine version | `string` | `"8.0"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Define size instance database, possible values: cloud-dbaas-bs1.medium, cloud-dbaas-bs1.large, cloud-dbaas-bs1.small, cloud-dbaas-gp1.small, cloud-dbaas-gp1.medium,  cloud-dbaas-gp1.large, cloud-dbaas-hm1.medium, cloud-dbaas-hm1.large, cloud-dbaas-hm1.small | `string` | `"BV4-8-10"` | no |
| <a name="input_password"></a> [password](#input\_password) | Define password firt user to login dbaas | `string` | `"P@ssw0rd"` | no |
| <a name="input_replicas_enable"></a> [replicas\_enable](#input\_replicas\_enable) | Define if this dbaas use replica | `bool` | `false` | no |
| <a name="input_replicas_number"></a> [replicas\_number](#input\_replicas\_number) | Define number of replica | `number` | `1` | no |
| <a name="input_user"></a> [user](#input\_user) | Define name firts user to login dbaas | `string` | `"admin"` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Define size volume in GB on dbaas | `number` | `20` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_instance_types"></a> [all\_instance\_types](#output\_all\_instance\_types) | List of available database instance type. |
| <a name="output_available_engines"></a> [available\_engines](#output\_available\_engines) | List of available database engines. |
| <a name="output_engine_id"></a> [engine\_id](#output\_engine\_id) | Unique identifier for the database engine. |
| <a name="output_id"></a> [id](#output\_id) | Unique identifier for the DBaaS instance. Generated automatically on creation. |
| <a name="output_instance_type_id"></a> [instance\_type\_id](#output\_instance\_type\_id) | Unique identifier for the instance. |
| <a name="output_parameter_group_id"></a> [parameter\_group\_id](#output\_parameter\_group\_id) | Unique identifier for the parameters group. |
| <a name="output_parameters_ids"></a> [parameters\_ids](#output\_parameters\_ids) | A map of unique identifiers for the parameters, keyed by parameter name. |
| <a name="output_status"></a> [status](#output\_status) | Status of the instance. |