## SSH to Cluster Admin

This cluster has an exposed SSH service running on port 32001/TCP to a pod in the cluster with cluster-admin rights.  To test this run

- `ansible-playbook ssh-to-cluster-master.yml`

Then get a note of the IP address of the Kubernetes cluster with 

```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' sshcm-control-plane
```

Connect to your client container

```
docker exec -it client /bin/bash
```

and from there

```
ssh -p 32001 sshuser@[Kubernetes Cluster IP]
```

The password for the sshuser account is `sshuser`