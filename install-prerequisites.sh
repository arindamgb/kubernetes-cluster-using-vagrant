#!/bin/bash

apt-get update
#apt-get install virtualbox -y
#apt-get install vagrant -y


# install virtualbox 7.0.20r163906
apt-get install software-properties-common -y
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
apt-get update
apt-get install virtualbox-7.0 -y


# install Vagrant 2.4.1
#wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
wget -qq -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
apt-get update
apt-get install vagrant -y


mkdir /etc/vbox/
cat <<EOF | sudo tee -a /etc/vbox/networks.conf
* 172.50.50.0/24
EOF

echo "\n"
echo "Below items installed:"
echo "\nVirtualbox Version:"
vboxmanage --version
echo "\nVagrant Version:"
vagrant --version
echo "\n"
