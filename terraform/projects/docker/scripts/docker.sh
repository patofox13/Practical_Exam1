#!/bin/bash

cat << EOF >> /etc/sysctl.conf
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
net.ipv6.conf.lo.disable_ipv6=1 
EOF

sysctl -p

apt -y update 

apt -y upgrade

apt -y remove docker docker-engine docker.io containerd runc

apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt -y update
apt -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

groupadd docker
usermod -aG docker ubuntu

docker pull nginx

docker run --name some-nginx -d some-content-nginx
