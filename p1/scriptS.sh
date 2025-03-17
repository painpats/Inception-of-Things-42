#!/bin/bash

sudo apt-get update && sudo apt-get upgrade
sudo apt-get install curl

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --flannel-iface eth1" sh -
