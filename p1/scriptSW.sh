#!/bin/bash

sudo apt-get install curl
curl -sfL https://get.k3s.io/ | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="agent" sh -s - --flannel-iface=eth1
