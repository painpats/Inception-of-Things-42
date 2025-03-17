#!/bin/bash

IP_S= 192.168.56.110
K3S_TOKEN=$(cat /var/lib/rancher/k3s/server/node-token)

sudo apt-get update && sudo apt-get upgrade
sudo apt-get install curl

curl -sfL https://get.k3s.io | K3S_URL=https://$IP_S:6443 K3S_TOKEN=$K3S_TOKEN sh -

