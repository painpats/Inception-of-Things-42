#!/bin/bash

# sudo sed -i -e 's/us.archive.ubuntu.com/archive.ubuntu.com/g' /etc/apt/sources.list
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y curl

curl -sfL https://get.k3s.io/ | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="server --flannel-iface eth1" sh - 

kubectl apply -f /vagrant/confs/deployments.yaml
kubectl apply -f /vagrant/confs/services.yaml
kubectl apply -f /vagrant/confs/ingress.yaml
