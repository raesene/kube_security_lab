## Unauthenticated API Server


- `ansible-playbook unauth-api-server.yml`

Then get a note of the IP address of the Kubernetes cluster with 

```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' apiservernoauth-control-plane
```

Connect to your client container

```
docker exec -it client /bin/bash
```

At this point you should be able to reach the API Server port on the vulnerable cluster.  Check with

```
nmap -sT -v -n -p6443 [CLUSTERIP]
```