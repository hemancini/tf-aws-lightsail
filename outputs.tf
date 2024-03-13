#Module      : Lightsail
#Description : Terraform Lightsail module variables.

output "arn" {
  value       = aws_lightsail_instance.instance[*].arn
  description = " The ARN of the Lightsail instance."
}

output "created_at" {
  value       = aws_lightsail_instance.instance[*].created_at
  description = "The timestamp when the instance was created."
}

output "instance_ip" {
  value       = aws_lightsail_instance.instance[*].public_ip_address
  description = "The Public IP Address name of the Lightsail instance."

}

output "instance_name" {
  value       = aws_lightsail_instance.instance[*].name
  description = "The name of the Lightsail instance."

}

output "aws_lightsail_distribution" {
  value = aws_lightsail_distribution.test[*]
}
