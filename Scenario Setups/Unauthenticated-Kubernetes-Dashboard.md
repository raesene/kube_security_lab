## SSH to Create Pod - Easy

This cluster has the Kubernetes Dashboard available without authentication listening on port 31337/TCP

- `ansible-playbook unauthenticated-kubernetes-dashboard.yml`

Then in a browser navigate to https://127.0.0.1:31337 and bypass the inevitable certificate warnings, to get started.