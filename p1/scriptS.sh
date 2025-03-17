#!/bin/bash
sudo sed -i -e 's/us.archive.ubuntu.com/archive.ubuntu.com/g' /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y curl
curl -sfL https://get.k3s.io/ | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="server" sh -s - --flannel-iface=eth1
ExecStart=/usr/local/bin/k3s server --kubelet-arg="cni-iface=eth1"
