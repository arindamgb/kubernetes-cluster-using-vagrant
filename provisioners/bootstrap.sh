#!/bin/bash

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
sudo cat >>/etc/hosts<<EOF
172.50.50.100 kmaster.example.com kmaster
172.50.50.101 kworker1.example.com kworker1
172.50.50.102 kworker2.example.com kworker2
EOF

# Disable swap
echo "[TASK 2] Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

# Forwarding IPv4 and letting iptables see bridged traffic
echo "[TASK 3] Forwarding Configuration"
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sysctl --system

echo "[TASK 4] Install kubernetes"
export DEBIAN_FRONTEND=noninteractive
rm -rf /etc/apt/apt.conf.d/70debconf
apt-get update -y
apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
apt-get update -y
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl


echo "[TASK 5] Install containerd"
apt-get update -y
apt-get install -y ca-certificates curl gnupg lsb-release -y
rm -rf /usr/share/keyrings/docker-archive-keyring.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
apt-get update -y
apt-get install -y containerd.io

rm -rf /etc/containerd
mkdir /etc/containerd
containerd config default > /etc/containerd/config.toml
sed -i 's/            SystemdCgroup = false/            SystemdCgroup = true/' /etc/containerd/config.toml
sed -i 's/registry\.k8s\.io\/pause:3\.6/registry.k8s.io\/pause:3.9/g' /etc/containerd/config.toml
systemctl enable containerd >/dev/null 2>&1
systemctl restart containerd >/dev/null 2>&1

# Start and Enable kubelet service
echo "[TASK 6] Enable and start kubelet service"
systemctl enable kubelet >/dev/null 2>&1
systemctl restart kubelet >/dev/null 2>&1

# Enable ssh password authentication
echo "[TASK 7] Enable ssh password authentication"
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart sshd

# Set Root password
echo "[TASK 8] Set root password"
echo -e "kubeadmin\nkubeadmin" | passwd root
#echo "kubeadmin" | passwd --stdin root >/dev/null 2>&1

# Update all uesrs bashrc file
echo "export TERM=xterm" >> /etc/bashrc
