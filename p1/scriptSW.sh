#!/bin/bash

sudo sed -i -e 's/us.archive.ubuntu.com/archive.ubuntu.com/g' /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y curl
curl -sfL https://get.k3s.io/ | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="agent" sh -s - --flannel-iface=eth1
ExecStart=/usr/local/bin/k3s agent --kubelet-arg="cni-iface=eth1"
