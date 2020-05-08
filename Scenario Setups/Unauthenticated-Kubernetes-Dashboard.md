## SSH to Create Pod - Easy

This cluster has the Kubernetes Dashboard available without authentication listening on port 31337/TCP

- `ansible-playbook unauthenticated-kubernetes-dashboard.yml`

Then get a note of the IP address of the Kubernetes cluster with 

```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kubedash-control-plane
```

Then in a browser navigate to https://[IP]:31337 and you can use the "Skip" option available on the login page.