#!/bin/bash -e

curl -fsSL https://get.docker.com | sh

fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' >> /etc/fstab

usermod -aG docker ubuntu

echo 'Port 9922' > /etc/ssh/sshd_config.d/90-port.conf
systemctl disable --now ssh.socket
systemctl enable ssh.service
systemctl restart ssh.service

docker network create --ipv6 kamal
