## Unauthenticated Read/Write Kubelet


- `ansible-playbook rwkubelet-noauth.yml`

Then get a note of the IP address of the Kubernetes cluster from the output of the ansible playbook or with 

```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rwkubeletnoauth-control-plane
```

Connect to your client container

```
docker exec -it client /bin/bash
```

At this point you should be able to reach the kubelet port on the vulnerable cluster.  Check with

```
nmap -sT -v -n -p10250 [CLUSTERIP]
```