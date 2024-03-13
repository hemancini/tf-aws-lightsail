locals {
  name                = "${var.name}-${var.environment}"
  certificate_enabled = var.distribution_enabled && var.domain_name != ""
  registre_subdomain  = local.certificate_enabled && var.registre_subdomain
  fulldomain          = "${var.name}.${var.domain_name}"
}

resource "aws_lightsail_instance" "instance" {
  count = var.instance_enabled ? var.instance_count : 0

  name              = format("%s%s%s", local.name, "-", (count.index))
  availability_zone = var.availability_zone
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  key_pair_name     = var.key_pair_name == "" && var.use_default_key_pair == false ? "${local.name}-keypair" : var.key_pair_name
  depends_on        = [aws_lightsail_key_pair.instance]
  user_data         = var.user_data
  tags = {
    "Name" = format("%s%s%s", local.name, "-", (count.index))
  }
}

resource "aws_lightsail_instance_public_ports" "public" {
  count         = var.port_info != null ? 1 : 0
  instance_name = join("", aws_lightsail_instance.instance[*].name)

  dynamic "port_info" {
    for_each = var.port_info == null ? [] : var.port_info

    content {
      protocol  = port_info.value.protocol
      from_port = port_info.value.port
      to_port   = port_info.value.port
      cidrs     = port_info.value.cidrs

    }
  }
}

resource "aws_lightsail_static_ip_attachment" "instance" {
  count          = var.instance_enabled && var.create_static_ip ? var.instance_count : 0
  static_ip_name = aws_lightsail_static_ip.instance[count.index].id
  instance_name  = aws_lightsail_instance.instance[count.index].id
}

resource "aws_lightsail_static_ip" "instance" {
  count = var.instance_enabled && var.create_static_ip ? var.instance_count : 0
  name  = format("%s-IP%s%s", local.name, "-", (count.index))
}

resource "aws_lightsail_key_pair" "instance" {
  count      = var.instance_enabled && var.key_pair_name == "" && var.use_default_key_pair == false ? 1 : 0
  name       = format("%s-keypair", local.name)
  pgp_key    = var.pgp_key
  public_key = var.public_key == "" ? file(var.key_path) : var.public_key
}

resource "aws_lightsail_domain" "test" {
  count = var.domain_name == "" ? 0 : 1

  domain_name = var.domain_name
}

resource "aws_lightsail_domain_entry" "test" {
  count       = var.domain_name == "" ? 0 : 1
  domain_name = var.domain_name
  name        = var.name
  type        = "A"
  target      = aws_lightsail_distribution.test[count.index].domain_name
  is_alias    = true
}


data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_lightsail_distribution" "test" {
  count      = var.distribution_enabled ? 1 : 0
  name       = format("%s-DIST%s%s", local.name, "-", (count.index))
  depends_on = [aws_lightsail_static_ip_attachment.instance]
  bundle_id  = "small_1_0"
  origin {
    name            = aws_lightsail_instance.instance[count.index].name
    region_name     = data.aws_availability_zones.available.id
    protocol_policy = "http-only"
  }
  # wordpress
  default_cache_behavior {
    behavior = "dont-cache"
  }

  certificate_name = local.certificate_enabled ? aws_lightsail_certificate.test[count.index].name : null
  cache_behavior {
    behavior = "cache"
    path     = "wp-content/*"
  }
  cache_behavior {
    behavior = "cache"
    path     = "wp-includes/*"
  }
  cache_behavior_settings {
    allowed_http_methods = "GET,HEAD,OPTIONS"
    cached_http_methods  = "GET,HEAD"
    default_ttl          = 86400
    maximum_ttl          = 31536000
    minimum_ttl          = 0
    forwarded_cookies {
      cookies_allow_list = []
      option             = "none"
    }
    forwarded_headers {
      headers_allow_list = [
        "Host"
      ]
      option = "allow-list"
    }
    forwarded_query_strings {
      option                     = true
      query_strings_allowed_list = []
    }
  }
}

data "aws_route53_zone" "this" {
  count = var.domain_name != "" ? 1 : 0
  name  = var.domain_name
}

resource "aws_lightsail_certificate" "test" {
  count       = local.certificate_enabled && local.registre_subdomain ? 1 : 0
  name        = format("%s-CERT%s%s", local.name, "-", (count.index))
  domain_name = local.fulldomain
}

resource "aws_route53_record" "validate" {
  count      = local.certificate_enabled && local.registre_subdomain ? 1 : 0
  zone_id    = data.aws_route53_zone.this[count.index].id
  name       = one(aws_lightsail_certificate.test[count.index].domain_validation_options).resource_record_name
  type       = one(aws_lightsail_certificate.test[count.index].domain_validation_options).resource_record_type
  ttl        = 300
  records    = [one(aws_lightsail_certificate.test[count.index].domain_validation_options).resource_record_value]
  depends_on = [aws_lightsail_certificate.test]
}
