# SSH to Create Pod - Hard

### Compromising the cluster

This scenario begins with ssh access to a pod. The ssh credentials can be found in the scenario setup.


1. `kubectl get po -n kube-system` will fail (user doesn't have those rights)
2. `kubectl get po` will work and give you a list of pods in the default namespace
3. `kubectl run` will work, but there's a problem, unlike the easy version there's no way to read logs or exec into a pod.
4. Start a new shell and exec into the client machine, then start an ncat listener on the client machine `ncat -l -p 8989`
5. Create a pod manifest called `ncat-reverse-shell-pod.yml` on the target host. This file can be found in `kube_security_lab/attacker_manifests/`
6. On the target host, run the pod `ncat-reverse-shell-pod.yml`, remembering to modify the target IP address to that of the client machine. You may need to move it somewhere you can edit files first, like the `/tmp/` directory
7. Note that in the manifest we're mounting in the pki directory with our target key into the pod as /pki
8. read the file /pki/ca.key
9. Profit!
