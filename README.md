# Easily provision and set up a Kubernetes cluster using Vagrant for local development and testing

## Technology and version

| Technology  | Version |
| ------------- |:-------------:|
| Ubuntu OS      | 22.04.2 LTS (Jammy Jellyfish)   |
| VitualBox     | 6.1.38    |
| Vagrant     | 2.2.19    |
| Kubernetes      | v1.27.3     |
| Calico CNI   | v3.25.0     |


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

## Get you system ready
* Download the repo
```
git clone https://github.com/arindamgb/kubernetes-cluster-using-vagrant.git
```
* Install virtualbox and Vagrant
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

![vagrant status](/images/vagrant-status.png "vagrant status")


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

![kubectl get nodes.](/images/get-nodes.png "kubectl get nodes")

_Kubernetes Cluster with 1 master and 2 worker is up and running_


## Shutdown/Delete the Cluster
* Run below command to Shutdown the Cluster
```
vagrant halt
```
* Run below command to Delete the cluster permanently
```
vagrant destroy
```

