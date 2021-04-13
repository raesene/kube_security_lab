## SSH to Create Pod - Easy

## Compromising the cluster

1. `kubectl get po -n kube-system` will fail (user doesn't have those rights)
2. `kubectl get po` will work and give you a list of pods in the default namespace
3. `kubectl run` will work, but there's a problem, unlike the easy version there's no way to read logs or exec into a pod.
4. Start a new shell and exec into the client machine, then start an ncat listener on the client machine `ncat -l -p 8989`
5. run the pod `ncat-reverse-shell-pod.yml` on the target host, remembering to modify the target IP address to that of the client machine, you may need to move it somewhere you can edit files first...
6. Note that in the manifest we're mounting in the pki directory with our target key into the pod as /pki
7. read the file /pki/ca.key
8. Profit!