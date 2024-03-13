module "lightsail" {
  source = "../"
  # version = "0.0.1"

  environment      = "staging"
  name             = "wordpress"
  create_static_ip = true
  # wordpress
  domain_name  = "hemancini.cl"
  blueprint_id = "wordpress"
  bundle_id    = "nano_2_0"
}

output "instance_ip" {
  value = module.lightsail.instance_ip
}

output "instance_name" {
  value = module.lightsail.instance_name
}

output "aws_lightsail_distribution" {
  value = module.lightsail.aws_lightsail_distribution[*].domain_name
}
