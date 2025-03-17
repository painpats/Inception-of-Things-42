#!/bin/bash

sudo sed -i -e 's/us.archive.ubuntu.com/archive.ubuntu.com/g' /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y curl

IP_ADDRESS="192.168.56.110"
NETMASK="255.255.255.0"

sudo ip addr add $IP_ADDRESS/$NETMASK dev eth1 || true
sudo ip link set eth1 up

sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --bind-address=$IP_ADDRESS --node-ip=$IP_ADDRESS" sh -

