#!/bin/bash

IP_S="192.168.56.110"
K3S_TOKEN=$(cat /var/lib/rancher/k3s/server/node-token)

sudo sed -i -e 's/us.archive.ubuntu.com/archive.ubuntu.com/g' /etc/apt/sources.list
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y curl

curl -sfL https://get.k3s.io | K3S_URL=https://$IP_S:6443 K3S_TOKEN=$K3S_TOKEN sh -

