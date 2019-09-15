## SSH to Create Pod - Easy

This cluster has an exposed SSH service running on port 32001/TCP to a pod in the cluster with rights to manage pods in the default namespace.  To test this run

- `ansible-playbook ssh-to-create-pods-easy.yml`

Then get a note of the IP address of the Kubernetes cluster with 

```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' sshcpe-control-plane
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