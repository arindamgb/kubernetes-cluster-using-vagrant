#!/bin/bash

apt-get update
apt-get install virtualbox -y
apt-get install vagrant -y

mkdir /etc/vbox/
cat <<EOF | sudo tee -a /etc/vbox/networks.conf
* 172.50.50.0/24
EOF

echo "Below items installed:"
vboxmanage --version
vagrant --version

