# Kubernetes Local Security Testing Lab

The goal of this project is to make use of [Docker](https://www.docker.com) and specifically [kind](https://kind.sigs.k8s.io/) to create a lab environment for testing Kubernetes exploits and security tools entirely locally on a single machine without any requirement for remote resources or Virtual Machines being spun up.

To get the flexibility to set-up the various vulnerable clusters we're using [Ansible](https://www.ansible.com/) playbooks.

## Pre-requisites

Before starting you'll need to install

 - Docker
 - Ansible
   - Also install the docker python module (e.g. `pip install docker-py` or `pip install docker`)
 - Kind - Install guide [here](https://kind.sigs.k8s.io/docs/user/quick-start/)


## Client Machine

There's a client machine with tools for Kubernetes security testing which can be brought up with the `client-machine.yml` playbook.

- `ansible-playbook client-machine.yml` 

Once you've run the playbook, you can connect to the client machine with 

`docker exec -it client /bin/bash`

## Vulnerable Clusters

There's a number of playbooks which will bring up cluster's with a specific mis-configuration that can be exploited.

- `etcd-noauth.yml` - ETCD Server available without authentication
- `insecure-port.yml` - Kubernetes API Server Insecure Port available
- `rwkubelet-noauth.yml` - Kubelet Read-Write Port available without authentication
- `ssh-to-cluster-master.yml` - Access to a running pod with a service account which has cluster-admin rights.
- `ssh-to-create-pods-easy.yml` - Access to a running pod with a service account which has rights to manage pods.
- `ssh-to-create-pods-hard.yml` - Access to a running pod with a service account which has rights to create pods.
- `ssh-to-get-secrets.yml` - Access to a running pod with a service account which has cluster level rights to get secrets. 
- `ssrf-to-insecure-port.yml` - This cluster has a web application with an SSRF vulnerability in it, which can be exploited to target the insecure port.
- `tiller-noauth.yml` - Tiller service configured without authentication.
- `unauth-api-server.yml` - API Server with anonymous access possible to sensitive paths.

## Using the clusters

Each of these can be used to try out various techniques for attacking Kubernetes clusters.  In general the goal of each exercise should be to get access to the `/etc/kubernetes/pki/ca.key` file as that's a "golden key" to persistent cluster access.

For each cluster the place to start is in the `Scenario Setups` which has details of how to get started.  Then if you want some information on one possible solution look in the `Scenario Walkthroughs` folder

## Cleanup

When you're finished with your cluster(s) just use

```
kind delete cluster --name=[CLUSTERNAME]
```

and 

```
docker stop client
```

## Demo Setup

There's a specific pair of playbooks which can be useful for demonstrating Kubernetes vulnerabilities.  the `demo-cluster.yml` brings up a kind cluster with multiple vulnerabilities and the `demo-client-machine.yml` brings up a client container with the Kubernetes Kubeconfig for the demo cluster already installed.  For this pair, it's important to bring up the cluster before the client machine, so that the kubeconfig file is available to be installed.