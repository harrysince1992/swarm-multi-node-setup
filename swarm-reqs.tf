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
  filename = "swarm_vars"
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

# resource "local_file" "swarm-playbook" {
#   filename = "swarm-playbook.yml"
#   content = <<EOF
# ---
# - name: Setup hostnames and local dns
#   hosts: all_hosts
#   become: true
#   tasks:
#     - name: setup hostname for {{ inventory_hostname }}
#       hostname:
#         name: "{{ inventory_hostname }}"

#     - name: add entries in /etc/hosts file
#       lineinfile:
#         line: "{{ item }}"
#         path: /etc/hosts
#       with_items:
#         - "${aws_instance.swarm-manager[0].private_ip}  swarm-manager"
#         - "${aws_instance.worker[0].private_ip}  swarm-worker01"
#         - "${aws_instance.worker[1].private_ip}  swarm-worker02"
# - name: setup swarm manager and initialize swarm
#   hosts: swarm-manager
#   become: true
#   tasks:
#   - name: check if docker is installed and running
#     command: "docker version --format '{{ '{{' }} .Server.Version {{ '}}' }}'"
#     register: docker_version

#   - name: initialize swarm manager
#     command: "docker swarm init --advertise-addr {{ ansible_ssh_host }}"
#     when: docker_version is succeeded

#   - name: save worker token
#     command: "docker swarm join-token --quiet worker"
#     register: swarm_token

# - name: setup swarm workers to join swarm cluster
#   hosts: swarm_workers
#   become: true
#   tasks:
#   - name: join swarm cluster
#     command: "docker swarm join --token {{ hostvars['swarm-manager']['swarm_token'].stdout }} ${aws_instance.swarm-manager[0].private_ip}:2377"
# EOF
# }
