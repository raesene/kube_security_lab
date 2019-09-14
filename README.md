# Kubernetes Local Security Testing Lab

The goal of this project is to make use of [Docker](https://www.docker.com) and specifically [kind](https://kind.sigs.k8s.io/) to create a lab environment for testing Kubernetes exploits and security tools entirely locally on a single machine without any requirement for remote resources or Virtual Machines being spun up.

To get the flexibility to set-up the various vulnerable clusters we're using [Ansible](https://www.ansible.com/) playbooks.

## Pre-requisites

Before starting you'll need to install

 - Docker
 - Ansible
   - Also install the docker python module (e.g. `pip install docker`)
 - Kind - Install guide [here](https://kind.sigs.k8s.io/docs/user/quick-start/)


## Client Machine

There's a client machine with tools for Kubernetes security testing which can be brought up with the `client-machine.yml` playbook.

- `ansible-playbook client-machine.yml` 

Once you've run the playbook, you can connect to the client machine with 

`docker exec -it client /bin/ash`

## Vulnerable Clusters

There's a number of playbooks which will bring up cluster's with a specific mis-configuration that can be exploited.

- `etcd-noauth.yml` - ETCD Server available without authentication
- `insecure-port.yml` - Kubernetes API Server Insecure Port available
- `rwkubelet-noauth.yml` - Kubelet Read-Write Port available without authentication
- `ssh-to-cluster-master.yml` - Access to a running pod with a service account which has cluster-admin rights.
- `ssh-to-create-pods-easy.yml` - Access to a running pod with a service account which has rights to manage pods.
- `ssh-to-create-pods-hard.yml` - Access to a running pod with a service account which has rights to create pods.
- `tiller-noauth.yml` - Tiller service configured without authentication.

## Using the clusters

Each of these can be used to try out various techniques for attacking Kubernetes clusters.  In general the goal of each exercise should be to get access to the `/etc/kubernetes/pki/ca.key` file as that's a "golden key" to persistent cluster access.

There will be walkthroughs for each cluster in the `walkthroughs` directory

## Cleanup

When you're finished with your cluster(s) just use

```
kind delete cluster --name=[CLUSTERNAME]
```

and 

```
docker stop client
```

## TODO

- Automate bringing up the whole environment with a single script
- Automate ensuring dependencies are present (run from a Docker container?)
- Expand the selection of playbooks available
- Improve the playbook design to remove duplication.