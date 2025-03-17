#!/bin/bash

sudo sed -i -e 's/us.archive.ubuntu.com/archive.ubuntu.com/g' /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y curl

AGENT_IP="192.168.56.111"
NETMASK="255.255.255.0"

SERVER_IP="192.168.56.110"
TOKEN_FILE="/vagrant/node-token"

K3S_TOKEN=$(cat "$TOKEN_FILE")

curl -sfL https://get.k3s.io | K3S_URL="https://$SERVER_IP:6443" K3S_TOKEN="$K3S_TOKEN" sh -
