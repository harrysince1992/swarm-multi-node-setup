# swarm-multi-node-setup

This creates a multi node swarm setup for DV environment

It creates one manager nodes and 2 worker nodes in different availability zones. It uses ansible to do the swarm setup on nodes.

Resources created:

1. a bastion host to access swarm manager and other nodes ( public IP received as terraform output )
2. one swarm manager node ( private IP received as terraform output )
3. 2 swarm worker nodes added to swarm cluster ( private IPs received as terraform output )
4. security groups for swarm and bastion host
5. aws key pair to import public key provided by user
6. it also saves private key in ubuntu user's home directory so we can do ssh into swarm instances
