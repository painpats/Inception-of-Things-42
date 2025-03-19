#!/bin/bash

sudo sed -i -e 's/us.archive.ubuntu.com/archive.ubuntu.com/g' /etc/apt/sources.list
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y curl

IP_S="192.168.56.110"  
export K3S_TOKEN_FILE="/vagrant/token"
curl -sfL https://get.k3s.io/ | INSTALL_K3S_EXEC="agent --server https://$IP_S:6443 --flannel-iface eth1 --token $K3S_TOKEN_FILE" sh -
# curl -sfL https://get.k3s.io/ | INSTALL_K3S_EXEC="agent --server https://192.168.56.110:6443 --flannel-iface eth1 --token mytoken" sh -