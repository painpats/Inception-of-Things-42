#!/bin/bash

sudo sed -i -e 's/us.archive.ubuntu.com/archive.ubuntu.com/g' /etc/apt/sources.list
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y curl

IP_S="192.168.56.110"
K3S_TOKEN=$(cat /var/lib/rancher/k3s/server/node-tocken)
curl -sfL https://get.k3s.io/ | INSTALL_K3S_EXEC="agent --server https://$IP_S:6443 --token $K3S_TOKEN --flannel-iface eth1" sh -
