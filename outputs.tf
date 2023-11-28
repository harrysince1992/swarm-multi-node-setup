output "private_subnet_ids" {
  value = module.module-vpc-3tier.private_subnet_ids
}

output "public_subnet_ids" {
  value = module.module-vpc-3tier.public_subnet_ids
}

output "bastion_host_ip" {
  value = aws_instance.bastion-host.public_ip
}

output "swarm_manager_ip" {
  value = aws_instance.swarm-manager[*].private_ip
}

output "swarm_workers_ip" {
  value = aws_instance.worker[*].private_ip
}