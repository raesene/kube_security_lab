# Kubernetes Local Security Testing Lab

The goal of this project is to make use of [Docker](https://www.docker.com) and specifically [kind](https://kind.sigs.k8s.io/) to create a lab environment for testing Kubernetes exploits and security tools entirely locally on a single machine without any requirement for remote resources or Virtual Machines being spun up.

To get the flexibility to set-up the various vulnerable clusters we're using [Ansible](https://www.ansible.com/) playbooks.

If you're want to get an idea of how this works and where to start, there's an episode of [rawkode live](https://www.youtube.com/watch?reload=9&v=Srd1qqxDReA&t=6s) where we go through it all.

## Pre-requisites

Before starting you'll need to install

- Docker
- Ansible
  - Also install the docker python module (e.g. `pip install docker` or `pip3 install docker`)
- Kind 0.11.0 - Install guide [here](https://kind.sigs.k8s.io/docs/user/quick-start/)
  -  Note: due to breaking changes in Kind v0.11.0+, currently only Kind v0.11.0 is supported
  -  You can check your version with `kind --version`

If you're running Ubuntu 18.04, you can use the `install_ansible_ubuntu.sh` file to do the ansible setup. If you're running Ubuntu 20.04 then you can just get ansible from apt.

## Getting Started

 1. Start up the vulnerable cluster you want to use, from the list below. At the end of the playbook you'll get an IP address for the cluster.
 2. Start the client machine container, and exec into a shell on it
 3. For the SSH clusters (the playbooks start ssh-to-*) SSH into a pod on the cluster with `ssh -p 32001 sshuser@[Kubernetes Cluster IP]` and a password of `sshuser`
 4. Attack away :)

More detailed explanations below .

## Client Machine

There's a client machine with tools for Kubernetes security testing which can be brought up with the `client-machine.yml` playbook. It's best to use this client machine for all CLI tasks when running the scenarios, so you don't accidentally pick up creds from the host, but remember to start the kind cluster before the client machine, or the Docker network to connect to, may not be available.

- `ansible-playbook client-machine.yml`

Once you've run the playbook, you can connect to the client machine with:-

`docker exec -it client /bin/bash`

The machine should be on the `172.18.0.0/24` network with the kind clusters (as well as being on the Docker default bridge)

## Vulnerable Clusters

There's a number of playbooks which will bring up cluster's with a specific mis-configuration that can be exploited.

- `etcd-noauth.yml` - ETCD Server available without authentication
- `insecure-port.yml` - Kubernetes API Server Insecure Port available
- `rwkubelet-noauth.yml` - Kubelet Read-Write Port available without authentication
- `ssh-to-cluster-admin.yml` - Access to a running pod with a service account which has cluster-admin rights.
- `ssh-to-create-daemonsets-hard.yml`
- `ssh-to-create-pods-easy.yml` - Access to a running pod with a service account which has rights to manage pods.
- `ssh-to-create-pods-hard.yml` - Access to a running pod with a service account which has rights to create pods.
- `ssh-to-create-pods-multi-node.yaml`
- `ssh-to-get-secrets.yml` - Access to a running pod with a service account which has cluster level rights to get secrets.
- `ssrf-to-insecure-port.yml` - This cluster has a web application with an SSRF vulnerability in it, which can be exploited to target the insecure port.
- `tiller-noauth.yml` - Tiller service configured without authentication.
- `unauth-api-server.yml` - API Server with anonymous access possible to sensitive paths.
- `unauth-kubernetes-dashboard.yml` - Cluster with the Kubernetes Dashboard installed and available without authentication.
- `rokubelet.yml` - Exposed read only kubelet. This one doesn't have a compromise path ready (yet!)

## Using the clusters

Each of these can be used to try out various techniques for attacking Kubernetes clusters.  In general the goal of each exercise should be to get access to the `/etc/kubernetes/pki/ca.key` file as that's a ["golden key"](https://raesene.github.io/blog/2019/04/16/kubernetes-certificate-auth-golden-key/) to persistent cluster access.

For each cluster the place to start is in the `Scenario Setups` which has details of how to get started.  

If you want some information on one possible solution look in the `Scenario Walkthroughs` folder

## Cleanup

When you're finished with your cluster(s) just use:

```bash
kind get clusters
```

To get a list of running clusters, then:

```bash
kind delete cluster --name=[CLUSTERNAME]
```

to remove the kind clusters, and:

```bash
docker stop client
```

to remove the client container

## Demo Setup

There's a specific pair of playbooks which can be useful for demonstrating Kubernetes vulnerabilities.  the `demo-cluster.yml` brings up a kind cluster with multiple vulnerabilities and the `demo-client-machine.yml` brings up a client container with the Kubernetes Kubeconfig for the demo cluster already installed.  For this pair, it's important to bring up the cluster before the client machine, so that the kubeconfig file is available to be installed.
