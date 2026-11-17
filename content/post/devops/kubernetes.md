---
title: "Kubernetes"
description: kubernetes
keywords: "k8s,k3s"

date: 2023-09-28T10:20:58+08:00
lastmod: 2026-11-17T11:23:54+08:00

categories:
  - cloud
tags: 
  - cloud
---

## kubeadm
```shell
# get join command on master node
sudo kubeadm token create --print-join-command

# get certificate-key will be deleted in two hours
sudo kubeadm init phase upload-certs --upload-certs
# join master as master: [join-command] --control-plane --certificate-key [certificate-key]
# join master as worker: [join-command]
```

## kubectl
```shell

# allow master scheduling
kubectl taint node --selector='node-role.kubernetes.io/control-plane' node-role.kubernetes.io/control-plane- node-role.kubernetes.io/master-

# deny master scheduling
kubectl taint node --selector='node-role.kubernetes.io/control-plane' node-role.kubernetes.io/control-plane="":NoSchedule node-role.kubernetes.io/master="":NoSchedule

# add label to node
kubectl label nodes k8s-nodeX slave=X

# show node label
kubectl get node --show-labels

# del node
kubectl drain k8s-nodeX --ignore-daemonsets --delete-emptydir-data
kubectl delete node k8s-nodeX
```