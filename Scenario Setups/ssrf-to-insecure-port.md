## SSRF to Insecure Port

This cluster has an exposed web application which is vulnerable to SSRF.  Start by running the playbook

- `ansible-playbook ssrf-to-insecure-port.yml`

Then get a note of the IP address of the Kubernetes cluster with 

```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' sshgs-control-plane
```

At this point, if you're running on a Linux host, you should be able to connect to the web application on the Docker network at

```
http://[CLUSTERIP]:32001/
```

The username is `ssrftester` and the password is `ssrftester`

The insecure port is only availble on 127.0.0.1, but the other cluster services (inc. API server) should be available on the clusterip