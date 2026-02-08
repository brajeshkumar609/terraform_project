output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "security_group_id" {
  value = module.security_group.security_group_id
}

output "instance_id" {
  value = module.ec2.instance_id
}

output "instance_private_ip" {
  value = module.ec2.private_ip
}

output "instance_public_ip" {
  value       = module.ec2.public_ip
  description = "Will be null if instance is in private subnet with no public IP"
}
