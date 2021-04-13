# SSRF to Insecure Port

The application provides the facility to do GET and POST requests, so there's a couple of different ways to approach this.

One option would be

1. Get a list of secrets using the GET SSRF endpoint
  - http://127.0.0.1:8080/api/v1/secrets
2. Get a secret that has privileges to create pods in the cluster
3. Find the token: field and make a copy of it
4. Base64 decode the token (one way to do that https://gchq.github.io/CyberChef)
5. use the token to make requests to the exposed API server 1. `kubectl --insecure-skip-tls-verify --token=[TOKEN] -shttps://[CLUSTERIP]:6443 `
6. Start a new shell and exec into the client machine, then start an ncat listener on the client machine `ncat -l -p 8989`
7. run the pod `ncat-reverse-shell-pod.yml` on the target host, remembering to modify the target IP address to that of the client machine, you may need to move it somewhere you can edit files first...
8. Note that in the manifest we're mounting in the pki directory with our target key into the pod as /pki
9. read the file /pki/ca.key