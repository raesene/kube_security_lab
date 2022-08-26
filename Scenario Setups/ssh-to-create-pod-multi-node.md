## SSH to Create Pod - Multi Node

This cluster has an exposed SSH service running on port 32001/TCP to a pod in the cluster with rights to manage pods in the default namespace.  To test this run

- `ansible-playbook ssh-to-create-pod-multi-node.yml`

Then get a note of the IP address of the worker node in the cluster by running:

```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' sshcpmn-worker
```

Connect to your client container

```
docker exec -it client /bin/bash
```

and from there

```
ssh -p 32001 sshuser@[worker node ip]
```

The password for the sshuser account is `sshuser`
