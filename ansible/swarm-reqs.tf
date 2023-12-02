# Ansible inventory file to create for swarm manager and worker nodes
resource "local_file" "inventory" {
  filename = "swarm-inventory.ini"
  content = <<EOF
swarm-manager ansible_ssh_host=${aws_instance.swarm-manager[0].private_ip}
swarm-worker01 ansible_ssh_host=${aws_instance.worker[0].private_ip}
swarm-worker02 ansible_ssh_host=${aws_instance.worker[1].private_ip}
bastion-host ansible_ssh_host=localhost

[all_hosts]
swarm-manager
swarm-worker01
swarm-worker02
bastion-host

[swarm_hosts]
swarm-manager
swarm-worker01
swarm-worker02

[swarm_workers]
swarm-worker01
swarm-worker02
EOF 

}

resource "local_file" "swarm_vars" {
  filename = "swarm_vars.yml"
  content = <<EOF
swarm_hosts_var:
- name: swarm-manager
  ip: ${aws_instance.swarm-manager[0].private_ip}
- name: swarm-worker01
  ip: ${aws_instance.worker[0].private_ip}
- name: swarm-worker02
  ip: ${aws_instance.worker[1].private_ip}
EOF
}
