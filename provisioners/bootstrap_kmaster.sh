#!/bin/bash

# download images
echo "[TASK 1] Download config images"
kubeadm config images pull

# Initialize Kubernetes with calico cidr
echo "[TASK 1] Initialize Kubernetes Cluster"
kubeadm init --apiserver-advertise-address=172.50.50.100 --pod-network-cidr=192.168.0.0/16
sleep 10s

# Copy Kube admin config
echo "[TASK 2] Export Configs"
export KUBECONFIG=/etc/kubernetes/admin.conf

# Deploy calico network
echo "[TASK 3] Deploy Calico network"
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml

# Generate Cluster join command
echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /joincluster.sh

# reboot persist and install bash completion
echo "[TASK 5] Install Bash Completion and update bashrc"
apt-get install bash-completion -y
cat <<EOF | sudo tee -a ~/.bashrc
export KUBECONFIG=/etc/kubernetes/admin.conf
source /usr/share/bash-completion/bash_completion
source <(kubectl completion bash)
source <(kubeadm completion bash)
EOF
source ~/.bashrc


