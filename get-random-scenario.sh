#!/bin/bash 
#Author : @mrintern

# Array with expressions
declare -a scenarios
scenarios=("etcd-noauth.yml" "insecure-port.yml" "rokubelet.yml" "rwkubelet-noauth.yml" "ssh-to-cluster-admin.yml" "ssh-to-create-daemonsets-hard.yml" "ssh-to-create-pods-easy.yml" "ssh-to-create-pods-hard.yml" "ssh-to-create-pods-multi-node.yml" "ssh-to-get-secrets.yml" "ssrf-to-insecure-port.yml" "tiller-noauth.yml" "unauth-api-server.yml" "unauth-kubernetes-dashboard.yml")

# Seed random generator
RANDOM=$$$(date +%s) 

# Get random scenario...
selectedscenario=${scenarios[ $RANDOM % ${#scenarios[@]} ]} 

#  launch random scenario!
ansible-playbook $selectedscenario
