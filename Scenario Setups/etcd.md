## Unauthenticated ETCD


- `ansible-playbook etcd-noauth.yml`

Then get a note of the IP address of the Kubernetes cluster with 

```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' etcdnoauth-control-plane
```

Connect to your client container

```
docker exec -it client /bin/ash
```

At this point you should be able to reach the etcd port on the vulnerable cluster.  Check with

```
nmap -sT -v -n -p2379 [CLUSTERIP]
```