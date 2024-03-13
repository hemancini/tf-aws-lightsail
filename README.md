## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lightsail_certificate.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_certificate) | resource |
| [aws_lightsail_distribution.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_distribution) | resource |
| [aws_lightsail_domain.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_domain) | resource |
| [aws_lightsail_domain_entry.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_domain_entry) | resource |
| [aws_lightsail_instance.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_instance) | resource |
| [aws_lightsail_instance_public_ports.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_instance_public_ports) | resource |
| [aws_lightsail_key_pair.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_key_pair) | resource |
| [aws_lightsail_static_ip.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_static_ip) | resource |
| [aws_lightsail_static_ip_attachment.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_static_ip_attachment) | resource |
| [aws_route53_record.validate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The Availability Zone in which to create your instance | `string` | `"us-east-1a"` | no |
| <a name="input_blueprint_id"></a> [blueprint\_id](#input\_blueprint\_id) | The ID for a virtual private server image | `string` | `"ubuntu_20_04"` | no |
| <a name="input_bundle_id"></a> [bundle\_id](#input\_bundle\_id) | The bundle of specification information | `string` | `"nano_2_0"` | no |
| <a name="input_create_static_ip"></a> [create\_static\_ip](#input\_create\_static\_ip) | Create and attach a statis IP to the instance | `bool` | `false` | no |
| <a name="input_distribution_enabled"></a> [distribution\_enabled](#input\_distribution\_enabled) | Flag to control the distribution creation. | `bool` | `true` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | This is the name of the resource. | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instances to launch. | `number` | `1` | no |
| <a name="input_instance_enabled"></a> [instance\_enabled](#input\_instance\_enabled) | Flag to control the instance creation. | `bool` | `true` | no |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | The key name to use for the instance. | `string` | `""` | no |
| <a name="input_key_path"></a> [key\_path](#input\_key\_path) | Public key path  (e.g. `~/.ssh/id_rsa.pub`). | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_pgp_key"></a> [pgp\_key](#input\_pgp\_key) | Flag to control the instance creation. | `string` | `""` | no |
| <a name="input_port_info"></a> [port\_info](#input\_port\_info) | n/a | <pre>list(object({<br>    protocol = string<br>    port     = number<br>    cidrs    = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | The public key material. This public key will be imported into Lightsail. | `string` | `""` | no |
| <a name="input_registre_subdomain"></a> [registre\_subdomain](#input\_registre\_subdomain) | Flag to control the subdomain registration. | `bool` | `true` | no |
| <a name="input_use_default_key_pair"></a> [use\_default\_key\_pair](#input\_use\_default\_key\_pair) | Default key pair name will be used, you must keep 'key\_pair\_name' empty | `bool` | `true` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Single lined launch script as a string to configure server with additional user data. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the Lightsail instance. |
| <a name="output_aws_lightsail_distribution"></a> [aws\_lightsail\_distribution](#output\_aws\_lightsail\_distribution) | n/a |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | The timestamp when the instance was created. |
| <a name="output_instance_ip"></a> [instance\_ip](#output\_instance\_ip) | The Public IP Address name of the Lightsail instance. |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | The name of the Lightsail instance. |
