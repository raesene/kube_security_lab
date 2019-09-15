# SSRF to Insecure Port

The application provides the facility to do GET and POST requests, so there's a couple of different ways to approach this.

One option would be

1. Get a list of running pods using the GET SSRF endpoint
  - http://[CLUSTERIP]:8080/api/v1/pods
2. From that get the name of the kube-apiserver pod (it should be something like `kube-apiserver-ssrfinsecureport-control-plane`)
3. Then execute our cat command for the ca.key file using the POST endpoint.