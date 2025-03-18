#!/bin/bash

sudo sed -i -e 's/us.archive.ubuntu.com/archive.ubuntu.com/g' /etc/apt/sources.list
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y curl

IP_S="192.168.56.110"
curl -sfL https://get.k3s.io/ | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="server --node-ip $IP_S --flannel-iface eth1" sh - 