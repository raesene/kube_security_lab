## SSH to Create Pod - Easy

## Compromising the cluster

3. `kubectl get po -n kube-system` will fail (user doesn't have those rights)
4. `kubectl get po` will work and give you a list of pods in the default namespace
At this point there's several ways to achieve the goal, lets go with hostpath
5. Now we need to create a pod that dumps out the PKI private key `kubectl create -f /key-dumper-pod.yml`
6. and the key should be in the logs `kubectl logs keydumper-pod`
7. profit!
