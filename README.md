> **Last updated on:** August 19, 2024

# Easily provision and set up a Kubernetes cluster using Vagrant for local development and testing

## Purpose of this repository

This repository provides a comprehensive solution for setting up a Kubernetes cluster using Vagrant. It simplifies the process of provisioning a multi-node Kubernetes environment on your local machine, allowing you to quickly spin up a development or testing cluster.

With the included Vagrant configuration files and provisioning scripts, you can easily create a cluster of virtual machines that mirror the desired Kubernetes architecture. The setup includes master and worker nodes, along with the necessary dependencies and configurations to establish a functional Kubernetes environment.

### Key Features
* Simple and automated provisioning of a Kubernetes cluster using Vagrant
* Supports customizable cluster sizes and configurations
* Streamlined deployment of master and worker nodes with pre-configured network settings
* Includes provisioning scripts for installing and configuring essential Kubernetes components
* Offers flexibility for experimenting, testing, and development purposes
* Well-documented steps and guidelines for getting started with the cluster setup
* Whether you're an application developer, system administrator, or Kubernetes enthusiast, this repository empowers you to quickly bootstrap a Kubernetes cluster on your local machine using Vagrant. Start leveraging the power of Kubernetesfor your development, testing, and learning needs.


## Technology and version

| Technology  | Version |
| ------------- |:-------------:|
| Ubuntu     |  22.04.4 LTS (Jammy Jellyfish)   |
| VitualBox     | 7.0.20r163906    |
| Vagrant     | 2.4.1    |
| Kubernetes      | v1.31.0     |
| Containerd (CRI)  |  1.7.20     |
| Calico (CNI)  |  v3.26.0     |


## Prerequisites
* Make sure you are logged in as `root`
* Check if the **VT-x** is enabled on the machine or VM you are working on.
Run this command on Linux terminal to check if already enabled:
```
cat /proc/cpuinfo | egrep "vmx|svm"
```
* Check if **Git** is installed on your system. If not run this command to install:
```
apt-get install -y git
```

## Get your system ready
* Clone the repository
```
git clone https://github.com/arindamgb/kubernetes-cluster-using-vagrant.git
```
* Install Virtualbox and Vagrant
```
cd kubernetes-cluster-using-vagrant
sh install-prerequisites.sh
```

## Set up the Kubernetes Cluster
* Run below command as `root`
```
vagrant up
```
* Check status
```
vagrant status
```
* It should show like below

![vagrant status](/images/vagrant-status-v1.31.png "vagrant status")


## Accessing the Cluster
* Run below command as `root`
```
vagrant ssh kmaster
sudo -i
```
* Check Cluster status
```
kubectl get nodes
```
* It should show like below

![kubectl get nodes.](/images/get-nodes-v1.31.png "kubectl get nodes")

_Kubernetes Cluster with 1 master and 2 worker is up and running_


## Shutdown/Delete the Cluster
* Run below command as `root` to Shutdown the Cluster
```
vagrant halt
```
* Run below command as `root` to Start the Cluster
```
vagrant up
```
* Run below command as `root` to Delete the cluster permanently
```
vagrant destroy
```

## For more references
* Kubernetes Website: [kubernetes.io](https://kubernetes.io/).
* My LinkedIn Profile: [Arindam Gustavo Biswas](https://www.linkedin.com/in/arindamgb/).
