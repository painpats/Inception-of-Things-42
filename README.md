# Inception of Things

![iot header](Assets/iot.png)

Mate: **[pirabaud](https://github.com/Pirabaud)**

Score: **%**

## Getting Started

**Step1:** Configure your Virtual Machine

We chose to use **Ubuntu 24.04.2**
![create-vm](Assets/create-vm.png)
![mb-cpu-vm](Assets/mb-cpu-vm.png)
![disk size - vm](Assets/disk-size-vm.png)

The tricky thing is that *Inception of Things* asks you to create <ins>2 VMs with Vagrant</ins>.
In order to do that, don't forget to set up properly your HostVM.

![enable-nested-vm](Assets/enable-nested-vm.png)

**Step2:** Install [Vagrant](https://developer.hashicorp.com/vagrant/install)

To check if Vagrant is installed : 
```bash
vagrant --version
```
**Step3:** Install a VM Provider, we chose VirtualBox

